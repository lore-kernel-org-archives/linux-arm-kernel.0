From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 24 May 2018 14:09:49 +0100
Subject: [PATCH 6/9] asm-generic/bitops/atomic.h: Rewrite using
 atomic_fetch_*
In-Reply-To: <20180524124734.GE8689@arm.com>
References: <1527159586-8578-1-git-send-email-will.deacon@arm.com>
 <1527159586-8578-7-git-send-email-will.deacon@arm.com>
 <20180524124410.GF12198@hirez.programming.kicks-ass.net>
 <20180524124734.GE8689@arm.com>
Message-ID: <20180524130948.f37eltocl5tnittp@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2018 at 01:47:39PM +0100, Will Deacon wrote:
> On Thu, May 24, 2018 at 02:44:10PM +0200, Peter Zijlstra wrote:
> > On Thu, May 24, 2018 at 11:59:43AM +0100, Will Deacon wrote:
> > > +static inline void set_bit(unsigned int nr, volatile unsigned long *p)
> > >  {
> > > +	p += BIT_WORD(nr);
> > > +	atomic_long_fetch_or_relaxed(BIT_MASK(nr), (atomic_long_t *)p);
> > >  }
> > >  
> > > +static inline void clear_bit(unsigned int nr, volatile unsigned long *p)
> > >  {
> > > +	p += BIT_WORD(nr);
> > > +	atomic_long_fetch_andnot_relaxed(BIT_MASK(nr), (atomic_long_t *)p);
> > >  }
> > >  
> > > +static inline void change_bit(unsigned int nr, volatile unsigned long *p)
> > >  {
> > > +	p += BIT_WORD(nr);
> > > +	atomic_long_fetch_xor_relaxed(BIT_MASK(nr), (atomic_long_t *)p);
> > >  }
> > 
> > Why use the fetch variants here?
> 
> I noticed the same thing just now; I'll drop that and just use the
> non-value-returning variants. It's shame that I can't do the same for
> the lock.h unlock code, but we don't have non-returning release variants.

As an aside, If I complete the autogeneration stuff, it'll be possible
to generate those. I split out the necessary barriers in [1], but I
still have a lot of other preparatory cleanup to do.

IIUC, the void-returning atomic ops are relaxed, so trying to unify that
with the usual rule that no suffix means fence will slow things down
unless we want to do a treewide substitition to fixup for that.

Thanks,
Mark.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=atomics/api-unification&id=c6b9ff2627d06776e427a7f1a7f83caeff3db536
