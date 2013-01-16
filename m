From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 16 Jan 2013 12:47:18 +0000
Subject: [RFC PATCH 3/4] ARM: bL_entry: Match memory barriers to
 architectural requirements
In-Reply-To: <50F698D4.2050702@ti.com>
References: <1358268498-8086-1-git-send-email-dave.martin@linaro.org>
 <1358268498-8086-4-git-send-email-dave.martin@linaro.org>
 <50F64DC7.6040707@ti.com> <20130116114912.GB1963@linaro.org>
 <50F698D4.2050702@ti.com>
Message-ID: <20130116124718.GC1963@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 05:41:00PM +0530, Santosh Shilimkar wrote:
> On Wednesday 16 January 2013 05:19 PM, Dave Martin wrote:
> >On Wed, Jan 16, 2013 at 12:20:47PM +0530, Santosh Shilimkar wrote:
> >>+ Catalin, RMK
> >>
> >>Dave,
> >>
> >>On Tuesday 15 January 2013 10:18 PM, Dave Martin wrote:
> >>>For architectural correctness even Strongly-Ordered memory accesses
> >>>require barriers in order to guarantee that multiple CPUs have a
> >>>coherent view of the ordering of memory accesses.
> >>>
> >>>Virtually everything done by this early code is done via explicit
> >>>memory access only, so DSBs are seldom required.  Existing barriers
> >>>are demoted to DMB, except where a DSB is needed to synchronise
> >>>non-memory signalling (i.e., before a SEV).  If a particular
> >>>platform performs cache maintenance in its power_up_setup function,
> >>>it should force it to complete explicitly including a DSB, instead
> >>>of relying on the bL_head framework code to do it.
> >>>
> >>>Some additional DMBs are added to ensure all the memory ordering
> >>>properties required by the race avoidance algorithm.  DMBs are also
> >>>moved out of loops, and for clarity some are moved so that most
> >>>directly follow the memory operation which needs to be
> >>>synchronised.
> >>>
> >>>The setting of a CPU's bL_entry_vectors[] entry is also required to
> >>>act as a synchronisation point, so a DMB is added after checking
> >>>that entry to ensure that other CPUs do not observe gated
> >>>operations leaking across the opening of the gate.
> >>>
> >>>Signed-off-by: Dave Martin <dave.martin@linaro.org>
> >>>---
> >>
> >>Sorry to pick on this again but I am not able to understand why
> >>the strongly ordered access needs barriers. At least from the
> >>ARM point of view, a strongly ordered write will be more of blocking
> >>write and the further interconnect also is suppose to respect that
> >
> >This is what I originally assumed (hence the absence of barriers in
> >the initial patch).
> >
> >>rule. SO read writes are like adding barrier after every load store
> >
> >This assumption turns out to be wrong, unfortunately, although in
> >a uniprocessor scenario is makes no difference.  A SO memory access
> >does block the CPU making the access, but explicitly does not
> >block the interconnect.
> >
> I suspected the interconnect part when you described the barrier
> need for SO memory region.
> 
> >In a typical boot scenario for example, all secondary CPUs are
> >quiescent or powered down, so there's no problem.  But we can't make
> >the same assumptions when we're trying to coordinate between
> >multiple active CPUs.
> >
> >>so adding explicit barriers doesn't make sense. Is this a side
> >>effect of some "write early response" kind of optimizations at
> >>interconnect level ?
> >
> >Strongly-Ordered accesses are always non-shareable, so there is
> >no explicit guarantee of coherency between multiple masters.
> >
> This is where probably issue then. My understanding is exactly
> opposite here and hence I wasn't worried about multi-master
> CPU scenario since sharable attributes would be taking care of it
> considering the same page tables being used in SMP system.
> 
> ARM documentation says -
> ------------
> Shareability and the S bit, with TEX remap
> The memory type of a region, as indicated in the Memory type column
> of Table B3-12 on page B3-1350, provides
> the first level of control of whether the region is shareable:
> ? If the memory type is Strongly-ordered then the region is Shareable
> ------------------------------------------------------------

Hmmm, it looks like you're right here.  My assumption that SO implies
non-shareable is wrong.  This is backed up by:

A3.5.6 Device and Strongly-ordered memory

"Address locations marked as Strongly-ordered [...] are always treated
as Shareable."


I think this is sufficient to ensure that if two CPUs access the same
location with SO accesses, each will see an access order to any single
location which is consistent with the program order of the accesses on
the other CPUs.  (This comes from the glossary definition of Coherent.)

However, I can't see any general guarantee for accesses to _different_
locations, beyond the guarantees for certain special cases given in
A3.8.2 Ordering requirements for memory accesses (address and control
dependencies etc.)

This may make some of the dmbs unnecessary, but it is not clear whether
they are all unnecessary.


I'll need to follow up on this and see if we can get an answer.

Cheers
---Dave
