From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 8 Mar 2013 15:41:29 +0000
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130308150655.2bad20ce@skate>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201303081350.15429.arnd@arndb.de> <20130308150655.2bad20ce@skate>
Message-ID: <201303081541.29410.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 March 2013, Thomas Petazzoni wrote:
> When the kernel starts, it resets all MBus windows that could have
> potentially been configured by the bootloader. So we start from a clean
> world.
> 
> So you're saying that the 'ranges' property should be empty, but the
> entire proposal from Jason Gunthorpe is centered around this 'ranges'
> property. Quoting Jason:
>
>    // Names and numbers made up for illistration
>    // The 2nd column is where to place the MBUS target in the CPU address map
>    ranges < MAPDEF(1, 0xe0, MAPDEF_NOMASK)  0xFE000000  0x10000 // boot rom
>             MAPDEF(1, 0x3f, MAPDEF_NOMASK)  0xFD000000  0x10000 // devbus-boot
>             MAPDEF(1, 0xxx, MAPDEF_NOMASK)  0xFF000000  0x10000 // internal-regs
>              [..]
> 
> I must confess I'm lost between your opinion and Jason's opinion.

There is not actually all that much disconnect. As a side note, an empty
"ranges" property means an identity map, which would be wrong here, while
an absent property means that there is currently no mapping.

If you want the boot loader to tell the kernel to autoconfigure all the
mappings, an absent ranges property would be the right thing. This makes
a lot of sense if you want to go fully dynamic, but I thought that you
were not attempting to go that far yet.

I think we really want the ranges to be populated at run-time though,
and have it match exactly the windows that we decide to put in, so that
of_address_translate works.

Even if you want to ignore all the mappings that the boot loader sets,
there are two different values that would make sense to put into the
ranges property anyway rather than leaving it out (as I mentioned earlier):

a) Put the mapping in there that is configured by hardware or boot loader,
to make any device work when you do not have a driver for MBUS. Any OS
could then just translate the addresses from DT and get working devices,
but an OS with an MBUS driver can choose to reconfigure the mappings
and update the ranges property. This is similar to e.g. the baud rate is
configured for a serial port: the firmware puts into DT what the UART
is configured to at boot time, and we can use that to output data,
or override it if we have a reason to want a different baud rate. We don't
normally bother updating the DT properties if we do that, because nothing
else depends on it.

b) Put a useful default mapping in the DT, and ask Linux to set up the
MBUS device so we don't need to duplicate the code in Linux and the boot
loader. An OS can still ignore the values and override them with something
else to get a fully dynamic mapping. This is similar e.g. to what we do
for the ethernet MAC addresses: If the kernel wants to pick some value,
it can find a reasonable one in the DT, which it will normally use, but
it can just as well use something elese.

I don't care much which of those options you choose (including leaving
the ranges property out of the initial DT), but I strongly believe that
the format of the in-memory ranges property should be what Jason Gunthorpe
suggested or at least very similar. I certainly don't want to see the
mapping hardwired in the driver. If you want the mapping to be completely
boot time created, an empty ranges or the default from the boot loader
makes the most sense. If you want some mappings to be fixed, I would
prefer them to be in the DT rather than in the driver.

> > > > At the stanza of MBUS driver's bus. Each line represents a MBUS target
> > > > (this is a physical HW IP block). The MAPDEF is a SOC specific 'target
> > > > id' that is currently living in tables in the driver. This value is
> > > > directly compatible with the mbus window register and is defined by
> > > > Marvell. The 2nd number is the CPU base address of that window, and
> > > > the last is the size.
> > > 
> > > Please explain how you handle PCIe windows.
> > 
> > Any window that we don't want to hardcode, like the PCIe windows, can
> 
> We don't want to hardcode any window, because it doesn't make sense.

I thought you were doing exact that with a table like

+static const struct mvebu_mbus_mapping armada_370_map[] = {
+       MAPDEF("bootrom",     1, 0xe0, MAPDEF_NOMASK),
+       MAPDEF("devbus-boot", 1, 0x2f, MAPDEF_NOMASK),
+       MAPDEF("devbus-cs0",  1, 0x3e, MAPDEF_NOMASK),
+       MAPDEF("devbus-cs1",  1, 0x3d, MAPDEF_NOMASK),
+       MAPDEF("devbus-cs2",  1, 0x3b, MAPDEF_NOMASK),
+       MAPDEF("devbus-cs3",  1, 0x37, MAPDEF_NOMASK),
+       MAPDEF("pcie0.0",     4, 0xe0, MAPDEF_PCIMASK),
+       MAPDEF("pcie1.0",     8, 0xe0, MAPDEF_PCIMASK),
+       {},
+};
+

> > be absent from the "ranges", which in DT syntax means exactly the right
> > thing: There are bus addresses on the child bus that are wired to one
> > device but not currently mapped into the parent bus. This is exactly
> > what we do for instance on a PCI bus ranges property that does not map
> > its I/O space window into the parent bus as a linear map. This is the
> > normal case on x86, but also done on a few other platforms.
> 
> It is also the case for all other devices: when the kernel starts, a
> NOR is not mapped into the parent bus until we create the address
> decoding window for it. Absolutely no difference compared to PCIe.

Yes, as I said: if you don't want the mapping for the device to be fixed,
it should not be in the ranges property at boot time, but only get added
at the point where you pick a mapping. This may concern all devices
or just a subset (PCIe, flash, ...).
 
> > The important difference is that the DT describes the physical address
> > space as seen from the CPU bus interface, but does not care at all about
> > the virtual addresses that the kernel puts into page tables.
> 
> It doesn't describe the physical address of everything, because certain
> things are dynamic. In some systems, the only peripheral addresses that
> are dynamic are the PCI ones, and they are not hardcoded in the Device
> Tree.
>
> In the special case of Marvell systems, many peripherals have dynamic
> addresses. It's just a specificity of Marvell SoCs, but it is in the
> end very similar to the dynamic nature of PCI devices.
> 
> Would it be possible to understand that this mechanism of address
> decoding windows is a bit special in Marvell SoCs, and that therefore
> the classical reasoning of what the DT encodes needs to be thought a
> little bit differently?

I don't think we should make a special case here when the common device
tree format can perfectly describe what these chips are doing.

> > Describing the mapping of addresses from one bus address space to another,
> > down to the CPU's view is the core of all DT bindings, and we should do
> > that properly and consistently. If you change the mapping at run-time,
> > updating the properties is the natural thing to do.
> 
> Again, you don't do that for PCI devices because their address is
> dynamic, so I don't see why we would have to do it for other devices
> whose address is also dynamic.

For PCI devices we are often taking a shortcut with the flattened
device tree format because we have to probe them all from the kernel
anyway, in particular for hotplugged devices. In traditional OF
based system, the firmware actually assigned addresses to all PCI
devices and showed them in the device tree. We get away with leaving
the PCI devices out of the DT because PCI is smart enough to assign
the addresses dynamically. On the MBUS, this is not possible without
knowing exactly what devices are behind it, and you can only describe
those devices if you either list them in the source code (which we
are trying to move away from with DT) or if you list them all in the
DT, but that requires describing them in a format that has the
sufficient information.

	Arnd
