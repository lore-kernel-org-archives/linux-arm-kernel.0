From: khilman@ti.com (Kevin Hilman)
Date: Thu, 07 Apr 2011 10:17:03 -0700
Subject: [PATCH/RFC 0/6] ARM: runtime PM: consolidate runtime PM
	implementations
In-Reply-To: <871v1eaz0u.fsf@ti.com> (Kevin Hilman's message of "Thu, 07 Apr
	2011 07:58:57 -0700")
References: <1302134569-22825-1-git-send-email-khilman@ti.com>
	<201104070738.42956.rjw@suse.com> <871v1eaz0u.fsf@ti.com>
Message-ID: <87hbaa7zhs.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman <khilman@ti.com> writes:

[...]

> Replacing the PM ops for all devices was done on OMAP and SH-mobile
> because that was the only approach we had.  Now that we have device
> power domains (thanks Rafael!), we can be more selective about which
> devices to apply them to.
>
> Note that my RFC patch/series did not do the selective part of deciding
> which devices to override and which ones not to, that part will be
> platform specific.  

Actually, thinking about this a little more, my patch actually does
select only relevant devices, and not *all* platform devices.

In my patch, the device power domain pointers are only added for devices
where a clk_get() actually succeeds.  In the original version, the
runtime PM hooks are overridden for *all* platform devices, but ones
that have no clock (or where clk_get() failed) have the additional
overhead of still calling the custom PM ops, but the custom ops have
nothing to do.

Kevin
