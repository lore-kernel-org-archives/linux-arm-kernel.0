From: will.deacon@arm.com (Will Deacon)
Date: Thu, 24 May 2018 13:47:39 +0100
Subject: [PATCH 6/9] asm-generic/bitops/atomic.h: Rewrite using
 atomic_fetch_*
In-Reply-To: <20180524124410.GF12198@hirez.programming.kicks-ass.net>
References: <1527159586-8578-1-git-send-email-will.deacon@arm.com>
 <1527159586-8578-7-git-send-email-will.deacon@arm.com>
 <20180524124410.GF12198@hirez.programming.kicks-ass.net>
Message-ID: <20180524124734.GE8689@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2018 at 02:44:10PM +0200, Peter Zijlstra wrote:
> On Thu, May 24, 2018 at 11:59:43AM +0100, Will Deacon wrote:
> > +static inline void set_bit(unsigned int nr, volatile unsigned long *p)
> >  {
> > +	p += BIT_WORD(nr);
> > +	atomic_long_fetch_or_relaxed(BIT_MASK(nr), (atomic_long_t *)p);
> >  }
> >  
> > +static inline void clear_bit(unsigned int nr, volatile unsigned long *p)
> >  {
> > +	p += BIT_WORD(nr);
> > +	atomic_long_fetch_andnot_relaxed(BIT_MASK(nr), (atomic_long_t *)p);
> >  }
> >  
> > +static inline void change_bit(unsigned int nr, volatile unsigned long *p)
> >  {
> > +	p += BIT_WORD(nr);
> > +	atomic_long_fetch_xor_relaxed(BIT_MASK(nr), (atomic_long_t *)p);
> >  }
> 
> Why use the fetch variants here?

I noticed the same thing just now; I'll drop that and just use the
non-value-returning variants. It's shame that I can't do the same for
the lock.h unlock code, but we don't have non-returning release variants.

Will
