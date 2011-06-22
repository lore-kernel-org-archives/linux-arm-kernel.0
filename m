From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 22 Jun 2011 17:46:39 +0900
Subject: [PATCH 1/7] ARM: EXYNOS4: Support system level power down
	configuration
In-Reply-To: <1308732405-16664-1-git-send-email-kgene.kim@samsung.com>
References: <1308732405-16664-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1308732405-16664-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaecheol Lee <jc.lee@samsung.com>

EXYNOS4 supports 3 different system level power down mode by PMU (Power
Management Unit). Each power down mode need to configure many PMU registers
with different value. This patch supports function to configure PMU registers
with pre-defined values in PMU code. This function may be used by PM code and
AFTR/LPA support driver.

Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos4/Makefile           |    2 +-
 arch/arm/mach-exynos4/include/mach/pmu.h |   27 +++++
 arch/arm/mach-exynos4/pmu.c              |  175 ++++++++++++++++++++++++++++++
 3 files changed, 203 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-exynos4/include/mach/pmu.h
 create mode 100644 arch/arm/mach-exynos4/pmu.c

diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index 60fe5ec..880f902 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -13,7 +13,7 @@ obj-				:=
 # Core support for EXYNOS4 system
 
 obj-$(CONFIG_CPU_EXYNOS4210)	+= cpu.o init.o clock.o irq-combiner.o
-obj-$(CONFIG_CPU_EXYNOS4210)	+= setup-i2c0.o irq-eint.o dma.o
+obj-$(CONFIG_CPU_EXYNOS4210)	+= setup-i2c0.o irq-eint.o dma.o pmu.o
 obj-$(CONFIG_PM)		+= pm.o sleep.o
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
diff --git a/arch/arm/mach-exynos4/include/mach/pmu.h b/arch/arm/mach-exynos4/include/mach/pmu.h
new file mode 100644
index 0000000..4f9c976
--- /dev/null
+++ b/arch/arm/mach-exynos4/include/mach/pmu.h
@@ -0,0 +1,27 @@
+/* linux/arch/arm/mach-exynos4/include/mach/pmu.h
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * EXYNOS4210 - PMU(Power Management Unit) support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_PMU_H
+#define __ASM_ARCH_PMU_H __FILE__
+
+enum sys_powerdown {
+	SYS_AFTR,
+	SYS_LPA,
+	SYS_SLEEP,
+	NUM_SYS_POWERDOWN,
+};
+
+extern void exynos4_sys_powerdown_conf(enum sys_powerdown mode);
+extern int exynos4_enter_lp(unsigned long *saveblk, long);
+extern void exynos4_idle_resume(void);
+
+#endif /* __ASM_ARCH_PMU_H */
diff --git a/arch/arm/mach-exynos4/pmu.c b/arch/arm/mach-exynos4/pmu.c
new file mode 100644
index 0000000..7ea9eb2
--- /dev/null
+++ b/arch/arm/mach-exynos4/pmu.c
@@ -0,0 +1,175 @@
+/* linux/arch/arm/mach-exynos4/pmu.c
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * EXYNOS4210 - CPU PMU(Power Management Unit) support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/io.h>
+#include <linux/kernel.h>
+
+#include <mach/regs-clock.h>
+#include <mach/pmu.h>
+
+static void __iomem *sys_powerdown_reg[] = {
+	S5P_ARM_CORE0_LOWPWR,
+	S5P_DIS_IRQ_CORE0,
+	S5P_DIS_IRQ_CENTRAL0,
+	S5P_ARM_CORE1_LOWPWR,
+	S5P_DIS_IRQ_CORE1,
+	S5P_DIS_IRQ_CENTRAL1,
+	S5P_ARM_COMMON_LOWPWR,
+	S5P_L2_0_LOWPWR,
+	S5P_L2_1_LOWPWR,
+	S5P_CMU_ACLKSTOP_LOWPWR,
+	S5P_CMU_SCLKSTOP_LOWPWR,
+	S5P_CMU_RESET_LOWPWR,
+	S5P_APLL_SYSCLK_LOWPWR,
+	S5P_MPLL_SYSCLK_LOWPWR,
+	S5P_VPLL_SYSCLK_LOWPWR,
+	S5P_EPLL_SYSCLK_LOWPWR,
+	S5P_CMU_CLKSTOP_GPS_ALIVE_LOWPWR,
+	S5P_CMU_RESET_GPSALIVE_LOWPWR,
+	S5P_CMU_CLKSTOP_CAM_LOWPWR,
+	S5P_CMU_CLKSTOP_TV_LOWPWR,
+	S5P_CMU_CLKSTOP_MFC_LOWPWR,
+	S5P_CMU_CLKSTOP_G3D_LOWPWR,
+	S5P_CMU_CLKSTOP_LCD0_LOWPWR,
+	S5P_CMU_CLKSTOP_LCD1_LOWPWR,
+	S5P_CMU_CLKSTOP_MAUDIO_LOWPWR,
+	S5P_CMU_CLKSTOP_GPS_LOWPWR,
+	S5P_CMU_RESET_CAM_LOWPWR,
+	S5P_CMU_RESET_TV_LOWPWR,
+	S5P_CMU_RESET_MFC_LOWPWR,
+	S5P_CMU_RESET_G3D_LOWPWR,
+	S5P_CMU_RESET_LCD0_LOWPWR,
+	S5P_CMU_RESET_LCD1_LOWPWR,
+	S5P_CMU_RESET_MAUDIO_LOWPWR,
+	S5P_CMU_RESET_GPS_LOWPWR,
+	S5P_TOP_BUS_LOWPWR,
+	S5P_TOP_RETENTION_LOWPWR,
+	S5P_TOP_PWR_LOWPWR,
+	S5P_LOGIC_RESET_LOWPWR,
+	S5P_ONENAND_MEM_LOWPWR,
+	S5P_MODIMIF_MEM_LOWPWR,
+	S5P_G2D_ACP_MEM_LOWPWR,
+	S5P_USBOTG_MEM_LOWPWR,
+	S5P_HSMMC_MEM_LOWPWR,
+	S5P_CSSYS_MEM_LOWPWR,
+	S5P_SECSS_MEM_LOWPWR,
+	S5P_PCIE_MEM_LOWPWR,
+	S5P_SATA_MEM_LOWPWR,
+	S5P_PAD_RETENTION_DRAM_LOWPWR,
+	S5P_PAD_RETENTION_MAUDIO_LOWPWR,
+	S5P_PAD_RETENTION_GPIO_LOWPWR,
+	S5P_PAD_RETENTION_UART_LOWPWR,
+	S5P_PAD_RETENTION_MMCA_LOWPWR,
+	S5P_PAD_RETENTION_MMCB_LOWPWR,
+	S5P_PAD_RETENTION_EBIA_LOWPWR,
+	S5P_PAD_RETENTION_EBIB_LOWPWR,
+	S5P_PAD_RETENTION_ISOLATION_LOWPWR,
+	S5P_PAD_RETENTION_ALV_SEL_LOWPWR,
+	S5P_XUSBXTI_LOWPWR,
+	S5P_XXTI_LOWPWR,
+	S5P_EXT_REGULATOR_LOWPWR,
+	S5P_GPIO_MODE_LOWPWR,
+	S5P_GPIO_MODE_MAUDIO_LOWPWR,
+	S5P_CAM_LOWPWR,
+	S5P_TV_LOWPWR,
+	S5P_MFC_LOWPWR,
+	S5P_G3D_LOWPWR,
+	S5P_LCD0_LOWPWR,
+	S5P_LCD1_LOWPWR,
+	S5P_MAUDIO_LOWPWR,
+	S5P_GPS_LOWPWR,
+	S5P_GPS_ALIVE_LOWPWR,
+};
+
+static const unsigned int sys_powerdown_val[][NUM_SYS_POWERDOWN] = {
+	/* { AFTR, LPA, SLEEP }*/
+	{ 0, 0, 2 },	/* ARM_CORE0 */
+	{ 0, 0, 0 },	/* ARM_DIS_IRQ_CORE0 */
+	{ 0, 0, 0 },	/* ARM_DIS_IRQ_CENTRAL0 */
+	{ 0, 0, 2 },	/* ARM_CORE1 */
+	{ 0, 0, 0 },	/* ARM_DIS_IRQ_CORE1 */
+	{ 0, 0, 0 },	/* ARM_DIS_IRQ_CENTRAL1 */
+	{ 0, 0, 2 },	/* ARM_COMMON */
+	{ 2, 2, 3 },	/* ARM_CPU_L2_0 */
+	{ 2, 2, 3 },	/* ARM_CPU_L2_1 */
+	{ 1, 0, 0 },	/* CMU_ACLKSTOP */
+	{ 1, 0, 0 },	/* CMU_SCLKSTOP */
+	{ 1, 1, 0 },	/* CMU_RESET */
+	{ 1, 0, 0 },	/* APLL_SYSCLK */
+	{ 1, 0, 0 },	/* MPLL_SYSCLK */
+	{ 1, 0, 0 },	/* VPLL_SYSCLK */
+	{ 1, 1, 0 },	/* EPLL_SYSCLK */
+	{ 1, 1, 0 },	/* CMU_CLKSTOP_GPS_ALIVE */
+	{ 1, 1, 0 },	/* CMU_RESET_GPS_ALIVE */
+	{ 1, 1, 0 },	/* CMU_CLKSTOP_CAM */
+	{ 1, 1, 0 },	/* CMU_CLKSTOP_TV */
+	{ 1, 1, 0 },	/* CMU_CLKSTOP_MFC */
+	{ 1, 1, 0 },	/* CMU_CLKSTOP_G3D */
+	{ 1, 1, 0 },	/* CMU_CLKSTOP_LCD0 */
+	{ 1, 1, 0 },	/* CMU_CLKSTOP_LCD1 */
+	{ 1, 1, 0 },	/* CMU_CLKSTOP_MAUDIO */
+	{ 1, 1, 0 },	/* CMU_CLKSTOP_GPS */
+	{ 1, 1, 0 },	/* CMU_RESET_CAM */
+	{ 1, 1, 0 },	/* CMU_RESET_TV */
+	{ 1, 1, 0 },	/* CMU_RESET_MFC */
+	{ 1, 1, 0 },	/* CMU_RESET_G3D */
+	{ 1, 1, 0 },	/* CMU_RESET_LCD0 */
+	{ 1, 1, 0 },	/* CMU_RESET_LCD1 */
+	{ 1, 1, 0 },	/* CMU_RESET_MAUDIO */
+	{ 1, 1, 0 },	/* CMU_RESET_GPS */
+	{ 3, 0, 0 },	/* TOP_BUS */
+	{ 1, 0, 1 },	/* TOP_RETENTION */
+	{ 3, 0, 3 },	/* TOP_PWR */
+	{ 1, 1, 0 },	/* LOGIC_RESET */
+	{ 3, 0, 0 },	/* ONENAND_MEM */
+	{ 3, 0, 0 },	/* MODIMIF_MEM */
+	{ 3, 0, 0 },	/* G2D_ACP_MEM */
+	{ 3, 0, 0 },	/* USBOTG_MEM */
+	{ 3, 0, 0 },	/* HSMMC_MEM */
+	{ 3, 0, 0 },	/* CSSYS_MEM */
+	{ 3, 0, 0 },	/* SECSS_MEM */
+	{ 3, 0, 0 },	/* PCIE_MEM */
+	{ 3, 0, 0 },	/* SATA_MEM */
+	{ 1, 0, 0 },	/* PAD_RETENTION_DRAM */
+	{ 1, 1, 0 },	/* PAD_RETENTION_MAUDIO */
+	{ 1, 0, 0 },	/* PAD_RETENTION_GPIO */
+	{ 1, 0, 0 },	/* PAD_RETENTION_UART */
+	{ 1, 0, 0 },	/* PAD_RETENTION_MMCA */
+	{ 1, 0, 0 },	/* PAD_RETENTION_MMCB */
+	{ 1, 0, 0 },	/* PAD_RETENTION_EBIA */
+	{ 1, 0, 0 },	/* PAD_RETENTION_EBIB */
+	{ 1, 0, 0 },	/* PAD_RETENTION_ISOLATION */
+	{ 1, 0, 0 },	/* PAD_RETENTION_ALV_SEL */
+	{ 1, 1, 0 },	/* XUSBXTI */
+	{ 1, 1, 0 },	/* XXTI */
+	{ 1, 1, 0 },	/* EXT_REGULATOR */
+	{ 1, 0, 0 },	/* GPIO_MODE */
+	{ 1, 1, 0 },	/* GPIO_MODE_MAUDIO */
+	{ 7, 0, 0 },	/* CAM */
+	{ 7, 0, 0 },	/* TV */
+	{ 7, 0, 0 },	/* MFC */
+	{ 7, 0, 0 },	/* G3D */
+	{ 7, 0, 0 },	/* LCD0 */
+	{ 7, 0, 0 },	/* LCD1 */
+	{ 7, 7, 0 },	/* MAUDIO */
+	{ 7, 0, 0 },	/* GPS */
+	{ 7, 0, 0 },	/* GPS_ALIVE */
+};
+
+void exynos4_sys_powerdown_conf(enum sys_powerdown mode)
+{
+	unsigned int count = ARRAY_SIZE(sys_powerdown_reg);
+
+	for (; count > 0; count--)
+		__raw_writel(sys_powerdown_val[count - 1][mode],
+				sys_powerdown_reg[count - 1]);
+}
-- 
1.7.1
