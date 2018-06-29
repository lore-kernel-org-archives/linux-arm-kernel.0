From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 29 Jun 2018 14:28:10 +0200
Subject: Clarifying dma_wmb behavior in presence of non-coherent masters and
 outer caches
Message-ID: <1530275290.22468.69.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Oleksij was hunting a memory corruption issue on SocFPGA for the last
few days. While we still don't have a clear picture about what's going
wrong, I was reading some driver code and stumbled across the use of
dma_wmb, which left me with some questions about the intended use
and/or implementation. I'll try to describe by train of thought below.

Some drivers like the DWMAC driver
(drivers/net/ethernet/stmicro/stmmac/) are using dma_wmb to order
accesses to DMA descriptors, to make sure the own bit is only visible
to the DMA engine once the descriptor has been fully set up. This seems
to be correct and the intended use of this barrier as described in
Documentation/memory-barriers.txt.

The barrier documentation describes the dma barrier as "for use with
consistent memory", wich Documentation/DMA-API.txt says is memory returned by dma_alloc_coherent. As the DMA descriptors are located in memory allocated this way, it seems the driver side implementation is fine (or at least matches the documentation).

The SocFPGA platform, where this driver is used, is a Cortex A9 with a
PL310 outer cache. The peripherals being non coherent masters, as on
most ARMv7 systems.

Now the current implementation of dma_wmb maps to a dmb(oshst), which
to me seems like it is too weak to guarantee store visibility ordering
to the non-coherent DMA engine master. I would have expected that at
least a dmb(st) is necessary to provide the ordering, as specified in
the?dma_wmb Documentation on such a system.

Also with a outer cache present I'm unsure if a dmb(st) has the desired
effect. Do we need to have a full cache synchronization operation in
between the writes, as is done for the raw wmb()?

Can you confirm my understanding of the situation, or did I miss
something there?

Thanks,
Lucas
