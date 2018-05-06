From: andrea.parri@amarulasolutions.com (Andrea Parri)
Date: Sun, 6 May 2018 16:15:52 +0200
Subject: [PATCH] locking/atomics: Combine the atomic_andnot() and
 atomic64_andnot() API definitions
In-Reply-To: <20180505085445.cmdnqh6xpnpfoqzb@gmail.com>
References: <20180504173937.25300-1-mark.rutland@arm.com>
 <20180504173937.25300-2-mark.rutland@arm.com>
 <20180504180105.GS12217@hirez.programming.kicks-ass.net>
 <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
 <20180505081100.nsyrqrpzq2vd27bk@gmail.com>
 <20180505083635.622xmcvb42dw5xxh@gmail.com>
 <20180505085445.cmdnqh6xpnpfoqzb@gmail.com>
Message-ID: <20180506141552.GA28937@andrea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ingo,

> From f5efafa83af8c46b9e81b010b46caeeadb450179 Mon Sep 17 00:00:00 2001
> From: Ingo Molnar <mingo@kernel.org>
> Date: Sat, 5 May 2018 10:46:41 +0200
> Subject: [PATCH] locking/atomics: Combine the atomic_andnot() and atomic64_andnot() API definitions
> 
> The atomic_andnot() and atomic64_andnot() are defined in 4 separate groups
> spred out in the atomic.h header:
> 
>  #ifdef atomic_andnot
>  ...
>  #endif /* atomic_andnot */
>  ...
>  #ifndef atomic_andnot
>  ...
>  #endif
>  ...
>  #ifdef atomic64_andnot
>  ...
>  #endif /* atomic64_andnot */
>  ...
>  #ifndef atomic64_andnot
>  ...
>  #endif
> 
> Combine them into unify them into two groups:

Nit: "Combine them into unify them into"

  Andrea


> 
>  #ifdef atomic_andnot
>  #else
>  #endif
> 
>  ...
> 
>  #ifdef atomic64_andnot
>  #else
>  #endif
> 
> So that one API group is defined in a single place within the header.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  include/linux/atomic.h | 72 +++++++++++++++++++++++++-------------------------
>  1 file changed, 36 insertions(+), 36 deletions(-)
> 
> diff --git a/include/linux/atomic.h b/include/linux/atomic.h
> index 352ecc72d7f5..1176cf7c6f03 100644
> --- a/include/linux/atomic.h
> +++ b/include/linux/atomic.h
> @@ -205,22 +205,6 @@
>  # endif
>  #endif
>  
> -#ifdef atomic_andnot
> -
> -#ifndef atomic_fetch_andnot_relaxed
> -# define atomic_fetch_andnot_relaxed		atomic_fetch_andnot
> -# define atomic_fetch_andnot_acquire		atomic_fetch_andnot
> -# define atomic_fetch_andnot_release		atomic_fetch_andnot
> -#else
> -# ifndef atomic_fetch_andnot
> -#  define atomic_fetch_andnot(...)		__atomic_op_fence(atomic_fetch_andnot, __VA_ARGS__)
> -#  define atomic_fetch_andnot_acquire(...)	__atomic_op_acquire(atomic_fetch_andnot, __VA_ARGS__)
> -#  define atomic_fetch_andnot_release(...)	__atomic_op_release(atomic_fetch_andnot, __VA_ARGS__)
> -# endif
> -#endif
> -
> -#endif /* atomic_andnot */
> -
>  #ifndef atomic_fetch_xor_relaxed
>  # define atomic_fetch_xor_relaxed		atomic_fetch_xor
>  # define atomic_fetch_xor_acquire		atomic_fetch_xor
> @@ -338,7 +322,22 @@ static inline int atomic_add_unless(atomic_t *v, int a, int u)
>  # define atomic_inc_not_zero(v)			atomic_add_unless((v), 1, 0)
>  #endif
>  
> -#ifndef atomic_andnot
> +#ifdef atomic_andnot
> +
> +#ifndef atomic_fetch_andnot_relaxed
> +# define atomic_fetch_andnot_relaxed		atomic_fetch_andnot
> +# define atomic_fetch_andnot_acquire		atomic_fetch_andnot
> +# define atomic_fetch_andnot_release		atomic_fetch_andnot
> +#else
> +# ifndef atomic_fetch_andnot
> +#  define atomic_fetch_andnot(...)		__atomic_op_fence(atomic_fetch_andnot, __VA_ARGS__)
> +#  define atomic_fetch_andnot_acquire(...)	__atomic_op_acquire(atomic_fetch_andnot, __VA_ARGS__)
> +#  define atomic_fetch_andnot_release(...)	__atomic_op_release(atomic_fetch_andnot, __VA_ARGS__)
> +# endif
> +#endif
> +
> +#else /* !atomic_andnot: */
> +
>  static inline void atomic_andnot(int i, atomic_t *v)
>  {
>  	atomic_and(~i, v);
> @@ -363,7 +362,8 @@ static inline int atomic_fetch_andnot_release(int i, atomic_t *v)
>  {
>  	return atomic_fetch_and_release(~i, v);
>  }
> -#endif
> +
> +#endif /* !atomic_andnot */
>  
>  /**
>   * atomic_inc_not_zero_hint - increment if not null
> @@ -600,22 +600,6 @@ static inline int atomic_dec_if_positive(atomic_t *v)
>  # endif
>  #endif
>  
> -#ifdef atomic64_andnot
> -
> -#ifndef atomic64_fetch_andnot_relaxed
> -# define atomic64_fetch_andnot_relaxed		atomic64_fetch_andnot
> -# define atomic64_fetch_andnot_acquire		atomic64_fetch_andnot
> -# define atomic64_fetch_andnot_release		atomic64_fetch_andnot
> -#else
> -# ifndef atomic64_fetch_andnot
> -#  define atomic64_fetch_andnot(...)		__atomic_op_fence(atomic64_fetch_andnot, __VA_ARGS__)
> -#  define atomic64_fetch_andnot_acquire(...)	__atomic_op_acquire(atomic64_fetch_andnot, __VA_ARGS__)
> -#  define atomic64_fetch_andnot_release(...)	__atomic_op_release(atomic64_fetch_andnot, __VA_ARGS__)
> -# endif
> -#endif
> -
> -#endif /* atomic64_andnot */
> -
>  #ifndef atomic64_fetch_xor_relaxed
>  # define atomic64_fetch_xor_relaxed		atomic64_fetch_xor
>  # define atomic64_fetch_xor_acquire		atomic64_fetch_xor
> @@ -672,7 +656,22 @@ static inline int atomic_dec_if_positive(atomic_t *v)
>  # define atomic64_try_cmpxchg_release		atomic64_try_cmpxchg
>  #endif
>  
> -#ifndef atomic64_andnot
> +#ifdef atomic64_andnot
> +
> +#ifndef atomic64_fetch_andnot_relaxed
> +# define atomic64_fetch_andnot_relaxed		atomic64_fetch_andnot
> +# define atomic64_fetch_andnot_acquire		atomic64_fetch_andnot
> +# define atomic64_fetch_andnot_release		atomic64_fetch_andnot
> +#else
> +# ifndef atomic64_fetch_andnot
> +#  define atomic64_fetch_andnot(...)		__atomic_op_fence(atomic64_fetch_andnot, __VA_ARGS__)
> +#  define atomic64_fetch_andnot_acquire(...)	__atomic_op_acquire(atomic64_fetch_andnot, __VA_ARGS__)
> +#  define atomic64_fetch_andnot_release(...)	__atomic_op_release(atomic64_fetch_andnot, __VA_ARGS__)
> +# endif
> +#endif
> +
> +#else /* !atomic64_andnot: */
> +
>  static inline void atomic64_andnot(long long i, atomic64_t *v)
>  {
>  	atomic64_and(~i, v);
> @@ -697,7 +696,8 @@ static inline long long atomic64_fetch_andnot_release(long long i, atomic64_t *v
>  {
>  	return atomic64_fetch_and_release(~i, v);
>  }
> -#endif
> +
> +#endif /* !atomic64_andnot */
>  
>  #define atomic64_cond_read_relaxed(v, c)	smp_cond_load_relaxed(&(v)->counter, (c))
>  #define atomic64_cond_read_acquire(v, c)	smp_cond_load_acquire(&(v)->counter, (c))
