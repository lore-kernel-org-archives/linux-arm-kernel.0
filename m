From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Jul 2016 12:15:33 +0200
Subject: [RFC PATCH] dmaengine: mv_xor: Add support for IO (PCIe) src/dst
 areas
In-Reply-To: <49b991d2-f7c4-5f09-0f28-b483d21c8934@denx.de>
References: <20160603162429.8760-1-sr@denx.de> <4330031.lrbVYzKFjS@wuerfel>
 <49b991d2-f7c4-5f09-0f28-b483d21c8934@denx.de>
Message-ID: <3800626.8dI3J7PQb7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 27, 2016 2:57:17 PM CEST Stefan Roese wrote:
> >>
> >> Arnd, do you have some ideas how to better solve this problem?
> >
> > I'm not sure I completely understand the problem yet, but my first
> > thought would be caching: have a copy of the ranges in RAM and loop
> > over that in order to decide whether to evict one entry or not,
> > avoiding the need for mmio register reads completely, and most of
> > the register writes as well.
> 
> Good idea. I would still need to call mvebu_mbus_get_io_win_info(),
> but the mmio accessed in this XOR driver could be minimized this
> way.

Right, this would only be needed on a cache miss. We can probably
assume that almost always the eight available windows are sufficient
for all I/O, so that would be once per window we actually need
and we never end up having to flush an entry in the cache.

One problem that you could hit is if the mbus windows get torn
down and reassigned (e.g. after unloading and reloading the PCI
driver in case we ever support that).

> > The mv_mbus_pci_info() should work as well, but it's possible you
> > can actually express that in a more generic way, since the
> > location of the PCI memory space should also be known to the PCI
> > core.
> 
> But we need the MBus target and attr for these different windows
> as well. So querying the MBus driver seems the only way for me.

Ok, makes sense.

> > Finally, what is the specific limitation on the number and size
> > of the windows?
> 
> A max. of 8 windows. The windows can be from 64KiB to 4GiB.

And I assume that there are more avaialable MBUS windows than those?

Otherwise we could always program the same translations into
the xor engine that are present in MBUS.

> > Could you just create static mappings that span
> > all of the potential address space, e.g. a single entry for
> > any address visibile to the CPU? I can't tell if you just need
> > the physical address as seen by the CPU (which would be easy)
> > or if you need the mbus address with their register numbers
> > (which probably doesn't have a single contiguous representation?
> 
> Unfortunately we need the MBus target and attribute values for
> each window. So a summarized representation probably won't
> work.
> 
> > Do you just need to cover PCI or also things like the SPI-NOR
> > direct mapping address?
> 
> My current use-case is just PCI.
> 
> Perhaps the cached mmio version would be acceptable? If I get
> an "go for it and I'll ack the patch v2" from someone, then
> I will gladly invest some time in this. 

I think that's the best option then.

	Arnd
