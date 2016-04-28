From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 28 Apr 2016 16:47:34 +0200
Subject: pci_ioremap_set_mem_type(), pci_remap_iospace()
In-Reply-To: <20160428144117.GX28464@e106497-lin.cambridge.arm.com>
References: <20160427225827.GC17629@localhost>
 <20160428120624.GV28464@e106497-lin.cambridge.arm.com>
 <20160428141336.60aa4be1@free-electrons.com>
 <20160428130228.GW28464@e106497-lin.cambridge.arm.com>
 <20160428151222.2ef7ce06@free-electrons.com>
 <20160428144117.GX28464@e106497-lin.cambridge.arm.com>
Message-ID: <20160428164734.0b3837be@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Adding in Cc Arnd Bergmann, since he participated to the discussion
several years ago around the PCI DT binding for the Armada platform.

On Thu, 28 Apr 2016 15:41:17 +0100, Liviu Dudau wrote:

> > See how the address and size are 0 ? 
> 
> PCI or host address? Either are not zero, I'm afraid: PCI is 0x1 0, 0x2 0 ...
> while host address is given by MBUS_ID(...) 0. Anyway ...

The host address is kind of a "fake address". "MBUS_ID(..., ....) 0" is
not something that you can ioremap. See
Documentation/devicetree/bindings/pci/mvebu-pci.txt:

"""
Since the location and size of the different MBus windows is not fixed
in
hardware, and only determined in runtime, those ranges cover the full
first
4 GB of the physical address space, and do not translate into a valid
CPU
address.
"""

> > We don't know at the moment of
> > scanning the DT, what will be the address and size of the different MEM
> > and IO mappings.
> 
> True, but you have bounds on the sizes of each region given the way you
> encode the address translation. Trying to decode what the example above is
> telling me:
>   - each port has 0x80000_00000000 possible IO space allocated based on
>     the MBUS_ID split of address space
>   - same for MEM space.
> 
> And IMO you *should* have address and sizes for the MEM and IO mappings, as
> they act as *upper* boundaries. No one says you need to reserve the whole
> space, you are just describing how the hardware translates addresses between
> the busses.

Hm, not sure what would be the benefit of changing the Device Tree with
this, but I'm probably missing something.

> Just for my own clarification, is the reason why the ranges are declared like
> this due to the fact that each port is a separate entity and multiple ports
> cannot be served by the same MBus window? What stops you from having one
> MBus window assigned to all IO space and the other window(s) assigned to MEM
> for individual ports?

Each port needs its own MBus window for the PCI memory space and PCI
I/O space that is accessed by this port. The MBUS_ID(x, y) thing is
here to encode the information that are needed to create such windows,
which as you can see are different for each port.

So we cannot have a single MBus window for all the IO space, we need
one per PCI port.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
