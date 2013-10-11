From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Oct 2013 17:55:30 +0100
Subject: [PATCH] arm/arm64: remove atomic_clear_mask() in
 "include/asm/atomic.h"
In-Reply-To: <5257E539.9080902@asianux.com>
References: <5256117A.4000009@asianux.com> <5256121A.9030504@asianux.com>
 <52561269.60900@asianux.com>
 <20131010100733.GH3817@mudshark.cambridge.arm.com>
 <52568998.2080108@asianux.com>
 <20131010142305.GG6199@mudshark.cambridge.arm.com>
 <525751E2.3020207@asianux.com>
 <20131011104419.GE14732@mudshark.cambridge.arm.com>
 <5257E033.3090607@asianux.com> <5257E539.9080902@asianux.com>
Message-ID: <20131011165530.GS14732@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 11, 2013 at 12:47:05PM +0100, Chen Gang wrote:
> In current kernel wide source code, except other architectures, only
> s390 scsi drivers use atomic_clear_mask(), and arm/arm64 need not
> support s390 drivers.
> 
> So remove atomic_clear_mask() from "arm[64]/include/asm/atomic.h".

  Acked-by: Will Deacon <will.deacon@arm.com>

Catalin, are you happy for me to send this via the ARM tree?

Will

> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arm/include/asm/atomic.h   |   24 ------------------------
>  arch/arm64/include/asm/atomic.h |   14 --------------
>  2 files changed, 0 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
> index da1c77d..3b3ae49fa 100644
> --- a/arch/arm/include/asm/atomic.h
> +++ b/arch/arm/include/asm/atomic.h
> @@ -134,21 +134,6 @@ static inline int atomic_cmpxchg(atomic_t *ptr, int old, int new)
>  	return oldval;
>  }
>  
> -static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
> -{
> -	unsigned long tmp, tmp2;
> -
> -	__asm__ __volatile__("@ atomic_clear_mask\n"
> -"1:	ldrex	%0, [%3]\n"
> -"	bic	%0, %0, %4\n"
> -"	strex	%1, %0, [%3]\n"
> -"	teq	%1, #0\n"
> -"	bne	1b"
> -	: "=&r" (tmp), "=&r" (tmp2), "+Qo" (*addr)
> -	: "r" (addr), "Ir" (mask)
> -	: "cc");
> -}
> -
>  #else /* ARM_ARCH_6 */
>  
>  #ifdef CONFIG_SMP
> @@ -197,15 +182,6 @@ static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
>  	return ret;
>  }
>  
> -static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
> -{
> -	unsigned long flags;
> -
> -	raw_local_irq_save(flags);
> -	*addr &= ~mask;
> -	raw_local_irq_restore(flags);
> -}
> -
>  #endif /* __LINUX_ARM_ARCH__ */
>  
>  #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
> diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
> index 8363644..01de5aa 100644
> --- a/arch/arm64/include/asm/atomic.h
> +++ b/arch/arm64/include/asm/atomic.h
> @@ -126,20 +126,6 @@ static inline int atomic_cmpxchg(atomic_t *ptr, int old, int new)
>  	return oldval;
>  }
>  
> -static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
> -{
> -	unsigned long tmp, tmp2;
> -
> -	asm volatile("// atomic_clear_mask\n"
> -"1:	ldxr	%0, %2\n"
> -"	bic	%0, %0, %3\n"
> -"	stxr	%w1, %0, %2\n"
> -"	cbnz	%w1, 1b"
> -	: "=&r" (tmp), "=&r" (tmp2), "+Q" (*addr)
> -	: "Ir" (mask)
> -	: "cc");
> -}
> -
>  #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
>  
>  static inline int __atomic_add_unless(atomic_t *v, int a, int u)
> -- 
> 1.7.7.6
> 
