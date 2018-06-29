From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Jun 2018 15:25:39 +0100
Subject: Clarifying dma_wmb behavior in presence of non-coherent masters
 and outer caches
In-Reply-To: <1530275290.22468.69.camel@pengutronix.de>
References: <1530275290.22468.69.camel@pengutronix.de>
Message-ID: <20180629142539.GH17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2018 at 02:28:10PM +0200, Lucas Stach wrote:
> Oleksij was hunting a memory corruption issue on SocFPGA for the last
> few days. While we still don't have a clear picture about what's going
> wrong, I was reading some driver code and stumbled across the use of
> dma_wmb, which left me with some questions about the intended use
> and/or implementation. I'll try to describe by train of thought below.

I don't have a full understanding of this (partly because of
implementation details, and I don't know the SocFPGA implementation.)

The dma_*() barriers were proposed by Alexander Duyck in 2014, and the
commit explicitly states that dma_wmb() will be outer-shareable only.

I think what constitutes "outer-shareable" in terms of DMB is also
something of a debate - the ARM ARM is vague on that subject, basically
saying its implementation dependent:

  In a VMSA implementation, for Shareable Normal memory, whether
  there is a distinction between Inner Shareable and Outer Shareable
  is IMPLEMENTATION DEFINED.

In the case of the three levels of shareability being implemented, a
"dmb ish" only reaches as far as the inner domain, "dmb osh" reaches
both the inner and outer domains, and "dmb sy" reaches outside the
outer domain.  Where there's no distinction between inner and outer,
it seems that both "dmb ish*" and "dmb osh*" will both have the same
reach.

That would mean that "dmb osh*" would not be visible outside of the
shareability domain, which surely is where most non-coherent DMA
masters in our SoCs lie, so on the face of it, it seems that it is
the wrong reach for this barrier.

However, it obviously works for most systems out there, which suggests
that "dmb osh*" reaches beyond "dmb ish*", but that seems to go against
the ARM ARM.

All our memory in Linux is mapped with NOS=1, which basically means
all shareable memory in the system is only inner shareable, and
nothing is shareable outside of the inner domain.  Does it make
sense to use "dmb osh*" if we have no outer-shareable memory?

Final bit of the puzzle is about which domain the PL310 ends up in.
It will come as no surprise that's also "implementation defined":

  "The relationship between these conceptual levels of cache and the
   implemented physical levels of cache is IMPLEMENTATION DEFINED,
   and can differ from the boundaries between the Inner and Outer
   Shareability domains."

were "conceptual levels" is talking about the inner/outer cacheability
level.

The only thing we can be sure about is that the L1 caches are in the
inner cacheability and inner shareability domains.  Everything else
is... implementation defined.

So, it seems to be possible that a L2 cache, such as the PL310, could
be in the inner cacheability domain and the outer shareability domain,
or vice versa!

"Implementation defined" is a nightmare when it comes to generic OSes
that have to work across multiple different implementations.

Maybe Will can shed some light on this topic.

> Some drivers like the DWMAC driver
> (drivers/net/ethernet/stmicro/stmmac/) are using dma_wmb to order
> accesses to DMA descriptors, to make sure the own bit is only visible
> to the DMA engine once the descriptor has been fully set up. This seems
> to be correct and the intended use of this barrier as described in
> Documentation/memory-barriers.txt.
> 
> The barrier documentation describes the dma barrier as "for use with
> consistent memory", wich Documentation/DMA-API.txt says is memory returned by dma_alloc_coherent. As the DMA descriptors are located in memory allocated this way, it seems the driver side implementation is fine (or at least matches the documentation).
> 
> The SocFPGA platform, where this driver is used, is a Cortex A9 with a
> PL310 outer cache. The peripherals being non coherent masters, as on
> most ARMv7 systems.
> 
> Now the current implementation of dma_wmb maps to a dmb(oshst), which
> to me seems like it is too weak to guarantee store visibility ordering
> to the non-coherent DMA engine master. I would have expected that at
> least a dmb(st) is necessary to provide the ordering, as specified in
> the?dma_wmb Documentation on such a system.
> 
> Also with a outer cache present I'm unsure if a dmb(st) has the desired
> effect. Do we need to have a full cache synchronization operation in
> between the writes, as is done for the raw wmb()?
> 
> Can you confirm my understanding of the situation, or did I miss
> something there?
> 
> Thanks,
> Lucas
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
