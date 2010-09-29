From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 29 Sep 2010 13:56:13 +0100
Subject: [RFC PATCH] ARM: Allow HIGHPTE with OUTER_CACHE if the
	processor supports outer PTWs
In-Reply-To: <20100907124410.7084.64812.stgit@e102109-lin.cambridge.arm.com>
References: <20100907124410.7084.64812.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <1285764973.7983.33.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, 2010-09-07 at 13:46 +0100, Catalin Marinas wrote:
> This patch introduces CONFIG_CPU_HAS_OUTER_PTW (selected by CPU_V7) to
> allow HIGHPTE to be selected even when OUTER_CACHE is enabled.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
> 
> I haven't seen any discussion on the initial patch for HIGHPTE. I'm not
> sure why the limitation on !OUTER_CACHE. The set_pte_ext() at least on
> ARMv6 and ARMv7 doesn't do any outer cache flushing. Do we even need
> something like CPU_HAS_OUTER_PTW?

Any thoughts on this since you pushed the original patch for HIGHPTE? Is
there any architecture that does outer cache maintenance by physical
address in set_pte_ext()?

(keeping the patch below for reference, though I think we should just
drop the restriction on !OUTER_CACHE)

> I tested it on Versatile Express and haven't seen any errors.
> 
> 
>  arch/arm/Kconfig    |    2 +-
>  arch/arm/mm/Kconfig |    8 ++++++++
>  2 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index a7ed21f..17d00ec 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1318,7 +1318,7 @@ config HIGHMEM
>  config HIGHPTE
>         bool "Allocate 2nd-level pagetables from highmem"
>         depends on HIGHMEM
> -       depends on !OUTER_CACHE
> +       depends on !OUTER_CACHE || CPU_HAS_OUTER_PTW
> 
>  config HW_PERF_EVENTS
>         bool "Enable hardware performance counter support for perf events"
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 8493ed0..cf0fa87 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -420,6 +420,7 @@ config CPU_V7
>         select CPU_HAS_ASID if MMU
>         select CPU_COPY_V6 if MMU
>         select CPU_TLB_V7 if MMU
> +       select CPU_HAS_OUTER_PTW if MMU
> 
>  # Figure out what processor architecture version we should be using.
>  # This defines the compiler instruction set which depends on the machine type.
> @@ -607,6 +608,13 @@ config CPU_USE_DOMAINS
>           This option enables or disables the use of domain switching
>           via the set_fs() function.
> 
> +config CPU_HAS_OUTER_PTW
> +       bool
> +       depends on MMU
> +       help
> +         This option is enabled if the processors can perform page
> +         table walks on the outer cache.
> +
>  #
>  # CPU supports 36-bit I/O
>  #

-- 
Catalin
