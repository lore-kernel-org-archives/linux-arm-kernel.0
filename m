From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 8 Mar 2013 15:06:55 +0100
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <201303081350.15429.arnd@arndb.de>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306230412.GA5870@obsidianresearch.com>
 <20130307113917.0b751a75@skate> <201303081350.15429.arnd@arndb.de>
Message-ID: <20130308150655.2bad20ce@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Fri, 8 Mar 2013 13:50:15 +0000, Arnd Bergmann wrote:

> > And to me, it seems completely stupid to have some windows defined
> > statically in the Device Tree, and some other windows set up
> > dynamically when the system initializes.
> 
> You could have no "ranges" property in the boot time DT if you are
> looking for consistency here.
> 
> Ideally, the ranges would contain exactly the setup of the MBUS windows
> that was configured with at boot time, and then get updated by the
> kernel when the windows are dynamically changed. An skipping the
> ranges at boot time would imply that none of the devices underneath
> MBUS are currently mapped to physical addresses. Putting some of
> the ranges is there is a way to handle two cases though:
> 
> * Overriding the boot loader (or hardware) defaults, telling the
>   kernel that we really want to set up the windows differently. In
>   a perfect world, this would not be necessary, because the boot
>   loader should be able to make sure the two always match.
> * Windows that we don't want to be set up at boot time yet because
>   we know that we want dynamic allocation.

When the kernel starts, it resets all MBus windows that could have
potentially been configured by the bootloader. So we start from a clean
world.

So you're saying that the 'ranges' property should be empty, but the
entire proposal from Jason Gunthorpe is centered around this 'ranges'
property. Quoting Jason:

   // Names and numbers made up for illistration
   // The 2nd column is where to place the MBUS target in the CPU address map
   ranges < MAPDEF(1, 0xe0, MAPDEF_NOMASK)  0xFE000000  0x10000 // boot rom
            MAPDEF(1, 0x3f, MAPDEF_NOMASK)  0xFD000000  0x10000 // devbus-boot
            MAPDEF(1, 0xxx, MAPDEF_NOMASK)  0xFF000000  0x10000 // internal-regs
             [..]

I must confess I'm lost between your opinion and Jason's opinion.

> > > At the stanza of MBUS driver's bus. Each line represents a MBUS target
> > > (this is a physical HW IP block). The MAPDEF is a SOC specific 'target
> > > id' that is currently living in tables in the driver. This value is
> > > directly compatible with the mbus window register and is defined by
> > > Marvell. The 2nd number is the CPU base address of that window, and
> > > the last is the size.
> > 
> > Please explain how you handle PCIe windows.
> 
> Any window that we don't want to hardcode, like the PCIe windows, can

We don't want to hardcode any window, because it doesn't make sense.

> be absent from the "ranges", which in DT syntax means exactly the right
> thing: There are bus addresses on the child bus that are wired to one
> device but not currently mapped into the parent bus. This is exactly
> what we do for instance on a PCI bus ranges property that does not map
> its I/O space window into the parent bus as a linear map. This is the
> normal case on x86, but also done on a few other platforms.

It is also the case for all other devices: when the kernel starts, a
NOR is not mapped into the parent bus until we create the address
decoding window for it. Absolutely no difference compared to PCIe.

> > > Per OF conventions the base address should be the value the bootloader
> > > left it at - but that is not important, the value could be 0. A
> > > dynamic MBUS driver would go through each item in the ranges, find
> > > an address range and program a window with the MAPDEF from the DT. It
> > > would then write the base address back into the DT (at runtime!) so
> > > that the entire DT remains conistent with the current state of the
> > > hardware.
> > 
> > Why the heck would the kernel need to rewrite the DT ?
> > 
> > Just like a driver does an ioremap() to create a virtual -> physical
> > mapping, the driver can just as well do mvebu_mbus_add_window() to
> > create a physical -> device mapping. It doesn't have to be hardcoded
> > into the Device Tree.
> 
> The important difference is that the DT describes the physical address
> space as seen from the CPU bus interface, but does not care at all about
> the virtual addresses that the kernel puts into page tables.

It doesn't describe the physical address of everything, because certain
things are dynamic. In some systems, the only peripheral addresses that
are dynamic are the PCI ones, and they are not hardcoded in the Device
Tree.

In the special case of Marvell systems, *many* peripherals have dynamic
addresses. It's just a specificity of Marvell SoCs, but it is in the
end very similar to the dynamic nature of PCI devices.

Would it be possible to understand that this mechanism of address
decoding windows is a bit special in Marvell SoCs, and that therefore
the classical reasoning of what the DT encodes needs to be thought a
little bit differently?

> Describing the mapping of addresses from one bus address space to another,
> down to the CPU's view is the core of all DT bindings, and we should do
> that properly and consistently. If you change the mapping at run-time,
> updating the properties is the natural thing to do.

Again, you don't do that for PCI devices because their address is
dynamic, so I don't see why we would have to do it for other devices
whose address is also dynamic.

Really, I've sent this PCIe driver first on December, 7th, and it was
working. 99% percent of the problems have been around the Device Tree,
and continue to be around this. Wasn't DT supposed to make things
easier? I am really surprised by the amount of nitpicking that this
driver receives, when I see how incoherent the pinctrl DT bindings for
the various SoC are for example...

At this point, I have absolutely no idea what direction to take to
bring this further. I'm basically in a dead-end.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
