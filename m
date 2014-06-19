From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Jun 2014 12:17:35 +0200
Subject: The problem of fixing the obvious problem...
In-Reply-To: <20140619094319.GN32514@n2100.arm.linux.org.uk>
References: <20140619094319.GN32514@n2100.arm.linux.org.uk>
Message-ID: <4332175.W7nZ6A4hH1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 June 2014 10:43:19 Russell King - ARM Linux wrote:
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 0ba482638ebf..2085b3d42ed6 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -28,7 +28,6 @@ config ARCH_OMAP4
>         select ARM_CPU_SUSPEND if PM
>         select ARM_ERRATA_720789
>         select ARM_GIC
> -       select CACHE_L2X0
>         select HAVE_ARM_SCU if SMP
>         select HAVE_ARM_TWD if SMP
>         select OMAP_INTERCONNECT
> 
> May look as if it's the right thing to do, but there's symbols lower down
> (PL310_ERRATA_*) which are selected which depend on this symbol being
> enabled.
> 
> What this means is that it's now possible for OMAP to be configured with
> CACHE_L2X0 disabled _and_ for the PL310_ERRATA_* options to be forced on,
> which results in:
> 
> warning: (SOC_IMX6 && SOC_VF610 && ARCH_OMAP4) selects PL310_ERRATA_588369 which has unmet direct dependencies (CACHE_L2X0)
> warning: (SOC_IMX6 && SOC_VF610 && ARCH_OMAP4) selects PL310_ERRATA_727915 which has unmet direct dependencies (CACHE_L2X0)
> 
> So, let's clean up this sillyness by doing the job properly - ensuring
> that /all/ PL310_ERRATA_* symbols are selected conditionally on
> CACHE_L2X0 (whether or not CACHE_L2X0 is selected), so when people remove
> that select statement, it doesn't cause these kinds of side effects.
> 
> The patch below will be in linux-next tomorrow.
> 
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> Subject: [PATCH] ARM: l2c: fix dependencies on PL310 errata symbols
> 
> A number of configurations spit out warnings similar to:
> 
> warning: (SOC_IMX6 && SOC_VF610 && ARCH_OMAP4) selects PL310_ERRATA_588369 which has unmet direct dependencies (CACHE_L2X0)
> warning: (SOC_IMX6 && SOC_VF610 && ARCH_OMAP4) selects PL310_ERRATA_727915 which has unmet direct dependencies (CACHE_L2X0)
> 
> Clean up the dependencies here:
> * PL310 symbols should only be selected when CACHE_L2X0 is enabled.
> * Since the cache-l2x0 code detects PL310 presence at runtime, and we will
>   eventually get rid of CACHE_PL310, surround these errata options with an
>   if CACHE_L2X0 conditional rather than repeating the dependency against
>   each.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 

Thanks a lot!

Acked-by: Arnd Bergmann <arnd@arndb.de>
