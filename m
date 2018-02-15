From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Feb 2018 18:20:49 +0000
Subject: [RFC PATCH 3/5] asm-generic/bitops/atomic.h: Rewrite using
 atomic_fetch_*
In-Reply-To: <20180215170847.GD25181@hirez.programming.kicks-ass.net>
References: <1518708575-12284-1-git-send-email-will.deacon@arm.com>
 <1518708575-12284-4-git-send-email-will.deacon@arm.com>
 <20180215170847.GD25181@hirez.programming.kicks-ass.net>
Message-ID: <20180215182049.GC15274@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

Thanks for having a look.

On Thu, Feb 15, 2018 at 06:08:47PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 15, 2018 at 03:29:33PM +0000, Will Deacon wrote:
> > +static inline void __clear_bit_unlock(unsigned int nr,
> > +				      volatile unsigned long *p)
> > +{
> > +	unsigned long old;
> >  
> > +	p += BIT_WORD(nr);
> > +	old = READ_ONCE(*p);
> > +	old &= ~BIT_MASK(nr);
> > +	smp_store_release(p, old);
> 
> This should be atomic_set_release() I think, for the special case where
> atomics are implemented with spinlocks, see the 'fun' case in
> Documentation/atomic_t.txt.

My understanding of __clear_bit_unlock is that there is guaranteed to be
no concurrent accesses to the same word, so why would it matter whether
locks are used to implement atomics?

> The only other comment is that I think it would be better if you use
> atomic_t instead of atomic_long_t. It would just mean changing
> BIT_WORD() and BIT_MASK().

It would make it pretty messy for big-endian architectures, I think...

> The reason is that we generate a pretty sane set of atomic_t primitives
> as long as the architecture supplies cmpxchg, but atomic64 defaults to
> utter crap, even on 64bit platforms.

I think all the architectures using this today are 32-bit:

blackfin
c6x
cris
metag
openrisc
sh
xtensa

and I don't know how much we should care about optimising the generic atomic
bitops for 64-bit architectures that rely on spinlocks for 64-bit atomics!

Will
