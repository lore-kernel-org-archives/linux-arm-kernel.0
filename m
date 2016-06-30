From: will.deacon@arm.com (Will Deacon)
Date: Thu, 30 Jun 2016 14:00:17 +0100
Subject: [PATCH v2] arm64: barrier: implement wfe-based
 smp_cond_load_acquire
In-Reply-To: <1467049434-30451-1-git-send-email-will.deacon@arm.com>
References: <1467049434-30451-1-git-send-email-will.deacon@arm.com>
Message-ID: <20160630130016.GE7962@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2016 at 06:43:54PM +0100, Will Deacon wrote:
> smp_cond_load_acquire is used to spin on a variable until some
> expression involving that variable becomes true.
> 
> On arm64, we can build this using WFE and LDXR, since clearing of the
> exclusive monitor as a result of the variable being changed by another
> CPU generates an event, which will wake us up out of WFE.
> 
> This patch implements smp_cond_load_acquire using LDXR and WFE, which
> themselves are contained in an internal __cmpwait function.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> 
> Based on Peter's locking/core branch.
> 
> v1->v2: Use cmpwait_relaxed
> 
>  arch/arm64/include/asm/barrier.h | 13 ++++++++++
>  arch/arm64/include/asm/cmpxchg.h | 51 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)

Peter -- could you take this one via locking/core for 4.8, please? I don't
anticipate any conflicts with the arm64 tree and it relies on your other
cond-wait patches anyway.

Cheers,

Will

> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> index dae5c49618db..4eea7f618dce 100644
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
> +	for (;;) {							\
> +		VAL = smp_load_acquire(__PTR);				\
> +		if (cond_expr)						\
> +			break;						\
> +		__cmpwait_relaxed(__PTR, VAL);				\
> +	}								\
> +	VAL;								\
> +})
> +
>  #include <asm-generic/barrier.h>
>  
>  #endif	/* __ASSEMBLY__ */
> diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
> index 510c7b404454..bd86a79491bc 100644
> --- a/arch/arm64/include/asm/cmpxchg.h
> +++ b/arch/arm64/include/asm/cmpxchg.h
> @@ -224,4 +224,55 @@ __CMPXCHG_GEN(_mb)
>  	__ret;								\
>  })
>  
> +#define __CMPWAIT_CASE(w, sz, name)					\
> +static inline void __cmpwait_case_##name(volatile void *ptr,		\
> +					 unsigned long val)		\
> +{									\
> +	unsigned long tmp;						\
> +									\
> +	asm volatile(							\
> +	"	ldxr" #sz "\t%" #w "[tmp], %[v]\n"		\
> +	"	eor	%" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"	\
> +	"	cbnz	%" #w "[tmp], 1f\n"				\
> +	"	wfe\n"							\
> +	"1:"								\
> +	: [tmp] "=&r" (tmp), [v] "+Q" (*(unsigned long *)ptr)		\
> +	: [val] "r" (val));						\
> +}
> +
> +__CMPWAIT_CASE(w, b, 1);
> +__CMPWAIT_CASE(w, h, 2);
> +__CMPWAIT_CASE(w,  , 4);
> +__CMPWAIT_CASE( ,  , 8);
> +
> +#undef __CMPWAIT_CASE
> +
> +#define __CMPWAIT_GEN(sfx)						\
> +static inline void __cmpwait##sfx(volatile void *ptr,			\
> +				  unsigned long val,			\
> +				  int size)				\
> +{									\
> +	switch (size) {							\
> +	case 1:								\
> +		return __cmpwait_case##sfx##_1(ptr, (u8)val);		\
> +	case 2:								\
> +		return __cmpwait_case##sfx##_2(ptr, (u16)val);		\
> +	case 4:								\
> +		return __cmpwait_case##sfx##_4(ptr, val);		\
> +	case 8:								\
> +		return __cmpwait_case##sfx##_8(ptr, val);		\
> +	default:							\
> +		BUILD_BUG();						\
> +	}								\
> +									\
> +	unreachable();							\
> +}
> +
> +__CMPWAIT_GEN()
> +
> +#undef __CMPWAIT_GEN
> +
> +#define __cmpwait_relaxed(ptr, val) \
> +	__cmpwait((ptr), (unsigned long)(val), sizeof(*(ptr)))
> +
>  #endif	/* __ASM_CMPXCHG_H */
> -- 
> 2.1.4
> 
