From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Dec 2011 23:22:11 +0000
Subject: [RFC PATCH] ARM: vmlinux.lds.S: do not hardcode cacheline size
 as 32 bytes
In-Reply-To: <4EEA43D9.9040700@codeaurora.org>
References: <1323799572-5641-1-git-send-email-will.deacon@arm.com>
 <4EEA43D9.9040700@codeaurora.org>
Message-ID: <20111215232211.GA29606@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Thu, Dec 15, 2011 at 07:00:41PM +0000, Stephen Boyd wrote:
> On 12/13/11 10:06, Will Deacon wrote:
> > The linker script assumes a cacheline size of 32 bytes when aligning
> > the .data..cacheline_aligned and .data..percpu sections.
> >
> > This patch updates the script to use L1_CACHE_BYTES, which should be set
> > to 64 on platforms that require it.
> >
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >
> > I'm posting this as an RFC because, whilst this fixes a bug, it looks
> > like many platforms don't select ARM_L1_CACHE_SHIFT_6 when they should
> > (all Cortex-A8 platforms should select this, for example).
> 
> What are the implications of not having cache aligned data? Is it a
> performance impact or something more?

It's used both for performance reasons but also for correctness. For
example, I think that having the line size too small could cause possible
misalignment of streaming DMA buffers (see ARCH_DMA_MINALIGN), which could
lead to data corruption when we invalidate adjacent data on speculating
CPUs.

> > @@ -205,7 +206,7 @@ SECTIONS
> >  #endif
> >  
> >  		NOSAVE_DATA
> > -		CACHELINE_ALIGNED_DATA(32)
> > +		CACHELINE_ALIGNED_DATA(L1_CACHE_BYTES)
> >  		READ_MOSTLY_DATA(32)
> 
> Does READ_MOSTLY_DATA also need to be cache aligned? At least powerpc is
> doing that.

This is in the optimistion camp but it's probably a good idea since it will
help to keep read-mostly data cachelines in the shared state on SMP systems.

The main issue I have with all of this is the lack of platforms selecting
the correct shift. Defaulting to 6 would be my preference, but it's hard to
tell what to predicate this on (CPU_V6 || CPU_V7 ?).

Will
