From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Apr 2016 18:23:57 +0200
Subject: pci_ioremap_set_mem_type(), pci_remap_iospace()
In-Reply-To: <20160428164734.0b3837be@free-electrons.com>
References: <20160427225827.GC17629@localhost>
 <20160428144117.GX28464@e106497-lin.cambridge.arm.com>
 <20160428164734.0b3837be@free-electrons.com>
Message-ID: <4332620.Jdkz6hNRbl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 April 2016 16:47:34 Thomas Petazzoni wrote:

> > > We don't know at the moment of
> > > scanning the DT, what will be the address and size of the different MEM
> > > and IO mappings.
> > 
> > True, but you have bounds on the sizes of each region given the way you
> > encode the address translation. Trying to decode what the example above is
> > telling me:
> >   - each port has 0x80000_00000000 possible IO space allocated based on
> >     the MBUS_ID split of address space
> >   - same for MEM space.
> > 
> > And IMO you *should* have address and sizes for the MEM and IO mappings, as
> > they act as *upper* boundaries. No one says you need to reserve the whole
> > space, you are just describing how the hardware translates addresses between
> > the busses.
> 
> Hm, not sure what would be the benefit of changing the Device Tree with
> this, but I'm probably missing something.

Everything's fine here: we correctly describe how for each MEM and IO
window, the hardware has a 4GB address space within the MBUS.

Part of the debate back then was whether we should also fix a mapping
between the PCIs MBUS windows and the host CPU address space as we
do for all other MBUS slaves, but we decided in the end to use dynamic
allocation of MBUS windows to give us more flexibility: there are cases
where we don't know in advance how much address space to give to
each port, or whether there are enough MBUS windows to map all I/O
spaces.

> > Just for my own clarification, is the reason why the ranges are declared like
> > this due to the fact that each port is a separate entity and multiple ports
> > cannot be served by the same MBus window? What stops you from having one
> > MBus window assigned to all IO space and the other window(s) assigned to MEM
> > for individual ports?
> 
> Each port needs its own MBus window for the PCI memory space and PCI
> I/O space that is accessed by this port. The MBUS_ID(x, y) thing is
> here to encode the information that are needed to create such windows,
> which as you can see are different for each port.
> 
> So we cannot have a single MBus window for all the IO space, we need
> one per PCI port.

Right.

	Arnd
