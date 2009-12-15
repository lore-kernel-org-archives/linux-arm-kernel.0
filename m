From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 15 Dec 2009 10:24:48 +0000
Subject: [PATCH 3/5] arm: use the spinlocked, generic atomic64 support
In-Reply-To: <alpine.LFD.2.00.0912141443010.23173@xanadu.home>
References: <alpine.LFD.2.00.0912141443010.23173@xanadu.home>
Message-ID: <1260872688.1569.19.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-12-14 at 19:52 +0000, Nicolas Pitre wrote:
> On Mon, 14 Dec 2009, Will Deacon wrote:
> > *Nicolas Pitre wrote:
> >
> > > Can't a variant of include/linux/cnt32_to_63.h be used here?>
> > > typedef struct {
> > >     atomic_t low;
> > >     u32 high;
> > > } atomic64_t;
> > >
> > > static inline void atomic64_set(atomic64_t *ptr, u64 new_val)
> > > {
> > >     u32 low = new_val;
> > >     u32 high = new_val >> 32;
> > >     BUG_ON(high & 0x80000000);
> > >     atomic_set(&ptr->low, low);
> > >     ptr->high = (high & 0x7fffffff) | (low & 0x80000000);
> > > }
> >
> > How do you ensure that this is atomic? To me it looks like one CPU
> > could write the lower 32-bits and another could write the upper 32,
> > leaving the memory location in an inconsistent state.
> 
> This one is indeed not exactly atomic.  It isn't the interesting case
> either though.  Probably a strd could fix that.

STRD is not guaranteed to be atomic either (it may be implemented as a
succession of two word stores like an STM), especially when the low
latency interrupt mode is enabled.

-- 
Catalin
