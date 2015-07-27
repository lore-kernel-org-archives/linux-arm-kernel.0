From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 27 Jul 2015 17:40:35 +0100
Subject: [PATCH v4 1/7] x86/kasan: generate KASAN_SHADOW_OFFSET in Makefile
In-Reply-To: <1437756119-12817-2-git-send-email-a.ryabinin@samsung.com>
References: <1437756119-12817-1-git-send-email-a.ryabinin@samsung.com>
 <1437756119-12817-2-git-send-email-a.ryabinin@samsung.com>
Message-ID: <20150727164034.GC350@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 07:41:53PM +0300, Andrey Ryabinin wrote:
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index b3a1a5d..6d6dd6f 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -255,11 +255,6 @@ config ARCH_SUPPORTS_OPTIMIZED_INLINING
>  config ARCH_SUPPORTS_DEBUG_PAGEALLOC
>  	def_bool y
>  
> -config KASAN_SHADOW_OFFSET
> -	hex
> -	depends on KASAN
> -	default 0xdffffc0000000000
> -
>  config HAVE_INTEL_TXT
>  	def_bool y
>  	depends on INTEL_IOMMU && ACPI
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 118e6de..c666989 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -39,6 +39,8 @@ ifdef CONFIG_X86_NEED_RELOCS
>          LDFLAGS_vmlinux := --emit-relocs
>  endif
>  
> +KASAN_SHADOW_OFFSET := 0xdffffc0000000000

To keep things simple for x86, can you not just define:

KASAN_SHADOW_OFFSET := $(CONFIG_KASAN_SHADOW_OFFSET)

or, even better, in scripts/Makefile.kasan:

KASAN_SHADOW_OFFSET ?= $(CONFIG_KASAN_SHADOW_OFFSET)

and set it under arch/arm64/Makefile only.

-- 
Catalin
