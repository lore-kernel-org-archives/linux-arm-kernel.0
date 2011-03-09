From: jc.lee@samsung.com (Jaecheol Lee)
Date: Wed,  9 Mar 2011 11:08:40 +0900
Subject: [PATCH 2/3] ARM: EXYNOS4: Suspend to RAM Support
In-Reply-To: <1299636521-4831-1-git-send-email-jc.lee@samsung.com>
References: <1299636521-4831-1-git-send-email-jc.lee@samsung.com>
Message-ID: <1299636521-4831-3-git-send-email-jc.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support suspend to ram for EXYNOS4210.
As a note, this includes function of outer cache flush
because it is used before entering PM.

Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
---
 arch/arm/mach-exynos4/Makefile                  |    1 +
 arch/arm/mach-exynos4/include/mach/pm-core.h    |   50 +++
 arch/arm/mach-exynos4/include/mach/regs-clock.h |    9 +-
 arch/arm/mach-exynos4/pm.c                      |  419 +++++++++++++++++++++++
 arch/arm/mach-exynos4/sleep.S                   |  171 +++++++++
 arch/arm/plat-samsung/include/plat/cpu.h        |    1 +
 arch/arm/plat-samsung/pm.c                      |    3 +
 7 files changed, 652 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-exynos4/include/mach/pm-core.h
 create mode 100644 arch/arm/mach-exynos4/pm.c
 create mode 100644 arch/arm/mach-exynos4/sleep.S

diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index 45422cb..461ae57 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -14,6 +14,7 @@ obj-				:=
 
 obj-$(CONFIG_CPU_EXYNOS4210)	+= cpu.o init.o clock.o irq-combiner.o
 obj-$(CONFIG_CPU_EXYNOS4210)	+= setup-i2c0.o time.o gpiolib.o irq-eint.o dma.o
+obj-$(CONFIG_PM)		+= pm.o sleep.o
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
 
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
diff --git a/arch/arm/mach-exynos4/include/mach/pm-core.h b/arch/arm/mach-exynos4/include/mach/pm-core.h
new file mode 100644
index 0000000..68f71f2
--- /dev/null
+++ b/arch/arm/mach-exynos4/include/mach/pm-core.h
@@ -0,0 +1,50 @@
+/* linux/arch/arm/mach-exynos4/include/mach/pm-core.h
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Based on arch/arm/mach-s3c2410/include/mach/pm-core.h,
+ * Copyright 2008 Simtec Electronics
+ *      Ben Dooks <ben@simtec.co.uk>
+ *      http://armlinux.simtec.co.uk/
+ *
+ * EXYNOS4210 - PM core support for arch/arm/plat-s5p/pm.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+#include <mach/regs-pmu.h>
+
+static inline void s3c_pm_debug_init_uart(void)
+{
+	/* nothing here yet */
+}
+
+static inline void s3c_pm_arch_prepare_irqs(void)
+{
+	unsigned int tmp;
+	tmp = __raw_readl(S5P_WAKEUP_MASK);
+	tmp &= ~(1 << 31);
+	__raw_writel(tmp, S5P_WAKEUP_MASK);
+
+	__raw_writel(s3c_irqwake_intmask, S5P_WAKEUP_MASK);
+	__raw_writel(s3c_irqwake_eintmask, S5P_EINT_WAKEUP_MASK);
+}
+
+static inline void s3c_pm_arch_stop_clocks(void)
+{
+	/* nothing here yet */
+}
+
+static inline void s3c_pm_arch_show_resume_irqs(void)
+{
+	/* nothing here yet */
+}
+
+static inline void s3c_pm_arch_update_uart(void __iomem *regs,
+					   struct pm_uart_save *save)
+{
+	/* nothing here yet */
+}
+
diff --git a/arch/arm/mach-exynos4/include/mach/regs-clock.h b/arch/arm/mach-exynos4/include/mach/regs-clock.h
index ba8f91c..ae5475a 100644
--- a/arch/arm/mach-exynos4/include/mach/regs-clock.h
+++ b/arch/arm/mach-exynos4/include/mach/regs-clock.h
@@ -17,8 +17,6 @@
 
 #define S5P_CLKREG(x)			(S5P_VA_CMU + (x))
 
-#define S5P_INFORM0			S5P_CLKREG(0x800)
-
 #define S5P_CLKDIV_LEFTBUS		S5P_CLKREG(0x04500)
 #define S5P_CLKDIV_STAT_LEFTBUS		S5P_CLKREG(0x04600)
 
@@ -33,9 +31,11 @@
 #define S5P_CLKSRC_TOP0			S5P_CLKREG(0x0C210)
 #define S5P_CLKSRC_TOP1			S5P_CLKREG(0x0C214)
 #define S5P_CLKSRC_CAM			S5P_CLKREG(0x0C220)
+#define S5P_CLKSRC_MFC			S5P_CLKREG(0x0C228)
 #define S5P_CLKSRC_IMAGE		S5P_CLKREG(0x0C230)
 #define S5P_CLKSRC_LCD0			S5P_CLKREG(0x0C234)
 #define S5P_CLKSRC_LCD1			S5P_CLKREG(0x0C238)
+#define S5P_CLKSRC_MAUDIO		S5P_CLKREG(0x0C23C)
 #define S5P_CLKSRC_FSYS			S5P_CLKREG(0x0C240)
 #define S5P_CLKSRC_PERIL0		S5P_CLKREG(0x0C250)
 #define S5P_CLKSRC_PERIL1		S5P_CLKREG(0x0C254)
@@ -45,6 +45,7 @@
 #define S5P_CLKDIV_IMAGE		S5P_CLKREG(0x0C530)
 #define S5P_CLKDIV_LCD0			S5P_CLKREG(0x0C534)
 #define S5P_CLKDIV_LCD1			S5P_CLKREG(0x0C538)
+#define S5P_CLKDIV_MAUDIO		S5P_CLKREG(0x0C53C)
 #define S5P_CLKDIV_FSYS0		S5P_CLKREG(0x0C540)
 #define S5P_CLKDIV_FSYS1		S5P_CLKREG(0x0C544)
 #define S5P_CLKDIV_FSYS2		S5P_CLKREG(0x0C548)
@@ -58,8 +59,10 @@
 
 #define S5P_CLKSRC_MASK_TOP		S5P_CLKREG(0x0C310)
 #define S5P_CLKSRC_MASK_CAM		S5P_CLKREG(0x0C320)
+#define S5P_CLKSRC_MASK_TV		S5P_CLKREG(0x0C324)
 #define S5P_CLKSRC_MASK_LCD0		S5P_CLKREG(0x0C334)
 #define S5P_CLKSRC_MASK_LCD1		S5P_CLKREG(0x0C338)
+#define S5P_CLKSRC_MASK_MAUDIO		S5P_CLKREG(0x0C33C)
 #define S5P_CLKSRC_MASK_FSYS		S5P_CLKREG(0x0C340)
 #define S5P_CLKSRC_MASK_PERIL0		S5P_CLKREG(0x0C350)
 #define S5P_CLKSRC_MASK_PERIL1		S5P_CLKREG(0x0C354)
@@ -67,6 +70,7 @@
 #define S5P_CLKDIV_STAT_TOP		S5P_CLKREG(0x0C610)
 
 #define S5P_CLKGATE_IP_CAM		S5P_CLKREG(0x0C920)
+#define S5P_CLKGATE_IP_MFC		S5P_CLKREG(0x0C928)
 #define S5P_CLKGATE_IP_IMAGE		S5P_CLKREG(0x0C930)
 #define S5P_CLKGATE_IP_LCD0		S5P_CLKREG(0x0C934)
 #define S5P_CLKGATE_IP_LCD1		S5P_CLKREG(0x0C938)
@@ -74,6 +78,7 @@
 #define S5P_CLKGATE_IP_PERIL		S5P_CLKREG(0x0C950)
 #define S5P_CLKGATE_IP_PERIR		S5P_CLKREG(0x0C960)
 
+#define S5P_CLKSRC_MASK_DMC		S5P_CLKREG(0x10300)
 #define S5P_CLKSRC_DMC			S5P_CLKREG(0x10200)
 #define S5P_CLKDIV_DMC0			S5P_CLKREG(0x10500)
 #define S5P_CLKDIV_STAT_DMC0		S5P_CLKREG(0x10600)
diff --git a/arch/arm/mach-exynos4/pm.c b/arch/arm/mach-exynos4/pm.c
new file mode 100644
index 0000000..fb5065b
--- /dev/null
+++ b/arch/arm/mach-exynos4/pm.c
@@ -0,0 +1,419 @@
+/* linux/arch/arm/mach-exynos4/pm.c
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * EXYNOS4210 - Power Management support
+ *
+ * Based on arch/arm/mach-s3c2410/pm.c
+ * Copyright (c) 2006 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/init.h>
+#include <linux/suspend.h>
+#include <linux/io.h>
+
+#include <asm/cacheflush.h>
+#include <asm/hardware/cache-l2x0.h>
+
+#include <plat/cpu.h>
+#include <plat/pm.h>
+#include <plat/regs-timer.h>
+
+#include <mach/regs-irq.h>
+#include <mach/regs-gpio.h>
+#include <mach/regs-clock.h>
+#include <mach/regs-pmu.h>
+#include <mach/pm-core.h>
+
+extern int exynos4_l2x0_cache_init(void);
+
+static struct sleep_save exynos4_sleep[] = {
+	{ .reg = S5P_ARM_CORE0_LOWPWR			, .val = 0x2, },
+	{ .reg = S5P_DIS_IRQ_CORE0			, .val = 0x0, },
+	{ .reg = S5P_DIS_IRQ_CENTRAL0			, .val = 0x0, },
+	{ .reg = S5P_ARM_CORE1_LOWPWR			, .val = 0x2, },
+	{ .reg = S5P_DIS_IRQ_CORE1			, .val = 0x0, },
+	{ .reg = S5P_DIS_IRQ_CENTRAL1			, .val = 0x0, },
+	{ .reg = S5P_ARM_COMMON_LOWPWR			, .val = 0x2, },
+	{ .reg = S5P_L2_0_LOWPWR			, .val = 0x3, },
+	{ .reg = S5P_L2_1_LOWPWR			, .val = 0x3, },
+	{ .reg = S5P_CMU_ACLKSTOP_LOWPWR		, .val = 0x0, },
+	{ .reg = S5P_CMU_SCLKSTOP_LOWPWR		, .val = 0x0, },
+	{ .reg = S5P_CMU_RESET_LOWPWR			, .val = 0x0, },
+	{ .reg = S5P_APLL_SYSCLK_LOWPWR			, .val = 0x0, },
+	{ .reg = S5P_MPLL_SYSCLK_LOWPWR			, .val = 0x0, },
+	{ .reg = S5P_VPLL_SYSCLK_LOWPWR			, .val = 0x0, },
+	{ .reg = S5P_EPLL_SYSCLK_LOWPWR			, .val = 0x0, },
+	{ .reg = S5P_CMU_CLKSTOP_GPS_ALIVE_LOWPWR	, .val = 0x0, },
+	{ .reg = S5P_CMU_RESET_GPSALIVE_LOWPWR		, .val = 0x0, },
+	{ .reg = S5P_CMU_CLKSTOP_CAM_LOWPWR		, .val = 0x0, },
+	{ .reg = S5P_CMU_CLKSTOP_TV_LOWPWR		, .val = 0x0, },
+	{ .reg = S5P_CMU_CLKSTOP_MFC_LOWPWR		, .val = 0x0, },
+	{ .reg = S5P_CMU_CLKSTOP_G3D_LOWPWR		, .val = 0x0, },
+	{ .reg = S5P_CMU_CLKSTOP_LCD0_LOWPWR		, .val = 0x0, },
+	{ .reg = S5P_CMU_CLKSTOP_LCD1_LOWPWR		, .val = 0x0, },
+	{ .reg = S5P_CMU_CLKSTOP_MAUDIO_LOWPWR		, .val = 0x0, },
+	{ .reg = S5P_CMU_CLKSTOP_GPS_LOWPWR		, .val = 0x0, },
+	{ .reg = S5P_CMU_RESET_CAM_LOWPWR		, .val = 0x0, },
+	{ .reg = S5P_CMU_RESET_TV_LOWPWR		, .val = 0x0, },
+	{ .reg = S5P_CMU_RESET_MFC_LOWPWR		, .val = 0x0, },
+	{ .reg = S5P_CMU_RESET_G3D_LOWPWR		, .val = 0x0, },
+	{ .reg = S5P_CMU_RESET_LCD0_LOWPWR		, .val = 0x0, },
+	{ .reg = S5P_CMU_RESET_LCD1_LOWPWR		, .val = 0x0, },
+	{ .reg = S5P_CMU_RESET_MAUDIO_LOWPWR		, .val = 0x0, },
+	{ .reg = S5P_CMU_RESET_GPS_LOWPWR		, .val = 0x0, },
+	{ .reg = S5P_TOP_BUS_LOWPWR			, .val = 0x0, },
+	{ .reg = S5P_TOP_RETENTION_LOWPWR		, .val = 0x1, },
+	{ .reg = S5P_TOP_PWR_LOWPWR			, .val = 0x3, },
+	{ .reg = S5P_LOGIC_RESET_LOWPWR			, .val = 0x0, },
+	{ .reg = S5P_ONENAND_MEM_LOWPWR			, .val = 0x0, },
+	{ .reg = S5P_MODIMIF_MEM_LOWPWR			, .val = 0x0, },
+	{ .reg = S5P_G2D_ACP_MEM_LOWPWR			, .val = 0x0, },
+	{ .reg = S5P_USBOTG_MEM_LOWPWR			, .val = 0x0, },
+	{ .reg = S5P_HSMMC_MEM_LOWPWR			, .val = 0x0, },
+	{ .reg = S5P_CSSYS_MEM_LOWPWR			, .val = 0x0, },
+	{ .reg = S5P_SECSS_MEM_LOWPWR			, .val = 0x0, },
+	{ .reg = S5P_PCIE_MEM_LOWPWR			, .val = 0x0, },
+	{ .reg = S5P_SATA_MEM_LOWPWR			, .val = 0x0, },
+	{ .reg = S5P_PAD_RETENTION_DRAM_LOWPWR		, .val = 0x0, },
+	{ .reg = S5P_PAD_RETENTION_MAUDIO_LOWPWR	, .val = 0x0, },
+	{ .reg = S5P_PAD_RETENTION_GPIO_LOWPWR		, .val = 0x0, },
+	{ .reg = S5P_PAD_RETENTION_UART_LOWPWR		, .val = 0x0, },
+	{ .reg = S5P_PAD_RETENTION_MMCA_LOWPWR		, .val = 0x0, },
+	{ .reg = S5P_PAD_RETENTION_MMCB_LOWPWR		, .val = 0x0, },
+	{ .reg = S5P_PAD_RETENTION_EBIA_LOWPWR		, .val = 0x0, },
+	{ .reg = S5P_PAD_RETENTION_EBIB_LOWPWR		, .val = 0x0, },
+	{ .reg = S5P_PAD_RETENTION_ISOLATION_LOWPWR	, .val = 0x0, },
+	{ .reg = S5P_PAD_RETENTION_ALV_SEL_LOWPWR	, .val = 0x0, },
+	{ .reg = S5P_XUSBXTI_LOWPWR			, .val = 0x0, },
+	{ .reg = S5P_XXTI_LOWPWR			, .val = 0x0, },
+	{ .reg = S5P_EXT_REGULATOR_LOWPWR		, .val = 0x0, },
+	{ .reg = S5P_GPIO_MODE_LOWPWR			, .val = 0x0, },
+	{ .reg = S5P_GPIO_MODE_MAUDIO_LOWPWR		, .val = 0x0, },
+	{ .reg = S5P_CAM_LOWPWR				, .val = 0x0, },
+	{ .reg = S5P_TV_LOWPWR				, .val = 0x0, },
+	{ .reg = S5P_MFC_LOWPWR				, .val = 0x0, },
+	{ .reg = S5P_G3D_LOWPWR				, .val = 0x0, },
+	{ .reg = S5P_LCD0_LOWPWR			, .val = 0x0, },
+	{ .reg = S5P_LCD1_LOWPWR			, .val = 0x0, },
+	{ .reg = S5P_MAUDIO_LOWPWR			, .val = 0x0, },
+	{ .reg = S5P_GPS_LOWPWR				, .val = 0x0, },
+	{ .reg = S5P_GPS_ALIVE_LOWPWR			, .val = 0x0, },
+	{ .reg = S5P_LCD1_LOWPWR			, .val = 0x0, },
+	{ .reg = S5P_MAUDIO_LOWPWR			, .val = 0x0, },
+	{ .reg = S5P_GPS_LOWPWR				, .val = 0x0, },
+	{ .reg = S5P_GPS_ALIVE_LOWPWR			, .val = 0x0, },
+};
+
+static struct sleep_save exynos4_set_clksrc[] = {
+	{ .reg = S5P_CLKSRC_MASK_TOP			, .val = 0x00000001, },
+	{ .reg = S5P_CLKSRC_MASK_CAM			, .val = 0x11111111, },
+	{ .reg = S5P_CLKSRC_MASK_TV			, .val = 0x00000111, },
+	{ .reg = S5P_CLKSRC_MASK_LCD0			, .val = 0x00001111, },
+	{ .reg = S5P_CLKSRC_MASK_LCD1			, .val = 0x00001111, },
+	{ .reg = S5P_CLKSRC_MASK_MAUDIO			, .val = 0x00000001, },
+	{ .reg = S5P_CLKSRC_MASK_FSYS			, .val = 0x01011111, },
+	{ .reg = S5P_CLKSRC_MASK_PERIL0			, .val = 0x01111111, },
+	{ .reg = S5P_CLKSRC_MASK_PERIL1			, .val = 0x01110111, },
+	{ .reg = S5P_CLKSRC_MASK_DMC			, .val = 0x00010000, },
+};
+
+static struct sleep_save exynos4_core_save[] = {
+	/* CMU side */
+	SAVE_ITEM(S5P_CLKDIV_LEFTBUS),
+	SAVE_ITEM(S5P_CLKDIV_RIGHTBUS),
+	SAVE_ITEM(S5P_EPLL_CON0),
+	SAVE_ITEM(S5P_EPLL_CON1),
+	SAVE_ITEM(S5P_CLKSRC_TOP0),
+	SAVE_ITEM(S5P_CLKSRC_TOP1),
+	SAVE_ITEM(S5P_CLKSRC_CAM),
+	SAVE_ITEM(S5P_CLKSRC_MFC),
+	SAVE_ITEM(S5P_CLKSRC_IMAGE),
+	SAVE_ITEM(S5P_CLKSRC_LCD0),
+	SAVE_ITEM(S5P_CLKSRC_LCD1),
+	SAVE_ITEM(S5P_CLKSRC_MAUDIO),
+	SAVE_ITEM(S5P_CLKSRC_FSYS),
+	SAVE_ITEM(S5P_CLKSRC_PERIL0),
+	SAVE_ITEM(S5P_CLKSRC_PERIL1),
+	SAVE_ITEM(S5P_CLKDIV_CAM),
+	SAVE_ITEM(S5P_CLKDIV_IMAGE),
+	SAVE_ITEM(S5P_CLKDIV_LCD0),
+	SAVE_ITEM(S5P_CLKDIV_LCD1),
+	SAVE_ITEM(S5P_CLKDIV_MAUDIO),
+	SAVE_ITEM(S5P_CLKDIV_FSYS0),
+	SAVE_ITEM(S5P_CLKDIV_FSYS1),
+	SAVE_ITEM(S5P_CLKDIV_FSYS2),
+	SAVE_ITEM(S5P_CLKDIV_FSYS3),
+	SAVE_ITEM(S5P_CLKDIV_PERIL0),
+	SAVE_ITEM(S5P_CLKDIV_PERIL1),
+	SAVE_ITEM(S5P_CLKDIV_PERIL2),
+	SAVE_ITEM(S5P_CLKDIV_PERIL3),
+	SAVE_ITEM(S5P_CLKDIV_PERIL4),
+	SAVE_ITEM(S5P_CLKDIV_PERIL5),
+	SAVE_ITEM(S5P_CLKDIV_TOP),
+	SAVE_ITEM(S5P_CLKSRC_MASK_CAM),
+	SAVE_ITEM(S5P_CLKSRC_MASK_TV),
+	SAVE_ITEM(S5P_CLKSRC_MASK_LCD0),
+	SAVE_ITEM(S5P_CLKSRC_MASK_LCD1),
+	SAVE_ITEM(S5P_CLKSRC_MASK_MAUDIO),
+	SAVE_ITEM(S5P_CLKSRC_MASK_FSYS),
+	SAVE_ITEM(S5P_CLKSRC_MASK_PERIL0),
+	SAVE_ITEM(S5P_CLKSRC_MASK_PERIL1),
+	SAVE_ITEM(S5P_CLKGATE_IP_CAM),
+	SAVE_ITEM(S5P_CLKGATE_IP_MFC),
+	SAVE_ITEM(S5P_CLKGATE_IP_IMAGE),
+	SAVE_ITEM(S5P_CLKGATE_IP_LCD0),
+	SAVE_ITEM(S5P_CLKGATE_IP_LCD1),
+	SAVE_ITEM(S5P_CLKGATE_IP_FSYS),
+	SAVE_ITEM(S5P_CLKGATE_IP_PERIL),
+	SAVE_ITEM(S5P_CLKGATE_IP_PERIR),
+	SAVE_ITEM(S5P_CLKSRC_MASK_DMC),
+	SAVE_ITEM(S5P_CLKSRC_DMC),
+	SAVE_ITEM(S5P_CLKDIV_DMC0),
+	SAVE_ITEM(S5P_CLKSRC_CPU),
+	SAVE_ITEM(S5P_CLKDIV_CPU),
+	SAVE_ITEM(S5P_CLKGATE_SCLKCPU),
+
+	/* GIC side */
+	SAVE_ITEM(S5P_VA_GIC_CPU + 0x000),
+	SAVE_ITEM(S5P_VA_GIC_CPU + 0x004),
+	SAVE_ITEM(S5P_VA_GIC_CPU + 0x008),
+	SAVE_ITEM(S5P_VA_GIC_CPU + 0x00C),
+	SAVE_ITEM(S5P_VA_GIC_CPU + 0x014),
+	SAVE_ITEM(S5P_VA_GIC_CPU + 0x018),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x000),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x004),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x100),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x104),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x108),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x300),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x304),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x308),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x400),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x404),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x408),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x40C),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x410),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x414),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x418),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x41C),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x420),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x424),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x428),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x42C),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x430),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x434),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x438),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x43C),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x440),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x444),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x448),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x44C),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x450),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x454),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x458),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x45C),
+
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x800),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x804),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x808),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x80C),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x810),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x814),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x818),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x81C),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x820),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x824),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x828),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x82C),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x830),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x834),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x838),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x83C),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x840),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x844),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x848),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x84C),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x850),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x854),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x858),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x85C),
+
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC00),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC04),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC08),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC0C),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC10),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC14),
+
+	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x000),
+	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x010),
+	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x020),
+	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x030),
+	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x040),
+	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x050),
+	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x060),
+	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x070),
+	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x080),
+	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x090),
+};
+
+static struct sleep_save exynos4_l2cc_save[] = {
+	SAVE_ITEM(S5P_VA_L2CC + L2X0_TAG_LATENCY_CTRL),
+	SAVE_ITEM(S5P_VA_L2CC + L2X0_DATA_LATENCY_CTRL),
+	SAVE_ITEM(S5P_VA_L2CC + L2X0_PREFETCH_CTRL),
+	SAVE_ITEM(S5P_VA_L2CC + L2X0_POWER_CTRL),
+	SAVE_ITEM(S5P_VA_L2CC + L2X0_AUX_CTRL),
+};
+
+void exynos4_cpu_suspend(void)
+{
+	unsigned long tmp;
+	unsigned long mask = 0xFFFFFFFF;
+
+	/* Before enter central sequence mode, clock src register have to set */
+
+	s3c_pm_do_restore_core(exynos4_set_clksrc, ARRAY_SIZE(exynos4_set_clksrc));
+
+	/* Setting Central Sequence Register for power down mode */
+
+	tmp = __raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
+	tmp &= ~(S5P_CENTRAL_LOWPWR_CFG);
+	__raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
+
+	/* Setting Central Sequence option Register */
+
+	tmp = __raw_readl(S5P_CENTRAL_SEQ_OPTION);
+	tmp &= ~(S5P_USE_MASK);
+	tmp |= S5P_USE_STANDBY_WFI0;
+	__raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
+
+	/* Clear all interrupt pending to avoid early wakeup */
+
+	__raw_writel(mask, (S5P_VA_GIC_DIST + 0x280));
+	__raw_writel(mask, (S5P_VA_GIC_DIST + 0x284));
+	__raw_writel(mask, (S5P_VA_GIC_DIST + 0x288));
+
+	/* Disable all interrupt */
+
+	__raw_writel(0x0, (S5P_VA_GIC_CPU + 0x000));
+	__raw_writel(0x0, (S5P_VA_GIC_DIST + 0x000));
+	__raw_writel(mask, (S5P_VA_GIC_DIST + 0x184));
+	__raw_writel(mask, (S5P_VA_GIC_DIST + 0x188));
+
+	/* issue the standby signal into the pm unit. */
+	cpu_do_idle();
+
+	/* we should never get past here */
+	panic("sleep resumed to originator?");
+}
+
+static void exynos4_pm_prepare(void)
+{
+	u32 tmp;
+
+	s3c_pm_do_save(exynos4_core_save, ARRAY_SIZE(exynos4_core_save));
+	s3c_pm_do_save(exynos4_l2cc_save, ARRAY_SIZE(exynos4_l2cc_save));
+
+	tmp = __raw_readl(S5P_INFORM1);
+
+	/* Set value of power down register for sleep mode */
+
+	s3c_pm_do_restore_core(exynos4_sleep, ARRAY_SIZE(exynos4_sleep));
+	__raw_writel(S5P_CHECK_SLEEP, S5P_INFORM1);
+
+	/* ensure at least INFORM0 has the resume address */
+
+	__raw_writel(virt_to_phys(s3c_cpu_resume), S5P_INFORM0);
+}
+
+static int exynos4_pm_add(struct sys_device *sysdev)
+{
+	pm_cpu_prep = exynos4_pm_prepare;
+	pm_cpu_sleep = exynos4_cpu_suspend;
+
+	return 0;
+}
+
+/* This function copy from linux/arch/arm/kernel/smp_scu.c */
+
+void exynos4_scu_enable(void __iomem *scu_base)
+{
+	u32 scu_ctrl;
+
+	scu_ctrl = __raw_readl(scu_base);
+	/* already enabled? */
+	if (scu_ctrl & 1)
+		return;
+
+	scu_ctrl |= 1;
+	__raw_writel(scu_ctrl, scu_base);
+
+	/*
+	 * Ensure that the data accessed by CPU0 before the SCU was
+	 * initialised is visible to the other CPUs.
+	 */
+	flush_cache_all();
+}
+
+static int exynos4_pm_resume(struct sys_device *dev)
+{
+	unsigned int tmp;
+	unsigned long mask = 0xFFFFFFFF;
+
+	/* For release retention */
+
+	__raw_writel((1 << 28), S5P_PAD_RET_GPIO_OPTION);
+	__raw_writel((1 << 28), S5P_PAD_RET_UART_OPTION);
+	__raw_writel((1 << 28), S5P_PAD_RET_MMCA_OPTION);
+	__raw_writel((1 << 28), S5P_PAD_RET_MMCB_OPTION);
+	__raw_writel((1 << 28), S5P_PAD_RET_EBIA_OPTION);
+	__raw_writel((1 << 28), S5P_PAD_RET_EBIB_OPTION);
+
+	s3c_pm_do_restore_core(exynos4_core_save, ARRAY_SIZE(exynos4_core_save));
+
+	/* Clear External Interrupt Pending */
+
+	__raw_writel(mask, S5P_EINT_PEND(0));
+	__raw_writel(mask, S5P_EINT_PEND(1));
+	__raw_writel(mask, S5P_EINT_PEND(2));
+	__raw_writel(mask, S5P_EINT_PEND(3));
+
+	exynos4_scu_enable(S5P_VA_SCU);
+
+#ifdef CONFIG_CACHE_L2X0
+	s3c_pm_do_restore_core(exynos4_l2cc_save, ARRAY_SIZE(exynos4_l2cc_save));
+	outer_cache.inv_all();
+	/* enable L2X0*/
+	writel_relaxed(1, S5P_VA_L2CC + L2X0_CTRL);
+#endif
+
+	return 0;
+}
+
+static struct sysdev_driver exynos4_pm_driver = {
+	.add		= exynos4_pm_add,
+	.resume		= exynos4_pm_resume,
+};
+
+static __init int exynos4_pm_drvinit(void)
+{
+	unsigned int tmp;
+
+	s3c_pm_init();
+
+	/* All wakeup disable */
+
+	tmp = __raw_readl(S5P_WAKEUP_MASK);
+	tmp |= ((0xFF << 8) | (0x1F << 1));
+	__raw_writel(tmp, S5P_WAKEUP_MASK);
+
+	return sysdev_driver_register(&exynos4_sysclass, &exynos4_pm_driver);
+}
+arch_initcall(exynos4_pm_drvinit);
diff --git a/arch/arm/mach-exynos4/sleep.S b/arch/arm/mach-exynos4/sleep.S
new file mode 100644
index 0000000..dd6d31e
--- /dev/null
+++ b/arch/arm/mach-exynos4/sleep.S
@@ -0,0 +1,171 @@
+/* linux/arch/arm/mach-exynos4/sleep.S
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * EXYNOS4210 power Manager (Suspend-To-RAM) support
+ * Based on S3C2410 sleep code by:
+ *	Ben Dooks, (c) 2004 Simtec Electronics
+ *
+ * Based on PXA/SA1100 sleep code by:
+ *	Nicolas Pitre, (c) 2002 Monta Vista Software Inc
+ *	Cliff Brake, (c) 2001
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+*/
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/memory.h>
+
+	.text
+
+	/*
+	 * s3c_cpu_save
+	 *
+	 * entry:
+	 *	r0 = save address (virtual addr of s3c_sleep_save_phys)
+	 */
+
+ENTRY(s3c_cpu_save)
+
+	stmfd	sp!, { r3 - r12, lr }
+
+	mrc	p15, 0, r4, c13, c0, 0	@ FCSE/PID
+	mrc	p15, 0, r5, c3, c0, 0	@ Domain ID
+	mrc	p15, 0, r6, c2, c0, 0	@ Translation Table BASE0
+	mrc	p15, 0, r7, c2, c0, 1	@ Translation Table BASE1
+	mrc	p15, 0, r8, c2, c0, 2	@ Translation Table Control
+	mrc	p15, 0, r9, c1, c0, 0	@ Control register
+	mrc	p15, 0, r10, c1, c0, 1	@ Auxiliary control register
+	mrc	p15, 0, r11, c1, c0, 2	@ Co-processor access controls
+	mrc	p15, 0, r12, c10, c2, 0	@ Read PRRR
+	mrc	p15, 0, r3, c10, c2, 1	@ READ NMRR
+
+	stmia	r0, { r3 - r13 }
+
+	bl	s3c_pm_cb_flushcache
+
+	ldr	r0, =pm_cpu_sleep
+	ldr	r0, [ r0 ]
+	mov	pc, r0
+
+resume_with_mmu:
+	/* After MMU is turned on, restore the previous MMU table */
+	ldr	r9 , =(PAGE_OFFSET - PHYS_OFFSET)
+	add	r4, r4, r9
+	str	r12, [r4]
+
+	ldmfd	sp!, { r3 - r12, pc }
+
+	.ltorg
+
+	.data
+
+	.global	s3c_sleep_save_phys
+s3c_sleep_save_phys:
+	.word	0
+
+	/*
+	 * sleep magic, to allow the bootloader to check for an valid
+	 * image to resume to. Must be the first word before the
+	 * s3c_cpu_resume entry.
+	 */
+
+	.word	0x2bedf00d
+
+	/*
+	 * s3c_cpu_resume
+	 *
+	 * resume code entry for bootloader to call
+	 *
+	 * we must put this code here in the data segment as we have no
+	 * other way of restoring the stack pointer after sleep, and we
+	 * must not write to the code segment (code is read-only)
+	 */
+
+ENTRY(s3c_cpu_resume)
+	mov	r0, #PSR_I_BIT | PSR_F_BIT | SVC_MODE
+	msr	cpsr_c, r0
+
+	mov	r1, #0
+	mcr	p15, 0, r1, c8, c7, 0		@ invalidate TLBs
+	mcr	p15, 0, r1, c7, c5, 0		@ invalidate I Cache
+
+	ldr	r0, s3c_sleep_save_phys		@ address of restore block
+	ldmia	r0, { r3 - r13 }
+
+	mcr	p15, 0, r4, c13, c0, 0		@ FCSE/PID
+	mcr	p15, 0, r5, c3, c0, 0		@ Domain ID
+
+	mcr	p15, 0, r8, c2, c0, 2		@ Translation Table Control
+	mcr	p15, 0, r7, c2, c0, 1		@ Translation Table BASE1
+	mcr	p15, 0, r6, c2, c0, 0		@ Translation Table BASE0
+
+	mcr	p15, 0, r10, c1, c0, 1		@ Auxiliary control register
+
+	mov	r0, #0
+	mcr	p15, 0, r0, c8, c7, 0		@ Invalidate I & D TLB
+
+	mov	r0, #0				@ restore copro access
+	mcr	p15, 0, r11, c1, c0, 2		@ Co-processor access
+	mcr	p15, 0, r0, c7, c5, 4
+
+	mcr	p15, 0, r12, c10, c2, 0		@ write PRRR
+	mcr	p15, 0, r3, c10, c2, 1		@ write NMRR
+
+	/*
+	 * In Cortex-A8, when MMU is turned on, the pipeline is flushed.
+	 * And there are no valid entries in the MMU table at this point.
+	 * So before turning on the MMU, the MMU entry for the DRAM address
+	 * range is added. After the MMU is turned on, the other entries
+	 * in the MMU table will be restored.
+	 */
+
+	/* r6 = Translation Table BASE0 */
+	mov	r4, r6
+	mov	r4, r4, LSR #14
+	mov	r4, r4, LSL #14
+
+	/* Load address for adding to MMU table list */
+	ldr	r11, =0x10020800		@ INFORM0 reg.
+	ldr	r10, [r11, #0]
+	mov	r10, r10, LSR #18
+	bic	r10, r10, #0x3
+	orr	r4, r4, r10
+
+	/* Calculate MMU table entry */
+	mov	r10, r10, LSL #18
+	ldr	r5, =0x40E
+	orr	r10, r10, r5
+
+	/* Back up originally data */
+	ldr	r12, [r4]
+
+	/* Add calculated MMU table entry into MMU table list */
+	str	r10, [r4]
+
+	ldr	r2, =resume_with_mmu
+	mcr	p15, 0, r9, c1, c0, 0		@ turn on MMU, etc
+
+	nop
+	nop
+	nop
+	nop
+	nop					@ second-to-last before mmu
+
+	mov	pc, r2				@ go back to virtual address
+
+	.ltorg
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index 9addb3d..cedfff5 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -82,6 +82,7 @@ extern struct sysdev_class s3c64xx_sysclass;
 extern struct sysdev_class s5p64x0_sysclass;
 extern struct sysdev_class s5p6442_sysclass;
 extern struct sysdev_class s5pv210_sysclass;
+extern struct sysdev_class exynos4_sysclass;
 
 extern void (*s5pc1xx_idle)(void);
 
diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
index 02d531f..c24b6c2 100644
--- a/arch/arm/plat-samsung/pm.c
+++ b/arch/arm/plat-samsung/pm.c
@@ -340,6 +340,9 @@ static int s3c_pm_enter(suspend_state_t state)
 void s3c_pm_cb_flushcache(void)
 {
 	flush_cache_all();
+#ifdef CONFIG_OUTER_CACHE
+	outer_flush_all();
+#endif
 }
 
 static int s3c_pm_prepare(void)
-- 
1.7.1
