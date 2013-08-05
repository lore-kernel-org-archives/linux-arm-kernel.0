From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Aug 2013 02:14:55 -0700
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Describing complex,
 non-probable system topologies
In-Reply-To: <20130805085114.GE15885@kroah.com>
References: <20130802090355.GF7656@atomide.com>
 <20130802093222.GA8982@kroah.com>
 <20130802123445.GG7656@atomide.com>
 <20130802141449.GA7533@kroah.com>
 <20130805065535.GP7656@atomide.com>
 <20130805071106.GA14215@kroah.com>
 <20130805073730.GU7656@atomide.com>
 <20130805080254.GA15376@kroah.com>
 <20130805082138.GV7656@atomide.com>
 <20130805085114.GE15885@kroah.com>
Message-ID: <20130805091455.GA7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Greg KH <greg@kroah.com> [130805 01:56]:
> On Mon, Aug 05, 2013 at 01:21:38AM -0700, Tony Lindgren wrote:
> > * Greg KH <greg@kroah.com> [130805 01:08]:
> > > On Mon, Aug 05, 2013 at 12:37:30AM -0700, Tony Lindgren wrote:
> > > > * Greg KH <greg@kroah.com> [130805 00:16]:
> > > > > On Sun, Aug 04, 2013 at 11:55:35PM -0700, Tony Lindgren wrote:
> > > > > > 
> > > > > > But for things that are completely bus specific for various SoCs, how
> > > > > > would you like to handle those?
> > > > > > 
> > > > > > For example, we are currently using platform bus and bus notifiers and
> > > > > > then the runtime PM calls from device driver trigger the bus specific
> > > > > > things.
> > > > > > 
> > > > > > Would you prefer to instead use a custom bus instead of extending
> > > > > > the platform bus for things like that?
> > > > > 
> > > > > Yes I would.  I would really like to only use the platform bus for very
> > > > > few things, if any at all.
> > > > 
> > > > OK. How would you prefer to set up things from driver point of view
> > > > so the device drivers don't need to care which bus it's connected to?
> > > 
> > > What do you mean by "don't need to care"?  How are these drivers talking
> > > to the device on the bus in the first place?  If these are different
> > > busses, then they are talked to in different ways, right?
> > 
> > Let's assume that just ioremap + read/write is needed.
> 
> That implies that there is no "bus" at all involved here, so what's the
> problem?  :)

Right, it's all mem mapped. But there can be timings and partitioning
of the area that the "bus" needs to set up.
 
> > > Any specific examples you have to point to in the kernel today?
> > 
> > The one I'm struggling with is the _omap_device_notifier_call
> > that's not currently doing much, but we've been trying to find
> > a clean way to implement runtime PM calls for the bus.
> > 
> > There are other examples doing notifiers with platform_bus, have
> > not checked but I'm guessing they have similar needs:
> > 
> > $ git grep bus_register_notifier | grep platform_bus_type
> > arch/arm/mach-exynos/pm_domains.c:      bus_register_notifier(&platform_bus_type, &platform_nb);
> > arch/arm/mach-highbank/highbank.c:      bus_register_notifier(&platform_bus_type, &highbank_platform_nb);
> > arch/arm/mach-mvebu/coherency.c:                bus_register_notifier(&platform_bus_type,
> > arch/arm/mach-omap2/omap_device.c:      bus_register_notifier(&platform_bus_type, &platform_nb);
> > arch/microblaze/kernel/setup.c: bus_register_notifier(&platform_bus_type, &dflt_plat_bus_notifier);
> > arch/powerpc/kernel/dma-swiotlb.c:      bus_register_notifier(&platform_bus_type,
> > arch/powerpc/platforms/cell/beat_iommu.c:       bus_register_notifier(&platform_bus_type, &celleb_of_bus_notifier);
> > arch/powerpc/platforms/cell/iommu.c:    bus_register_notifier(&platform_bus_type, &cell_of_bus_notifier);
> > drivers/acpi/acpi_lpss.c:               bus_register_notifier(&platform_bus_type, &acpi_lpss_nb);
> > drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c:               err = bus_register_notifier(&platform_bus_type, &wait.notifier);
> > drivers/net/ethernet/ibm/emac/core.c:   bus_register_notifier(&platform_bus_type, &emac_of_bus_notifier);
> >  
> > > > That is, for the let's say 10 - 15 slightly different types of busses
> > > > that are currently handled as platform bus?
> > > 
> > > What makes them "different"?
> > 
> > How the power and clock domains are done and how the clocks are gated
> > or idled. So basically how the devices are reset and idled at the bus
> > level.
> 
> I think of a "bus" as the way that a device talks to the hardware (i.e.
> PCI, USB, i2c, spi, etc.)  You are saying a "bus" is something
> different, something that is used to control the "raw" devices that just
> do iowrites.

Yeah. But usually the SoC specific implementation of the above
bus hardware is itself on a mem mapped bus.. That's why we've been using
platform bus.
 
> Why not just create a bus for your devices, have them register platform
> devices (so you can take advantage of the existing drivers) and have
> your own "platform bus" of a specific type?  The code to do that would
> only need to be created once "per bus", and that way you can handle all
> of the needed reset/idle stuff properly for things "attached" to it.

Hmm yes so do you have an example of such a thing?
 
> Perhaps we need to get in front of a whiteboard at the ARM mini summit
> and hash this all out...

Sure that would probably help quite a bit.

Regards,

Tony
