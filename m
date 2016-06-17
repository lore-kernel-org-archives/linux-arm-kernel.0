From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 17 Jun 2016 15:27:42 +0100
Subject: [PATCH] arm64: barrier: implement wfe-base smp_cond_load_acquire
In-Reply-To: <1466169136-28672-1-git-send-email-will.deacon@arm.com>
References: <1466169136-28672-1-git-send-email-will.deacon@arm.com>
Message-ID: <20160617142738.GA20181@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Fri, Jun 17, 2016 at 02:12:15PM +0100, Will Deacon wrote:
> smp_cond_load_acquire is used to spin on a variable until some
> expression involving that variable becomes true.
> 
> On arm64, we can build this using WFE and LDXR, since clearing of the
> exclusive monitor as a result of the variable being changed by another
> CPU generates an event, which will wake us up out of WFE.
> 
> This patch implements smp_cond_load_acquire using LDAXR and WFE, which
> themselves are contained in an internal __cmpwait_acquire function.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> 
> Based on Peter's locking/core branch.
> 
>  arch/arm64/include/asm/barrier.h | 13 ++++++++++
>  arch/arm64/include/asm/cmpxchg.h | 52 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> index dae5c49618db..4bb2b09f8ca9 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h
> @@ -91,6 +91,19 @@ do {									\
>  	__u.__val;							\
>  })
>  
> +#define smp_cond_load_acquire(ptr, cond_expr)				\
> +({									\
> +	typeof(ptr) __PTR = (ptr);					\
> +	typeof(*ptr) VAL;						\

I was going to mention that the use of __PTR and VAL looked inconsistent
with the res of the arm64 routines, but I see that's part of the API for
the use of cond_expr, per [1].

> +	for (;;) {							\
> +		VAL = smp_load_acquire(__PTR);				\
> +		if (cond_expr)						\
> +			break;						\
> +		__cmpwait_acquire(__PTR, VAL);				\
> +	}								\
> +	VAL;								\
> +})
> +
>  #include <asm-generic/barrier.h>
>  
>  #endif	/* __ASSEMBLY__ */
> diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
> index 510c7b404454..84b83e521edc 100644
> --- a/arch/arm64/include/asm/cmpxchg.h
> +++ b/arch/arm64/include/asm/cmpxchg.h
> @@ -224,4 +224,56 @@ __CMPXCHG_GEN(_mb)
>  	__ret;								\
>  })
>  
> +#define __CMPWAIT_CASE(w, sz, name, acq, cl)				\
> +static inline void __cmpwait_case_##name(volatile void *ptr,		\
> +					 unsigned long val)		\
> +{									\
> +	unsigned long tmp;						\
> +									\
> +	asm volatile(							\
> +	"	ld" #acq "xr" #sz "\t%" #w "[tmp], %[v]\n"		\
> +	"	eor	%" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"	\
> +	"	cbnz	%" #w "[tmp], 1f\n"				\
> +	"	wfe\n"							\
> +	"1:"								\
> +	: [tmp] "=&r" (tmp), [v] "+Q" (*(unsigned long *)ptr)		\
> +	: [val] "r" (val)						\
> +	: cl);								\
> +}
> +
> +__CMPWAIT_CASE(w, b, acq_1, a, "memory");
> +__CMPWAIT_CASE(w, h, acq_2, a, "memory");
> +__CMPWAIT_CASE(w,  , acq_4, a, "memory");
> +__CMPWAIT_CASE( ,  , acq_8, a, "memory");
> +
> +#undef __CMPWAIT_CASE

>From my understanding of the intent, I believe that the asm is correct.

I'm guessing from the way this and __CMPWAIT_GEN are parameterised that
there is a plan for variants of this with different ordering semantics,
though I'm having difficulty envisioning them. Perhaps I lack
imagination. ;)

Is there any case for waiting with anything other than acquire
semantics? If not, we could fold the acq parameter and acq_ prefix from
the name parameter.

Do we expect this to be used outside of smp_cond_load_acquire? If not,
can't we rely on the prior smp_load_acquire for the acquire semantics
(and use pain LDXR* here)? Then the acq part can go from the cmpwait
cases entirely.

Is there any case where we wouldn't want the memory clobber?

Thanks,
Mark.

[1] https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git/commit/?h=locking/core&id=c1b003e1416e46640f6613952da2fe65c5522f4d
