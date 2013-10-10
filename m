From: will.deacon@arm.com (Will Deacon)
Date: Thu, 10 Oct 2013 10:58:41 +0100
Subject: [PATCH 2/3] arm: include: asm: atomic.h: use 'unsigned int' and
 'atomic' instead of 'unsigned long' for atomic_clear_mask()
In-Reply-To: <5256121A.9030504@asianux.com>
References: <52561137.3070608@asianux.com> <5256117A.4000009@asianux.com>
 <5256121A.9030504@asianux.com>
Message-ID: <20131010095841.GG3817@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 10, 2013 at 03:34:02AM +0100, Chen Gang wrote:
> In current kernel wide source, for arm, only s390 scsi drivers use
> atomic_clear_mask(), now, s390 itself need use 'unsigned int' and
> 'atomic_t', so need match s390's atomic_clear_mask().
> 
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arm/include/asm/atomic.h |   13 +++++++------
>  1 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
> index da1c77d..0832a7f 100644
> --- a/arch/arm/include/asm/atomic.h
> +++ b/arch/arm/include/asm/atomic.h
> @@ -134,9 +134,10 @@ static inline int atomic_cmpxchg(atomic_t *ptr, int old, int new)
>  	return oldval;
>  }
>  
> -static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
> +static inline void atomic_clear_mask(unsigned int mask, atomic_t *ptr)
>  {
> -	unsigned long tmp, tmp2;
> +	unsigned int tmp;

I reckon this should be int (the mask parameter is unsigned, but
atomic_t.counter is signed).

> +	unsigned long tmp2;
>  
>  	__asm__ __volatile__("@ atomic_clear_mask\n"
>  "1:	ldrex	%0, [%3]\n"
> @@ -144,8 +145,8 @@ static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
>  "	strex	%1, %0, [%3]\n"
>  "	teq	%1, #0\n"
>  "	bne	1b"
> -	: "=&r" (tmp), "=&r" (tmp2), "+Qo" (*addr)
> -	: "r" (addr), "Ir" (mask)
> +	: "=&r" (tmp), "=&r" (tmp2), "+Qo" (ptr->counter)
> +	: "r" (&ptr->counter), "Ir" (mask)
>  	: "cc");
>  }
>  
> @@ -197,12 +198,12 @@ static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
>  	return ret;
>  }
>  
> -static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
> +static inline void atomic_clear_mask(unsigned int mask, atomic_t *v)
>  {
>  	unsigned long flags;
>  
>  	raw_local_irq_save(flags);
> -	*addr &= ~mask;
> +	v->counter &= ~mask;
>  	raw_local_irq_restore(flags);
>  }

This is now identical to asm-generic/atomic.h. I wonder whether we could
just #include that file for the ARMv6 case? You'd need to check the
differences carefully.

Finally, I still question the need for the clear_mask function anyway. We
don't implement set_mask, and these functions are only used by either other
arch code or in drivers that don't work on ARM anyway.

Will
