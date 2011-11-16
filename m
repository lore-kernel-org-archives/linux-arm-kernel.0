From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 16 Nov 2011 07:59:40 +0100
Subject: [PATCH 3/5] [orion] Move address map setup out of the drivers
 and into platform.
In-Reply-To: <alpine.LFD.2.02.1111151648150.3307@xanadu.home>
References: <1321128007-3520-1-git-send-email-andrew@lunn.ch>
 <1321128007-3520-4-git-send-email-andrew@lunn.ch>
 <alpine.LFD.2.02.1111141855340.3307@xanadu.home>
 <20111115074122.GA2012@lunn.ch>
 <alpine.LFD.2.02.1111151648150.3307@xanadu.home>
Message-ID: <20111116065940.GH2953@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > What do you think about the idea of keeping the first two patches,
> > i.e. *_mbus_dram_info out of mach-* and into plat-orion. Then
> > providing a function orion_mbus_dram_info() which returns its. Keep
> > the address map setup code in the drivers, remove struct
> > mbus_dram_target_info from platform_data and use this function
> > instead?
> 
> I pretty much like patch #1.  Just remember to mark unneeded data after 
> boot as __initdata.

O.K. I can do that and submit it.
 
> I don't see the point of patch #2.  Having a kirkwood specific piece of 
> data called kirkwood_foo rather than orion_foo makes more sense to me.

Is it kirkwood specific? All plat-orion based systems have one
mbus_dram_target_info. The structure i would say belongs to orion, but
the contents to kirkwood. How you use the structure belongs to orion,
since all the drivers, independent of if they are running on kirkwood,
dove, mv78xx0, all use it in the same way.

> Having a static orion_mbus_dram_info() function might be a problem on 
> other platforms.  for example, the mv643xx_eth driver is also used by 
> some PowerPC targets.

That in itself is interesting. I looked at the PowerPC code,
powerpc/platforms/chrp/pegasos_eth.c &
powerpc/sysdev/mv64x60_dev.c. No mention of any _mbus_dram_info
structure. Which to me means _mbus_dram_info is an plat-orion thing
and not an mv643xx_eth thing, so maybe it belongs in the plat-orion?

I guess what will decide it, is when another SoC comes along using
these devices and needs the address map setup doing differently. Then
it is clear its a platform thing, not a device thing.

> The sata_mv driver is shared between Orion/Kirkwood/Dove SOCs and
> Marvell SATA controllers on PCI cards that can be found on any
> architecture with a PCI bus.  Etc.  It is therefore necessary to
> query those resources in a standard way and be prepared for the fact
> that they might just be absent.  So I'd suggest looking at the
> possibility of using IORESOURCE_BUS in the standard platform device
> data or a similar mechanism.

There seems to be a lack of information and usage of IORESOURCE_BUS.
arch/x86/pci/broadcom_bus.c seems to create such a resource record,
prints it out and then it is throw away.

drivers/usb/gadget/net2272.c uses it to indicated how much registers
offsets need left shifting when access io memory. Only the blackfin
uses it.

pnp/interface.c etc just prints it and then ignores it.

There is nothing under Documentation about it....

All i could find is:
http://lkml.indiana.edu/hypermail/linux/kernel/1003.0/02515.html

	IORESOURCE_BUS is for PCI bus number ranges. For bridge
	devices, ACPI reports secondary bus number ranges in _CRS
	descriptors, but we currently ignore them.  Adding this
	resource type will allow us to handle those descriptors in
	PNPACPI.

How would you suggest using IORESOURCE_BUS? 

    Andrew
