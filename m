From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 07 Nov 2016 09:56:09 +0100
Subject: [PATCH v7 2/2] ARM: EXYNOS: refactoring of mach-exynos to enable
 chipid driver
In-Reply-To: <1478347427-28409-3-git-send-email-pankaj.dubey@samsung.com>
References: <1478347427-28409-1-git-send-email-pankaj.dubey@samsung.com>
 <1478347427-28409-3-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <8265239.AocGIQzL5f@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, November 5, 2016 5:33:47 PM CET Pankaj Dubey wrote:
> This patch enables chipid driver for ARCH_EXYNOS and refactors
> machine code for using chipid driver for identification of
> SoC ID and SoC rev.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/Kconfig                 |  1 +
>  arch/arm/mach-exynos/common.h                | 92 ----------------------------
>  arch/arm/mach-exynos/exynos.c                | 31 ----------
>  arch/arm/mach-exynos/firmware.c              | 10 +--
>  arch/arm/mach-exynos/include/mach/map.h      | 21 -------
>  arch/arm/mach-exynos/platsmp.c               | 22 ++++---
>  arch/arm/mach-exynos/pm.c                    | 41 ++++++++-----
>  arch/arm/plat-samsung/cpu.c                  | 14 -----
>  arch/arm/plat-samsung/include/plat/cpu.h     |  2 -
>  arch/arm/plat-samsung/include/plat/map-s5p.h |  2 -
>  10 files changed, 47 insertions(+), 189 deletions(-)
>  delete mode 100644 arch/arm/mach-exynos/include/mach/map.h

Nice code removal!

> -
>  static void __init exynos_init_io(void)
>  {
>  	debug_ll_io_init();
> -
> -	of_scan_flat_dt(exynos_fdt_map_chipid, NULL);
> -
> -	/* detect cpu id and rev. */
> -	s5p_init_cpu(S5P_VA_CHIPID);
>  }

This is now the default for .map_io, so you can remove the rest of the
function as well and do

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 757fc11de30d..808872981f45 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -234,7 +234,6 @@ DT_MACHINE_START(EXYNOS_DT, "SAMSUNG EXYNOS (Flattened Device Tree)")
 	.l2c_aux_val	= 0x3c400001,
 	.l2c_aux_mask	= 0xc20fffff,
 	.smp		= smp_ops(exynos_smp_ops),
-	.map_io		= exynos_init_io,
 	.init_early	= exynos_firmware_init,
 	.init_irq	= exynos_init_irq,
 	.init_machine	= exynos_dt_machine_init,

> diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
> index fd6da54..a9f8504e 100644
> --- a/arch/arm/mach-exynos/firmware.c
> +++ b/arch/arm/mach-exynos/firmware.c
> @@ -44,7 +44,7 @@ static int exynos_do_idle(unsigned long mode)
>  		writel_relaxed(virt_to_phys(exynos_cpu_resume_ns),
>  			       sysram_ns_base_addr + 0x24);
>  		writel_relaxed(EXYNOS_AFTR_MAGIC, sysram_ns_base_addr + 0x20);
> -		if (soc_is_exynos3250()) {
> +		if (of_machine_is_compatible("samsung,exynos3250")) {
>  			flush_cache_all();
>  			exynos_smc(SMC_CMD_SAVE, OP_TYPE_CORE,
>  				   SMC_POWERSTATE_IDLE, 0);

I'd rather not see a proliferation of many such checks. Please try
to rework it to have fewer checks, e.g. by having a separate instance
of "struct firmware_ops" for each incompatible variant and making the
decision once.

>  
> +static struct soc_device_attribute exynos4210_rev11[] = {
> +	{ .soc_id = "EXYNOS4210", .revision = "11", },
> +	{ },
> +};
> +
>  static void __iomem *cpu_boot_reg_base(void)
>  {
> -	if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_1_1)
> +	if (soc_device_match(exynos4210_rev11))
>  		return pmu_base_addr + S5P_INFORM5;
>  	return sysram_base_addr;
>  }
> @@ -182,9 +187,10 @@ static inline void __iomem *cpu_boot_reg(int cpu)
>  	boot_reg = cpu_boot_reg_base();
>  	if (!boot_reg)
>  		return IOMEM_ERR_PTR(-ENODEV);
> -	if (soc_is_exynos4412())
> +	if (of_machine_is_compatible("samsung,exynos4412"))
>  		boot_reg += 4*cpu;
> -	else if (soc_is_exynos5420() || soc_is_exynos5800())
> +	else if (of_machine_is_compatible("samsung,exynos5420") ||
> +			of_machine_is_compatible("samsung,exynos5800"))
>  		boot_reg += 4;
>  	return boot_reg;
>  }

Same here, it would be nicer to rework the code to compute the address
once while called from a place where you already know this information
and then store the register address.

>  
> +static struct soc_device_attribute exynos4210_rev11[] = {
> +	{ .soc_id = "EXYNOS4210", .revision = "11", },
> +	{ },
> +};
> +
> +static struct soc_device_attribute exynos4210_rev10[] = {
> +	{ .soc_id = "EXYNOS4210", .revision = "10", },
> +	{ },
> +};

Please use a single 'soc_device_attribute' table and make use
of the .data field to encode the difference.

	Arnd
