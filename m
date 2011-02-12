From: andreiw@motorola.com (Andrei Warkentin)
Date: Sat, 12 Feb 2011 11:50:25 -0600
Subject: [PATCH 3/5] ARM: l2x0: Errata fix for flush by Way operation can
	cause data corruption
In-Reply-To: <1297510187-31547-4-git-send-email-santosh.shilimkar@ti.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
	<1297510187-31547-4-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <AANLkTimkqZ5datA+7shggbWz3+j=TDg5beUkQK=b1AmK@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 12, 2011 at 5:29 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> PL310 implements the Clean & Invalidate by Way L2 cache maintenance
> operation (offset 0x7FC). This operation runs in background so that
> PL310 can handle normal accesses while it is in progress. Under very
> rare circumstances, due to this erratum, write data can be lost when
> PL310 treats a cacheable write transaction during a Clean & Invalidate
> by Way operation.
>
> Workaround:
> Disable Write-Back and Cache Linefill (Debug Control Register)
> Clean & Invalidate by Way (0x7FC)
> Re-enable Write-Back and Cache Linefill (Debug Control Register)
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---
> ?arch/arm/Kconfig ? ? ? ? ? ?| ? 11 +++++++++++
> ?arch/arm/mach-omap2/Kconfig | ? ?1 +
> ?arch/arm/mm/cache-l2x0.c ? ?| ? 16 ++++++++++------
> ?3 files changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5cff165..2e6b879 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1177,6 +1177,17 @@ config ARM_ERRATA_743622
> ? ? ? ? ?visible impact on the overall performance or power consumption of the
> ? ? ? ? ?processor.
>
> +config PL310_ERRATA_727915
> + ? ? ? bool "Background Clean & Invalidate by Way operation can cause data corruption"
> + ? ? ? depends on CACHE_L2X0 && ARCH_OMAP4
> + ? ? ? help
> + ? ? ? ? PL310 implements the Clean & Invalidate by Way L2 cache maintenance
> + ? ? ? ? operation (offset 0x7FC). This operation runs in background so that
> + ? ? ? ? PL310 can handle normal accesses while it is in progress. Under very
> + ? ? ? ? rare circumstances, due to this erratum, write data can be lost when
> + ? ? ? ? PL310 treats a cacheable write transaction during a Clean &
> + ? ? ? ? Invalidate by Way operation Note that this errata uses Texas
> + ? ? ? ? Instrument's secure monitor api to implement the work around.
> ?endmenu
>
> ?source "arch/arm/common/Kconfig"
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index f285dd7..1f0ff75 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -46,6 +46,7 @@ config ARCH_OMAP4
> ? ? ? ?select ARM_GIC
> ? ? ? ?select LOCAL_TIMERS
> ? ? ? ?select PL310_ERRATA_588369
> + ? ? ? select PL310_ERRATA_727915
> ? ? ? ?select ARM_ERRATA_720789
> ? ? ? ?select ARCH_HAS_OPP
> ? ? ? ?select PM_OPP if PM
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index 170c9bb..c7c8fbe 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -67,7 +67,7 @@ static inline void l2x0_inv_line(unsigned long addr)
> ? ? ? ?writel_relaxed(addr, base + L2X0_INV_LINE_PA);
> ?}
>
> -#ifdef CONFIG_PL310_ERRATA_588369
> +#if defined(CONFIG_PL310_ERRATA_588369) || defined(CONFIG_PL310_ERRATA_727915)
> ?static void debug_writel(unsigned long val)
> ?{
> ? ? ? ?extern void omap_smc1(u32 fn, u32 arg);
> @@ -78,7 +78,14 @@ static void debug_writel(unsigned long val)
> ? ? ? ? */
> ? ? ? ?omap_smc1(0x100, val);
> ?}
> +#else
> +/* Optimised out for non-errata case */
> +static inline void debug_writel(unsigned long val)
> +{
> +}
> +#endif
>
> +#ifdef CONFIG_PL310_ERRATA_588369
> ?static inline void l2x0_flush_line(unsigned long addr)
> ?{
> ? ? ? ?void __iomem *base = l2x0_base;
> @@ -91,11 +98,6 @@ static inline void l2x0_flush_line(unsigned long addr)
> ?}
> ?#else
>
> -/* Optimised out for non-errata case */
> -static inline void debug_writel(unsigned long val)
> -{
> -}
> -
> ?static inline void l2x0_flush_line(unsigned long addr)
> ?{
> ? ? ? ?void __iomem *base = l2x0_base;
> @@ -119,9 +121,11 @@ static void l2x0_flush_all(void)
>
> ? ? ? ?/* clean all ways */
> ? ? ? ?spin_lock_irqsave(&l2x0_lock, flags);
> + ? ? ? debug_writel(0x03);
> ? ? ? ?writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_CLEAN_INV_WAY);
> ? ? ? ?cache_wait_way(l2x0_base + L2X0_CLEAN_INV_WAY, l2x0_way_mask);
> ? ? ? ?cache_sync();
> + ? ? ? debug_writel(0x00);
> ? ? ? ?spin_unlock_irqrestore(&l2x0_lock, flags);
> ?}
>
> --
> 1.6.0.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

Can these PL310 errata fixes be made more generic? PL310 is present in
non-OMAP platforms too, which lack the TI hypervisor. And these
platforms might have the same PL310 rev, and suffer the same glitches.
While ideally there is some kind of hypervisor_ops to modify the
protected register, at the very least there should be the generic
debug_write handling the  "I  can write all PL310 regs" case. If
you're interested I have a patch someplace that tried to do this,
hopefully I can still find it.
