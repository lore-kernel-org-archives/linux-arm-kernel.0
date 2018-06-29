From: will.deacon@arm.com (Will Deacon)
Date: Fri, 29 Jun 2018 17:22:48 +0100
Subject: Clarifying dma_wmb behavior in presence of non-coherent masters
 and outer caches
In-Reply-To: <20180629142539.GH17271@n2100.armlinux.org.uk>
References: <1530275290.22468.69.camel@pengutronix.de>
 <20180629142539.GH17271@n2100.armlinux.org.uk>
Message-ID: <20180629162248.GB20010@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Fri, Jun 29, 2018 at 03:25:39PM +0100, Russell King - ARM Linux wrote:
> On Fri, Jun 29, 2018 at 02:28:10PM +0200, Lucas Stach wrote:
> > Oleksij was hunting a memory corruption issue on SocFPGA for the last
> > few days. While we still don't have a clear picture about what's going
> > wrong, I was reading some driver code and stumbled across the use of
> > dma_wmb, which left me with some questions about the intended use
> > and/or implementation. I'll try to describe by train of thought below.
> 
> I don't have a full understanding of this (partly because of
> implementation details, and I don't know the SocFPGA implementation.)
> 
> The dma_*() barriers were proposed by Alexander Duyck in 2014, and the
> commit explicitly states that dma_wmb() will be outer-shareable only.
> 
> I think what constitutes "outer-shareable" in terms of DMB is also
> something of a debate - the ARM ARM is vague on that subject, basically
> saying its implementation dependent:
> 
>   In a VMSA implementation, for Shareable Normal memory, whether
>   there is a distinction between Inner Shareable and Outer Shareable
>   is IMPLEMENTATION DEFINED.
> 
> In the case of the three levels of shareability being implemented, a
> "dmb ish" only reaches as far as the inner domain, "dmb osh" reaches
> both the inner and outer domains, and "dmb sy" reaches outside the
> outer domain.  Where there's no distinction between inner and outer,
> it seems that both "dmb ish*" and "dmb osh*" will both have the same
> reach.
> 
> That would mean that "dmb osh*" would not be visible outside of the
> shareability domain, which surely is where most non-coherent DMA
> masters in our SoCs lie, so on the face of it, it seems that it is
> the wrong reach for this barrier.
> 
> However, it obviously works for most systems out there, which suggests
> that "dmb osh*" reaches beyond "dmb ish*", but that seems to go against
> the ARM ARM.
> 
> All our memory in Linux is mapped with NOS=1, which basically means
> all shareable memory in the system is only inner shareable, and
> nothing is shareable outside of the inner domain.  Does it make
> sense to use "dmb osh*" if we have no outer-shareable memory?
> 
> Final bit of the puzzle is about which domain the PL310 ends up in.
> It will come as no surprise that's also "implementation defined":
> 
>   "The relationship between these conceptual levels of cache and the
>    implemented physical levels of cache is IMPLEMENTATION DEFINED,
>    and can differ from the boundaries between the Inner and Outer
>    Shareability domains."
> 
> were "conceptual levels" is talking about the inner/outer cacheability
> level.
> 
> The only thing we can be sure about is that the L1 caches are in the
> inner cacheability and inner shareability domains.  Everything else
> is... implementation defined.
> 
> So, it seems to be possible that a L2 cache, such as the PL310, could
> be in the inner cacheability domain and the outer shareability domain,
> or vice versa!
> 
> "Implementation defined" is a nightmare when it comes to generic OSes
> that have to work across multiple different implementations.
> 
> Maybe Will can shed some light on this topic.

You're right that cacheability and shareability are different things. For
the purposes of ordering and coherence, we care about shareability. Normal
non-cacheable is outer-shareable (which is a superset of inner-shareable),
so DMB OSH is sufficient to order accesses to that buffer from the
perspective of all observers. Since we use Normal non-cacheable mappings
for non-coherent DMA buffers (and there is no such thing as a
system-shareable memory type), then these barriers are sufficient to provide
ordering in this case too.

Ideally, we'd limit the DMA barriers to the inner-shareable domain when
dealing with coherent devices, but there's no way to determine that from
the barrier macros.

Lucas -- did changing the shareability of the DMA barriers actually solve
your problem?

Will
