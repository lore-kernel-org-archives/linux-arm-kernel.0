From: will.deacon@arm.com (Will Deacon)
Date: Wed, 25 Feb 2015 14:01:30 +0000
Subject: [PATCH v2] arm64: mm: increase VA range of identity map
In-Reply-To: <1424797703-2804-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1424797703-2804-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150225140130.GF12377@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 24, 2015 at 05:08:23PM +0000, Ard Biesheuvel wrote:
> The page size and the number of translation levels, and hence the supported
> virtual address range, are build-time configurables on arm64 whose optimal
> values are use case dependent. However, in the current implementation, if
> the system's RAM is located at a very high offset, the virtual address range
> needs to reflect that merely because the identity mapping, which is only used
> to enable or disable the MMU, requires the extended virtual range to map the
> physical memory at an equal virtual offset.
> 
> This patch relaxes that requirement, by increasing the number of translation
> levels for the identity mapping only, and only when actually needed, i.e.,
> when system RAM's offset is found to be out of reach at runtime.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> v2:
> - Dropped hunk regarding KVM, this will be addressed separately. Note that the
>   build is still broken on Seattle if you have KVM enabled and 4k pages with
>   3 levels of translation configured, but at least you have something to watch
>   on your console now
> - Fix ordering wrt TLB flushing
> - Set T0SZ based on actual leading zero count in __pa(KERNEL_END), the net
>   result is the same (one additional level of translation, if needed)
> 
>  arch/arm64/include/asm/mmu_context.h   | 38 ++++++++++++++++++++++++++++++++++
>  arch/arm64/include/asm/page.h          |  6 ++++--
>  arch/arm64/include/asm/pgtable-hwdef.h |  7 ++++++-
>  arch/arm64/kernel/head.S               | 22 ++++++++++++++++++++
>  arch/arm64/kernel/smp.c                |  1 +
>  arch/arm64/mm/mmu.c                    |  7 ++++++-
>  arch/arm64/mm/proc-macros.S            | 11 ++++++++++
>  arch/arm64/mm/proc.S                   |  3 +++
>  8 files changed, 91 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index a9eee33dfa62..641ce0574999 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -64,6 +64,44 @@ static inline void cpu_set_reserved_ttbr0(void)
>  	: "r" (ttbr));
>  }
>  
> +/*
> + * TCR.T0SZ value to use when the ID map is active. Usually equals
> + * TCR_T0SZ(VA_BITS), unless system RAM is positioned very high in
> + * physical memory, in which case it will be smaller.
> + */
> +extern u64 idmap_t0sz;
> +
> +static inline void __cpu_set_tcr_t0sz(u64 t0sz)
> +{
> +	unsigned long tcr;
> +
> +	if (!IS_ENABLED(CONFIG_ARM64_VA_BITS_48)
> +	    && unlikely(idmap_t0sz != TCR_T0SZ(VA_BITS)))
> +		asm volatile(
> +		"	mrs	%0, tcr_el1		;"
> +		"	bfi	%0, %1, #%2, #%3	;"

It's odd that you need these '#'s. Do you see issues without them?

> +		"	msr	tcr_el1, %0		;"
> +		"	isb"
> +		: "=&r" (tcr)
> +		: "r"(t0sz), "I"(TCR_T0SZ_OFFSET), "I"(TCR_TxSZ_WIDTH));
> +}

Hmm, do we need a memory clobber here, or can we rely on the caller doing
having the appropriate compiler barriers?

Will
