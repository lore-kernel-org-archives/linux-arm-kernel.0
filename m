From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 31 May 2018 15:17:02 +0100
Subject: [PATCH 1/3] ARM: spectre-v1: add speculation barrier (csdb) macros
In-Reply-To: <E1fONfc-000708-MX@rmk-PC.armlinux.org.uk>
References: <20180531133047.GS17671@n2100.armlinux.org.uk>
 <E1fONfc-000708-MX@rmk-PC.armlinux.org.uk>
Message-ID: <20180531141702.ucqgk54rl4ilocse@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2018 at 02:31:12PM +0100, Russell King wrote:
> Add assembly and C macros for the new CSDB instruction.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Looks correct to me per the Cache Speculation Side-chaneels 2.1
document.

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm/include/asm/assembler.h |  8 ++++++++
>  arch/arm/include/asm/barrier.h   | 13 +++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index bc8d4bbd82e2..ef1386b1af9b 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -447,6 +447,14 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
>  	.size \name , . - \name
>  	.endm
>  
> +	.macro	csdb
> +#ifdef CONFIG_THUMB2_KERNEL
> +	.inst.w	0xf3af8014
> +#else
> +	.inst	0xe320f014
> +#endif
> +	.endm
> +
>  	.macro check_uaccess, addr:req, size:req, limit:req, tmp:req, bad:req
>  #ifndef CONFIG_CPU_USE_DOMAINS
>  	adds	\tmp, \addr, #\size - 1
> diff --git a/arch/arm/include/asm/barrier.h b/arch/arm/include/asm/barrier.h
> index 40f5c410fd8c..3d9c1d4b7e75 100644
> --- a/arch/arm/include/asm/barrier.h
> +++ b/arch/arm/include/asm/barrier.h
> @@ -17,6 +17,12 @@
>  #define isb(option) __asm__ __volatile__ ("isb " #option : : : "memory")
>  #define dsb(option) __asm__ __volatile__ ("dsb " #option : : : "memory")
>  #define dmb(option) __asm__ __volatile__ ("dmb " #option : : : "memory")
> +#ifdef CONFIG_THUMB2_KERNEL
> +#define CSDB	".inst.w 0xf3af8014"
> +#else
> +#define CSDB	".inst	0xe320f014"
> +#endif
> +#define csdb() __asm__ __volatile__(CSDB : : : "memory")
>  #elif defined(CONFIG_CPU_XSC3) || __LINUX_ARM_ARCH__ == 6
>  #define isb(x) __asm__ __volatile__ ("mcr p15, 0, %0, c7, c5, 4" \
>  				    : : "r" (0) : "memory")
> @@ -37,6 +43,13 @@
>  #define dmb(x) __asm__ __volatile__ ("" : : : "memory")
>  #endif
>  
> +#ifndef CSDB
> +#define CSDB
> +#endif
> +#ifndef csdb
> +#define csdb()
> +#endif
> +
>  #ifdef CONFIG_ARM_HEAVY_MB
>  extern void (*soc_mb)(void);
>  extern void arm_heavy_mb(void);
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
