From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 7 Mar 2013 11:39:17 +0100
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130306230412.GA5870@obsidianresearch.com>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1362577426-12804-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306190821.GA4689@obsidianresearch.com>
 <20130306202710.15a6aa2c@skate>
 <20130306202447.GA4916@obsidianresearch.com>
 <20130306214036.62fc93b9@skate>
 <20130306215031.GB4916@obsidianresearch.com>
 <20130306222712.GP23237@titan.lakedaemon.net>
 <20130306230412.GA5870@obsidianresearch.com>
Message-ID: <20130307113917.0b751a75@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Wed, 6 Mar 2013 16:04:12 -0700, Jason Gunthorpe wrote:

> I'm not sure this is what we are discussing, certainly it isn't what I
> was talking about...
> 
> The discussion was around the SOC specific tables in the driver and if
> they should be in DT or C code. These tables very much describe the
> hardware, and are copied from similar tables in the Marvell manuals.
> 
> For instance I repeated this idea:
> 
>    ranges =<MAPDEF(1, 0xe0, MAPDEF_NOMASK)  0xFE000000  0x10000 // boot rom
>             MAPDEF(1, 0x3f, MAPDEF_NOMASK)  0xFD000000  0x10000 // devbus-boot
>             MAPDEF(1, 0xxx, MAPDEF_NOMASK)  0xFF000000  0x10000 // internal-regs
>              [..]

This doesn't work for PCIe interfaces. The PCIe windows cannot be
described in the DT, because they are inherently dynamic, and depend on
which PCIe devices are plugged into the PCIe slots, and how much I/O
and memory space each of those devices require.

This means that regardless of what you think, *some* windows will have
to be created dynamically during the system initialization, and we will
*not* be able to describe all windows in the Device Tree.

And to me, it seems completely stupid to have some windows defined
statically in the Device Tree, and some other windows set up
dynamically when the system initializes.

> At the stanza of MBUS driver's bus. Each line represents a MBUS target
> (this is a physical HW IP block). The MAPDEF is a SOC specific 'target
> id' that is currently living in tables in the driver. This value is
> directly compatible with the mbus window register and is defined by
> Marvell. The 2nd number is the CPU base address of that window, and
> the last is the size.

Please explain how you handle PCIe windows.

> Per OF conventions the base address should be the value the bootloader
> left it at - but that is not important, the value could be 0. A
> dynamic MBUS driver would go through each item in the ranges, find
> an address range and program a window with the MAPDEF from the DT. It
> would then write the base address back into the DT (at runtime!) so
> that the entire DT remains conistent with the current state of the
> hardware.

Why the heck would the kernel need to rewrite the DT ?

Just like a driver does an ioremap() to create a virtual -> physical
mapping, the driver can just as well do mvebu_mbus_add_window() to
create a physical -> device mapping. It doesn't have to be hardcoded
into the Device Tree.

> An initial implementation without dynamic address allocation would
> just have the mbus driver directly use the 2nd value as the base
> address.
> 
> The attraction to this model is that the association of later DT
> stanza's to MBUS targets is extremely clear:
> 
>        nor at 0 {
>           compatible = 'linux mtd nor driver';
>           regs = <MAPDEF(1, 0xab, MAPDEF_NOMASK) 0x10000>;
>       }
> 
> We can now tell directly that 'linux mtd nor driver' is behind MBUS
> target 0xab, and the OF code already knows the base for this MBUS
> target from the ranges property, as modified by the MBUS driver. The
> MBUS driver also knows which targets to configure windows for
> immediately at boot without having to consult internal tables. Plus we
> don't need to modify the NOR driver to call out to MBUS window
> functions to fetch an address.

Please take the PCIe example instead. Thanks.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
