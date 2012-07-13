From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 13 Jul 2012 09:21:41 -0400 (EDT)
Subject: [PATCH] ARM: mutex: use generic atomic_dec-based implementation
 for ARMv6+
In-Reply-To: <1342177463-21238-1-git-send-email-will.deacon@arm.com>
References: <1342177463-21238-1-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.LFD.2.02.1207130905390.14068@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Jul 2012, Will Deacon wrote:

> The open-coded mutex implementation for ARMv6+ cores suffers from a
> couple of problems:
> 
> 	1. (major) There aren't any barriers in sight, so in the
> 	   uncontended case we don't actually protect any accesses
> 	   performed in during the critical section.
> 
> 	2. (minor) If the strex indicates failure to complete the store,
> 	   we assume that the lock is contended and run away down the
> 	   failure (slow) path. This assumption isn't correct and the
> 	   core may fail the strex for reasons other than contention.
> 
> This patch solves both of these problems by using the generic atomic_dec
> based implementation for mutexes on ARMv6+. This also has the benefit of
> removing a fair amount of inline assembly code.

I don't agree with #2.  Mutexes should be optimized for the uncontended 
case.  And in such case, strex failures are unlikely.

There was a time where the fast path was inlined in the code while any 
kind of contention processing was pushed out of line.  Going to the slow 
path on strex failure just followed that model and provided correct 
mutex behavior while making the inlined sequence one instruction 
shorter.  Therefore #2 is not a problem at all, not even a minor one.

These days the whole mutex code is always out of line so the saving of a 
single branch instruction in the whole kernel doesn't really matter 
anymore. So to say that I agree with the patch but not the second half 
of its justification.

> Cc: Nicolas Pitre <nico@fluxnic.net>
> Reported-by: Shan Kang <kangshan0910@gmail.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> 
> Given that Shan reports that this has been observed to cause problems in
> practice, I think this is certainly a candidate for -stable.
> 
>  arch/arm/include/asm/mutex.h |  113 +-----------------------------------------
>  1 files changed, 2 insertions(+), 111 deletions(-)
> 
> diff --git a/arch/arm/include/asm/mutex.h b/arch/arm/include/asm/mutex.h
> index 93226cf..bd68642 100644
> --- a/arch/arm/include/asm/mutex.h
> +++ b/arch/arm/include/asm/mutex.h
> @@ -12,116 +12,7 @@
>  /* On pre-ARMv6 hardware the swp based implementation is the most efficient. */
>  # include <asm-generic/mutex-xchg.h>
>  #else
> -
> -/*
> - * Attempting to lock a mutex on ARMv6+ can be done with a bastardized
> - * atomic decrement (it is not a reliable atomic decrement but it satisfies
> - * the defined semantics for our purpose, while being smaller and faster
> - * than a real atomic decrement or atomic swap.  The idea is to attempt
> - * decrementing the lock value only once.  If once decremented it isn't zero,
> - * or if its store-back fails due to a dispute on the exclusive store, we
> - * simply bail out immediately through the slow path where the lock will be
> - * reattempted until it succeeds.
> - */
> -static inline void
> -__mutex_fastpath_lock(atomic_t *count, void (*fail_fn)(atomic_t *))
> -{
> -	int __ex_flag, __res;
> -
> -	__asm__ (
> -
> -		"ldrex	%0, [%2]	\n\t"
> -		"sub	%0, %0, #1	\n\t"
> -		"strex	%1, %0, [%2]	"
> -
> -		: "=&r" (__res), "=&r" (__ex_flag)
> -		: "r" (&(count)->counter)
> -		: "cc","memory" );
> -
> -	__res |= __ex_flag;
> -	if (unlikely(__res != 0))
> -		fail_fn(count);
> -}
> -
> -static inline int
> -__mutex_fastpath_lock_retval(atomic_t *count, int (*fail_fn)(atomic_t *))
> -{
> -	int __ex_flag, __res;
> -
> -	__asm__ (
> -
> -		"ldrex	%0, [%2]	\n\t"
> -		"sub	%0, %0, #1	\n\t"
> -		"strex	%1, %0, [%2]	"
> -
> -		: "=&r" (__res), "=&r" (__ex_flag)
> -		: "r" (&(count)->counter)
> -		: "cc","memory" );
> -
> -	__res |= __ex_flag;
> -	if (unlikely(__res != 0))
> -		__res = fail_fn(count);
> -	return __res;
> -}
> -
> -/*
> - * Same trick is used for the unlock fast path. However the original value,
> - * rather than the result, is used to test for success in order to have
> - * better generated assembly.
> - */
> -static inline void
> -__mutex_fastpath_unlock(atomic_t *count, void (*fail_fn)(atomic_t *))
> -{
> -	int __ex_flag, __res, __orig;
> -
> -	__asm__ (
> -
> -		"ldrex	%0, [%3]	\n\t"
> -		"add	%1, %0, #1	\n\t"
> -		"strex	%2, %1, [%3]	"
> -
> -		: "=&r" (__orig), "=&r" (__res), "=&r" (__ex_flag)
> -		: "r" (&(count)->counter)
> -		: "cc","memory" );
> -
> -	__orig |= __ex_flag;
> -	if (unlikely(__orig != 0))
> -		fail_fn(count);
> -}
> -
> -/*
> - * If the unlock was done on a contended lock, or if the unlock simply fails
> - * then the mutex remains locked.
> - */
> -#define __mutex_slowpath_needs_to_unlock()	1
> -
> -/*
> - * For __mutex_fastpath_trylock we use another construct which could be
> - * described as a "single value cmpxchg".
> - *
> - * This provides the needed trylock semantics like cmpxchg would, but it is
> - * lighter and less generic than a true cmpxchg implementation.
> - */
> -static inline int
> -__mutex_fastpath_trylock(atomic_t *count, int (*fail_fn)(atomic_t *))
> -{
> -	int __ex_flag, __res, __orig;
> -
> -	__asm__ (
> -
> -		"1: ldrex	%0, [%3]	\n\t"
> -		"subs		%1, %0, #1	\n\t"
> -		"strexeq	%2, %1, [%3]	\n\t"
> -		"movlt		%0, #0		\n\t"
> -		"cmpeq		%2, #0		\n\t"
> -		"bgt		1b		"
> -
> -		: "=&r" (__orig), "=&r" (__res), "=&r" (__ex_flag)
> -		: "r" (&count->counter)
> -		: "cc", "memory" );
> -
> -	return __orig;
> -}
> -
> +/* ARMv6+ can implement efficient atomic decrement using exclusive accessors. */
> +# include <asm-generic/mutex-dec.h>
>  #endif
>  #endif
> -- 
> 1.7.4.1
> 
