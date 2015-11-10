From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 10 Nov 2015 17:13:04 +0530
Subject: [PATCH v4 9/9] drivers: soc: Add support for Exynos PMU driver
In-Reply-To: <1447155784-12667-1-git-send-email-pankaj.dubey@samsung.com>
References: <1447155784-12667-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1447155784-12667-10-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves Exynos PMU driver implementation from "arm/mach-exynos"
to "drivers/soc/samsung". This driver is mainly used for setting misc
bits of register from PMU IP of Exynos SoC which will be required to
configure before Suspend/Resume. Currently all these settings are done
in "arch/arm/mach-exynos/pmu.c" but moving ahead for ARM64 based SoC
support, there is a need of this PMU driver in driver/* folder.

This driver uses existing DT binding information and there should
be no functionality change in the supported platforms.

Signed-off-by: Amit Daniel Kachhap <amitdanielk@gmail.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/Kconfig          |   1 +
 arch/arm/mach-exynos/Makefile         |   4 +-
 arch/arm/mach-exynos/exynos-pmu.h     |  45 ------
 arch/arm/mach-exynos/exynos3250-pmu.c | 175 ---------------------
 arch/arm/mach-exynos/exynos4-pmu.c    | 223 ---------------------------
 arch/arm/mach-exynos/exynos5250-pmu.c | 196 ------------------------
 arch/arm/mach-exynos/exynos5420-pmu.c | 280 ----------------------------------
 arch/arm/mach-exynos/pmu.c            | 183 ----------------------
 drivers/soc/samsung/Kconfig           |   4 +
 drivers/soc/samsung/Makefile          |   4 +
 drivers/soc/samsung/exynos-pmu.c      | 183 ++++++++++++++++++++++
 drivers/soc/samsung/exynos-pmu.h      |  45 ++++++
 drivers/soc/samsung/exynos3250-pmu.c  | 175 +++++++++++++++++++++
 drivers/soc/samsung/exynos4-pmu.c     | 223 +++++++++++++++++++++++++++
 drivers/soc/samsung/exynos5250-pmu.c  | 196 ++++++++++++++++++++++++
 drivers/soc/samsung/exynos5420-pmu.c  | 280 ++++++++++++++++++++++++++++++++++
 16 files changed, 1112 insertions(+), 1105 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/exynos-pmu.h
 delete mode 100644 arch/arm/mach-exynos/exynos3250-pmu.c
 delete mode 100644 arch/arm/mach-exynos/exynos4-pmu.c
 delete mode 100644 arch/arm/mach-exynos/exynos5250-pmu.c
 delete mode 100644 arch/arm/mach-exynos/exynos5420-pmu.c
 delete mode 100644 arch/arm/mach-exynos/pmu.c
 create mode 100644 drivers/soc/samsung/exynos-pmu.c
 create mode 100644 drivers/soc/samsung/exynos-pmu.h
 create mode 100644 drivers/soc/samsung/exynos3250-pmu.c
 create mode 100644 drivers/soc/samsung/exynos4-pmu.c
 create mode 100644 drivers/soc/samsung/exynos5250-pmu.c
 create mode 100644 drivers/soc/samsung/exynos5420-pmu.c

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 83c85f5..874cb38 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -16,6 +16,7 @@ menuconfig ARCH_EXYNOS
 	select ARM_GIC
 	select COMMON_CLK_SAMSUNG
 	select EXYNOS_THERMAL
+	select EXYNOS_PMU
 	select EXYNOS_SROM if PM
 	select HAVE_ARM_SCU if SMP
 	select HAVE_S3C2410_I2C if I2C
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 2d58063..34d29df 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -9,9 +9,7 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) += -I$(srctree)/$(src)/include -I$(srctree)
 
 # Core
 
-obj-$(CONFIG_ARCH_EXYNOS)	+= exynos.o pmu.o exynos-smc.o firmware.o \
-					exynos3250-pmu.o exynos4-pmu.o \
-					exynos5250-pmu.o exynos5420-pmu.o
+obj-$(CONFIG_ARCH_EXYNOS)	+= exynos.o exynos-smc.o firmware.o
 
 obj-$(CONFIG_EXYNOS_CPU_SUSPEND) += pm.o sleep.o
 obj-$(CONFIG_PM_SLEEP)		+= suspend.o
diff --git a/arch/arm/mach-exynos/exynos-pmu.h b/arch/arm/mach-exynos/exynos-pmu.h
deleted file mode 100644
index 306f5c7..0000000
--- a/arch/arm/mach-exynos/exynos-pmu.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/*
- * Copyright (c) 2015 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Header for EXYNOS PMU Driver support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __EXYNOS_PMU_H
-#define __EXYNOS_PMU_H
-
-#include <linux/io.h>
-
-#define PMU_TABLE_END	(-1U)
-
-
-struct exynos_pmu_conf {
-	unsigned int offset;
-	u8 val[NUM_SYS_POWERDOWN];
-};
-
-struct exynos_pmu_data {
-	const struct exynos_pmu_conf *pmu_config;
-	const struct exynos_pmu_conf *pmu_config_extra;
-
-	void (*pmu_init)(void);
-	void (*powerdown_conf)(enum sys_powerdown);
-	void (*powerdown_conf_extra)(enum sys_powerdown);
-};
-
-extern void __iomem *pmu_base_addr;
-/* list of all exported SoC specific data */
-extern const struct exynos_pmu_data exynos3250_pmu_data;
-extern const struct exynos_pmu_data exynos4210_pmu_data;
-extern const struct exynos_pmu_data exynos4212_pmu_data;
-extern const struct exynos_pmu_data exynos4412_pmu_data;
-extern const struct exynos_pmu_data exynos5250_pmu_data;
-extern const struct exynos_pmu_data exynos5420_pmu_data;
-
-extern void pmu_raw_writel(u32 val, u32 offset);
-extern u32 pmu_raw_readl(u32 offset);
-#endif /* __EXYNOS_PMU_H */
diff --git a/arch/arm/mach-exynos/exynos3250-pmu.c b/arch/arm/mach-exynos/exynos3250-pmu.c
deleted file mode 100644
index 20b3ab8..0000000
--- a/arch/arm/mach-exynos/exynos3250-pmu.c
+++ /dev/null
@@ -1,175 +0,0 @@
-/*
- * Copyright (c) 2011-2015 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * EXYNOS3250 - CPU PMU (Power Management Unit) support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/soc/samsung/exynos-regs-pmu.h>
-#include <linux/soc/samsung/exynos-pmu.h>
-
-#include "exynos-pmu.h"
-
-static struct exynos_pmu_conf exynos3250_pmu_config[] = {
-	/* { .offset = offset, .val = { AFTR, W-AFTR, SLEEP } */
-	{ EXYNOS3_ARM_CORE0_SYS_PWR_REG,		{ 0x0, 0x0, 0x2} },
-	{ EXYNOS3_DIS_IRQ_ARM_CORE0_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS3_DIS_IRQ_ARM_CORE0_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
-	{ EXYNOS3_ARM_CORE1_SYS_PWR_REG,		{ 0x0, 0x0, 0x2} },
-	{ EXYNOS3_DIS_IRQ_ARM_CORE1_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS3_DIS_IRQ_ARM_CORE1_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
-	{ EXYNOS3_ISP_ARM_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
-	{ EXYNOS3_DIS_IRQ_ISP_ARM_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS3_DIS_IRQ_ISP_ARM_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS3_ARM_COMMON_SYS_PWR_REG,		{ 0x0, 0x0, 0x2} },
-	{ EXYNOS3_ARM_L2_SYS_PWR_REG,			{ 0x0, 0x0, 0x3} },
-	{ EXYNOS3_CMU_ACLKSTOP_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ EXYNOS3_CMU_SCLKSTOP_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ EXYNOS3_CMU_RESET_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ EXYNOS3_DRAM_FREQ_DOWN_SYS_PWR_REG,		{ 0x1, 0x1, 0x1} },
-	{ EXYNOS3_DDRPHY_DLLOFF_SYS_PWR_REG,		{ 0x1, 0x1, 0x1} },
-	{ EXYNOS3_LPDDR_PHY_DLL_LOCK_SYS_PWR_REG,	{ 0x1, 0x1, 0x1} },
-	{ EXYNOS3_CMU_ACLKSTOP_COREBLK_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS3_CMU_SCLKSTOP_COREBLK_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS3_CMU_RESET_COREBLK_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
-	{ EXYNOS3_APLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS3_MPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS3_BPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS3_VPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ EXYNOS3_EPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS3_UPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x1, 0x1} },
-	{ EXYNOS3_EPLLUSER_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS3_MPLLUSER_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS3_BPLLUSER_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS3_CMU_CLKSTOP_CAM_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS3_CMU_CLKSTOP_MFC_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS3_CMU_CLKSTOP_G3D_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS3_CMU_CLKSTOP_LCD0_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS3_CMU_CLKSTOP_ISP_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS3_CMU_CLKSTOP_MAUDIO_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS3_CMU_RESET_CAM_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS3_CMU_RESET_MFC_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS3_CMU_RESET_G3D_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS3_CMU_RESET_LCD0_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS3_CMU_RESET_ISP_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS3_CMU_RESET_MAUDIO_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS3_TOP_BUS_SYS_PWR_REG,			{ 0x3, 0x0, 0x0} },
-	{ EXYNOS3_TOP_RETENTION_SYS_PWR_REG,		{ 0x1, 0x1, 0x1} },
-	{ EXYNOS3_TOP_PWR_SYS_PWR_REG,			{ 0x3, 0x3, 0x3} },
-	{ EXYNOS3_TOP_BUS_COREBLK_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
-	{ EXYNOS3_TOP_RETENTION_COREBLK_SYS_PWR_REG,	{ 0x1, 0x1, 0x1} },
-	{ EXYNOS3_TOP_PWR_COREBLK_SYS_PWR_REG,		{ 0x3, 0x3, 0x3} },
-	{ EXYNOS3_LOGIC_RESET_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ EXYNOS3_OSCCLK_GATE_SYS_PWR_REG,		{ 0x1, 0x1, 0x1} },
-	{ EXYNOS3_LOGIC_RESET_COREBLK_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
-	{ EXYNOS3_OSCCLK_GATE_COREBLK_SYS_PWR_REG,	{ 0x1, 0x0, 0x1} },
-	{ EXYNOS3_PAD_RETENTION_DRAM_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
-	{ EXYNOS3_PAD_RETENTION_MAUDIO_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
-	{ EXYNOS3_PAD_RETENTION_GPIO_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
-	{ EXYNOS3_PAD_RETENTION_UART_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
-	{ EXYNOS3_PAD_RETENTION_MMC0_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
-	{ EXYNOS3_PAD_RETENTION_MMC1_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
-	{ EXYNOS3_PAD_RETENTION_MMC2_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
-	{ EXYNOS3_PAD_RETENTION_SPI_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
-	{ EXYNOS3_PAD_RETENTION_EBIA_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
-	{ EXYNOS3_PAD_RETENTION_EBIB_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
-	{ EXYNOS3_PAD_RETENTION_JTAG_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
-	{ EXYNOS3_PAD_ISOLATION_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ EXYNOS3_PAD_ALV_SEL_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ EXYNOS3_XUSBXTI_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
-	{ EXYNOS3_XXTI_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
-	{ EXYNOS3_EXT_REGULATOR_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ EXYNOS3_EXT_REGULATOR_COREBLK_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
-	{ EXYNOS3_GPIO_MODE_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ EXYNOS3_GPIO_MODE_MAUDIO_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ EXYNOS3_TOP_ASB_RESET_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ EXYNOS3_TOP_ASB_ISOLATION_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
-	{ EXYNOS3_TOP_ASB_RESET_COREBLK_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
-	{ EXYNOS3_TOP_ASB_ISOLATION_COREBLK_SYS_PWR_REG, { 0x1, 0x1, 0x0} },
-	{ EXYNOS3_CAM_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
-	{ EXYNOS3_MFC_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
-	{ EXYNOS3_G3D_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
-	{ EXYNOS3_LCD0_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
-	{ EXYNOS3_ISP_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
-	{ EXYNOS3_MAUDIO_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
-	{ EXYNOS3_CMU_SYSCLK_ISP_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ PMU_TABLE_END,},
-};
-
-static unsigned int const exynos3250_list_feed[] = {
-	EXYNOS3_ARM_CORE_OPTION(0),
-	EXYNOS3_ARM_CORE_OPTION(1),
-	EXYNOS3_ARM_CORE_OPTION(2),
-	EXYNOS3_ARM_CORE_OPTION(3),
-	EXYNOS3_ARM_COMMON_OPTION,
-	EXYNOS3_TOP_PWR_OPTION,
-	EXYNOS3_CORE_TOP_PWR_OPTION,
-	S5P_CAM_OPTION,
-	S5P_MFC_OPTION,
-	S5P_G3D_OPTION,
-	S5P_LCD0_OPTION,
-	S5P_ISP_OPTION,
-};
-
-static void exynos3250_powerdown_conf_extra(enum sys_powerdown mode)
-{
-	unsigned int i;
-	unsigned int tmp;
-
-	/* Enable only SC_FEEDBACK */
-	for (i = 0; i < ARRAY_SIZE(exynos3250_list_feed); i++) {
-		tmp = pmu_raw_readl(exynos3250_list_feed[i]);
-		tmp &= ~(EXYNOS3_OPTION_USE_SC_COUNTER);
-		tmp |= EXYNOS3_OPTION_USE_SC_FEEDBACK;
-		pmu_raw_writel(tmp, exynos3250_list_feed[i]);
-	}
-
-	if (mode != SYS_SLEEP)
-		return;
-
-	pmu_raw_writel(XUSBXTI_DURATION, EXYNOS3_XUSBXTI_DURATION);
-	pmu_raw_writel(XXTI_DURATION, EXYNOS3_XXTI_DURATION);
-	pmu_raw_writel(EXT_REGULATOR_DURATION, EXYNOS3_EXT_REGULATOR_DURATION);
-	pmu_raw_writel(EXT_REGULATOR_COREBLK_DURATION,
-		       EXYNOS3_EXT_REGULATOR_COREBLK_DURATION);
-}
-
-static void exynos3250_pmu_init(void)
-{
-	unsigned int value;
-
-	/*
-	 * To prevent from issuing new bus request form L2 memory system
-	 * If core status is power down, should be set '1' to L2 power down
-	 */
-	value = pmu_raw_readl(EXYNOS3_ARM_COMMON_OPTION);
-	value |= EXYNOS3_OPTION_SKIP_DEACTIVATE_ACEACP_IN_PWDN;
-	pmu_raw_writel(value, EXYNOS3_ARM_COMMON_OPTION);
-
-	/* Enable USE_STANDBY_WFI for all CORE */
-	pmu_raw_writel(S5P_USE_STANDBY_WFI_ALL, S5P_CENTRAL_SEQ_OPTION);
-
-	/*
-	 * Set PSHOLD port for output high
-	 */
-	value = pmu_raw_readl(S5P_PS_HOLD_CONTROL);
-	value |= S5P_PS_HOLD_OUTPUT_HIGH;
-	pmu_raw_writel(value, S5P_PS_HOLD_CONTROL);
-
-	/*
-	 * Enable signal for PSHOLD port
-	 */
-	value = pmu_raw_readl(S5P_PS_HOLD_CONTROL);
-	value |= S5P_PS_HOLD_EN;
-	pmu_raw_writel(value, S5P_PS_HOLD_CONTROL);
-}
-
-const struct exynos_pmu_data exynos3250_pmu_data = {
-	.pmu_config	= exynos3250_pmu_config,
-	.pmu_init	= exynos3250_pmu_init,
-	.powerdown_conf_extra	= exynos3250_powerdown_conf_extra,
-};
diff --git a/arch/arm/mach-exynos/exynos4-pmu.c b/arch/arm/mach-exynos/exynos4-pmu.c
deleted file mode 100644
index 4b0a79e..0000000
--- a/arch/arm/mach-exynos/exynos4-pmu.c
+++ /dev/null
@@ -1,223 +0,0 @@
-/*
- * Copyright (c) 2011-2015 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * EXYNOS4 - CPU PMU(Power Management Unit) support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/soc/samsung/exynos-regs-pmu.h>
-#include <linux/soc/samsung/exynos-pmu.h>
-
-#include "exynos-pmu.h"
-
-static const struct exynos_pmu_conf exynos4210_pmu_config[] = {
-	/* { .offset = offset, .val = { AFTR, LPA, SLEEP } */
-	{ S5P_ARM_CORE0_LOWPWR,			{ 0x0, 0x0, 0x2 } },
-	{ S5P_DIS_IRQ_CORE0,			{ 0x0, 0x0, 0x0 } },
-	{ S5P_DIS_IRQ_CENTRAL0,			{ 0x0, 0x0, 0x0 } },
-	{ S5P_ARM_CORE1_LOWPWR,			{ 0x0, 0x0, 0x2 } },
-	{ S5P_DIS_IRQ_CORE1,			{ 0x0, 0x0, 0x0 } },
-	{ S5P_DIS_IRQ_CENTRAL1,			{ 0x0, 0x0, 0x0 } },
-	{ S5P_ARM_COMMON_LOWPWR,		{ 0x0, 0x0, 0x2 } },
-	{ S5P_L2_0_LOWPWR,			{ 0x2, 0x2, 0x3 } },
-	{ S5P_L2_1_LOWPWR,			{ 0x2, 0x2, 0x3 } },
-	{ S5P_CMU_ACLKSTOP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_SCLKSTOP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_RESET_LOWPWR,			{ 0x1, 0x1, 0x0 } },
-	{ S5P_APLL_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_MPLL_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_VPLL_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_EPLL_SYSCLK_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_CLKSTOP_GPS_ALIVE_LOWPWR,	{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_RESET_GPSALIVE_LOWPWR,	{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_CLKSTOP_CAM_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_CLKSTOP_TV_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_CLKSTOP_MFC_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_CLKSTOP_G3D_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_CLKSTOP_LCD0_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_CLKSTOP_LCD1_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_CLKSTOP_MAUDIO_LOWPWR,	{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_CLKSTOP_GPS_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_RESET_CAM_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_RESET_TV_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_RESET_MFC_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_RESET_G3D_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_RESET_LCD0_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_RESET_LCD1_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_RESET_MAUDIO_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_RESET_GPS_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_TOP_BUS_LOWPWR,			{ 0x3, 0x0, 0x0 } },
-	{ S5P_TOP_RETENTION_LOWPWR,		{ 0x1, 0x0, 0x1 } },
-	{ S5P_TOP_PWR_LOWPWR,			{ 0x3, 0x0, 0x3 } },
-	{ S5P_LOGIC_RESET_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_ONENAND_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
-	{ S5P_MODIMIF_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
-	{ S5P_G2D_ACP_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
-	{ S5P_USBOTG_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
-	{ S5P_HSMMC_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
-	{ S5P_CSSYS_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
-	{ S5P_SECSS_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
-	{ S5P_PCIE_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
-	{ S5P_SATA_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_DRAM_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_MAUDIO_LOWPWR,	{ 0x1, 0x1, 0x0 } },
-	{ S5P_PAD_RETENTION_GPIO_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_UART_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_MMCA_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_MMCB_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_EBIA_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_EBIB_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_ISOLATION_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_ALV_SEL_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_XUSBXTI_LOWPWR,			{ 0x1, 0x1, 0x0 } },
-	{ S5P_XXTI_LOWPWR,			{ 0x1, 0x1, 0x0 } },
-	{ S5P_EXT_REGULATOR_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_GPIO_MODE_LOWPWR,			{ 0x1, 0x0, 0x0 } },
-	{ S5P_GPIO_MODE_MAUDIO_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CAM_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ S5P_TV_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ S5P_MFC_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ S5P_G3D_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ S5P_LCD0_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ S5P_LCD1_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ S5P_MAUDIO_LOWPWR,			{ 0x7, 0x7, 0x0 } },
-	{ S5P_GPS_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ S5P_GPS_ALIVE_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ PMU_TABLE_END,},
-};
-
-static const struct exynos_pmu_conf exynos4x12_pmu_config[] = {
-	{ S5P_ARM_CORE0_LOWPWR,			{ 0x0, 0x0, 0x2 } },
-	{ S5P_DIS_IRQ_CORE0,			{ 0x0, 0x0, 0x0 } },
-	{ S5P_DIS_IRQ_CENTRAL0,			{ 0x0, 0x0, 0x0 } },
-	{ S5P_ARM_CORE1_LOWPWR,			{ 0x0, 0x0, 0x2 } },
-	{ S5P_DIS_IRQ_CORE1,			{ 0x0, 0x0, 0x0 } },
-	{ S5P_DIS_IRQ_CENTRAL1,			{ 0x0, 0x0, 0x0 } },
-	{ S5P_ISP_ARM_LOWPWR,			{ 0x1, 0x0, 0x0 } },
-	{ S5P_DIS_IRQ_ISP_ARM_LOCAL_LOWPWR,	{ 0x0, 0x0, 0x0 } },
-	{ S5P_DIS_IRQ_ISP_ARM_CENTRAL_LOWPWR,	{ 0x0, 0x0, 0x0 } },
-	{ S5P_ARM_COMMON_LOWPWR,		{ 0x0, 0x0, 0x2 } },
-	{ S5P_L2_0_LOWPWR,			{ 0x0, 0x0, 0x3 } },
-	/* XXX_OPTION register should be set other field */
-	{ S5P_ARM_L2_0_OPTION,			{ 0x10, 0x10, 0x0 } },
-	{ S5P_L2_1_LOWPWR,			{ 0x0, 0x0, 0x3 } },
-	{ S5P_ARM_L2_1_OPTION,			{ 0x10, 0x10, 0x0 } },
-	{ S5P_CMU_ACLKSTOP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_SCLKSTOP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_RESET_LOWPWR,			{ 0x1, 0x1, 0x0 } },
-	{ S5P_DRAM_FREQ_DOWN_LOWPWR,		{ 0x1, 0x1, 0x1 } },
-	{ S5P_DDRPHY_DLLOFF_LOWPWR,		{ 0x1, 0x1, 0x1 } },
-	{ S5P_LPDDR_PHY_DLL_LOCK_LOWPWR,	{ 0x1, 0x1, 0x1 } },
-	{ S5P_CMU_ACLKSTOP_COREBLK_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_SCLKSTOP_COREBLK_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_RESET_COREBLK_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_APLL_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_MPLL_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_VPLL_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_EPLL_SYSCLK_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_MPLLUSER_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_CLKSTOP_GPS_ALIVE_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_RESET_GPSALIVE_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_CLKSTOP_CAM_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_CLKSTOP_TV_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_CLKSTOP_MFC_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_CLKSTOP_G3D_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_CLKSTOP_LCD0_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_CLKSTOP_ISP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_CLKSTOP_MAUDIO_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_CLKSTOP_GPS_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_RESET_CAM_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_RESET_TV_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_RESET_MFC_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_RESET_G3D_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_RESET_LCD0_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_RESET_ISP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_RESET_MAUDIO_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_RESET_GPS_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_TOP_BUS_LOWPWR,			{ 0x3, 0x0, 0x0 } },
-	{ S5P_TOP_RETENTION_LOWPWR,		{ 0x1, 0x0, 0x1 } },
-	{ S5P_TOP_PWR_LOWPWR,			{ 0x3, 0x0, 0x3 } },
-	{ S5P_TOP_BUS_COREBLK_LOWPWR,		{ 0x3, 0x0, 0x0 } },
-	{ S5P_TOP_RETENTION_COREBLK_LOWPWR,	{ 0x1, 0x0, 0x1 } },
-	{ S5P_TOP_PWR_COREBLK_LOWPWR,		{ 0x3, 0x0, 0x3 } },
-	{ S5P_LOGIC_RESET_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_OSCCLK_GATE_LOWPWR,		{ 0x1, 0x0, 0x1 } },
-	{ S5P_LOGIC_RESET_COREBLK_LOWPWR,	{ 0x1, 0x1, 0x0 } },
-	{ S5P_OSCCLK_GATE_COREBLK_LOWPWR,	{ 0x1, 0x0, 0x1 } },
-	{ S5P_ONENAND_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
-	{ S5P_ONENAND_MEM_OPTION,		{ 0x10, 0x10, 0x0 } },
-	{ S5P_HSI_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
-	{ S5P_HSI_MEM_OPTION,			{ 0x10, 0x10, 0x0 } },
-	{ S5P_G2D_ACP_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
-	{ S5P_G2D_ACP_MEM_OPTION,		{ 0x10, 0x10, 0x0 } },
-	{ S5P_USBOTG_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
-	{ S5P_USBOTG_MEM_OPTION,		{ 0x10, 0x10, 0x0 } },
-	{ S5P_HSMMC_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
-	{ S5P_HSMMC_MEM_OPTION,			{ 0x10, 0x10, 0x0 } },
-	{ S5P_CSSYS_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
-	{ S5P_CSSYS_MEM_OPTION,			{ 0x10, 0x10, 0x0 } },
-	{ S5P_SECSS_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
-	{ S5P_SECSS_MEM_OPTION,			{ 0x10, 0x10, 0x0 } },
-	{ S5P_ROTATOR_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
-	{ S5P_ROTATOR_MEM_OPTION,		{ 0x10, 0x10, 0x0 } },
-	{ S5P_PAD_RETENTION_DRAM_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_MAUDIO_LOWPWR,	{ 0x1, 0x1, 0x0 } },
-	{ S5P_PAD_RETENTION_GPIO_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_UART_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_MMCA_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_MMCB_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_EBIA_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_EBIB_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_GPIO_COREBLK_LOWPWR, { 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_ISOLATION_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_ISOLATION_COREBLK_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_ALV_SEL_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_XUSBXTI_LOWPWR,			{ 0x1, 0x1, 0x0 } },
-	{ S5P_XXTI_LOWPWR,			{ 0x1, 0x1, 0x0 } },
-	{ S5P_EXT_REGULATOR_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_GPIO_MODE_LOWPWR,			{ 0x1, 0x0, 0x0 } },
-	{ S5P_GPIO_MODE_COREBLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_GPIO_MODE_MAUDIO_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_TOP_ASB_RESET_LOWPWR,		{ 0x1, 0x1, 0x1 } },
-	{ S5P_TOP_ASB_ISOLATION_LOWPWR,		{ 0x1, 0x0, 0x1 } },
-	{ S5P_CAM_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ S5P_TV_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ S5P_MFC_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ S5P_G3D_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ S5P_LCD0_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ S5P_ISP_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ S5P_MAUDIO_LOWPWR,			{ 0x7, 0x7, 0x0 } },
-	{ S5P_GPS_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ S5P_GPS_ALIVE_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ S5P_CMU_SYSCLK_ISP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_SYSCLK_GPS_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ PMU_TABLE_END,},
-};
-
-static const struct exynos_pmu_conf exynos4412_pmu_config[] = {
-	{ S5P_ARM_CORE2_LOWPWR,			{ 0x0, 0x0, 0x2 } },
-	{ S5P_DIS_IRQ_CORE2,			{ 0x0, 0x0, 0x0 } },
-	{ S5P_DIS_IRQ_CENTRAL2,			{ 0x0, 0x0, 0x0 } },
-	{ S5P_ARM_CORE3_LOWPWR,			{ 0x0, 0x0, 0x2 } },
-	{ S5P_DIS_IRQ_CORE3,			{ 0x0, 0x0, 0x0 } },
-	{ S5P_DIS_IRQ_CENTRAL3,			{ 0x0, 0x0, 0x0 } },
-	{ PMU_TABLE_END,},
-};
-
-const struct exynos_pmu_data exynos4210_pmu_data = {
-	.pmu_config	= exynos4210_pmu_config,
-};
-
-const struct exynos_pmu_data exynos4212_pmu_data = {
-	.pmu_config	= exynos4x12_pmu_config,
-};
-
-const struct exynos_pmu_data exynos4412_pmu_data = {
-	.pmu_config		= exynos4x12_pmu_config,
-	.pmu_config_extra	= exynos4412_pmu_config,
-};
-
diff --git a/arch/arm/mach-exynos/exynos5250-pmu.c b/arch/arm/mach-exynos/exynos5250-pmu.c
deleted file mode 100644
index a6d4188..0000000
--- a/arch/arm/mach-exynos/exynos5250-pmu.c
+++ /dev/null
@@ -1,196 +0,0 @@
-/*
- * Copyright (c) 2011-2015 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * EXYNOS5250 - CPU PMU (Power Management Unit) support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/soc/samsung/exynos-regs-pmu.h>
-#include <linux/soc/samsung/exynos-pmu.h>
-
-#include "exynos-pmu.h"
-
-static const struct exynos_pmu_conf exynos5250_pmu_config[] = {
-	/* { .offset = offset, .val = { AFTR, LPA, SLEEP } */
-	{ EXYNOS5_ARM_CORE0_SYS_PWR_REG,		{ 0x0, 0x0, 0x2} },
-	{ EXYNOS5_DIS_IRQ_ARM_CORE0_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_DIS_IRQ_ARM_CORE0_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
-	{ EXYNOS5_ARM_CORE1_SYS_PWR_REG,		{ 0x0, 0x0, 0x2} },
-	{ EXYNOS5_DIS_IRQ_ARM_CORE1_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_DIS_IRQ_ARM_CORE1_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
-	{ EXYNOS5_FSYS_ARM_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_DIS_IRQ_FSYS_ARM_CENTRAL_SYS_PWR_REG,	{ 0x1, 0x1, 0x1} },
-	{ EXYNOS5_ISP_ARM_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_DIS_IRQ_ISP_ARM_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_DIS_IRQ_ISP_ARM_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_ARM_COMMON_SYS_PWR_REG,		{ 0x0, 0x0, 0x2} },
-	{ EXYNOS5_ARM_L2_SYS_PWR_REG,			{ 0x3, 0x3, 0x3} },
-	{ EXYNOS5_ARM_L2_OPTION,			{ 0x10, 0x10, 0x0 } },
-	{ EXYNOS5_CMU_ACLKSTOP_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
-	{ EXYNOS5_CMU_SCLKSTOP_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
-	{ EXYNOS5_CMU_RESET_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_CMU_ACLKSTOP_SYSMEM_SYS_PWR_REG,	{ 0x1, 0x0, 0x1} },
-	{ EXYNOS5_CMU_SCLKSTOP_SYSMEM_SYS_PWR_REG,	{ 0x1, 0x0, 0x1} },
-	{ EXYNOS5_CMU_RESET_SYSMEM_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_DRAM_FREQ_DOWN_SYS_PWR_REG,		{ 0x1, 0x1, 0x1} },
-	{ EXYNOS5_DDRPHY_DLLOFF_SYS_PWR_REG,		{ 0x1, 0x1, 0x1} },
-	{ EXYNOS5_DDRPHY_DLLLOCK_SYS_PWR_REG,		{ 0x1, 0x1, 0x1} },
-	{ EXYNOS5_APLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_MPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_VPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_EPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_BPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_CPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_MPLLUSER_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_BPLLUSER_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_TOP_BUS_SYS_PWR_REG,			{ 0x3, 0x0, 0x0} },
-	{ EXYNOS5_TOP_RETENTION_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
-	{ EXYNOS5_TOP_PWR_SYS_PWR_REG,			{ 0x3, 0x0, 0x3} },
-	{ EXYNOS5_TOP_BUS_SYSMEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
-	{ EXYNOS5_TOP_RETENTION_SYSMEM_SYS_PWR_REG,	{ 0x1, 0x0, 0x1} },
-	{ EXYNOS5_TOP_PWR_SYSMEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x3} },
-	{ EXYNOS5_LOGIC_RESET_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_OSCCLK_GATE_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
-	{ EXYNOS5_LOGIC_RESET_SYSMEM_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_OSCCLK_GATE_SYSMEM_SYS_PWR_REG,	{ 0x1, 0x0, 0x1} },
-	{ EXYNOS5_USBOTG_MEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
-	{ EXYNOS5_G2D_MEM_SYS_PWR_REG,			{ 0x3, 0x0, 0x0} },
-	{ EXYNOS5_USBDRD_MEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
-	{ EXYNOS5_SDMMC_MEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
-	{ EXYNOS5_CSSYS_MEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
-	{ EXYNOS5_SECSS_MEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
-	{ EXYNOS5_ROTATOR_MEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
-	{ EXYNOS5_INTRAM_MEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
-	{ EXYNOS5_INTROM_MEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
-	{ EXYNOS5_JPEG_MEM_SYS_PWR_REG,			{ 0x3, 0x0, 0x0} },
-	{ EXYNOS5_JPEG_MEM_OPTION,			{ 0x10, 0x10, 0x0} },
-	{ EXYNOS5_HSI_MEM_SYS_PWR_REG,			{ 0x3, 0x0, 0x0} },
-	{ EXYNOS5_MCUIOP_MEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
-	{ EXYNOS5_SATA_MEM_SYS_PWR_REG,			{ 0x3, 0x0, 0x0} },
-	{ EXYNOS5_PAD_RETENTION_DRAM_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_PAD_RETENTION_MAU_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_PAD_RETENTION_GPIO_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_PAD_RETENTION_UART_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_PAD_RETENTION_MMCA_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_PAD_RETENTION_MMCB_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_PAD_RETENTION_EBIA_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_PAD_RETENTION_EBIB_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_PAD_RETENTION_SPI_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_PAD_RETENTION_GPIO_SYSMEM_SYS_PWR_REG, { 0x1, 0x0, 0x0} },
-	{ EXYNOS5_PAD_ISOLATION_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_PAD_ISOLATION_SYSMEM_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_PAD_ALV_SEL_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_XUSBXTI_SYS_PWR_REG,			{ 0x1, 0x1, 0x1} },
-	{ EXYNOS5_XXTI_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_EXT_REGULATOR_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_GPIO_MODE_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_GPIO_MODE_SYSMEM_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_GPIO_MODE_MAU_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_TOP_ASB_RESET_SYS_PWR_REG,		{ 0x1, 0x1, 0x1} },
-	{ EXYNOS5_TOP_ASB_ISOLATION_SYS_PWR_REG,	{ 0x1, 0x0, 0x1} },
-	{ EXYNOS5_GSCL_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
-	{ EXYNOS5_ISP_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
-	{ EXYNOS5_MFC_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
-	{ EXYNOS5_G3D_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
-	{ EXYNOS5_DISP1_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
-	{ EXYNOS5_MAU_SYS_PWR_REG,			{ 0x7, 0x7, 0x0} },
-	{ EXYNOS5_CMU_CLKSTOP_GSCL_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_CMU_CLKSTOP_ISP_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_CMU_CLKSTOP_MFC_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_CMU_CLKSTOP_G3D_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_CMU_CLKSTOP_DISP1_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_CMU_CLKSTOP_MAU_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_CMU_SYSCLK_GSCL_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_CMU_SYSCLK_ISP_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_CMU_SYSCLK_MFC_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_CMU_SYSCLK_G3D_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_CMU_SYSCLK_DISP1_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_CMU_SYSCLK_MAU_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_CMU_RESET_GSCL_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_CMU_RESET_ISP_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_CMU_RESET_MFC_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_CMU_RESET_G3D_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_CMU_RESET_DISP1_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_CMU_RESET_MAU_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ PMU_TABLE_END,},
-};
-
-static unsigned int const exynos5_list_both_cnt_feed[] = {
-	EXYNOS5_ARM_CORE0_OPTION,
-	EXYNOS5_ARM_CORE1_OPTION,
-	EXYNOS5_ARM_COMMON_OPTION,
-	EXYNOS5_GSCL_OPTION,
-	EXYNOS5_ISP_OPTION,
-	EXYNOS5_MFC_OPTION,
-	EXYNOS5_G3D_OPTION,
-	EXYNOS5_DISP1_OPTION,
-	EXYNOS5_MAU_OPTION,
-	EXYNOS5_TOP_PWR_OPTION,
-	EXYNOS5_TOP_PWR_SYSMEM_OPTION,
-};
-
-static unsigned int const exynos5_list_disable_wfi_wfe[] = {
-	EXYNOS5_ARM_CORE1_OPTION,
-	EXYNOS5_FSYS_ARM_OPTION,
-	EXYNOS5_ISP_ARM_OPTION,
-};
-
-static void exynos5250_pmu_init(void)
-{
-	unsigned int value;
-	/*
-	 * When SYS_WDTRESET is set, watchdog timer reset request
-	 * is ignored by power management unit.
-	 */
-	value = pmu_raw_readl(EXYNOS5_AUTO_WDTRESET_DISABLE);
-	value &= ~EXYNOS5_SYS_WDTRESET;
-	pmu_raw_writel(value, EXYNOS5_AUTO_WDTRESET_DISABLE);
-
-	value = pmu_raw_readl(EXYNOS5_MASK_WDTRESET_REQUEST);
-	value &= ~EXYNOS5_SYS_WDTRESET;
-	pmu_raw_writel(value, EXYNOS5_MASK_WDTRESET_REQUEST);
-}
-
-static void exynos5_powerdown_conf(enum sys_powerdown mode)
-{
-	unsigned int i;
-	unsigned int tmp;
-
-	/*
-	 * Enable both SC_FEEDBACK and SC_COUNTER
-	 */
-	for (i = 0; i < ARRAY_SIZE(exynos5_list_both_cnt_feed); i++) {
-		tmp = pmu_raw_readl(exynos5_list_both_cnt_feed[i]);
-		tmp |= (EXYNOS5_USE_SC_FEEDBACK |
-			EXYNOS5_USE_SC_COUNTER);
-		pmu_raw_writel(tmp, exynos5_list_both_cnt_feed[i]);
-	}
-
-	/*
-	 * SKIP_DEACTIVATE_ACEACP_IN_PWDN_BITFIELD Enable
-	 */
-	tmp = pmu_raw_readl(EXYNOS5_ARM_COMMON_OPTION);
-	tmp |= EXYNOS5_SKIP_DEACTIVATE_ACEACP_IN_PWDN;
-	pmu_raw_writel(tmp, EXYNOS5_ARM_COMMON_OPTION);
-
-	/*
-	 * Disable WFI/WFE on XXX_OPTION
-	 */
-	for (i = 0; i < ARRAY_SIZE(exynos5_list_disable_wfi_wfe); i++) {
-		tmp = pmu_raw_readl(exynos5_list_disable_wfi_wfe[i]);
-		tmp &= ~(EXYNOS5_OPTION_USE_STANDBYWFE |
-			 EXYNOS5_OPTION_USE_STANDBYWFI);
-		pmu_raw_writel(tmp, exynos5_list_disable_wfi_wfe[i]);
-	}
-}
-
-const struct exynos_pmu_data exynos5250_pmu_data = {
-	.pmu_config	= exynos5250_pmu_config,
-	.pmu_init	= exynos5250_pmu_init,
-	.powerdown_conf	= exynos5_powerdown_conf,
-};
-
diff --git a/arch/arm/mach-exynos/exynos5420-pmu.c b/arch/arm/mach-exynos/exynos5420-pmu.c
deleted file mode 100644
index 5810afe..0000000
--- a/arch/arm/mach-exynos/exynos5420-pmu.c
+++ /dev/null
@@ -1,280 +0,0 @@
-/*
- * Copyright (c) 2011-2015 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * EXYNOS5420 - CPU PMU (Power Management Unit) support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/pm.h>
-#include <linux/soc/samsung/exynos-regs-pmu.h>
-#include <linux/soc/samsung/exynos-pmu.h>
-
-#include <asm/cputype.h>
-
-#include "exynos-pmu.h"
-
-static struct exynos_pmu_conf exynos5420_pmu_config[] = {
-	/* { .offset = offset, .val = { AFTR, LPA, SLEEP } */
-	{ EXYNOS5_ARM_CORE0_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_DIS_IRQ_ARM_CORE0_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_DIS_IRQ_ARM_CORE0_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
-	{ EXYNOS5_ARM_CORE1_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_DIS_IRQ_ARM_CORE1_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_DIS_IRQ_ARM_CORE1_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_ARM_CORE2_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_DIS_IRQ_ARM_CORE2_LOCAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_DIS_IRQ_ARM_CORE2_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_ARM_CORE3_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_DIS_IRQ_ARM_CORE3_LOCAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_DIS_IRQ_ARM_CORE3_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_KFC_CORE0_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_DIS_IRQ_KFC_CORE0_LOCAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_DIS_IRQ_KFC_CORE0_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_KFC_CORE1_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_DIS_IRQ_KFC_CORE1_LOCAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_DIS_IRQ_KFC_CORE1_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_KFC_CORE2_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_DIS_IRQ_KFC_CORE2_LOCAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_DIS_IRQ_KFC_CORE2_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_KFC_CORE3_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_DIS_IRQ_KFC_CORE3_LOCAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_DIS_IRQ_KFC_CORE3_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
-	{ EXYNOS5_ISP_ARM_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_DIS_IRQ_ISP_ARM_LOCAL_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_DIS_IRQ_ISP_ARM_CENTRAL_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_ARM_COMMON_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_KFC_COMMON_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_ARM_L2_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_KFC_L2_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_CMU_ACLKSTOP_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_CMU_SCLKSTOP_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
-	{ EXYNOS5_CMU_RESET_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_CMU_ACLKSTOP_SYSMEM_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_CMU_SCLKSTOP_SYSMEM_SYS_PWR_REG,	{ 0x1, 0x0, 0x1} },
-	{ EXYNOS5_CMU_RESET_SYSMEM_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_DRAM_FREQ_DOWN_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
-	{ EXYNOS5_DDRPHY_DLLOFF_SYS_PWR_REG,		{ 0x1, 0x1, 0x1} },
-	{ EXYNOS5_DDRPHY_DLLLOCK_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
-	{ EXYNOS5_APLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_MPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_VPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_EPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_BPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_CPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_DPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_IPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_KPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_MPLLUSER_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_BPLLUSER_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_RPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_SPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_TOP_BUS_SYS_PWR_REG,			{ 0x3, 0x0, 0x0} },
-	{ EXYNOS5_TOP_RETENTION_SYS_PWR_REG,		{ 0x1, 0x1, 0x1} },
-	{ EXYNOS5_TOP_PWR_SYS_PWR_REG,			{ 0x3, 0x3, 0x0} },
-	{ EXYNOS5_TOP_BUS_SYSMEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
-	{ EXYNOS5_TOP_RETENTION_SYSMEM_SYS_PWR_REG,	{ 0x1, 0x0, 0x1} },
-	{ EXYNOS5_TOP_PWR_SYSMEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
-	{ EXYNOS5_LOGIC_RESET_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_OSCCLK_GATE_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
-	{ EXYNOS5_LOGIC_RESET_SYSMEM_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_OSCCLK_GATE_SYSMEM_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_INTRAM_MEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x3} },
-	{ EXYNOS5420_INTROM_MEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x3} },
-	{ EXYNOS5_PAD_RETENTION_DRAM_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_PAD_RETENTION_MAU_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5420_PAD_RETENTION_JTAG_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5420_PAD_RETENTION_DRAM_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_PAD_RETENTION_UART_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_PAD_RETENTION_MMC0_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_PAD_RETENTION_MMC1_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_PAD_RETENTION_MMC2_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_PAD_RETENTION_HSI_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_PAD_RETENTION_EBIA_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_PAD_RETENTION_EBIB_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_PAD_RETENTION_SPI_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5420_PAD_RETENTION_DRAM_COREBLK_SYS_PWR_REG, { 0x1, 0x0, 0x0} },
-	{ EXYNOS5_PAD_ISOLATION_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_PAD_ISOLATION_SYSMEM_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_PAD_ALV_SEL_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_XUSBXTI_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_XXTI_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_EXT_REGULATOR_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_GPIO_MODE_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_GPIO_MODE_SYSMEM_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_GPIO_MODE_MAU_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_TOP_ASB_RESET_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
-	{ EXYNOS5_TOP_ASB_ISOLATION_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
-	{ EXYNOS5_GSCL_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
-	{ EXYNOS5_ISP_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
-	{ EXYNOS5_MFC_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
-	{ EXYNOS5_G3D_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
-	{ EXYNOS5420_DISP1_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
-	{ EXYNOS5420_MAU_SYS_PWR_REG,			{ 0x7, 0x7, 0x0} },
-	{ EXYNOS5420_G2D_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
-	{ EXYNOS5420_MSC_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
-	{ EXYNOS5420_FSYS_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
-	{ EXYNOS5420_FSYS2_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
-	{ EXYNOS5420_PSGEN_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
-	{ EXYNOS5420_PERIC_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
-	{ EXYNOS5420_WCORE_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
-	{ EXYNOS5_CMU_CLKSTOP_GSCL_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_CMU_CLKSTOP_ISP_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_CMU_CLKSTOP_MFC_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_CMU_CLKSTOP_G3D_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_CLKSTOP_DISP1_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_CLKSTOP_MAU_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_CLKSTOP_G2D_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_CLKSTOP_MSC_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_CLKSTOP_FSYS_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_CLKSTOP_PSGEN_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_CLKSTOP_PERIC_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_CLKSTOP_WCORE_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_CMU_SYSCLK_GSCL_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_CMU_SYSCLK_ISP_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_CMU_SYSCLK_MFC_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_CMU_SYSCLK_G3D_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_SYSCLK_DISP1_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_SYSCLK_MAU_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_SYSCLK_G2D_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_SYSCLK_MSC_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_SYSCLK_FSYS_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_SYSCLK_FSYS2_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_SYSCLK_PSGEN_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_SYSCLK_PERIC_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_SYSCLK_WCORE_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_RESET_FSYS2_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_RESET_PSGEN_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_RESET_PERIC_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_RESET_WCORE_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_CMU_RESET_GSCL_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_CMU_RESET_ISP_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_CMU_RESET_MFC_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5_CMU_RESET_G3D_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_RESET_DISP1_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_RESET_MAU_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_RESET_G2D_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_RESET_MSC_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
-	{ EXYNOS5420_CMU_RESET_FSYS_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
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
-	pr_info("EXYNOS5420 PMU initialized\n");
-}
-
-const struct exynos_pmu_data exynos5420_pmu_data = {
-	.pmu_config	= exynos5420_pmu_config,
-	.pmu_init	= exynos5420_pmu_init,
-	.powerdown_conf	= exynos5420_powerdown_conf,
-};
diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
deleted file mode 100644
index f300ac9..0000000
--- a/arch/arm/mach-exynos/pmu.c
+++ /dev/null
@@ -1,183 +0,0 @@
-/*
- * Copyright (c) 2011-2014 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * EXYNOS - CPU PMU(Power Management Unit) support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/platform_device.h>
-#include <linux/delay.h>
-#include <linux/notifier.h>
-#include <linux/reboot.h>
-
-#include <linux/soc/samsung/exynos-regs-pmu.h>
-#include <linux/soc/samsung/exynos-pmu.h>
-
-#include "exynos-pmu.h"
-
-struct exynos_pmu_context {
-	struct device *dev;
-	const struct exynos_pmu_data *pmu_data;
-};
-
-void __iomem *pmu_base_addr;
-static struct exynos_pmu_context *pmu_context;
-
-void pmu_raw_writel(u32 val, u32 offset)
-{
-	writel_relaxed(val, pmu_base_addr + offset);
-}
-
-u32 pmu_raw_readl(u32 offset)
-{
-	return readl_relaxed(pmu_base_addr + offset);
-}
-
-void exynos_sys_powerdown_conf(enum sys_powerdown mode)
-{
-	unsigned int i;
-	const struct exynos_pmu_data *pmu_data;
-
-	if(!pmu_context)
-		return;
-
-	pmu_data = pmu_context->pmu_data;
-
-	if (pmu_data->powerdown_conf)
-		pmu_data->powerdown_conf(mode);
-
-	if (pmu_data->pmu_config) {
-		for (i = 0; (pmu_data->pmu_config[i].offset != PMU_TABLE_END); i++)
-			pmu_raw_writel(pmu_data->pmu_config[i].val[mode],
-					pmu_data->pmu_config[i].offset);
-	}
-
-	if (pmu_data->powerdown_conf_extra)
-		pmu_data->powerdown_conf_extra(mode);
-
-	if (pmu_data->pmu_config_extra) {
-		for (i = 0; pmu_data->pmu_config_extra[i].offset != PMU_TABLE_END; i++)
-			pmu_raw_writel(pmu_data->pmu_config_extra[i].val[mode],
-					pmu_data->pmu_config_extra[i].offset);
-	}
-}
-
-static void exynos_power_off(void)
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
-static int pmu_restart_notify(struct notifier_block *this,
-		unsigned long code, void *unused)
-{
-	pmu_raw_writel(0x1, EXYNOS_SWRESET);
-
-	return NOTIFY_DONE;
-}
-
-/*
- * PMU platform driver and devicetree bindings.
- */
-static const struct of_device_id exynos_pmu_of_device_ids[] = {
-	{
-		.compatible = "samsung,exynos3250-pmu",
-		.data = &exynos3250_pmu_data,
-	}, {
-		.compatible = "samsung,exynos4210-pmu",
-		.data = &exynos4210_pmu_data,
-	}, {
-		.compatible = "samsung,exynos4212-pmu",
-		.data = &exynos4212_pmu_data,
-	}, {
-		.compatible = "samsung,exynos4412-pmu",
-		.data = &exynos4412_pmu_data,
-	}, {
-		.compatible = "samsung,exynos5250-pmu",
-		.data = &exynos5250_pmu_data,
-	}, {
-		.compatible = "samsung,exynos5420-pmu",
-		.data = &exynos5420_pmu_data,
-	},
-	{ /*sentinel*/ },
-};
-
-/*
- * Exynos PMU restart notifier, handles restart functionality
- */
-static struct notifier_block pmu_restart_handler = {
-	.notifier_call = pmu_restart_notify,
-	.priority = 128,
-};
-
-static int exynos_pmu_probe(struct platform_device *pdev)
-{
-	const struct of_device_id *match;
-	struct device *dev = &pdev->dev;
-	struct resource *res;
-	int ret;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pmu_base_addr = devm_ioremap_resource(dev, res);
-	if (IS_ERR(pmu_base_addr))
-		return PTR_ERR(pmu_base_addr);
-
-	pmu_context = devm_kzalloc(&pdev->dev,
-			sizeof(struct exynos_pmu_context),
-			GFP_KERNEL);
-	if (!pmu_context) {
-		dev_err(dev, "Cannot allocate memory.\n");
-		return -ENOMEM;
-	}
-	pmu_context->dev = dev;
-
-	match = of_match_node(exynos_pmu_of_device_ids, dev->of_node);
-
-	pmu_context->pmu_data = match->data;
-
-	if (pmu_context->pmu_data->pmu_init)
-		pmu_context->pmu_data->pmu_init();
-
-	platform_set_drvdata(pdev, pmu_context);
-
-	ret = register_restart_handler(&pmu_restart_handler);
-	if (ret)
-		dev_warn(dev, "can't register restart handler err=%d\n", ret);
-
-	pm_power_off = exynos_power_off;
-
-	dev_dbg(dev, "Exynos PMU Driver probe done\n");
-	return 0;
-}
-
-static struct platform_driver exynos_pmu_driver = {
-	.driver  = {
-		.name   = "exynos-pmu",
-		.of_match_table = exynos_pmu_of_device_ids,
-	},
-	.probe = exynos_pmu_probe,
-};
-
-static int __init exynos_pmu_init(void)
-{
-	return platform_driver_register(&exynos_pmu_driver);
-
-}
-postcore_initcall(exynos_pmu_init);
diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
index 2833b5b..f545d6c 100644
--- a/drivers/soc/samsung/Kconfig
+++ b/drivers/soc/samsung/Kconfig
@@ -10,4 +10,8 @@ config EXYNOS_SROM
 	bool
 	depends on ARM && ARCH_EXYNOS && PM
 
+config EXYNOS_PMU
+	bool
+	depends on ARCH_EXYNOS
+
 endmenu
diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
index 9c554d5..26fb489 100644
--- a/drivers/soc/samsung/Makefile
+++ b/drivers/soc/samsung/Makefile
@@ -1 +1,5 @@
 obj-$(CONFIG_EXYNOS_SROM)	+= exynos-srom.o
+ifdef CONFIG_ARM
+obj-$(CONFIG_EXYNOS_PMU)	+= exynos-pmu.o exynos3250-pmu.o exynos4-pmu.o \
+					exynos5250-pmu.o exynos5420-pmu.o
+endif
diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
new file mode 100644
index 0000000..f300ac9
--- /dev/null
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -0,0 +1,183 @@
+/*
+ * Copyright (c) 2011-2014 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * EXYNOS - CPU PMU(Power Management Unit) support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+
+#include <linux/soc/samsung/exynos-regs-pmu.h>
+#include <linux/soc/samsung/exynos-pmu.h>
+
+#include "exynos-pmu.h"
+
+struct exynos_pmu_context {
+	struct device *dev;
+	const struct exynos_pmu_data *pmu_data;
+};
+
+void __iomem *pmu_base_addr;
+static struct exynos_pmu_context *pmu_context;
+
+void pmu_raw_writel(u32 val, u32 offset)
+{
+	writel_relaxed(val, pmu_base_addr + offset);
+}
+
+u32 pmu_raw_readl(u32 offset)
+{
+	return readl_relaxed(pmu_base_addr + offset);
+}
+
+void exynos_sys_powerdown_conf(enum sys_powerdown mode)
+{
+	unsigned int i;
+	const struct exynos_pmu_data *pmu_data;
+
+	if(!pmu_context)
+		return;
+
+	pmu_data = pmu_context->pmu_data;
+
+	if (pmu_data->powerdown_conf)
+		pmu_data->powerdown_conf(mode);
+
+	if (pmu_data->pmu_config) {
+		for (i = 0; (pmu_data->pmu_config[i].offset != PMU_TABLE_END); i++)
+			pmu_raw_writel(pmu_data->pmu_config[i].val[mode],
+					pmu_data->pmu_config[i].offset);
+	}
+
+	if (pmu_data->powerdown_conf_extra)
+		pmu_data->powerdown_conf_extra(mode);
+
+	if (pmu_data->pmu_config_extra) {
+		for (i = 0; pmu_data->pmu_config_extra[i].offset != PMU_TABLE_END; i++)
+			pmu_raw_writel(pmu_data->pmu_config_extra[i].val[mode],
+					pmu_data->pmu_config_extra[i].offset);
+	}
+}
+
+static void exynos_power_off(void)
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
+static int pmu_restart_notify(struct notifier_block *this,
+		unsigned long code, void *unused)
+{
+	pmu_raw_writel(0x1, EXYNOS_SWRESET);
+
+	return NOTIFY_DONE;
+}
+
+/*
+ * PMU platform driver and devicetree bindings.
+ */
+static const struct of_device_id exynos_pmu_of_device_ids[] = {
+	{
+		.compatible = "samsung,exynos3250-pmu",
+		.data = &exynos3250_pmu_data,
+	}, {
+		.compatible = "samsung,exynos4210-pmu",
+		.data = &exynos4210_pmu_data,
+	}, {
+		.compatible = "samsung,exynos4212-pmu",
+		.data = &exynos4212_pmu_data,
+	}, {
+		.compatible = "samsung,exynos4412-pmu",
+		.data = &exynos4412_pmu_data,
+	}, {
+		.compatible = "samsung,exynos5250-pmu",
+		.data = &exynos5250_pmu_data,
+	}, {
+		.compatible = "samsung,exynos5420-pmu",
+		.data = &exynos5420_pmu_data,
+	},
+	{ /*sentinel*/ },
+};
+
+/*
+ * Exynos PMU restart notifier, handles restart functionality
+ */
+static struct notifier_block pmu_restart_handler = {
+	.notifier_call = pmu_restart_notify,
+	.priority = 128,
+};
+
+static int exynos_pmu_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pmu_base_addr = devm_ioremap_resource(dev, res);
+	if (IS_ERR(pmu_base_addr))
+		return PTR_ERR(pmu_base_addr);
+
+	pmu_context = devm_kzalloc(&pdev->dev,
+			sizeof(struct exynos_pmu_context),
+			GFP_KERNEL);
+	if (!pmu_context) {
+		dev_err(dev, "Cannot allocate memory.\n");
+		return -ENOMEM;
+	}
+	pmu_context->dev = dev;
+
+	match = of_match_node(exynos_pmu_of_device_ids, dev->of_node);
+
+	pmu_context->pmu_data = match->data;
+
+	if (pmu_context->pmu_data->pmu_init)
+		pmu_context->pmu_data->pmu_init();
+
+	platform_set_drvdata(pdev, pmu_context);
+
+	ret = register_restart_handler(&pmu_restart_handler);
+	if (ret)
+		dev_warn(dev, "can't register restart handler err=%d\n", ret);
+
+	pm_power_off = exynos_power_off;
+
+	dev_dbg(dev, "Exynos PMU Driver probe done\n");
+	return 0;
+}
+
+static struct platform_driver exynos_pmu_driver = {
+	.driver  = {
+		.name   = "exynos-pmu",
+		.of_match_table = exynos_pmu_of_device_ids,
+	},
+	.probe = exynos_pmu_probe,
+};
+
+static int __init exynos_pmu_init(void)
+{
+	return platform_driver_register(&exynos_pmu_driver);
+
+}
+postcore_initcall(exynos_pmu_init);
diff --git a/drivers/soc/samsung/exynos-pmu.h b/drivers/soc/samsung/exynos-pmu.h
new file mode 100644
index 0000000..306f5c7
--- /dev/null
+++ b/drivers/soc/samsung/exynos-pmu.h
@@ -0,0 +1,45 @@
+/*
+ * Copyright (c) 2015 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Header for EXYNOS PMU Driver support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __EXYNOS_PMU_H
+#define __EXYNOS_PMU_H
+
+#include <linux/io.h>
+
+#define PMU_TABLE_END	(-1U)
+
+
+struct exynos_pmu_conf {
+	unsigned int offset;
+	u8 val[NUM_SYS_POWERDOWN];
+};
+
+struct exynos_pmu_data {
+	const struct exynos_pmu_conf *pmu_config;
+	const struct exynos_pmu_conf *pmu_config_extra;
+
+	void (*pmu_init)(void);
+	void (*powerdown_conf)(enum sys_powerdown);
+	void (*powerdown_conf_extra)(enum sys_powerdown);
+};
+
+extern void __iomem *pmu_base_addr;
+/* list of all exported SoC specific data */
+extern const struct exynos_pmu_data exynos3250_pmu_data;
+extern const struct exynos_pmu_data exynos4210_pmu_data;
+extern const struct exynos_pmu_data exynos4212_pmu_data;
+extern const struct exynos_pmu_data exynos4412_pmu_data;
+extern const struct exynos_pmu_data exynos5250_pmu_data;
+extern const struct exynos_pmu_data exynos5420_pmu_data;
+
+extern void pmu_raw_writel(u32 val, u32 offset);
+extern u32 pmu_raw_readl(u32 offset);
+#endif /* __EXYNOS_PMU_H */
diff --git a/drivers/soc/samsung/exynos3250-pmu.c b/drivers/soc/samsung/exynos3250-pmu.c
new file mode 100644
index 0000000..20b3ab8
--- /dev/null
+++ b/drivers/soc/samsung/exynos3250-pmu.c
@@ -0,0 +1,175 @@
+/*
+ * Copyright (c) 2011-2015 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * EXYNOS3250 - CPU PMU (Power Management Unit) support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/soc/samsung/exynos-regs-pmu.h>
+#include <linux/soc/samsung/exynos-pmu.h>
+
+#include "exynos-pmu.h"
+
+static struct exynos_pmu_conf exynos3250_pmu_config[] = {
+	/* { .offset = offset, .val = { AFTR, W-AFTR, SLEEP } */
+	{ EXYNOS3_ARM_CORE0_SYS_PWR_REG,		{ 0x0, 0x0, 0x2} },
+	{ EXYNOS3_DIS_IRQ_ARM_CORE0_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS3_DIS_IRQ_ARM_CORE0_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS3_ARM_CORE1_SYS_PWR_REG,		{ 0x0, 0x0, 0x2} },
+	{ EXYNOS3_DIS_IRQ_ARM_CORE1_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS3_DIS_IRQ_ARM_CORE1_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS3_ISP_ARM_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
+	{ EXYNOS3_DIS_IRQ_ISP_ARM_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS3_DIS_IRQ_ISP_ARM_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS3_ARM_COMMON_SYS_PWR_REG,		{ 0x0, 0x0, 0x2} },
+	{ EXYNOS3_ARM_L2_SYS_PWR_REG,			{ 0x0, 0x0, 0x3} },
+	{ EXYNOS3_CMU_ACLKSTOP_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS3_CMU_SCLKSTOP_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS3_CMU_RESET_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS3_DRAM_FREQ_DOWN_SYS_PWR_REG,		{ 0x1, 0x1, 0x1} },
+	{ EXYNOS3_DDRPHY_DLLOFF_SYS_PWR_REG,		{ 0x1, 0x1, 0x1} },
+	{ EXYNOS3_LPDDR_PHY_DLL_LOCK_SYS_PWR_REG,	{ 0x1, 0x1, 0x1} },
+	{ EXYNOS3_CMU_ACLKSTOP_COREBLK_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS3_CMU_SCLKSTOP_COREBLK_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS3_CMU_RESET_COREBLK_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
+	{ EXYNOS3_APLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS3_MPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS3_BPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS3_VPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS3_EPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS3_UPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x1, 0x1} },
+	{ EXYNOS3_EPLLUSER_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS3_MPLLUSER_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS3_BPLLUSER_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS3_CMU_CLKSTOP_CAM_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS3_CMU_CLKSTOP_MFC_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS3_CMU_CLKSTOP_G3D_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS3_CMU_CLKSTOP_LCD0_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS3_CMU_CLKSTOP_ISP_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS3_CMU_CLKSTOP_MAUDIO_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS3_CMU_RESET_CAM_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS3_CMU_RESET_MFC_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS3_CMU_RESET_G3D_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS3_CMU_RESET_LCD0_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS3_CMU_RESET_ISP_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS3_CMU_RESET_MAUDIO_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS3_TOP_BUS_SYS_PWR_REG,			{ 0x3, 0x0, 0x0} },
+	{ EXYNOS3_TOP_RETENTION_SYS_PWR_REG,		{ 0x1, 0x1, 0x1} },
+	{ EXYNOS3_TOP_PWR_SYS_PWR_REG,			{ 0x3, 0x3, 0x3} },
+	{ EXYNOS3_TOP_BUS_COREBLK_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
+	{ EXYNOS3_TOP_RETENTION_COREBLK_SYS_PWR_REG,	{ 0x1, 0x1, 0x1} },
+	{ EXYNOS3_TOP_PWR_COREBLK_SYS_PWR_REG,		{ 0x3, 0x3, 0x3} },
+	{ EXYNOS3_LOGIC_RESET_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS3_OSCCLK_GATE_SYS_PWR_REG,		{ 0x1, 0x1, 0x1} },
+	{ EXYNOS3_LOGIC_RESET_COREBLK_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
+	{ EXYNOS3_OSCCLK_GATE_COREBLK_SYS_PWR_REG,	{ 0x1, 0x0, 0x1} },
+	{ EXYNOS3_PAD_RETENTION_DRAM_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
+	{ EXYNOS3_PAD_RETENTION_MAUDIO_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
+	{ EXYNOS3_PAD_RETENTION_GPIO_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
+	{ EXYNOS3_PAD_RETENTION_UART_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
+	{ EXYNOS3_PAD_RETENTION_MMC0_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
+	{ EXYNOS3_PAD_RETENTION_MMC1_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
+	{ EXYNOS3_PAD_RETENTION_MMC2_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
+	{ EXYNOS3_PAD_RETENTION_SPI_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
+	{ EXYNOS3_PAD_RETENTION_EBIA_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
+	{ EXYNOS3_PAD_RETENTION_EBIB_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
+	{ EXYNOS3_PAD_RETENTION_JTAG_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
+	{ EXYNOS3_PAD_ISOLATION_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS3_PAD_ALV_SEL_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS3_XUSBXTI_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
+	{ EXYNOS3_XXTI_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
+	{ EXYNOS3_EXT_REGULATOR_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS3_EXT_REGULATOR_COREBLK_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
+	{ EXYNOS3_GPIO_MODE_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS3_GPIO_MODE_MAUDIO_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS3_TOP_ASB_RESET_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS3_TOP_ASB_ISOLATION_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
+	{ EXYNOS3_TOP_ASB_RESET_COREBLK_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
+	{ EXYNOS3_TOP_ASB_ISOLATION_COREBLK_SYS_PWR_REG, { 0x1, 0x1, 0x0} },
+	{ EXYNOS3_CAM_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
+	{ EXYNOS3_MFC_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
+	{ EXYNOS3_G3D_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
+	{ EXYNOS3_LCD0_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
+	{ EXYNOS3_ISP_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
+	{ EXYNOS3_MAUDIO_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
+	{ EXYNOS3_CMU_SYSCLK_ISP_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ PMU_TABLE_END,},
+};
+
+static unsigned int const exynos3250_list_feed[] = {
+	EXYNOS3_ARM_CORE_OPTION(0),
+	EXYNOS3_ARM_CORE_OPTION(1),
+	EXYNOS3_ARM_CORE_OPTION(2),
+	EXYNOS3_ARM_CORE_OPTION(3),
+	EXYNOS3_ARM_COMMON_OPTION,
+	EXYNOS3_TOP_PWR_OPTION,
+	EXYNOS3_CORE_TOP_PWR_OPTION,
+	S5P_CAM_OPTION,
+	S5P_MFC_OPTION,
+	S5P_G3D_OPTION,
+	S5P_LCD0_OPTION,
+	S5P_ISP_OPTION,
+};
+
+static void exynos3250_powerdown_conf_extra(enum sys_powerdown mode)
+{
+	unsigned int i;
+	unsigned int tmp;
+
+	/* Enable only SC_FEEDBACK */
+	for (i = 0; i < ARRAY_SIZE(exynos3250_list_feed); i++) {
+		tmp = pmu_raw_readl(exynos3250_list_feed[i]);
+		tmp &= ~(EXYNOS3_OPTION_USE_SC_COUNTER);
+		tmp |= EXYNOS3_OPTION_USE_SC_FEEDBACK;
+		pmu_raw_writel(tmp, exynos3250_list_feed[i]);
+	}
+
+	if (mode != SYS_SLEEP)
+		return;
+
+	pmu_raw_writel(XUSBXTI_DURATION, EXYNOS3_XUSBXTI_DURATION);
+	pmu_raw_writel(XXTI_DURATION, EXYNOS3_XXTI_DURATION);
+	pmu_raw_writel(EXT_REGULATOR_DURATION, EXYNOS3_EXT_REGULATOR_DURATION);
+	pmu_raw_writel(EXT_REGULATOR_COREBLK_DURATION,
+		       EXYNOS3_EXT_REGULATOR_COREBLK_DURATION);
+}
+
+static void exynos3250_pmu_init(void)
+{
+	unsigned int value;
+
+	/*
+	 * To prevent from issuing new bus request form L2 memory system
+	 * If core status is power down, should be set '1' to L2 power down
+	 */
+	value = pmu_raw_readl(EXYNOS3_ARM_COMMON_OPTION);
+	value |= EXYNOS3_OPTION_SKIP_DEACTIVATE_ACEACP_IN_PWDN;
+	pmu_raw_writel(value, EXYNOS3_ARM_COMMON_OPTION);
+
+	/* Enable USE_STANDBY_WFI for all CORE */
+	pmu_raw_writel(S5P_USE_STANDBY_WFI_ALL, S5P_CENTRAL_SEQ_OPTION);
+
+	/*
+	 * Set PSHOLD port for output high
+	 */
+	value = pmu_raw_readl(S5P_PS_HOLD_CONTROL);
+	value |= S5P_PS_HOLD_OUTPUT_HIGH;
+	pmu_raw_writel(value, S5P_PS_HOLD_CONTROL);
+
+	/*
+	 * Enable signal for PSHOLD port
+	 */
+	value = pmu_raw_readl(S5P_PS_HOLD_CONTROL);
+	value |= S5P_PS_HOLD_EN;
+	pmu_raw_writel(value, S5P_PS_HOLD_CONTROL);
+}
+
+const struct exynos_pmu_data exynos3250_pmu_data = {
+	.pmu_config	= exynos3250_pmu_config,
+	.pmu_init	= exynos3250_pmu_init,
+	.powerdown_conf_extra	= exynos3250_powerdown_conf_extra,
+};
diff --git a/drivers/soc/samsung/exynos4-pmu.c b/drivers/soc/samsung/exynos4-pmu.c
new file mode 100644
index 0000000..4b0a79e
--- /dev/null
+++ b/drivers/soc/samsung/exynos4-pmu.c
@@ -0,0 +1,223 @@
+/*
+ * Copyright (c) 2011-2015 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * EXYNOS4 - CPU PMU(Power Management Unit) support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/soc/samsung/exynos-regs-pmu.h>
+#include <linux/soc/samsung/exynos-pmu.h>
+
+#include "exynos-pmu.h"
+
+static const struct exynos_pmu_conf exynos4210_pmu_config[] = {
+	/* { .offset = offset, .val = { AFTR, LPA, SLEEP } */
+	{ S5P_ARM_CORE0_LOWPWR,			{ 0x0, 0x0, 0x2 } },
+	{ S5P_DIS_IRQ_CORE0,			{ 0x0, 0x0, 0x0 } },
+	{ S5P_DIS_IRQ_CENTRAL0,			{ 0x0, 0x0, 0x0 } },
+	{ S5P_ARM_CORE1_LOWPWR,			{ 0x0, 0x0, 0x2 } },
+	{ S5P_DIS_IRQ_CORE1,			{ 0x0, 0x0, 0x0 } },
+	{ S5P_DIS_IRQ_CENTRAL1,			{ 0x0, 0x0, 0x0 } },
+	{ S5P_ARM_COMMON_LOWPWR,		{ 0x0, 0x0, 0x2 } },
+	{ S5P_L2_0_LOWPWR,			{ 0x2, 0x2, 0x3 } },
+	{ S5P_L2_1_LOWPWR,			{ 0x2, 0x2, 0x3 } },
+	{ S5P_CMU_ACLKSTOP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_SCLKSTOP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_LOWPWR,			{ 0x1, 0x1, 0x0 } },
+	{ S5P_APLL_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_MPLL_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_VPLL_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_EPLL_SYSCLK_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_CLKSTOP_GPS_ALIVE_LOWPWR,	{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_RESET_GPSALIVE_LOWPWR,	{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_CLKSTOP_CAM_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_CLKSTOP_TV_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_CLKSTOP_MFC_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_CLKSTOP_G3D_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_CLKSTOP_LCD0_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_CLKSTOP_LCD1_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_CLKSTOP_MAUDIO_LOWPWR,	{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_CLKSTOP_GPS_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_RESET_CAM_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_RESET_TV_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_RESET_MFC_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_RESET_G3D_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_RESET_LCD0_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_RESET_LCD1_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_RESET_MAUDIO_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_RESET_GPS_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_TOP_BUS_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_TOP_RETENTION_LOWPWR,		{ 0x1, 0x0, 0x1 } },
+	{ S5P_TOP_PWR_LOWPWR,			{ 0x3, 0x0, 0x3 } },
+	{ S5P_LOGIC_RESET_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_ONENAND_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
+	{ S5P_MODIMIF_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
+	{ S5P_G2D_ACP_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
+	{ S5P_USBOTG_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
+	{ S5P_HSMMC_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_CSSYS_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_SECSS_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_PCIE_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_SATA_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_DRAM_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_MAUDIO_LOWPWR,	{ 0x1, 0x1, 0x0 } },
+	{ S5P_PAD_RETENTION_GPIO_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_UART_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_MMCA_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_MMCB_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_EBIA_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_EBIB_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_ISOLATION_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_ALV_SEL_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_XUSBXTI_LOWPWR,			{ 0x1, 0x1, 0x0 } },
+	{ S5P_XXTI_LOWPWR,			{ 0x1, 0x1, 0x0 } },
+	{ S5P_EXT_REGULATOR_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_GPIO_MODE_LOWPWR,			{ 0x1, 0x0, 0x0 } },
+	{ S5P_GPIO_MODE_MAUDIO_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CAM_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_TV_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_MFC_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_G3D_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_LCD0_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_LCD1_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_MAUDIO_LOWPWR,			{ 0x7, 0x7, 0x0 } },
+	{ S5P_GPS_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_GPS_ALIVE_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ PMU_TABLE_END,},
+};
+
+static const struct exynos_pmu_conf exynos4x12_pmu_config[] = {
+	{ S5P_ARM_CORE0_LOWPWR,			{ 0x0, 0x0, 0x2 } },
+	{ S5P_DIS_IRQ_CORE0,			{ 0x0, 0x0, 0x0 } },
+	{ S5P_DIS_IRQ_CENTRAL0,			{ 0x0, 0x0, 0x0 } },
+	{ S5P_ARM_CORE1_LOWPWR,			{ 0x0, 0x0, 0x2 } },
+	{ S5P_DIS_IRQ_CORE1,			{ 0x0, 0x0, 0x0 } },
+	{ S5P_DIS_IRQ_CENTRAL1,			{ 0x0, 0x0, 0x0 } },
+	{ S5P_ISP_ARM_LOWPWR,			{ 0x1, 0x0, 0x0 } },
+	{ S5P_DIS_IRQ_ISP_ARM_LOCAL_LOWPWR,	{ 0x0, 0x0, 0x0 } },
+	{ S5P_DIS_IRQ_ISP_ARM_CENTRAL_LOWPWR,	{ 0x0, 0x0, 0x0 } },
+	{ S5P_ARM_COMMON_LOWPWR,		{ 0x0, 0x0, 0x2 } },
+	{ S5P_L2_0_LOWPWR,			{ 0x0, 0x0, 0x3 } },
+	/* XXX_OPTION register should be set other field */
+	{ S5P_ARM_L2_0_OPTION,			{ 0x10, 0x10, 0x0 } },
+	{ S5P_L2_1_LOWPWR,			{ 0x0, 0x0, 0x3 } },
+	{ S5P_ARM_L2_1_OPTION,			{ 0x10, 0x10, 0x0 } },
+	{ S5P_CMU_ACLKSTOP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_SCLKSTOP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_LOWPWR,			{ 0x1, 0x1, 0x0 } },
+	{ S5P_DRAM_FREQ_DOWN_LOWPWR,		{ 0x1, 0x1, 0x1 } },
+	{ S5P_DDRPHY_DLLOFF_LOWPWR,		{ 0x1, 0x1, 0x1 } },
+	{ S5P_LPDDR_PHY_DLL_LOCK_LOWPWR,	{ 0x1, 0x1, 0x1 } },
+	{ S5P_CMU_ACLKSTOP_COREBLK_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_SCLKSTOP_COREBLK_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_COREBLK_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_APLL_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_MPLL_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_VPLL_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_EPLL_SYSCLK_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_MPLLUSER_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_CLKSTOP_GPS_ALIVE_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_GPSALIVE_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_CLKSTOP_CAM_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_CLKSTOP_TV_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_CLKSTOP_MFC_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_CLKSTOP_G3D_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_CLKSTOP_LCD0_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_CLKSTOP_ISP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_CLKSTOP_MAUDIO_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_CLKSTOP_GPS_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_CAM_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_TV_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_MFC_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_G3D_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_LCD0_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_ISP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_MAUDIO_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_RESET_GPS_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_TOP_BUS_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_TOP_RETENTION_LOWPWR,		{ 0x1, 0x0, 0x1 } },
+	{ S5P_TOP_PWR_LOWPWR,			{ 0x3, 0x0, 0x3 } },
+	{ S5P_TOP_BUS_COREBLK_LOWPWR,		{ 0x3, 0x0, 0x0 } },
+	{ S5P_TOP_RETENTION_COREBLK_LOWPWR,	{ 0x1, 0x0, 0x1 } },
+	{ S5P_TOP_PWR_COREBLK_LOWPWR,		{ 0x3, 0x0, 0x3 } },
+	{ S5P_LOGIC_RESET_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_OSCCLK_GATE_LOWPWR,		{ 0x1, 0x0, 0x1 } },
+	{ S5P_LOGIC_RESET_COREBLK_LOWPWR,	{ 0x1, 0x1, 0x0 } },
+	{ S5P_OSCCLK_GATE_COREBLK_LOWPWR,	{ 0x1, 0x0, 0x1 } },
+	{ S5P_ONENAND_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
+	{ S5P_ONENAND_MEM_OPTION,		{ 0x10, 0x10, 0x0 } },
+	{ S5P_HSI_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_HSI_MEM_OPTION,			{ 0x10, 0x10, 0x0 } },
+	{ S5P_G2D_ACP_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
+	{ S5P_G2D_ACP_MEM_OPTION,		{ 0x10, 0x10, 0x0 } },
+	{ S5P_USBOTG_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
+	{ S5P_USBOTG_MEM_OPTION,		{ 0x10, 0x10, 0x0 } },
+	{ S5P_HSMMC_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_HSMMC_MEM_OPTION,			{ 0x10, 0x10, 0x0 } },
+	{ S5P_CSSYS_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_CSSYS_MEM_OPTION,			{ 0x10, 0x10, 0x0 } },
+	{ S5P_SECSS_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_SECSS_MEM_OPTION,			{ 0x10, 0x10, 0x0 } },
+	{ S5P_ROTATOR_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
+	{ S5P_ROTATOR_MEM_OPTION,		{ 0x10, 0x10, 0x0 } },
+	{ S5P_PAD_RETENTION_DRAM_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_MAUDIO_LOWPWR,	{ 0x1, 0x1, 0x0 } },
+	{ S5P_PAD_RETENTION_GPIO_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_UART_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_MMCA_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_MMCB_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_EBIA_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_EBIB_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_GPIO_COREBLK_LOWPWR, { 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_ISOLATION_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_ISOLATION_COREBLK_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_ALV_SEL_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_XUSBXTI_LOWPWR,			{ 0x1, 0x1, 0x0 } },
+	{ S5P_XXTI_LOWPWR,			{ 0x1, 0x1, 0x0 } },
+	{ S5P_EXT_REGULATOR_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_GPIO_MODE_LOWPWR,			{ 0x1, 0x0, 0x0 } },
+	{ S5P_GPIO_MODE_COREBLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_GPIO_MODE_MAUDIO_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_TOP_ASB_RESET_LOWPWR,		{ 0x1, 0x1, 0x1 } },
+	{ S5P_TOP_ASB_ISOLATION_LOWPWR,		{ 0x1, 0x0, 0x1 } },
+	{ S5P_CAM_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_TV_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_MFC_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_G3D_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_LCD0_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_ISP_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_MAUDIO_LOWPWR,			{ 0x7, 0x7, 0x0 } },
+	{ S5P_GPS_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_GPS_ALIVE_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_CMU_SYSCLK_ISP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_SYSCLK_GPS_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ PMU_TABLE_END,},
+};
+
+static const struct exynos_pmu_conf exynos4412_pmu_config[] = {
+	{ S5P_ARM_CORE2_LOWPWR,			{ 0x0, 0x0, 0x2 } },
+	{ S5P_DIS_IRQ_CORE2,			{ 0x0, 0x0, 0x0 } },
+	{ S5P_DIS_IRQ_CENTRAL2,			{ 0x0, 0x0, 0x0 } },
+	{ S5P_ARM_CORE3_LOWPWR,			{ 0x0, 0x0, 0x2 } },
+	{ S5P_DIS_IRQ_CORE3,			{ 0x0, 0x0, 0x0 } },
+	{ S5P_DIS_IRQ_CENTRAL3,			{ 0x0, 0x0, 0x0 } },
+	{ PMU_TABLE_END,},
+};
+
+const struct exynos_pmu_data exynos4210_pmu_data = {
+	.pmu_config	= exynos4210_pmu_config,
+};
+
+const struct exynos_pmu_data exynos4212_pmu_data = {
+	.pmu_config	= exynos4x12_pmu_config,
+};
+
+const struct exynos_pmu_data exynos4412_pmu_data = {
+	.pmu_config		= exynos4x12_pmu_config,
+	.pmu_config_extra	= exynos4412_pmu_config,
+};
+
diff --git a/drivers/soc/samsung/exynos5250-pmu.c b/drivers/soc/samsung/exynos5250-pmu.c
new file mode 100644
index 0000000..a6d4188
--- /dev/null
+++ b/drivers/soc/samsung/exynos5250-pmu.c
@@ -0,0 +1,196 @@
+/*
+ * Copyright (c) 2011-2015 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * EXYNOS5250 - CPU PMU (Power Management Unit) support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/soc/samsung/exynos-regs-pmu.h>
+#include <linux/soc/samsung/exynos-pmu.h>
+
+#include "exynos-pmu.h"
+
+static const struct exynos_pmu_conf exynos5250_pmu_config[] = {
+	/* { .offset = offset, .val = { AFTR, LPA, SLEEP } */
+	{ EXYNOS5_ARM_CORE0_SYS_PWR_REG,		{ 0x0, 0x0, 0x2} },
+	{ EXYNOS5_DIS_IRQ_ARM_CORE0_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_DIS_IRQ_ARM_CORE0_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5_ARM_CORE1_SYS_PWR_REG,		{ 0x0, 0x0, 0x2} },
+	{ EXYNOS5_DIS_IRQ_ARM_CORE1_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_DIS_IRQ_ARM_CORE1_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5_FSYS_ARM_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_DIS_IRQ_FSYS_ARM_CENTRAL_SYS_PWR_REG,	{ 0x1, 0x1, 0x1} },
+	{ EXYNOS5_ISP_ARM_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_DIS_IRQ_ISP_ARM_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_DIS_IRQ_ISP_ARM_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_ARM_COMMON_SYS_PWR_REG,		{ 0x0, 0x0, 0x2} },
+	{ EXYNOS5_ARM_L2_SYS_PWR_REG,			{ 0x3, 0x3, 0x3} },
+	{ EXYNOS5_ARM_L2_OPTION,			{ 0x10, 0x10, 0x0 } },
+	{ EXYNOS5_CMU_ACLKSTOP_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5_CMU_SCLKSTOP_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5_CMU_RESET_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_CMU_ACLKSTOP_SYSMEM_SYS_PWR_REG,	{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5_CMU_SCLKSTOP_SYSMEM_SYS_PWR_REG,	{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5_CMU_RESET_SYSMEM_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_DRAM_FREQ_DOWN_SYS_PWR_REG,		{ 0x1, 0x1, 0x1} },
+	{ EXYNOS5_DDRPHY_DLLOFF_SYS_PWR_REG,		{ 0x1, 0x1, 0x1} },
+	{ EXYNOS5_DDRPHY_DLLLOCK_SYS_PWR_REG,		{ 0x1, 0x1, 0x1} },
+	{ EXYNOS5_APLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_MPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_VPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_EPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_BPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_CPLL_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_MPLLUSER_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_BPLLUSER_SYSCLK_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_TOP_BUS_SYS_PWR_REG,			{ 0x3, 0x0, 0x0} },
+	{ EXYNOS5_TOP_RETENTION_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5_TOP_PWR_SYS_PWR_REG,			{ 0x3, 0x0, 0x3} },
+	{ EXYNOS5_TOP_BUS_SYSMEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
+	{ EXYNOS5_TOP_RETENTION_SYSMEM_SYS_PWR_REG,	{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5_TOP_PWR_SYSMEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x3} },
+	{ EXYNOS5_LOGIC_RESET_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_OSCCLK_GATE_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5_LOGIC_RESET_SYSMEM_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_OSCCLK_GATE_SYSMEM_SYS_PWR_REG,	{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5_USBOTG_MEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
+	{ EXYNOS5_G2D_MEM_SYS_PWR_REG,			{ 0x3, 0x0, 0x0} },
+	{ EXYNOS5_USBDRD_MEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
+	{ EXYNOS5_SDMMC_MEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
+	{ EXYNOS5_CSSYS_MEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
+	{ EXYNOS5_SECSS_MEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
+	{ EXYNOS5_ROTATOR_MEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
+	{ EXYNOS5_INTRAM_MEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
+	{ EXYNOS5_INTROM_MEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
+	{ EXYNOS5_JPEG_MEM_SYS_PWR_REG,			{ 0x3, 0x0, 0x0} },
+	{ EXYNOS5_JPEG_MEM_OPTION,			{ 0x10, 0x10, 0x0} },
+	{ EXYNOS5_HSI_MEM_SYS_PWR_REG,			{ 0x3, 0x0, 0x0} },
+	{ EXYNOS5_MCUIOP_MEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
+	{ EXYNOS5_SATA_MEM_SYS_PWR_REG,			{ 0x3, 0x0, 0x0} },
+	{ EXYNOS5_PAD_RETENTION_DRAM_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_PAD_RETENTION_MAU_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_PAD_RETENTION_GPIO_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_PAD_RETENTION_UART_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_PAD_RETENTION_MMCA_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_PAD_RETENTION_MMCB_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_PAD_RETENTION_EBIA_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_PAD_RETENTION_EBIB_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_PAD_RETENTION_SPI_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_PAD_RETENTION_GPIO_SYSMEM_SYS_PWR_REG, { 0x1, 0x0, 0x0} },
+	{ EXYNOS5_PAD_ISOLATION_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_PAD_ISOLATION_SYSMEM_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_PAD_ALV_SEL_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_XUSBXTI_SYS_PWR_REG,			{ 0x1, 0x1, 0x1} },
+	{ EXYNOS5_XXTI_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_EXT_REGULATOR_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_GPIO_MODE_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_GPIO_MODE_SYSMEM_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_GPIO_MODE_MAU_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_TOP_ASB_RESET_SYS_PWR_REG,		{ 0x1, 0x1, 0x1} },
+	{ EXYNOS5_TOP_ASB_ISOLATION_SYS_PWR_REG,	{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5_GSCL_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5_ISP_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5_MFC_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5_G3D_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5_DISP1_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5_MAU_SYS_PWR_REG,			{ 0x7, 0x7, 0x0} },
+	{ EXYNOS5_CMU_CLKSTOP_GSCL_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_CMU_CLKSTOP_ISP_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_CMU_CLKSTOP_MFC_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_CMU_CLKSTOP_G3D_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_CMU_CLKSTOP_DISP1_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_CMU_CLKSTOP_MAU_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_CMU_SYSCLK_GSCL_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_CMU_SYSCLK_ISP_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_CMU_SYSCLK_MFC_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_CMU_SYSCLK_G3D_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_CMU_SYSCLK_DISP1_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_CMU_SYSCLK_MAU_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_CMU_RESET_GSCL_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_CMU_RESET_ISP_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_CMU_RESET_MFC_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_CMU_RESET_G3D_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_CMU_RESET_DISP1_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_CMU_RESET_MAU_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ PMU_TABLE_END,},
+};
+
+static unsigned int const exynos5_list_both_cnt_feed[] = {
+	EXYNOS5_ARM_CORE0_OPTION,
+	EXYNOS5_ARM_CORE1_OPTION,
+	EXYNOS5_ARM_COMMON_OPTION,
+	EXYNOS5_GSCL_OPTION,
+	EXYNOS5_ISP_OPTION,
+	EXYNOS5_MFC_OPTION,
+	EXYNOS5_G3D_OPTION,
+	EXYNOS5_DISP1_OPTION,
+	EXYNOS5_MAU_OPTION,
+	EXYNOS5_TOP_PWR_OPTION,
+	EXYNOS5_TOP_PWR_SYSMEM_OPTION,
+};
+
+static unsigned int const exynos5_list_disable_wfi_wfe[] = {
+	EXYNOS5_ARM_CORE1_OPTION,
+	EXYNOS5_FSYS_ARM_OPTION,
+	EXYNOS5_ISP_ARM_OPTION,
+};
+
+static void exynos5250_pmu_init(void)
+{
+	unsigned int value;
+	/*
+	 * When SYS_WDTRESET is set, watchdog timer reset request
+	 * is ignored by power management unit.
+	 */
+	value = pmu_raw_readl(EXYNOS5_AUTO_WDTRESET_DISABLE);
+	value &= ~EXYNOS5_SYS_WDTRESET;
+	pmu_raw_writel(value, EXYNOS5_AUTO_WDTRESET_DISABLE);
+
+	value = pmu_raw_readl(EXYNOS5_MASK_WDTRESET_REQUEST);
+	value &= ~EXYNOS5_SYS_WDTRESET;
+	pmu_raw_writel(value, EXYNOS5_MASK_WDTRESET_REQUEST);
+}
+
+static void exynos5_powerdown_conf(enum sys_powerdown mode)
+{
+	unsigned int i;
+	unsigned int tmp;
+
+	/*
+	 * Enable both SC_FEEDBACK and SC_COUNTER
+	 */
+	for (i = 0; i < ARRAY_SIZE(exynos5_list_both_cnt_feed); i++) {
+		tmp = pmu_raw_readl(exynos5_list_both_cnt_feed[i]);
+		tmp |= (EXYNOS5_USE_SC_FEEDBACK |
+			EXYNOS5_USE_SC_COUNTER);
+		pmu_raw_writel(tmp, exynos5_list_both_cnt_feed[i]);
+	}
+
+	/*
+	 * SKIP_DEACTIVATE_ACEACP_IN_PWDN_BITFIELD Enable
+	 */
+	tmp = pmu_raw_readl(EXYNOS5_ARM_COMMON_OPTION);
+	tmp |= EXYNOS5_SKIP_DEACTIVATE_ACEACP_IN_PWDN;
+	pmu_raw_writel(tmp, EXYNOS5_ARM_COMMON_OPTION);
+
+	/*
+	 * Disable WFI/WFE on XXX_OPTION
+	 */
+	for (i = 0; i < ARRAY_SIZE(exynos5_list_disable_wfi_wfe); i++) {
+		tmp = pmu_raw_readl(exynos5_list_disable_wfi_wfe[i]);
+		tmp &= ~(EXYNOS5_OPTION_USE_STANDBYWFE |
+			 EXYNOS5_OPTION_USE_STANDBYWFI);
+		pmu_raw_writel(tmp, exynos5_list_disable_wfi_wfe[i]);
+	}
+}
+
+const struct exynos_pmu_data exynos5250_pmu_data = {
+	.pmu_config	= exynos5250_pmu_config,
+	.pmu_init	= exynos5250_pmu_init,
+	.powerdown_conf	= exynos5_powerdown_conf,
+};
+
diff --git a/drivers/soc/samsung/exynos5420-pmu.c b/drivers/soc/samsung/exynos5420-pmu.c
new file mode 100644
index 0000000..5810afe
--- /dev/null
+++ b/drivers/soc/samsung/exynos5420-pmu.c
@@ -0,0 +1,280 @@
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
+#include <linux/pm.h>
+#include <linux/soc/samsung/exynos-regs-pmu.h>
+#include <linux/soc/samsung/exynos-pmu.h>
+
+#include <asm/cputype.h>
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
+	pr_info("EXYNOS5420 PMU initialized\n");
+}
+
+const struct exynos_pmu_data exynos5420_pmu_data = {
+	.pmu_config	= exynos5420_pmu_config,
+	.pmu_init	= exynos5420_pmu_init,
+	.powerdown_conf	= exynos5420_powerdown_conf,
+};
-- 
2.4.5
