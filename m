From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 24 Mar 2010 09:42:08 +0000
Subject: ARM caches variants.
In-Reply-To: <20100323234949.GG20130@shareable.org>
References: <20100323234949.GG20130@shareable.org>
Message-ID: <1269423728.29073.11.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-03-23 at 23:49 +0000, Jamie Lokier wrote:
> Catalin Marinas wrote:
> > > In other word, is not the cache line used by virtual address addr:
> > > (addr % cache size) / (cache line size)
> >
> > With any cache line, you have an index and a tag for identifying it. The
> > cache may have multiple ways (e.g. 4-way associative) to speed up the
> > look-up. For a 32KB 4-way associative cache you have 8KB per way (2^13).
> >
> > If the cache line size is 32B (2^5), the index of a cache line is:
> >
> > addr & (2^13 - 1) >> 5
> >
> > e.g. bits 12..5 from the VA are used for indexing the cache line.
> >
> > The tag is given by the rest of the top bits, in the above case bits
> > 31..13 of the VA (if VIVT cache) or PA (VIPT cache).
> >
> > The cache look-up for a VA goes something like this:
> >
> >      1. extracts the index. With a 4-way associative cache there are 4
> >         possible cache lines for this index
> >      2. extracts the tag (from either VA or PA, depending on the cache
> >         type). For VIPT caches, it needs to do a TLB look-up as well to
> >         find the physical address
> >      3. check the four cache lines identified by the index at step 1
> >         against their tag
> >      4. if the tag matches, you get a hit, otherwise a miss
> >
> > For your #2 and #3 issues, if two processes map the same PA using
> > different VAs, data can end up pretty much anywhere in a VIVT cache. If
> > you calculate the index and tag (used to identify a cache line) for two
> > different VAs, the only common part are bits 11..5 of the index (since
> > they are inside a page). If you want to have the same index and tag for
> > the two different VAs, you end up with having to use the same VA in both
> > processes.
> >
> > With VIPT caches, the tag is the same for issues #2 and #3. The only
> > difference may be in a few top bits of the index. In the above case,
> > it's bit 12 of the VA which may differ. This gives you two page colours
> > (with 64KB 4-way associative cache you have 2 bits for the colour
> > resulting in 4 colours).
> 
> That's a very helpful explanation, thank you.
> 
> Am I to understand that "VIPT aliasing" means there are some of those
> bits and therefore >= 2 colours, and "VIPT non-aliasing" means the
> cache size / ways is <= PAGE_SIZE, and therefore has effectively 1 colour?

A method to get non-aliasing VIPT is to have the way size <= PAGE_SIZE.
That's how ARM1136 with 16K caches works. But with bigger caches, adding
more ways may get expensive in hardware.

> I suspect some x86s have VIPT caches, especially AMD (I've seen timing
> measurements which clearly show page colour effects), and I can only
> imagine that aliasing is prevent by when a cache line requests to be
> filled from higher level cache (L2), something very similar to SMP
> MESI cache coherence gets involved to keep both lines consistent.
> 
> That would make a "VIPT non-aliasing" cache that has multiple colours.
> Is that ever done on the ARM architecture?

ARMv7 has non-aliasing VIPT D-cache where the aliasing is handled by the
hardware (maybe similar to MESI). I don't know the hardware
implementation but my guess is that a cache look-up checks all the
indices (4 in a 64K 4-way associative cache) and the tag may be extended
to bit 12 (and may overlap with the index).

Note that the I-cache on ARMv7 is an aliasing VIPT (when the way size >
PAGE_SIZE).

-- 
Catalin
