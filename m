From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 May 2016 21:51:47 +0200
Subject: [PATCH v2 1/2] Documentation: DT: bindings: Add Broadcom STB PCIe
 bindings
In-Reply-To: <5732139C.80101@gmail.com>
References: <1462475700-1654-1-git-send-email-f.fainelli@gmail.com>
 <4513390.VWu0VVAxOl@wuerfel> <5732139C.80101@gmail.com>
Message-ID: <2533093.jsjycoq8tW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 May 2016 10:00:12 Florian Fainelli wrote:
> 
> The two critical pieces of information that the PCIe RC needs are:
> 
> - number of memory controllers present in the system to avoid
> configuring a window to a non-existing or non-populated memory controller
> 
> - size of the memory populated on the memory controller
> 
> You would think that we should somehow be able to derive this
> information from the "memory" node, but there are a few caveats:
> 
> - on MIPS platforms, we have discontiguous physical memory ranges (256MB
> @ 0x0, then 768MB or 1792MB @ 0x 0x20000000 and 1GB @ 0x90000000), yet
> the PCIe RC does not know about the hole(s)

That sounds like you need a dma-ranges property anyway to describe how
the DMA addresses are mapped.

> - on ARM platforms, we have an identiy mapping for the PAs below 4GB,
> but when we cross it, we have additional non-linear memory regions
> 
> Both of these memory nodes would imply we know how to identify which
> physical address belongs to which memory controller, while this is
> actually possible and known, it creates a dependency on another piece of
> driver to provide that information.
> 
> We do have memory controller nodes populated in the Device Tree, however
> their binding (out of tree for the moment) does only specify their
> programmable register interface, and not how how much physical memory
> and where they provide to the system.
> 
> It does seem like we should be able to utilize the "dma-ranges" property
> to determine both the memory controller number and their respective
> populated memory sizes.
> 
> In the case where we have an identiy mapping though, this seems a little
> redundant, but less of a stretch than our custom properties and nodes.
> 
> Does that sound reasonable to you?

I'd have to look at an example first. Ideally, each line in the
dma-ranges property would refer to one memory controller, and
that would be very easy to mandate, but it sounds like in the MIPS
case you end up with an extra entry for the first 256MB that is
on the same memory controller as the second 768MB.

	Arnd
