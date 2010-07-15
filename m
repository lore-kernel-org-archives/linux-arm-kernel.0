From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Jul 2010 17:35:26 +0100
Subject: tq 2440
In-Reply-To: <AANLkTil8GE1OguyAfp3XgfJvEmH98yNrlvGAx684a-qL@mail.gmail.com>
References: <AANLkTimyBHliUa62qmfja_ke6YTTysiVAtJcZfi8l2gG@mail.gmail.com>
	<AANLkTil8GE1OguyAfp3XgfJvEmH98yNrlvGAx684a-qL@mail.gmail.com>
Message-ID: <20100715163526.GJ29322@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 15, 2010 at 11:16:30PM +0800, Conke Hu wrote:
> ever notice to the following kernel log?
> "Device 's3c2440-nand' does not have a release() function, it is
> broken and must."
> release() function should be implemented  in the platform_device.

That's not telling you to provide a release function.  The warning is
telling you that a device is being unregistered which doesn't have a
release function.

Consider this point - maybe it doesn't have a release function because
it's not supposed to be unregistered?

> > ------------[ cut here ]------------
> > WARNING: at fs/sysfs/dir.c:463 sysfs_add_one+0x30/0x44()
> > sysfs: duplicate filename 'dm9000.0' can not be created

This is the cause of the problem.  You're registering two dm9000.0
devices.  That's illegal, and it then causes all these:

> > WARNING: at drivers/base/core.c:122 device_release+0x6c/0x78()
> > Device 's3c24xx_led.3' does not have a release() function, it is broken and mus.
> > WARNING: at drivers/base/core.c:122 device_release+0x6c/0x78()
> > Device 's3c24xx_led.2' does not have a release() function, it is broken and mus.
> > WARNING: at drivers/base/core.c:122 device_release+0x6c/0x78()
> > Device 's3c24xx_led.1' does not have a release() function, it is broken and mus.
> > WARNING: at drivers/base/core.c:122 device_release+0x6c/0x78()
> > Device 's3c24xx_led.0' does not have a release() function, it is broken and mus.
> > WARNING: at drivers/base/core.c:122 device_release+0x6c/0x78()
> > Device 's3c2440-nand' does not have a release() function, it is broken and must.
...

Fix the first problem (which is the real one) and you won't have these
other problems (which aren't actually a problem.)
