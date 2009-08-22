From: nico@cam.org (Nicolas Pitre)
Date: Fri, 21 Aug 2009 23:23:00 -0400 (EDT)
Subject: [PATCH] Convert MMC subsys drivers to dev_pm_ops
In-Reply-To: <200908220452.05108.marek.vasut@gmail.com>
References: <200908220223.50588.marek.vasut@gmail.com>
	<alpine.LFD.2.00.0908212234150.6044@xanadu.home>
	<200908220452.05108.marek.vasut@gmail.com>
Message-ID: <alpine.LFD.2.00.0908212308450.6044@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 22 Aug 2009, Marek Vasut wrote:

> Dne So 22. srpna 2009 04:44:00 Nicolas Pitre napsal(a):
> > On Sat, 22 Aug 2009, Marek Vasut wrote:
> > > Hi,
> > >
> > > This converts most of the drivers found in drivers/mmc/host to
> > > dev_pm_ops. Also, it contains some fixes for the probe/remove functions
> > > in some cases.
> >
> > Are you sure you're actually fixing things?
> >
> > You replaced platform_driver_probe() calls with
> > platform_driver_register() calls, and made the probe functions __devinit
> > instead of __init.  Especially when the platform device is unlikely to
> > go away or new ones to ever appear, there is no point keeping the
> > probe code around after it is done.
> 
> Yeah, the __devinit should actually remove the init function when done ... to 
> my understanding. Sorry in case I'm wrong.

No it cannot, because there is normally no way if it is really done as 
new device, like on a USB bus, may appear later and bind to the same 
driver.  So __devinit will actually discard the code only if hotplug is 
disabled in the kernel config (see include/linux/init.h and 
include/asm-generic/vmlinux.lds.h).

Quoting drivers/base/platform.c:

 * platform_driver_probe - register driver for non-hotpluggable device
 * @drv: platform driver structure
 * @probe: the driver probe routine, probably from an __init section
 *
 * Use this instead of platform_driver_register() when you know the device
 * is not hotpluggable and has already been registered, and you want to
 * remove its run-once probe() infrastructure from memory after the driver
 * has bound to the device.
 *
 * One typical use for this would be with drivers for controllers integrated
 * into system-on-chip processors, where the controller devices have been
 * configured as part of board setup.


Nicolas
