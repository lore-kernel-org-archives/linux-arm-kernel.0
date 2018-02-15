From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 15 Feb 2018 18:08:47 +0100
Subject: [RFC PATCH 3/5] asm-generic/bitops/atomic.h: Rewrite using
 atomic_fetch_*
In-Reply-To: <1518708575-12284-4-git-send-email-will.deacon@arm.com>
References: <1518708575-12284-1-git-send-email-will.deacon@arm.com>
 <1518708575-12284-4-git-send-email-will.deacon@arm.com>
Message-ID: <20180215170847.GD25181@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 03:29:33PM +0000, Will Deacon wrote:
> +static inline void set_bit(unsigned int nr, volatile unsigned long *p)
> +{
> +	p += BIT_WORD(nr);
> +	atomic_long_fetch_or_relaxed(BIT_MASK(nr), (atomic_long_t *)p);
> +}
>  
> +static inline void clear_bit(unsigned int nr, volatile unsigned long *p)
> +{
> +	p += BIT_WORD(nr);
> +	atomic_long_fetch_andnot_relaxed(BIT_MASK(nr), (atomic_long_t *)p);
> +}
>  
> +static inline void change_bit(unsigned int nr, volatile unsigned long *p)
> +{
> +	p += BIT_WORD(nr);
> +	atomic_long_fetch_xor_relaxed(BIT_MASK(nr), (atomic_long_t *)p);
> +}
>  
> +static inline int test_and_set_bit(unsigned int nr, volatile unsigned long *p)
>  {
> +	long old;
>  	unsigned long mask = BIT_MASK(nr);
>  
> +	p += BIT_WORD(nr);
> +	if (READ_ONCE(*p) & mask)
> +		return 1;
> +
> +	old = atomic_long_fetch_or(mask, (atomic_long_t *)p);
> +	return !!(old & mask);
>  }
>  
> +static inline int test_and_clear_bit(unsigned int nr, volatile unsigned long *p)
>  {
> +	long old;
>  	unsigned long mask = BIT_MASK(nr);
>  
> +	p += BIT_WORD(nr);
> +	if (!(READ_ONCE(*p) & mask))
> +		return 0;
> +
> +	old = atomic_long_fetch_andnot(mask, (atomic_long_t *)p);
> +	return !!(old & mask);
>  }
>  
> +static inline int test_and_change_bit(unsigned int nr, volatile unsigned long *p)
>  {
> +	long old;
>  	unsigned long mask = BIT_MASK(nr);
>  
> +	p += BIT_WORD(nr);
> +	old = atomic_long_fetch_xor(mask, (atomic_long_t *)p);
> +	return !!(old & mask);
>  }
>  
> +static inline int test_and_set_bit_lock(unsigned int nr,
> +					volatile unsigned long *p)
>  {
> +	long old;
>  	unsigned long mask = BIT_MASK(nr);
>  
> +	p += BIT_WORD(nr);
> +	if (READ_ONCE(*p) & mask)
> +		return 1;
>  
> +	old = atomic_long_fetch_or_acquire(mask, (atomic_long_t *)p);
> +	return !!(old & mask);
>  }
>  
> +static inline void clear_bit_unlock(unsigned int nr, volatile unsigned long *p)
>  {
> +	p += BIT_WORD(nr);
> +	atomic_long_fetch_andnot_release(BIT_MASK(nr), (atomic_long_t *)p);
> +}
>  
> +static inline void __clear_bit_unlock(unsigned int nr,
> +				      volatile unsigned long *p)
> +{
> +	unsigned long old;
>  
> +	p += BIT_WORD(nr);
> +	old = READ_ONCE(*p);
> +	old &= ~BIT_MASK(nr);
> +	smp_store_release(p, old);

This should be atomic_set_release() I think, for the special case where
atomics are implemented with spinlocks, see the 'fun' case in
Documentation/atomic_t.txt.

>  }

The only other comment is that I think it would be better if you use
atomic_t instead of atomic_long_t. It would just mean changing
BIT_WORD() and BIT_MASK().

The reason is that we generate a pretty sane set of atomic_t primitives
as long as the architecture supplies cmpxchg, but atomic64 defaults to
utter crap, even on 64bit platforms.

Otherwise this looks pretty neat.
