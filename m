From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 12 Jul 2011 11:07:04 +0100
Subject: [RFC] Improving scalability of smp_mb__[before|after]_clear_bit
In-Reply-To: <CAN_5kQAniGQgLix4nAsLpJZ3r=LR_NDjuvaXokJ=NiwLfp=7zw@mail.gmail.com>
References: <CAN_5kQAniGQgLix4nAsLpJZ3r=LR_NDjuvaXokJ=NiwLfp=7zw@mail.gmail.com>
Message-ID: <20110712100704.GC13235@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2011 at 08:34:59AM +0100, heechul Yun wrote:
> I think L2 cache sync operation, called by mb(), is not necessary for
> bitops.  This patch improves lat_pagefault of lmbench by up to 11% on
> a A9 SMP.  Higher proceesor counts can benefit more.
> 
> ---
> diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bitops.h
> index b4892a0..f428059 100644
> --- a/arch/arm/include/asm/bitops.h
> +++ b/arch/arm/include/asm/bitops.h
> @@ -26,8 +26,8 @@
>  #include <linux/compiler.h>
>  #include <asm/system.h>
> 
> -#define smp_mb__before_clear_bit()     mb()
> -#define smp_mb__after_clear_bit()      mb()
> +#define smp_mb__before_clear_bit()     smp_mb()
> +#define smp_mb__after_clear_bit()      smp_mb()
> 
>  /*
>   * These functions are the basis of our bit ops.
 
It looks fine to me.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
