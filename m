From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 27 Jul 2015 16:59:23 +0100
Subject: [PATCH v4 5/7] arm64: add KASAN support
In-Reply-To: <1437756119-12817-6-git-send-email-a.ryabinin@samsung.com>
References: <1437756119-12817-1-git-send-email-a.ryabinin@samsung.com>
 <1437756119-12817-6-git-send-email-a.ryabinin@samsung.com>
Message-ID: <20150727155922.GB350@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 07:41:57PM +0300, Andrey Ryabinin wrote:
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 4d2a925..2cacf55 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -40,6 +40,12 @@ else
>  TEXT_OFFSET := 0x00080000
>  endif
>  
> +# KASAN_SHADOW_OFFSET = VA_START + (1 << (VA_BITS - 3)) - (1 << 61)
> +KASAN_SHADOW_OFFSET := $(shell printf "0x%x\n" $$(( \
> +			(-1 << $(CONFIG_ARM64_VA_BITS)) \
> +			+ (1 << ($(CONFIG_ARM64_VA_BITS) - 3)) \
> +			- (1 << (64 - 3)) )) )

Does this work with any POSIX shell? Do we always have a 64-bit type?
As I wasn't sure about this, I suggested awk (or perl).

> +static void __init clear_pgds(unsigned long start,
> +			unsigned long end)
> +{
> +	/*
> +	 * Remove references to kasan page tables from
> +	 * swapper_pg_dir. pgd_clear() can't be used
> +	 * here because it's nop on 2,3-level pagetable setups
> +	 */
> +	for (; start && start < end; start += PGDIR_SIZE)
> +		set_pgd(pgd_offset_k(start), __pgd(0));
> +}

I don't think we need the "start" check, just "start < end". Do you
expect a start == 0 (or overflow)?

-- 
Catalin
