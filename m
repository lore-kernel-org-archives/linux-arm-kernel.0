From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Oct 2015 15:06:46 +0100
Subject: [PATCHv3 10/11] arm64: Add 16K page size support
In-Reply-To: <1444821634-1689-11-git-send-email-suzuki.poulose@arm.com>
References: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
 <1444821634-1689-11-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151015140646.GJ8825@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> +config ARM64_16K_PAGES
> +	bool "16KB"
> +	help
> +	  The system will use 16KB pages support. AArch32 emulation
> +	  requires applications compiled with 16K(or multiple of 16K)
> +	  aligned segments.

Nit: missing space before '('
Nit: 'a multiple of'

> @@ -503,6 +517,7 @@ config XEN
>  config FORCE_MAX_ZONEORDER
>  	int
>  	default "14" if (ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE)
> +	default "12" if (ARM64_16K_PAGES && TRANSPARENT_HUGEPAGE)
>  	default "11"

I'm a little lost here. How are these numbers derived?

>  menuconfig ARMV8_DEPRECATED
> @@ -689,9 +704,9 @@ config COMPAT
>  	  the user helper functions, VFP support and the ptrace interface are
>  	  handled appropriately by the kernel.
>  
> -	  If you also enabled CONFIG_ARM64_64K_PAGES, please be aware that you
> -	  will only be able to execute AArch32 binaries that were compiled with
> -	  64k aligned segments.
> +	  If you use a page size other than 4KB(i.e, 16KB or 64KB), please be aware

Nit: missing space before '(' please.

> diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
> index 8b9884c..a294c70 100644
> --- a/arch/arm64/include/asm/fixmap.h
> +++ b/arch/arm64/include/asm/fixmap.h
> @@ -55,8 +55,10 @@ enum fixed_addresses {
>  	 * Temporary boot-time mappings, used by early_ioremap(),
>  	 * before ioremap() is functional.
>  	 */
> -#ifdef CONFIG_ARM64_64K_PAGES
> +#if	defined(CONFIG_ARM64_64K_PAGES)
>  #define NR_FIX_BTMAPS		4
> +#elif	defined (CONFIG_ARM64_16K_PAGES)
> +#define NR_FIX_BTMAPS		16
>  #else
>  #define NR_FIX_BTMAPS		64
>  #endif

We could include <linux/sizes.h> and simplify this to:

#define NR_FIX_BTMAPS (SZ_256K / PAGE_SIZE)

Which works for me locally.

> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index 5eac6a2..90c7ff2 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -25,6 +25,8 @@
>  
>  #ifdef CONFIG_ARM64_4K_PAGES
>  #define THREAD_SIZE_ORDER	2
> +#elif defined(CONFIG_ARM64_16K_PAGES)
> +#define THREAD_SIZE_ORDER	0
>  #endif
>  #define THREAD_SIZE		16384

The above looks correct.

As an open/general question, why do both THREAD_SIZE_ORDER and
THREAD_SIZE exist? One really should be defined in terms of the other.

As far as I can tell,the only user of THREAD_SIZE_ORDER outside of arch
code is fork.c, which could calculate it as:

ilog2(DIV_ROUND_UP(THREAD_SIZE, PAGE_SIZE))

Though I suspect we can't do that in a macro here for fear of a fragile
build, so that's something for another time.

> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index b6aa9e0..2ed57a8 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -624,7 +624,12 @@ ENDPROC(__secondary_switched)
>  #define id_aa64mmfr0_tgran_shift	ID_AA64MMFR0_TGRAN64_SHIFT
>  #define id_aa64mmfr0_tgran_on		ID_AA64MMFR0_TGRAN64_ON
>  
> -#else
> +#elif	defined(CONFIG_ARM64_16K_PAGES)
> +
> +#define id_aa64mmfr0_tgran_shift	ID_AA64MMFR0_TGRAN16_SHIFT
> +#define id_aa64mmfr0_tgran_on		ID_AA64MMFR0_TGRAN16_ON
> +
> +#elif	defined(CONFIG_ARM64_4K_PAGES)
>  
>  #define id_aa64mmfr0_tgran_shift	ID_AA64MMFR0_TGRAN4_SHIFT
>  #define id_aa64mmfr0_tgran_on		ID_AA64MMFR0_TGRAN4_ON

I assume you'll s/ON/SUPPORTED/ per comments in another thread.

Otherwise this looks fine to me.

Thanks,
Mark.
