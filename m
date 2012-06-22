From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 22 Jun 2012 16:22:20 -0400 (EDT)
Subject: [PATCH 2/2] ARM: rwlocks: remove unused branch labels from trylock
 routines
In-Reply-To: <1340378146-17560-3-git-send-email-will.deacon@arm.com>
References: <1340378146-17560-1-git-send-email-will.deacon@arm.com>
 <1340378146-17560-3-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.LFD.2.02.1206221621350.10229@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Jun 2012, Will Deacon wrote:

> The ARM arch_{read,write}_trylock implementations include unused
> backwards branch labels, since we don't retry the locking operation
> if the exclusive store fails.
> 
> This patch removes the labels.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/include/asm/spinlock.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
> index dcca638..aa7945b 100644
> --- a/arch/arm/include/asm/spinlock.h
> +++ b/arch/arm/include/asm/spinlock.h
> @@ -183,7 +183,7 @@ static inline int arch_write_trylock(arch_rwlock_t *rw)
>  	unsigned long tmp;
>  
>  	__asm__ __volatile__(
> -"1:	ldrex	%0, [%1]\n"
> +"	ldrex	%0, [%1]\n"
>  "	teq	%0, #0\n"
>  "	strexeq	%0, %2, [%1]"
>  	: "=&r" (tmp)
> @@ -269,7 +269,7 @@ static inline int arch_read_trylock(arch_rwlock_t *rw)
>  	unsigned long tmp, tmp2 = 1;
>  
>  	__asm__ __volatile__(
> -"1:	ldrex	%0, [%2]\n"
> +"	ldrex	%0, [%2]\n"
>  "	adds	%0, %0, #1\n"
>  "	strexpl	%1, %0, [%2]\n"
>  	: "=&r" (tmp), "+r" (tmp2)
> -- 
> 1.7.4.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
