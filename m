From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 12 Nov 2015 13:30:05 +0900
Subject: [PATCH v4 7/9] ARM: EXYNOS: split up exynos5420 SoC specific PMU
 data
In-Reply-To: <1447155784-12667-8-git-send-email-pankaj.dubey@samsung.com>
References: <1447155784-12667-1-git-send-email-pankaj.dubey@samsung.com>
 <1447155784-12667-8-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <564415CD.3070608@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.11.2015 20:43, Pankaj Dubey wrote:
> This patch splits up mach-exynos/pmu.c file, and moves exynos5420,
> PMU configuration data and functions handing data into exynos5420
> SoC specific PMU file mach-exynos/exynos5420-pmu.c.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/Makefile         |   2 +-
>  arch/arm/mach-exynos/exynos-pmu.h     |   1 +
>  arch/arm/mach-exynos/exynos5420-pmu.c | 280 ++++++++++++++++++++++++++++++++++
>  arch/arm/mach-exynos/pmu.c            | 263 -------------------------------
>  4 files changed, 282 insertions(+), 264 deletions(-)
>  create mode 100644 arch/arm/mach-exynos/exynos5420-pmu.c
> 
> diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
> index bfb23a5..2d58063 100644
> --- a/arch/arm/mach-exynos/Makefile
> +++ b/arch/arm/mach-exynos/Makefile
> @@ -11,7 +11,7 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) += -I$(srctree)/$(src)/include -I$(srctree)
>  
>  obj-$(CONFIG_ARCH_EXYNOS)	+= exynos.o pmu.o exynos-smc.o firmware.o \
>  					exynos3250-pmu.o exynos4-pmu.o \
> -					exynos5250-pmu.o
> +					exynos5250-pmu.o exynos5420-pmu.o
>  
>  obj-$(CONFIG_EXYNOS_CPU_SUSPEND) += pm.o sleep.o
>  obj-$(CONFIG_PM_SLEEP)		+= suspend.o
> diff --git a/arch/arm/mach-exynos/exynos-pmu.h b/arch/arm/mach-exynos/exynos-pmu.h
> index 003fa6d..306f5c7 100644
> --- a/arch/arm/mach-exynos/exynos-pmu.h
> +++ b/arch/arm/mach-exynos/exynos-pmu.h
> @@ -38,6 +38,7 @@ extern const struct exynos_pmu_data exynos4210_pmu_data;
>  extern const struct exynos_pmu_data exynos4212_pmu_data;
>  extern const struct exynos_pmu_data exynos4412_pmu_data;
>  extern const struct exynos_pmu_data exynos5250_pmu_data;
> +extern const struct exynos_pmu_data exynos5420_pmu_data;
>  
>  extern void pmu_raw_writel(u32 val, u32 offset);
>  extern u32 pmu_raw_readl(u32 offset);
> diff --git a/arch/arm/mach-exynos/exynos5420-pmu.c b/arch/arm/mach-exynos/exynos5420-pmu.c
> new file mode 100644
> index 0000000..5810afe
> --- /dev/null
> +++ b/arch/arm/mach-exynos/exynos5420-pmu.c
> @@ -0,0 +1,280 @@
> +/*
> + * Copyright (c) 2011-2015 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * EXYNOS5420 - CPU PMU (Power Management Unit) support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/pm.h>
> +#include <linux/soc/samsung/exynos-regs-pmu.h>
> +#include <linux/soc/samsung/exynos-pmu.h>
> +
> +#include <asm/cputype.h>
> +
> +#include "exynos-pmu.h"
> +
> +static struct exynos_pmu_conf exynos5420_pmu_config[] = {
> +	/* { .offset = offset, .val = { AFTR, LPA, SLEEP } */
> +	{ EXYNOS5_ARM_CORE0_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5_DIS_IRQ_ARM_CORE0_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5_DIS_IRQ_ARM_CORE0_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
> +	{ EXYNOS5_ARM_CORE1_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5_DIS_IRQ_ARM_CORE1_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5_DIS_IRQ_ARM_CORE1_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_ARM_CORE2_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_DIS_IRQ_ARM_CORE2_LOCAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_DIS_IRQ_ARM_CORE2_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_ARM_CORE3_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_DIS_IRQ_ARM_CORE3_LOCAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_DIS_IRQ_ARM_CORE3_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_KFC_CORE0_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_DIS_IRQ_KFC_CORE0_LOCAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_DIS_IRQ_KFC_CORE0_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_KFC_CORE1_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_DIS_IRQ_KFC_CORE1_LOCAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_DIS_IRQ_KFC_CORE1_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_KFC_CORE2_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_DIS_IRQ_KFC_CORE2_LOCAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_DIS_IRQ_KFC_CORE2_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_KFC_CORE3_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_DIS_IRQ_KFC_CORE3_LOCAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_DIS_IRQ_KFC_CORE3_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
> +	{ EXYNOS5_ISP_ARM_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5_DIS_IRQ_ISP_ARM_LOCAL_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5_DIS_IRQ_ISP_ARM_CENTRAL_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5420_ARM_COMMON_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_KFC_COMMON_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5_ARM_L2_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_KFC_L2_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5_CMU_ACLKSTOP_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5_CMU_SCLKSTOP_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
> +	{ EXYNOS5_CMU_RESET_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
> +	{ EXYNOS5_CMU_ACLKSTOP_SYSMEM_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5_CMU_SCLKSTOP_SYSMEM_SYS_PWR_REG,	{ 0x1, 0x0, 0x1} },
> +	{ EXYNOS5_CMU_RESET_SYSMEM_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
> +	{ EXYNOS5_DRAM_FREQ_DOWN_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
> +	{ EXYNOS5_DDRPHY_DLLOFF_SYS_PWR_REG,		{ 0x1, 0x1, 0x1} },
> +	{ EXYNOS5_DDRPHY_DLLLOCK_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
> +	{ EXYNOS5_APLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5_MPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5_VPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5_EPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
> +	{ EXYNOS5_BPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5_CPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5420_DPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5420_IPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5420_KPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5_MPLLUSER_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5_BPLLUSER_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5420_RPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5420_SPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5_TOP_BUS_SYS_PWR_REG,			{ 0x3, 0x0, 0x0} },
> +	{ EXYNOS5_TOP_RETENTION_SYS_PWR_REG,		{ 0x1, 0x1, 0x1} },
> +	{ EXYNOS5_TOP_PWR_SYS_PWR_REG,			{ 0x3, 0x3, 0x0} },
> +	{ EXYNOS5_TOP_BUS_SYSMEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
> +	{ EXYNOS5_TOP_RETENTION_SYSMEM_SYS_PWR_REG,	{ 0x1, 0x0, 0x1} },
> +	{ EXYNOS5_TOP_PWR_SYSMEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
> +	{ EXYNOS5_LOGIC_RESET_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
> +	{ EXYNOS5_OSCCLK_GATE_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
> +	{ EXYNOS5_LOGIC_RESET_SYSMEM_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5_OSCCLK_GATE_SYSMEM_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5420_INTRAM_MEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x3} },
> +	{ EXYNOS5420_INTROM_MEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x3} },
> +	{ EXYNOS5_PAD_RETENTION_DRAM_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5_PAD_RETENTION_MAU_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
> +	{ EXYNOS5420_PAD_RETENTION_JTAG_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
> +	{ EXYNOS5420_PAD_RETENTION_DRAM_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5420_PAD_RETENTION_UART_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5420_PAD_RETENTION_MMC0_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5420_PAD_RETENTION_MMC1_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5420_PAD_RETENTION_MMC2_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5420_PAD_RETENTION_HSI_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5420_PAD_RETENTION_EBIA_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5420_PAD_RETENTION_EBIB_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5420_PAD_RETENTION_SPI_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5420_PAD_RETENTION_DRAM_COREBLK_SYS_PWR_REG, { 0x1, 0x0, 0x0} },
> +	{ EXYNOS5_PAD_ISOLATION_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
> +	{ EXYNOS5_PAD_ISOLATION_SYSMEM_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5_PAD_ALV_SEL_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5_XUSBXTI_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
> +	{ EXYNOS5_XXTI_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
> +	{ EXYNOS5_EXT_REGULATOR_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
> +	{ EXYNOS5_GPIO_MODE_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5_GPIO_MODE_SYSMEM_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
> +	{ EXYNOS5_GPIO_MODE_MAU_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
> +	{ EXYNOS5_TOP_ASB_RESET_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
> +	{ EXYNOS5_TOP_ASB_ISOLATION_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
> +	{ EXYNOS5_GSCL_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
> +	{ EXYNOS5_ISP_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
> +	{ EXYNOS5_MFC_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
> +	{ EXYNOS5_G3D_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
> +	{ EXYNOS5420_DISP1_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
> +	{ EXYNOS5420_MAU_SYS_PWR_REG,			{ 0x7, 0x7, 0x0} },
> +	{ EXYNOS5420_G2D_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
> +	{ EXYNOS5420_MSC_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
> +	{ EXYNOS5420_FSYS_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
> +	{ EXYNOS5420_FSYS2_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
> +	{ EXYNOS5420_PSGEN_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
> +	{ EXYNOS5420_PERIC_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
> +	{ EXYNOS5420_WCORE_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
> +	{ EXYNOS5_CMU_CLKSTOP_GSCL_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5_CMU_CLKSTOP_ISP_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5_CMU_CLKSTOP_MFC_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5_CMU_CLKSTOP_G3D_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_CMU_CLKSTOP_DISP1_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_CMU_CLKSTOP_MAU_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_CMU_CLKSTOP_G2D_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_CMU_CLKSTOP_MSC_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_CMU_CLKSTOP_FSYS_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_CMU_CLKSTOP_PSGEN_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_CMU_CLKSTOP_PERIC_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_CMU_CLKSTOP_WCORE_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5_CMU_SYSCLK_GSCL_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5_CMU_SYSCLK_ISP_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5_CMU_SYSCLK_MFC_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5_CMU_SYSCLK_G3D_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_CMU_SYSCLK_DISP1_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_CMU_SYSCLK_MAU_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_CMU_SYSCLK_G2D_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_CMU_SYSCLK_MSC_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_CMU_SYSCLK_FSYS_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_CMU_SYSCLK_FSYS2_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_CMU_SYSCLK_PSGEN_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_CMU_SYSCLK_PERIC_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_CMU_SYSCLK_WCORE_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_CMU_RESET_FSYS2_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_CMU_RESET_PSGEN_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_CMU_RESET_PERIC_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_CMU_RESET_WCORE_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5_CMU_RESET_GSCL_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5_CMU_RESET_ISP_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5_CMU_RESET_MFC_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5_CMU_RESET_G3D_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_CMU_RESET_DISP1_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_CMU_RESET_MAU_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_CMU_RESET_G2D_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_CMU_RESET_MSC_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
> +	{ EXYNOS5420_CMU_RESET_FSYS_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
> +	{ PMU_TABLE_END,},
> +};
> +
> +static unsigned int const exynos5420_list_disable_pmu_reg[] = {
> +	EXYNOS5_CMU_CLKSTOP_GSCL_SYS_PWR_REG,
> +	EXYNOS5_CMU_CLKSTOP_ISP_SYS_PWR_REG,
> +	EXYNOS5_CMU_CLKSTOP_G3D_SYS_PWR_REG,
> +	EXYNOS5420_CMU_CLKSTOP_DISP1_SYS_PWR_REG,
> +	EXYNOS5420_CMU_CLKSTOP_MAU_SYS_PWR_REG,
> +	EXYNOS5420_CMU_CLKSTOP_G2D_SYS_PWR_REG,
> +	EXYNOS5420_CMU_CLKSTOP_MSC_SYS_PWR_REG,
> +	EXYNOS5420_CMU_CLKSTOP_FSYS_SYS_PWR_REG,
> +	EXYNOS5420_CMU_CLKSTOP_PSGEN_SYS_PWR_REG,
> +	EXYNOS5420_CMU_CLKSTOP_PERIC_SYS_PWR_REG,
> +	EXYNOS5420_CMU_CLKSTOP_WCORE_SYS_PWR_REG,
> +	EXYNOS5_CMU_SYSCLK_GSCL_SYS_PWR_REG,
> +	EXYNOS5_CMU_SYSCLK_ISP_SYS_PWR_REG,
> +	EXYNOS5_CMU_SYSCLK_G3D_SYS_PWR_REG,
> +	EXYNOS5420_CMU_SYSCLK_DISP1_SYS_PWR_REG,
> +	EXYNOS5420_CMU_SYSCLK_MAU_SYS_PWR_REG,
> +	EXYNOS5420_CMU_SYSCLK_G2D_SYS_PWR_REG,
> +	EXYNOS5420_CMU_SYSCLK_MSC_SYS_PWR_REG,
> +	EXYNOS5420_CMU_SYSCLK_FSYS_SYS_PWR_REG,
> +	EXYNOS5420_CMU_SYSCLK_FSYS2_SYS_PWR_REG,
> +	EXYNOS5420_CMU_SYSCLK_PSGEN_SYS_PWR_REG,
> +	EXYNOS5420_CMU_SYSCLK_PERIC_SYS_PWR_REG,
> +	EXYNOS5420_CMU_SYSCLK_WCORE_SYS_PWR_REG,
> +	EXYNOS5420_CMU_RESET_FSYS2_SYS_PWR_REG,
> +	EXYNOS5420_CMU_RESET_PSGEN_SYS_PWR_REG,
> +	EXYNOS5420_CMU_RESET_PERIC_SYS_PWR_REG,
> +	EXYNOS5420_CMU_RESET_WCORE_SYS_PWR_REG,
> +	EXYNOS5_CMU_RESET_GSCL_SYS_PWR_REG,
> +	EXYNOS5_CMU_RESET_ISP_SYS_PWR_REG,
> +	EXYNOS5_CMU_RESET_G3D_SYS_PWR_REG,
> +	EXYNOS5420_CMU_RESET_DISP1_SYS_PWR_REG,
> +	EXYNOS5420_CMU_RESET_MAU_SYS_PWR_REG,
> +	EXYNOS5420_CMU_RESET_G2D_SYS_PWR_REG,
> +	EXYNOS5420_CMU_RESET_MSC_SYS_PWR_REG,
> +	EXYNOS5420_CMU_RESET_FSYS_SYS_PWR_REG,
> +};
> +
> +void exynos5420_powerdown_conf(enum sys_powerdown mode)
> +{
> +	u32 this_cluster;
> +
> +	this_cluster = MPIDR_AFFINITY_LEVEL(read_cpuid_mpidr(), 1);
> +
> +	/*
> +	 * set the cluster id to IROM register to ensure that we wake
> +	 * up with the current cluster.
> +	 */
> +	pmu_raw_writel(this_cluster, EXYNOS_IROM_DATA2);
> +}

... the more he looked inside the more Piglet, I mean static, wasn't there.

Best regards,
Krzysztof
