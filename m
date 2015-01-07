From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 07 Jan 2015 11:01:27 +0530
Subject: [PATCH v2 5/6] ARCH: EXYNOS: split up exynos5420 SoC specific PMU data
In-Reply-To: <1420608688-10459-1-git-send-email-pankaj.dubey@samsung.com>
References: <1420608688-10459-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1420608688-10459-6-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch splits up mach-exynos/pmu.c file, and moves exynos5420,
PMU configuration data and functions handing data into exynos5420
SoC specific PMU file mach-exynos/exynos5420-pmu.c.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/Makefile         |   2 +-
 arch/arm/mach-exynos/exynos-pmu.h     |   1 +
 arch/arm/mach-exynos/exynos5420-pmu.c | 297 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-exynos/pmu.c            | 281 --------------------------------
 4 files changed, 299 insertions(+), 282 deletions(-)
 create mode 100644 arch/arm/mach-exynos/exynos5420-pmu.c

diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index de3c26a..462df1b 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -11,7 +11,7 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) += -I$(srctree)/$(src)/include -I$(srctree)
 
 obj-$(CONFIG_ARCH_EXYNOS)	+= exynos.o pmu.o exynos-smc.o firmware.o \
 					exynos3250-pmu.o exynos4-pmu.o \
-					exynos5250-pmu.o
+					exynos5250-pmu.o exynos5420-pmu.o
 
 obj-$(CONFIG_EXYNOS_CPU_SUSPEND) += pm.o sleep.o
 obj-$(CONFIG_PM_SLEEP)		+= suspend.o
diff --git a/arch/arm/mach-exynos/exynos-pmu.h b/arch/arm/mach-exynos/exynos-pmu.h
index 98c6bf3..4d53b68 100644
--- a/arch/arm/mach-exynos/exynos-pmu.h
+++ b/arch/arm/mach-exynos/exynos-pmu.h
@@ -48,4 +48,5 @@ extern const struct exynos_pmu_data exynos4210_pmu_data;
 extern const struct exynos_pmu_data exynos4212_pmu_data;
 extern const struct exynos_pmu_data exynos4412_pmu_data;
 extern const struct exynos_pmu_data exynos5250_pmu_data;
+extern const struct exynos_pmu_data exynos5420_pmu_data;
 #endif /* __EXYNOSPMU_H */
diff --git a/arch/arm/mach-exynos/exynos5420-pmu.c b/arch/arm/mach-exynos/exynos5420-pmu.c
new file mode 100644
index 0000000..beecd2e
--- /dev/null
+++ b/arch/arm/mach-exynos/exynos5420-pmu.c
@@ -0,0 +1,297 @@
+/*
+ * Copyright (c) 2011-2015 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * EXYNOS5420 - CPU PMU (Power Management Unit) support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/soc/samsung/exynos-regs-pmu.h>
+#include <linux/soc/samsung/exynos-pmu.h>
+
+#include "exynos-pmu.h"
+
+static struct exynos_pmu_conf exynos5420_pmu_config[] = {
+	/* { .offset = offset, .val = { AFTR, LPA, SLEEP } */
+	{ EXYNOS5_ARM_CORE0_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_DIS_IRQ_ARM_CORE0_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_DIS_IRQ_ARM_CORE0_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5_ARM_CORE1_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_DIS_IRQ_ARM_CORE1_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_DIS_IRQ_ARM_CORE1_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_ARM_CORE2_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_DIS_IRQ_ARM_CORE2_LOCAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_DIS_IRQ_ARM_CORE2_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_ARM_CORE3_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_DIS_IRQ_ARM_CORE3_LOCAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_DIS_IRQ_ARM_CORE3_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_KFC_CORE0_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_DIS_IRQ_KFC_CORE0_LOCAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_DIS_IRQ_KFC_CORE0_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_KFC_CORE1_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_DIS_IRQ_KFC_CORE1_LOCAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_DIS_IRQ_KFC_CORE1_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_KFC_CORE2_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_DIS_IRQ_KFC_CORE2_LOCAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_DIS_IRQ_KFC_CORE2_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_KFC_CORE3_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_DIS_IRQ_KFC_CORE3_LOCAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_DIS_IRQ_KFC_CORE3_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5_ISP_ARM_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_DIS_IRQ_ISP_ARM_LOCAL_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_DIS_IRQ_ISP_ARM_CENTRAL_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_ARM_COMMON_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_KFC_COMMON_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_ARM_L2_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_KFC_L2_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_CMU_ACLKSTOP_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_CMU_SCLKSTOP_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5_CMU_RESET_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_CMU_ACLKSTOP_SYSMEM_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_CMU_SCLKSTOP_SYSMEM_SYS_PWR_REG,	{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5_CMU_RESET_SYSMEM_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_DRAM_FREQ_DOWN_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5_DDRPHY_DLLOFF_SYS_PWR_REG,		{ 0x1, 0x1, 0x1} },
+	{ EXYNOS5_DDRPHY_DLLLOCK_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5_APLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_MPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_VPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_EPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_BPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_CPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_DPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_IPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_KPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_MPLLUSER_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_BPLLUSER_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_RPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_SPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_TOP_BUS_SYS_PWR_REG,			{ 0x3, 0x0, 0x0} },
+	{ EXYNOS5_TOP_RETENTION_SYS_PWR_REG,		{ 0x1, 0x1, 0x1} },
+	{ EXYNOS5_TOP_PWR_SYS_PWR_REG,			{ 0x3, 0x3, 0x0} },
+	{ EXYNOS5_TOP_BUS_SYSMEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
+	{ EXYNOS5_TOP_RETENTION_SYSMEM_SYS_PWR_REG,	{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5_TOP_PWR_SYSMEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
+	{ EXYNOS5_LOGIC_RESET_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_OSCCLK_GATE_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5_LOGIC_RESET_SYSMEM_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_OSCCLK_GATE_SYSMEM_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_INTRAM_MEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x3} },
+	{ EXYNOS5420_INTROM_MEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x3} },
+	{ EXYNOS5_PAD_RETENTION_DRAM_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_PAD_RETENTION_MAU_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5420_PAD_RETENTION_JTAG_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5420_PAD_RETENTION_DRAM_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_PAD_RETENTION_UART_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_PAD_RETENTION_MMC0_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_PAD_RETENTION_MMC1_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_PAD_RETENTION_MMC2_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_PAD_RETENTION_HSI_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_PAD_RETENTION_EBIA_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_PAD_RETENTION_EBIB_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_PAD_RETENTION_SPI_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_PAD_RETENTION_DRAM_COREBLK_SYS_PWR_REG, { 0x1, 0x0, 0x0} },
+	{ EXYNOS5_PAD_ISOLATION_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_PAD_ISOLATION_SYSMEM_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_PAD_ALV_SEL_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_XUSBXTI_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_XXTI_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_EXT_REGULATOR_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_GPIO_MODE_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_GPIO_MODE_SYSMEM_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_GPIO_MODE_MAU_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_TOP_ASB_RESET_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_TOP_ASB_ISOLATION_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_GSCL_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5_ISP_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5_MFC_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5_G3D_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5420_DISP1_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5420_MAU_SYS_PWR_REG,			{ 0x7, 0x7, 0x0} },
+	{ EXYNOS5420_G2D_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5420_MSC_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5420_FSYS_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5420_FSYS2_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5420_PSGEN_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5420_PERIC_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5420_WCORE_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5_CMU_CLKSTOP_GSCL_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_CMU_CLKSTOP_ISP_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_CMU_CLKSTOP_MFC_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_CMU_CLKSTOP_G3D_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_CLKSTOP_DISP1_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_CLKSTOP_MAU_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_CLKSTOP_G2D_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_CLKSTOP_MSC_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_CLKSTOP_FSYS_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_CLKSTOP_PSGEN_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_CLKSTOP_PERIC_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_CLKSTOP_WCORE_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_CMU_SYSCLK_GSCL_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_CMU_SYSCLK_ISP_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_CMU_SYSCLK_MFC_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_CMU_SYSCLK_G3D_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_SYSCLK_DISP1_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_SYSCLK_MAU_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_SYSCLK_G2D_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_SYSCLK_MSC_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_SYSCLK_FSYS_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_SYSCLK_FSYS2_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_SYSCLK_PSGEN_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_SYSCLK_PERIC_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_SYSCLK_WCORE_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_RESET_FSYS2_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_RESET_PSGEN_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_RESET_PERIC_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_RESET_WCORE_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_CMU_RESET_GSCL_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_CMU_RESET_ISP_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_CMU_RESET_MFC_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_CMU_RESET_G3D_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_RESET_DISP1_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_RESET_MAU_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_RESET_G2D_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_RESET_MSC_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_RESET_FSYS_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ PMU_TABLE_END,},
+};
+
+static unsigned int const exynos5420_list_disable_pmu_reg[] = {
+	EXYNOS5_CMU_CLKSTOP_GSCL_SYS_PWR_REG,
+	EXYNOS5_CMU_CLKSTOP_ISP_SYS_PWR_REG,
+	EXYNOS5_CMU_CLKSTOP_G3D_SYS_PWR_REG,
+	EXYNOS5420_CMU_CLKSTOP_DISP1_SYS_PWR_REG,
+	EXYNOS5420_CMU_CLKSTOP_MAU_SYS_PWR_REG,
+	EXYNOS5420_CMU_CLKSTOP_G2D_SYS_PWR_REG,
+	EXYNOS5420_CMU_CLKSTOP_MSC_SYS_PWR_REG,
+	EXYNOS5420_CMU_CLKSTOP_FSYS_SYS_PWR_REG,
+	EXYNOS5420_CMU_CLKSTOP_PSGEN_SYS_PWR_REG,
+	EXYNOS5420_CMU_CLKSTOP_PERIC_SYS_PWR_REG,
+	EXYNOS5420_CMU_CLKSTOP_WCORE_SYS_PWR_REG,
+	EXYNOS5_CMU_SYSCLK_GSCL_SYS_PWR_REG,
+	EXYNOS5_CMU_SYSCLK_ISP_SYS_PWR_REG,
+	EXYNOS5_CMU_SYSCLK_G3D_SYS_PWR_REG,
+	EXYNOS5420_CMU_SYSCLK_DISP1_SYS_PWR_REG,
+	EXYNOS5420_CMU_SYSCLK_MAU_SYS_PWR_REG,
+	EXYNOS5420_CMU_SYSCLK_G2D_SYS_PWR_REG,
+	EXYNOS5420_CMU_SYSCLK_MSC_SYS_PWR_REG,
+	EXYNOS5420_CMU_SYSCLK_FSYS_SYS_PWR_REG,
+	EXYNOS5420_CMU_SYSCLK_FSYS2_SYS_PWR_REG,
+	EXYNOS5420_CMU_SYSCLK_PSGEN_SYS_PWR_REG,
+	EXYNOS5420_CMU_SYSCLK_PERIC_SYS_PWR_REG,
+	EXYNOS5420_CMU_SYSCLK_WCORE_SYS_PWR_REG,
+	EXYNOS5420_CMU_RESET_FSYS2_SYS_PWR_REG,
+	EXYNOS5420_CMU_RESET_PSGEN_SYS_PWR_REG,
+	EXYNOS5420_CMU_RESET_PERIC_SYS_PWR_REG,
+	EXYNOS5420_CMU_RESET_WCORE_SYS_PWR_REG,
+	EXYNOS5_CMU_RESET_GSCL_SYS_PWR_REG,
+	EXYNOS5_CMU_RESET_ISP_SYS_PWR_REG,
+	EXYNOS5_CMU_RESET_G3D_SYS_PWR_REG,
+	EXYNOS5420_CMU_RESET_DISP1_SYS_PWR_REG,
+	EXYNOS5420_CMU_RESET_MAU_SYS_PWR_REG,
+	EXYNOS5420_CMU_RESET_G2D_SYS_PWR_REG,
+	EXYNOS5420_CMU_RESET_MSC_SYS_PWR_REG,
+	EXYNOS5420_CMU_RESET_FSYS_SYS_PWR_REG,
+};
+
+void exynos5420_powerdown_conf(enum sys_powerdown mode)
+{
+	u32 this_cluster;
+
+	this_cluster = MPIDR_AFFINITY_LEVEL(read_cpuid_mpidr(), 1);
+
+	/*
+	 * set the cluster id to IROM register to ensure that we wake
+	 * up with the current cluster.
+	 */
+	pmu_raw_writel(this_cluster, EXYNOS_IROM_DATA2);
+}
+
+static void exynos5_power_off(void)
+{
+	unsigned int tmp;
+
+	pr_info("Power down.\n");
+	tmp = pmu_raw_readl(EXYNOS_PS_HOLD_CONTROL);
+	tmp ^= (1 << 8);
+	pmu_raw_writel(tmp, EXYNOS_PS_HOLD_CONTROL);
+
+	/* Wait a little so we don't give a false warning below */
+	mdelay(100);
+
+	pr_err("Power down failed, please power off system manually.\n");
+	while (1)
+		;
+}
+
+static void exynos5420_pmu_init(void)
+{
+	unsigned int value;
+	int i;
+
+	/*
+	 * Set the CMU_RESET, CMU_SYSCLK and CMU_CLKSTOP registers
+	 * for local power blocks to Low initially as per Table 8-4:
+	 * "System-Level Power-Down Configuration Registers".
+	 */
+	for (i = 0; i < ARRAY_SIZE(exynos5420_list_disable_pmu_reg); i++)
+		pmu_raw_writel(0, exynos5420_list_disable_pmu_reg[i]);
+
+	/* Enable USE_STANDBY_WFI for all CORE */
+	pmu_raw_writel(EXYNOS5420_USE_STANDBY_WFI_ALL, S5P_CENTRAL_SEQ_OPTION);
+
+	value  = pmu_raw_readl(EXYNOS_L2_OPTION(0));
+	value &= ~EXYNOS5_USE_RETENTION;
+	pmu_raw_writel(value, EXYNOS_L2_OPTION(0));
+
+	value = pmu_raw_readl(EXYNOS_L2_OPTION(1));
+	value &= ~EXYNOS5_USE_RETENTION;
+	pmu_raw_writel(value, EXYNOS_L2_OPTION(1));
+
+	/*
+	 * If L2_COMMON is turned off, clocks related to ATB async
+	 * bridge are gated. Thus, when ISP power is gated, LPI
+	 * may get stuck.
+	 */
+	value = pmu_raw_readl(EXYNOS5420_LPI_MASK);
+	value |= EXYNOS5420_ATB_ISP_ARM;
+	pmu_raw_writel(value, EXYNOS5420_LPI_MASK);
+
+	value  = pmu_raw_readl(EXYNOS5420_LPI_MASK1);
+	value |= EXYNOS5420_ATB_KFC;
+	pmu_raw_writel(value, EXYNOS5420_LPI_MASK1);
+
+	/* Prevent issue of new bus request from L2 memory */
+	value = pmu_raw_readl(EXYNOS5420_ARM_COMMON_OPTION);
+	value |= EXYNOS5_SKIP_DEACTIVATE_ACEACP_IN_PWDN;
+	pmu_raw_writel(value, EXYNOS5420_ARM_COMMON_OPTION);
+
+	value = pmu_raw_readl(EXYNOS5420_KFC_COMMON_OPTION);
+	value |= EXYNOS5_SKIP_DEACTIVATE_ACEACP_IN_PWDN;
+	pmu_raw_writel(value, EXYNOS5420_KFC_COMMON_OPTION);
+
+	/* This setting is to reduce suspend/resume time */
+	pmu_raw_writel(DUR_WAIT_RESET, EXYNOS5420_LOGIC_RESET_DURATION3);
+
+	/* Serialized CPU wakeup of Eagle */
+	pmu_raw_writel(SPREAD_ENABLE, EXYNOS5420_ARM_INTR_SPREAD_ENABLE);
+
+	pmu_raw_writel(SPREAD_USE_STANDWFI,
+			EXYNOS5420_ARM_INTR_SPREAD_USE_STANDBYWFI);
+
+	pmu_raw_writel(0x1, EXYNOS5420_UP_SCHEDULER);
+
+	pm_power_off = exynos5_power_off;
+	pr_info("EXYNOS5420 PMU initialized\n");
+}
+
+const struct exynos_pmu_data exynos5420_pmu_data = {
+	.pmu_config	= exynos5420_pmu_config,
+	.pmu_init	= exynos5420_pmu_init,
+	.powerdown_conf	= exynos5420_powerdown_conf,
+};
diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index 97e5488..3e039c6 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -12,7 +12,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
-#include <linux/delay.h>
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/soc/samsung/exynos-regs-pmu.h>
@@ -27,219 +26,6 @@ struct exynos_pmu_context {
 
 static struct exynos_pmu_context *pmu_context;
 
-static struct exynos_pmu_conf exynos5420_pmu_config[] = {
-	/* { .offset = offset, .val = { AFTR, LPA, SLEEP } */
-	{ EXYNOS5_ARM_CORE0_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_DIS_IRQ_ARM_CORE0_LOCAL_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_DIS_IRQ_ARM_CORE0_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_ARM_CORE1_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_DIS_IRQ_ARM_CORE1_LOCAL_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_DIS_IRQ_ARM_CORE1_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_ARM_CORE2_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_DIS_IRQ_ARM_CORE2_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_DIS_IRQ_ARM_CORE2_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_ARM_CORE3_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_DIS_IRQ_ARM_CORE3_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_DIS_IRQ_ARM_CORE3_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_KFC_CORE0_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_DIS_IRQ_KFC_CORE0_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_DIS_IRQ_KFC_CORE0_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_KFC_CORE1_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_DIS_IRQ_KFC_CORE1_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_DIS_IRQ_KFC_CORE1_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_KFC_CORE2_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_DIS_IRQ_KFC_CORE2_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_DIS_IRQ_KFC_CORE2_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_KFC_CORE3_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_DIS_IRQ_KFC_CORE3_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_DIS_IRQ_KFC_CORE3_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_ISP_ARM_SYS_PWR_REG,				{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_DIS_IRQ_ISP_ARM_LOCAL_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_DIS_IRQ_ISP_ARM_CENTRAL_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_ARM_COMMON_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_KFC_COMMON_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_ARM_L2_SYS_PWR_REG,				{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_KFC_L2_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_CMU_ACLKSTOP_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_CMU_SCLKSTOP_SYS_PWR_REG,			{ 0x1, 0x0, 0x1} },
-	{ EXYNOS5_CMU_RESET_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_CMU_ACLKSTOP_SYSMEM_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_CMU_SCLKSTOP_SYSMEM_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
-	{ EXYNOS5_CMU_RESET_SYSMEM_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_DRAM_FREQ_DOWN_SYS_PWR_REG,			{ 0x1, 0x0, 0x1} },
-	{ EXYNOS5_DDRPHY_DLLOFF_SYS_PWR_REG,			{ 0x1, 0x1, 0x1} },
-	{ EXYNOS5_DDRPHY_DLLLOCK_SYS_PWR_REG,			{ 0x1, 0x0, 0x1} },
-	{ EXYNOS5_APLL_SYSCLK_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_MPLL_SYSCLK_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_VPLL_SYSCLK_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_EPLL_SYSCLK_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_BPLL_SYSCLK_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_CPLL_SYSCLK_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_DPLL_SYSCLK_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_IPLL_SYSCLK_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_KPLL_SYSCLK_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_MPLLUSER_SYSCLK_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_BPLLUSER_SYSCLK_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_RPLL_SYSCLK_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_SPLL_SYSCLK_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_TOP_BUS_SYS_PWR_REG,				{ 0x3, 0x0, 0x0} },
-	{ EXYNOS5_TOP_RETENTION_SYS_PWR_REG,			{ 0x1, 0x1, 0x1} },
-	{ EXYNOS5_TOP_PWR_SYS_PWR_REG,				{ 0x3, 0x3, 0x0} },
-	{ EXYNOS5_TOP_BUS_SYSMEM_SYS_PWR_REG,			{ 0x3, 0x0, 0x0} },
-	{ EXYNOS5_TOP_RETENTION_SYSMEM_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
-	{ EXYNOS5_TOP_PWR_SYSMEM_SYS_PWR_REG,			{ 0x3, 0x0, 0x0} },
-	{ EXYNOS5_LOGIC_RESET_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_OSCCLK_GATE_SYS_PWR_REG,			{ 0x1, 0x0, 0x1} },
-	{ EXYNOS5_LOGIC_RESET_SYSMEM_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_OSCCLK_GATE_SYSMEM_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_INTRAM_MEM_SYS_PWR_REG,			{ 0x3, 0x0, 0x3} },
-	{ EXYNOS5420_INTROM_MEM_SYS_PWR_REG,			{ 0x3, 0x0, 0x3} },
-	{ EXYNOS5_PAD_RETENTION_DRAM_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_PAD_RETENTION_MAU_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5420_PAD_RETENTION_JTAG_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5420_PAD_RETENTION_DRAM_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_PAD_RETENTION_UART_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_PAD_RETENTION_MMC0_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_PAD_RETENTION_MMC1_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_PAD_RETENTION_MMC2_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_PAD_RETENTION_HSI_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_PAD_RETENTION_EBIA_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_PAD_RETENTION_EBIB_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_PAD_RETENTION_SPI_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_PAD_RETENTION_DRAM_COREBLK_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_PAD_ISOLATION_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_PAD_ISOLATION_SYSMEM_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_PAD_ALV_SEL_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_XUSBXTI_SYS_PWR_REG,				{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_XXTI_SYS_PWR_REG,				{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_EXT_REGULATOR_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_GPIO_MODE_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_GPIO_MODE_SYSMEM_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_GPIO_MODE_MAU_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_TOP_ASB_RESET_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_TOP_ASB_ISOLATION_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_GSCL_SYS_PWR_REG,				{ 0x7, 0x0, 0x0} },
-	{ EXYNOS5_ISP_SYS_PWR_REG,				{ 0x7, 0x0, 0x0} },
-	{ EXYNOS5_MFC_SYS_PWR_REG,				{ 0x7, 0x0, 0x0} },
-	{ EXYNOS5_G3D_SYS_PWR_REG,				{ 0x7, 0x0, 0x0} },
-	{ EXYNOS5420_DISP1_SYS_PWR_REG,				{ 0x7, 0x0, 0x0} },
-	{ EXYNOS5420_MAU_SYS_PWR_REG,				{ 0x7, 0x7, 0x0} },
-	{ EXYNOS5420_G2D_SYS_PWR_REG,				{ 0x7, 0x0, 0x0} },
-	{ EXYNOS5420_MSC_SYS_PWR_REG,				{ 0x7, 0x0, 0x0} },
-	{ EXYNOS5420_FSYS_SYS_PWR_REG,				{ 0x7, 0x0, 0x0} },
-	{ EXYNOS5420_FSYS2_SYS_PWR_REG,				{ 0x7, 0x0, 0x0} },
-	{ EXYNOS5420_PSGEN_SYS_PWR_REG,				{ 0x7, 0x0, 0x0} },
-	{ EXYNOS5420_PERIC_SYS_PWR_REG,				{ 0x7, 0x0, 0x0} },
-	{ EXYNOS5420_WCORE_SYS_PWR_REG,				{ 0x7, 0x0, 0x0} },
-	{ EXYNOS5_CMU_CLKSTOP_GSCL_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_CMU_CLKSTOP_ISP_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_CMU_CLKSTOP_MFC_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_CMU_CLKSTOP_G3D_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_CLKSTOP_DISP1_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_CLKSTOP_MAU_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_CLKSTOP_G2D_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_CLKSTOP_MSC_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_CLKSTOP_FSYS_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_CLKSTOP_PSGEN_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_CLKSTOP_PERIC_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_CLKSTOP_WCORE_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_CMU_SYSCLK_GSCL_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_CMU_SYSCLK_ISP_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_CMU_SYSCLK_MFC_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_CMU_SYSCLK_G3D_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_SYSCLK_DISP1_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_SYSCLK_MAU_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_SYSCLK_G2D_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_SYSCLK_MSC_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_SYSCLK_FSYS_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_SYSCLK_FSYS2_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_SYSCLK_PSGEN_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_SYSCLK_PERIC_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_SYSCLK_WCORE_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_RESET_FSYS2_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_RESET_PSGEN_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_RESET_PERIC_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_RESET_WCORE_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_CMU_RESET_GSCL_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_CMU_RESET_ISP_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_CMU_RESET_MFC_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_CMU_RESET_G3D_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_RESET_DISP1_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_RESET_MAU_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_RESET_G2D_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_RESET_MSC_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_RESET_FSYS_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ PMU_TABLE_END,},
-};
-
-static unsigned int const exynos5420_list_disable_pmu_reg[] = {
-	EXYNOS5_CMU_CLKSTOP_GSCL_SYS_PWR_REG,
-	EXYNOS5_CMU_CLKSTOP_ISP_SYS_PWR_REG,
-	EXYNOS5_CMU_CLKSTOP_G3D_SYS_PWR_REG,
-	EXYNOS5420_CMU_CLKSTOP_DISP1_SYS_PWR_REG,
-	EXYNOS5420_CMU_CLKSTOP_MAU_SYS_PWR_REG,
-	EXYNOS5420_CMU_CLKSTOP_G2D_SYS_PWR_REG,
-	EXYNOS5420_CMU_CLKSTOP_MSC_SYS_PWR_REG,
-	EXYNOS5420_CMU_CLKSTOP_FSYS_SYS_PWR_REG,
-	EXYNOS5420_CMU_CLKSTOP_PSGEN_SYS_PWR_REG,
-	EXYNOS5420_CMU_CLKSTOP_PERIC_SYS_PWR_REG,
-	EXYNOS5420_CMU_CLKSTOP_WCORE_SYS_PWR_REG,
-	EXYNOS5_CMU_SYSCLK_GSCL_SYS_PWR_REG,
-	EXYNOS5_CMU_SYSCLK_ISP_SYS_PWR_REG,
-	EXYNOS5_CMU_SYSCLK_G3D_SYS_PWR_REG,
-	EXYNOS5420_CMU_SYSCLK_DISP1_SYS_PWR_REG,
-	EXYNOS5420_CMU_SYSCLK_MAU_SYS_PWR_REG,
-	EXYNOS5420_CMU_SYSCLK_G2D_SYS_PWR_REG,
-	EXYNOS5420_CMU_SYSCLK_MSC_SYS_PWR_REG,
-	EXYNOS5420_CMU_SYSCLK_FSYS_SYS_PWR_REG,
-	EXYNOS5420_CMU_SYSCLK_FSYS2_SYS_PWR_REG,
-	EXYNOS5420_CMU_SYSCLK_PSGEN_SYS_PWR_REG,
-	EXYNOS5420_CMU_SYSCLK_PERIC_SYS_PWR_REG,
-	EXYNOS5420_CMU_SYSCLK_WCORE_SYS_PWR_REG,
-	EXYNOS5420_CMU_RESET_FSYS2_SYS_PWR_REG,
-	EXYNOS5420_CMU_RESET_PSGEN_SYS_PWR_REG,
-	EXYNOS5420_CMU_RESET_PERIC_SYS_PWR_REG,
-	EXYNOS5420_CMU_RESET_WCORE_SYS_PWR_REG,
-	EXYNOS5_CMU_RESET_GSCL_SYS_PWR_REG,
-	EXYNOS5_CMU_RESET_ISP_SYS_PWR_REG,
-	EXYNOS5_CMU_RESET_G3D_SYS_PWR_REG,
-	EXYNOS5420_CMU_RESET_DISP1_SYS_PWR_REG,
-	EXYNOS5420_CMU_RESET_MAU_SYS_PWR_REG,
-	EXYNOS5420_CMU_RESET_G2D_SYS_PWR_REG,
-	EXYNOS5420_CMU_RESET_MSC_SYS_PWR_REG,
-	EXYNOS5420_CMU_RESET_FSYS_SYS_PWR_REG,
-};
-
-static void exynos5_power_off(void)
-{
-	unsigned int tmp;
-
-	pr_info("Power down.\n");
-	tmp = pmu_raw_readl(EXYNOS_PS_HOLD_CONTROL);
-	tmp ^= (1 << 8);
-	pmu_raw_writel(tmp, EXYNOS_PS_HOLD_CONTROL);
-
-	/* Wait a little so we don't give a false warning below */
-	mdelay(100);
-
-	pr_err("Power down failed, please power off system manually.\n");
-	while (1)
-		;
-}
-
-void exynos5420_powerdown_conf(enum sys_powerdown mode)
-{
-	u32 this_cluster;
-
-	this_cluster = MPIDR_AFFINITY_LEVEL(read_cpuid_mpidr(), 1);
-
-	/*
-	 * set the cluster id to IROM register to ensure that we wake
-	 * up with the current cluster.
-	 */
-	pmu_raw_writel(this_cluster, EXYNOS_IROM_DATA2);
-}
-
 void exynos_sys_powerdown_conf(enum sys_powerdown mode)
 {
 	unsigned int i;
@@ -265,67 +51,6 @@ void exynos_sys_powerdown_conf(enum sys_powerdown mode)
 	}
 }
 
-static void exynos5420_pmu_init(void)
-{
-	unsigned int value;
-	int i;
-
-	/*
-	 * Set the CMU_RESET, CMU_SYSCLK and CMU_CLKSTOP registers
-	 * for local power blocks to Low initially as per Table 8-4:
-	 * "System-Level Power-Down Configuration Registers".
-	 */
-	for (i = 0; i < ARRAY_SIZE(exynos5420_list_disable_pmu_reg); i++)
-		pmu_raw_writel(0, exynos5420_list_disable_pmu_reg[i]);
-
-	/* Enable USE_STANDBY_WFI for all CORE */
-	pmu_raw_writel(EXYNOS5420_USE_STANDBY_WFI_ALL, S5P_CENTRAL_SEQ_OPTION);
-
-	value  = pmu_raw_readl(EXYNOS_L2_OPTION(0));
-	value &= ~EXYNOS5_USE_RETENTION;
-	pmu_raw_writel(value, EXYNOS_L2_OPTION(0));
-
-	value = pmu_raw_readl(EXYNOS_L2_OPTION(1));
-	value &= ~EXYNOS5_USE_RETENTION;
-	pmu_raw_writel(value, EXYNOS_L2_OPTION(1));
-
-	/*
-	 * If L2_COMMON is turned off, clocks related to ATB async
-	 * bridge are gated. Thus, when ISP power is gated, LPI
-	 * may get stuck.
-	 */
-	value = pmu_raw_readl(EXYNOS5420_LPI_MASK);
-	value |= EXYNOS5420_ATB_ISP_ARM;
-	pmu_raw_writel(value, EXYNOS5420_LPI_MASK);
-
-	value  = pmu_raw_readl(EXYNOS5420_LPI_MASK1);
-	value |= EXYNOS5420_ATB_KFC;
-	pmu_raw_writel(value, EXYNOS5420_LPI_MASK1);
-
-	/* Prevent issue of new bus request from L2 memory */
-	value = pmu_raw_readl(EXYNOS5420_ARM_COMMON_OPTION);
-	value |= EXYNOS5_SKIP_DEACTIVATE_ACEACP_IN_PWDN;
-	pmu_raw_writel(value, EXYNOS5420_ARM_COMMON_OPTION);
-
-	value = pmu_raw_readl(EXYNOS5420_KFC_COMMON_OPTION);
-	value |= EXYNOS5_SKIP_DEACTIVATE_ACEACP_IN_PWDN;
-	pmu_raw_writel(value, EXYNOS5420_KFC_COMMON_OPTION);
-
-	/* This setting is to reduce suspend/resume time */
-	pmu_raw_writel(DUR_WAIT_RESET, EXYNOS5420_LOGIC_RESET_DURATION3);
-
-	/* Serialized CPU wakeup of Eagle */
-	pmu_raw_writel(SPREAD_ENABLE, EXYNOS5420_ARM_INTR_SPREAD_ENABLE);
-
-	pmu_raw_writel(SPREAD_USE_STANDWFI,
-			EXYNOS5420_ARM_INTR_SPREAD_USE_STANDBYWFI);
-
-	pmu_raw_writel(0x1, EXYNOS5420_UP_SCHEDULER);
-
-	pm_power_off = exynos5_power_off;
-	pr_info("EXYNOS5420 PMU initialized\n");
-}
-
 static int pmu_restart_notify(struct notifier_block *this,
 		unsigned long code, void *unused)
 {
@@ -334,12 +59,6 @@ static int pmu_restart_notify(struct notifier_block *this,
 	return NOTIFY_DONE;
 }
 
-static struct exynos_pmu_data exynos5420_pmu_data = {
-	.pmu_config	= exynos5420_pmu_config,
-	.pmu_init	= exynos5420_pmu_init,
-	.powerdown_conf	= exynos5420_powerdown_conf,
-};
-
 /*
  * PMU platform driver and devicetree bindings.
  */
-- 
2.2.0
