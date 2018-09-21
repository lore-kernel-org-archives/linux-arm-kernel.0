From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 21 Sep 2018 18:11:26 +0100
Subject: [PATCH 4/5] arm64: mmap: Allow for "high" 52-bit VA allocations
In-Reply-To: <20180829124543.25314-5-steve.capper@arm.com>
References: <20180829124543.25314-1-steve.capper@arm.com>
 <20180829124543.25314-5-steve.capper@arm.com>
Message-ID: <20180921171126.GC238853@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On Wed, Aug 29, 2018 at 01:45:42PM +0100, Steve Capper wrote:
> This patch alters arch_get_unmapped_area and
> arch_get_unmapped_area_topdown such that mmap calls with an addr
> parameter that lie above 48-bit VAs will receive a VA that lies within
> the 52-bit VA space on systems that support it.

The changes here don't seem to be too extensive. Can we not change the
generic code with some default functions that don't change the
functionality?

On x86 they had this code for years, so they patched it for 56-bit
support but on arm I'd like to still use the generic code.

> diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
> index b516e0bfdb71..827414b69866 100644
> --- a/arch/arm64/mm/mmap.c
> +++ b/arch/arm64/mm/mmap.c
> @@ -81,6 +81,15 @@ static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
>  
>  extern unsigned long mmap_min_addr;
>  
> +static unsigned long get_end_address(unsigned long addr)
> +{
> +	if (IS_ENABLED(CONFIG_ARM64_TRY_52BIT_VA) &&
> +			(addr > DEFAULT_MAP_WINDOW))
> +		return TASK_SIZE;
> +	else
> +		return DEFAULT_MAP_WINDOW;
> +}

We could as well have a generic get_end_address() (or a better name that
resembles high_limit) that always returns TASK_SIZE. We'd override it
for arm64.

-- 
Catalin
