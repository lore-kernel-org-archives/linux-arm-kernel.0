From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Nov 2009 13:00:48 +0000
Subject: [RFC PATCH] ARMv7: Use lazy cache flushing if hardware
	broadcasts cache operations
In-Reply-To: <20091105125059.2762.57284.stgit@pc1117.cambridge.arm.com>
References: <20091105125059.2762.57284.stgit@pc1117.cambridge.arm.com>
Message-ID: <20091105130048.GA21681@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 05, 2009 at 12:50:59PM +0000, Catalin Marinas wrote:
> diff --git a/arch/arm/include/asm/cachetype.h b/arch/arm/include/asm/cachetype.h
> index d3a4c2c..3d5d1c9 100644
> --- a/arch/arm/include/asm/cachetype.h
> +++ b/arch/arm/include/asm/cachetype.h
> @@ -1,6 +1,8 @@
>  #ifndef __ASM_ARM_CACHETYPE_H
>  #define __ASM_ARM_CACHETYPE_H
>  
> +#include <asm/cputype.h>
> +
>  #define CACHEID_VIVT			(1 << 0)
>  #define CACHEID_VIPT_NONALIASING	(1 << 1)
>  #define CACHEID_VIPT_ALIASING		(1 << 2)
> @@ -49,4 +51,18 @@ static inline unsigned int __attribute__((pure)) cacheid_is(unsigned int mask)
>  	       (~__CACHEID_NEVER & __CACHEID_ARCH_MIN & mask & cacheid);
>  }
>  
> +/*
> + * Cache maintenance operations hardware broadcasting.
> + */
> +#ifndef CONFIG_SMP
> +#define cache_ops_hw_broadcast()	1
> +#elif __LINUX_ARM_ARCH__ <= 6
> +#define cache_ops_hw_broadcast()	0
> +#else
> +static inline int cache_ops_hw_broadcast(void)
> +{
> +	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) >= 1;
> +}
> +#endif
> +

Please place this in asm/smp_plat.h, and let's have it in the same sense
as the TLB ops version as well for consistency (so we don't have to
individually remember how each of these functions work and their sense.)
IOW (this is cut'n'pasted, so is tab broken):

diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index 59303e2..e621530 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -13,4 +13,9 @@ static inline int tlb_ops_need_broadcast(void)
        return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 2;
 }
 
+static inline int cache_ops_need_broadcast(void)
+{
+       return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 1;
+}
+
 #endif
