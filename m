From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Feb 2016 18:03:33 +0000
Subject: arm qemu test failures due to 'driver-core: platform: probe
 of-devices only using list of compatibles'
In-Reply-To: <56C20DD6.8050604@arm.com>
References: <20160214165010.GA3189@roeck-us.net>
 <20160215105909.GH12289@pengutronix.de>
 <56C1F19F.8090100@roeck-us.net> <56C20DD6.8050604@arm.com>
Message-ID: <20160215180333.GK10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 05:41:42PM +0000, Sudeep Holla wrote:
> Sorry for missing this earlier, I could reproduce this on my TC2.
> The issue is with card-detect gpio probing. It's not related to AMBA
> probing as discussed on the mail thread.
> 
> mfd_add_device adds devices with of_node when cell->of_compatible is
> matched, but the device created is expected to be matched based on name
> which the patch under discussion clearly breaks.

If I'm understanding you correctly, you're saying that MFD re-adds
platform devices with the of_node of a new platform device pointing
to an existing of_node, but expects this new platform device to
match a _different_ driver?

Sounds like MFD needs fixing.  I've said this before: of_node's must
_never_ be copied between different device structures, especially
when they are on the _same_ bus - quite simply because the driver
core _can_ match using the DT compatible.

For example... let's say you have a platform device called "1234.foo"
created by DT with compatible of "example,foo".  You have two platform
drivers.  One of them matches compatible "example,foo" and the other
matches against platform devices with a name of "bar".

The "example,foo" device driver is matched against "1234.foo".  It
creates a platform device with a name of "bar" and bus ID "bar.0",
setting the of_node to the same as "1234.foo".

When scanning for a matching driver, if the "example,foo" driver is
found first, "bar.0" will be matched to this driver, and its probe
method called.  If it accepts this device, it will repeat its action,
creating "bar.1".  Repeat until you run out of memory.

If it instead finds the "bar" driver first, this driver will be used
and everything appears to work correctly.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
