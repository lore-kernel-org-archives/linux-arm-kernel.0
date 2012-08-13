From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 13 Aug 2012 14:14:48 -0400 (EDT)
Subject: [PATCH] ARM: mutex: use generic atomic_dec-based implementation
 for ARMv6+
In-Reply-To: <1344879528-24897-1-git-send-email-will.deacon@arm.com>
References: <1344879528-24897-1-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.LFD.2.02.1208131412130.5231@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 Aug 2012, Will Deacon wrote:

> Commit a76d7bd96d65 ("ARM: 7467/1: mutex: use generic xchg-based
> implementation for ARMv6+") removed the barrier-less, ARM-specific
> mutex implementation in favour of the generic xchg-based code.
> 
> Since then, a bug was uncovered in the xchg code when running on SMP
> platforms, due to interactions between the locking paths and the
> MUTEX_SPIN_ON_OWNER code. This was fixed in 0bce9c46bf3b ("mutex: place
> lock in contended state after fastpath_lock failure"), however, the
> atomic_dec-based mutex algorithm is now marginally more efficient for
> ARM (~0.5% improvement in hackbench scores on dual A15).
> 
> This patch moves ARMv6+ platforms to the atomic_dec-based mutex code.
> 
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/include/asm/mutex.h |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/mutex.h b/arch/arm/include/asm/mutex.h
> index b1479fd..d69ebc7 100644
> --- a/arch/arm/include/asm/mutex.h
> +++ b/arch/arm/include/asm/mutex.h
> @@ -9,8 +9,12 @@
>  #define _ASM_MUTEX_H
>  /*
>   * On pre-ARMv6 hardware this results in a swp-based implementation,
> - * which is the most efficient. For ARMv6+, we emit a pair of exclusive
> - * accesses instead.
> + * which is the most efficient. For ARMv6+, we have exclusive memory
> + * accessors and use atomic_dec to avoid the extra xchg operations
> + * on the locking slowpaths.
>   */
> +#if __LINUX_ARM_ARCH < 6
>  #include <asm-generic/mutex-xchg.h>
> +#else
> +#include <asm-generic/mutex-dec.h>
>  #endif
> -- 
> 1.7.4.1
> 
