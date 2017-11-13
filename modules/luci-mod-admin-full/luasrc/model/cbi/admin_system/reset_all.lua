-- Copyright 2008 Steven Barth <steven@midlink.org>
-- Copyright 2011 Jo-Philipp Wich <jow@openwrt.org>
-- Licensed to the public under the Apache License 2.0.

m = Map("system")
s = m:section(TypedSection, "reset_all","Reset facetory")
s.anonymous = true
s.addremove = false

rs = s:option(Flag, "reset","Enable reset default")
rs.rmempty = false

function rs.write(self, section, value)
if value == self.enabled then
		luci.sys.call("sleep 1; killall dropbear uhttpd; sleep 1; jffs2reset -y && reboot")
	end
	return Flag.write(self, section, value)
end
-- retain server list even if disabled
function rs.remove() end
return m
