From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 12 Nov 2010 15:17:32 +0800
Subject: [PATCH 03/11] ARM: pxa: split pxa93x from pxa3xx
In-Reply-To: <1289546260-6208-2-git-send-email-haojian.zhuang@marvell.com>
References: <1289546260-6208-1-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-2-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1289546260-6208-3-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to avoid confusion, seperate pxa93x from pxa3xx.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/Kconfig            |   18 +-
 arch/arm/mach-pxa/Makefile           |    2 +-
 arch/arm/mach-pxa/clock.h            |   20 ++
 arch/arm/mach-pxa/devices.c          |   10 +-
 arch/arm/mach-pxa/generic.c          |    8 +-
 arch/arm/mach-pxa/generic.h          |    3 +-
 arch/arm/mach-pxa/mfp-pxa3xx.c       |    5 +-
 arch/arm/mach-pxa/pxa3xx.c           |    9 -
 arch/arm/mach-pxa/pxa930.c           |  206 ---------------
 arch/arm/mach-pxa/pxa93x.c           |  471 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-pxa/saar.c             |    2 +-
 arch/arm/mach-pxa/smemc.c            |   10 +-
 arch/arm/mach-pxa/tavorevb.c         |    2 +-
 arch/arm/plat-pxa/Makefile           |    1 +
 arch/arm/plat-pxa/include/plat/mfp.h |    4 +-
 15 files changed, 525 insertions(+), 246 deletions(-)
 delete mode 100644 arch/arm/mach-pxa/pxa930.c
 create mode 100644 arch/arm/mach-pxa/pxa93x.c

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index dd235ec..84123d4 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -37,18 +37,18 @@ config MACH_LITTLETON
 	select CPU_PXA310
 
 config MACH_TAVOREVB
-	bool "PXA930 Evaluation Board (aka TavorEVB)"
-	select PXA3xx
+	bool "PXA935 Evaluation Board (aka TavorEVB)"
 	select CPU_PXA930
+	select CPU_PXA935
 
 config MACH_TAVOREVB3
 	bool "PXA95x Development Platform (aka TavorEVB III)"
 	select CPU_PXA950
 
 config MACH_SAAR
-	bool "PXA930 Handheld Platform (aka SAAR)"
-	select PXA3xx
+	bool "PXA935 Handheld Platform (aka SAAR)"
 	select CPU_PXA930
+	select CPU_PXA935
 
 comment "Third Party Dev Platforms (sorted by vendor name)"
 
@@ -639,15 +639,21 @@ config CPU_PXA320
 	help
 	  PXA320 (codename Monahans-P)
 
+config PXA93x
+	bool
+	select CPU_XSC3
+	help
+	  Select code specific to PXA93x variants
+
 config CPU_PXA930
 	bool
-	select PXA3xx
+	select PXA93x
 	help
 	  PXA930 (codename Tavor-P)
 
 config CPU_PXA935
 	bool
-	select CPU_PXA930
+	select PXA93x
 	help
 	  PXA935 (codename Tavor-P65)
 
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index e2f89c2..ebdb899 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -19,9 +19,9 @@ endif
 obj-$(CONFIG_PXA25x)		+= mfp-pxa2xx.o pxa2xx.o pxa25x.o
 obj-$(CONFIG_PXA27x)		+= mfp-pxa2xx.o pxa2xx.o pxa27x.o
 obj-$(CONFIG_PXA3xx)		+= mfp-pxa3xx.o pxa3xx.o smemc.o pxa3xx-ulpi.o
+obj-$(CONFIG_PXA93x)		+= mfp-pxa3xx.o pxa93x.o smemc.o
 obj-$(CONFIG_CPU_PXA300)	+= pxa300.o
 obj-$(CONFIG_CPU_PXA320)	+= pxa320.o
-obj-$(CONFIG_CPU_PXA930)	+= pxa930.o
 
 # NOTE: keep the order of boards in accordance to their order in Kconfig
 
diff --git a/arch/arm/mach-pxa/clock.h b/arch/arm/mach-pxa/clock.h
index d848874..0d824eb 100644
--- a/arch/arm/mach-pxa/clock.h
+++ b/arch/arm/mach-pxa/clock.h
@@ -67,3 +67,23 @@ extern void clk_pxa3xx_cken_enable(struct clk *);
 extern void clk_pxa3xx_cken_disable(struct clk *);
 #endif
 
+#ifdef CONFIG_PXA93x
+#define DEFINE_PXA93_CKEN(_name, _cken, _rate, _delay)	\
+struct clk clk_##_name = {				\
+		.ops	= &clk_pxa93x_cken_ops,		\
+		.rate	= _rate,			\
+		.cken	= CKEN_##_cken,			\
+		.delay	= _delay,			\
+	}
+
+#define DEFINE_PXA93_CK(_name, _cken, _ops)		\
+struct clk clk_##_name = {				\
+		.ops	= _ops,				\
+		.cken	= CKEN_##_cken,			\
+	}
+
+extern const struct clkops clk_pxa93x_cken_ops;
+extern void clk_pxa93x_cken_enable(struct clk *);
+extern void clk_pxa93x_cken_disable(struct clk *);
+#endif
+
diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index aaa1166..881ccc3 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -342,7 +342,7 @@ struct platform_device pxa27x_device_i2c_power = {
 };
 #endif
 
-#ifdef CONFIG_PXA3xx
+#if defined(CONFIG_PXA3xx) || defined(CONFIG_PXA93x)
 static struct resource pxa3xx_resources_i2c_power[] = {
 	{
 		.start  = 0x40f500c0,
@@ -632,7 +632,7 @@ struct platform_device pxa25x_device_assp = {
 };
 #endif /* CONFIG_PXA25x */
 
-#if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)
+#if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx) || defined(CONFIG_PXA93x)
 
 static struct resource pxa27x_resource_keypad[] = {
 	[0] = {
@@ -864,9 +864,9 @@ void __init pxa_set_camera_info(struct pxacamera_platform_data *info)
 {
 	pxa_register_device(&pxa27x_device_camera, info);
 }
-#endif /* CONFIG_PXA27x || CONFIG_PXA3xx */
+#endif /* CONFIG_PXA27x || CONFIG_PXA3xx || CONFIG_PXA93x */
 
-#ifdef CONFIG_PXA3xx
+#if defined(CONFIG_PXA3xx) || defined(CONFIG_PXA93x)
 static u64 pxa3xx_ssp4_dma_mask = DMA_BIT_MASK(32);
 
 static struct resource pxa3xx_resource_ssp4[] = {
@@ -1053,7 +1053,7 @@ struct platform_device pxa3xx_device_gcu = {
 	},
 };
 
-#endif /* CONFIG_PXA3xx */
+#endif /* CONFIG_PXA3xx || CONFIG_PXA93x */
 
 /* pxa2xx-spi platform-device ID equals respective SSP platform-device ID + 1.
  * See comment in arch/arm/mach-pxa/ssp.c::ssp_probe() */
diff --git a/arch/arm/mach-pxa/generic.c b/arch/arm/mach-pxa/generic.c
index d4ce8f9..84e2cc3 100644
--- a/arch/arm/mach-pxa/generic.c
+++ b/arch/arm/mach-pxa/generic.c
@@ -29,6 +29,7 @@
 #include <mach/reset.h>
 #include <mach/gpio.h>
 #include <mach/smemc.h>
+#include <mach/pxa3xx-regs.h>
 
 #include "generic.h"
 
@@ -36,9 +37,10 @@ void clear_reset_status(unsigned int mask)
 {
 	if (cpu_is_pxa2xx())
 		pxa2xx_clear_reset_status(mask);
-
-	if (cpu_is_pxa3xx())
-		pxa3xx_clear_reset_status(mask);
+	else {
+		/* RESET_STATUS_* has a 1:1 mapping with ARSR */
+		ARSR = mask;
+	}
 }
 
 unsigned long get_clock_tick_rate(void)
diff --git a/arch/arm/mach-pxa/generic.h b/arch/arm/mach-pxa/generic.h
index d2e8bc3..7dec811 100644
--- a/arch/arm/mach-pxa/generic.h
+++ b/arch/arm/mach-pxa/generic.h
@@ -20,6 +20,7 @@ extern void __init pxa26x_init_irq(void);
 #endif
 extern void __init pxa27x_init_irq(void);
 extern void __init pxa3xx_init_irq(void);
+extern void __init pxa93x_init_irq(void);
 
 extern void __init pxa_map_io(void);
 extern void __init pxa25x_map_io(void);
@@ -58,10 +59,8 @@ static inline void pxa2xx_clear_reset_status(unsigned int mask) {}
 
 #ifdef CONFIG_PXA3xx
 extern unsigned pxa3xx_get_clk_frequency_khz(int);
-extern void pxa3xx_clear_reset_status(unsigned int);
 #else
 #define pxa3xx_get_clk_frequency_khz(x)		(0)
-static inline void pxa3xx_clear_reset_status(unsigned int mask) {}
 #endif
 
 extern struct sysdev_class pxa_irq_sysclass;
diff --git a/arch/arm/mach-pxa/mfp-pxa3xx.c b/arch/arm/mach-pxa/mfp-pxa3xx.c
index 7a270ee..1bb58a3 100644
--- a/arch/arm/mach-pxa/mfp-pxa3xx.c
+++ b/arch/arm/mach-pxa/mfp-pxa3xx.c
@@ -62,9 +62,6 @@ struct sysdev_class pxa3xx_mfp_sysclass = {
 
 static int __init mfp_init_devicefs(void)
 {
-	if (cpu_is_pxa3xx())
-		return sysdev_class_register(&pxa3xx_mfp_sysclass);
-
-	return 0;
+	return sysdev_class_register(&pxa3xx_mfp_sysclass);
 }
 postcore_initcall(mfp_init_devicefs);
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index dc658ad..8957466 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -50,9 +50,6 @@
 #define PECR_IE(n)	((1 << ((n) * 2)) << 28)
 #define PECR_IS(n)	((1 << ((n) * 2)) << 29)
 
-/* crystal frequency to static memory controller multiplier (SMCFS) */
-static unsigned char smcfs_mult[8] = { 6, 0, 8, 0, 0, 16, };
-
 /* crystal frequency to HSIO bus frequency multiplier (HSS) */
 static unsigned char hss_mult[4] = { 8, 12, 16, 24 };
 
@@ -100,12 +97,6 @@ unsigned int pxa3xx_get_clk_frequency_khz(int info)
 	return CLK / 1000;
 }
 
-void pxa3xx_clear_reset_status(unsigned int mask)
-{
-	/* RESET_STATUS_* has a 1:1 mapping with ARSR */
-	ARSR = mask;
-}
-
 /*
  * Return the current AC97 clock frequency.
  */
diff --git a/arch/arm/mach-pxa/pxa930.c b/arch/arm/mach-pxa/pxa930.c
deleted file mode 100644
index 7d29dd3..0000000
--- a/arch/arm/mach-pxa/pxa930.c
+++ /dev/null
@@ -1,206 +0,0 @@
-/*
- * linux/arch/arm/mach-pxa/pxa930.c
- *
- * Code specific to PXA930
- *
- * Copyright (C) 2007-2008 Marvell Internation Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/irq.h>
-#include <linux/dma-mapping.h>
-
-#include <mach/pxa930.h>
-
-static struct mfp_addr_map pxa930_mfp_addr_map[] __initdata = {
-
-	MFP_ADDR(GPIO0, 0x02e0),
-	MFP_ADDR(GPIO1, 0x02dc),
-	MFP_ADDR(GPIO2, 0x02e8),
-	MFP_ADDR(GPIO3, 0x02d8),
-	MFP_ADDR(GPIO4, 0x02e4),
-	MFP_ADDR(GPIO5, 0x02ec),
-	MFP_ADDR(GPIO6, 0x02f8),
-	MFP_ADDR(GPIO7, 0x02fc),
-	MFP_ADDR(GPIO8, 0x0300),
-	MFP_ADDR(GPIO9, 0x02d4),
-	MFP_ADDR(GPIO10, 0x02f4),
-	MFP_ADDR(GPIO11, 0x02f0),
-	MFP_ADDR(GPIO12, 0x0304),
-	MFP_ADDR(GPIO13, 0x0310),
-	MFP_ADDR(GPIO14, 0x0308),
-	MFP_ADDR(GPIO15, 0x030c),
-	MFP_ADDR(GPIO16, 0x04e8),
-	MFP_ADDR(GPIO17, 0x04f4),
-	MFP_ADDR(GPIO18, 0x04f8),
-	MFP_ADDR(GPIO19, 0x04fc),
-	MFP_ADDR(GPIO20, 0x0518),
-	MFP_ADDR(GPIO21, 0x051c),
-	MFP_ADDR(GPIO22, 0x04ec),
-	MFP_ADDR(GPIO23, 0x0500),
-	MFP_ADDR(GPIO24, 0x04f0),
-	MFP_ADDR(GPIO25, 0x0504),
-	MFP_ADDR(GPIO26, 0x0510),
-	MFP_ADDR(GPIO27, 0x0514),
-	MFP_ADDR(GPIO28, 0x0520),
-	MFP_ADDR(GPIO29, 0x0600),
-	MFP_ADDR(GPIO30, 0x0618),
-	MFP_ADDR(GPIO31, 0x0610),
-	MFP_ADDR(GPIO32, 0x060c),
-	MFP_ADDR(GPIO33, 0x061c),
-	MFP_ADDR(GPIO34, 0x0620),
-	MFP_ADDR(GPIO35, 0x0628),
-	MFP_ADDR(GPIO36, 0x062c),
-	MFP_ADDR(GPIO37, 0x0630),
-	MFP_ADDR(GPIO38, 0x0634),
-	MFP_ADDR(GPIO39, 0x0638),
-	MFP_ADDR(GPIO40, 0x063c),
-	MFP_ADDR(GPIO41, 0x0614),
-	MFP_ADDR(GPIO42, 0x0624),
-	MFP_ADDR(GPIO43, 0x0608),
-	MFP_ADDR(GPIO44, 0x0604),
-	MFP_ADDR(GPIO45, 0x050c),
-	MFP_ADDR(GPIO46, 0x0508),
-	MFP_ADDR(GPIO47, 0x02bc),
-	MFP_ADDR(GPIO48, 0x02b4),
-	MFP_ADDR(GPIO49, 0x02b8),
-	MFP_ADDR(GPIO50, 0x02c8),
-	MFP_ADDR(GPIO51, 0x02c0),
-	MFP_ADDR(GPIO52, 0x02c4),
-	MFP_ADDR(GPIO53, 0x02d0),
-	MFP_ADDR(GPIO54, 0x02cc),
-	MFP_ADDR(GPIO55, 0x029c),
-	MFP_ADDR(GPIO56, 0x02a0),
-	MFP_ADDR(GPIO57, 0x0294),
-	MFP_ADDR(GPIO58, 0x0298),
-	MFP_ADDR(GPIO59, 0x02a4),
-	MFP_ADDR(GPIO60, 0x02a8),
-	MFP_ADDR(GPIO61, 0x02b0),
-	MFP_ADDR(GPIO62, 0x02ac),
-	MFP_ADDR(GPIO63, 0x0640),
-	MFP_ADDR(GPIO64, 0x065c),
-	MFP_ADDR(GPIO65, 0x0648),
-	MFP_ADDR(GPIO66, 0x0644),
-	MFP_ADDR(GPIO67, 0x0674),
-	MFP_ADDR(GPIO68, 0x0658),
-	MFP_ADDR(GPIO69, 0x0654),
-	MFP_ADDR(GPIO70, 0x0660),
-	MFP_ADDR(GPIO71, 0x0668),
-	MFP_ADDR(GPIO72, 0x0664),
-	MFP_ADDR(GPIO73, 0x0650),
-	MFP_ADDR(GPIO74, 0x066c),
-	MFP_ADDR(GPIO75, 0x064c),
-	MFP_ADDR(GPIO76, 0x0670),
-	MFP_ADDR(GPIO77, 0x0678),
-	MFP_ADDR(GPIO78, 0x067c),
-	MFP_ADDR(GPIO79, 0x0694),
-	MFP_ADDR(GPIO80, 0x069c),
-	MFP_ADDR(GPIO81, 0x06a0),
-	MFP_ADDR(GPIO82, 0x06a4),
-	MFP_ADDR(GPIO83, 0x0698),
-	MFP_ADDR(GPIO84, 0x06bc),
-	MFP_ADDR(GPIO85, 0x06b4),
-	MFP_ADDR(GPIO86, 0x06b0),
-	MFP_ADDR(GPIO87, 0x06c0),
-	MFP_ADDR(GPIO88, 0x06c4),
-	MFP_ADDR(GPIO89, 0x06ac),
-	MFP_ADDR(GPIO90, 0x0680),
-	MFP_ADDR(GPIO91, 0x0684),
-	MFP_ADDR(GPIO92, 0x0688),
-	MFP_ADDR(GPIO93, 0x0690),
-	MFP_ADDR(GPIO94, 0x068c),
-	MFP_ADDR(GPIO95, 0x06a8),
-	MFP_ADDR(GPIO96, 0x06b8),
-	MFP_ADDR(GPIO97, 0x0410),
-	MFP_ADDR(GPIO98, 0x0418),
-	MFP_ADDR(GPIO99, 0x041c),
-	MFP_ADDR(GPIO100, 0x0414),
-	MFP_ADDR(GPIO101, 0x0408),
-	MFP_ADDR(GPIO102, 0x0324),
-	MFP_ADDR(GPIO103, 0x040c),
-	MFP_ADDR(GPIO104, 0x0400),
-	MFP_ADDR(GPIO105, 0x0328),
-	MFP_ADDR(GPIO106, 0x0404),
-
-	MFP_ADDR(nXCVREN, 0x0204),
-	MFP_ADDR(DF_CLE_nOE, 0x020c),
-	MFP_ADDR(DF_nADV1_ALE, 0x0218),
-	MFP_ADDR(DF_SCLK_E, 0x0214),
-	MFP_ADDR(DF_SCLK_S, 0x0210),
-	MFP_ADDR(nBE0, 0x021c),
-	MFP_ADDR(nBE1, 0x0220),
-	MFP_ADDR(DF_nADV2_ALE, 0x0224),
-	MFP_ADDR(DF_INT_RnB, 0x0228),
-	MFP_ADDR(DF_nCS0, 0x022c),
-	MFP_ADDR(DF_nCS1, 0x0230),
-	MFP_ADDR(nLUA, 0x0254),
-	MFP_ADDR(nLLA, 0x0258),
-	MFP_ADDR(DF_nWE, 0x0234),
-	MFP_ADDR(DF_nRE_nOE, 0x0238),
-	MFP_ADDR(DF_ADDR0, 0x024c),
-	MFP_ADDR(DF_ADDR1, 0x0250),
-	MFP_ADDR(DF_ADDR2, 0x025c),
-	MFP_ADDR(DF_ADDR3, 0x0260),
-	MFP_ADDR(DF_IO0, 0x023c),
-	MFP_ADDR(DF_IO1, 0x0240),
-	MFP_ADDR(DF_IO2, 0x0244),
-	MFP_ADDR(DF_IO3, 0x0248),
-	MFP_ADDR(DF_IO4, 0x0264),
-	MFP_ADDR(DF_IO5, 0x0268),
-	MFP_ADDR(DF_IO6, 0x026c),
-	MFP_ADDR(DF_IO7, 0x0270),
-	MFP_ADDR(DF_IO8, 0x0274),
-	MFP_ADDR(DF_IO9, 0x0278),
-	MFP_ADDR(DF_IO10, 0x027c),
-	MFP_ADDR(DF_IO11, 0x0280),
-	MFP_ADDR(DF_IO12, 0x0284),
-	MFP_ADDR(DF_IO13, 0x0288),
-	MFP_ADDR(DF_IO14, 0x028c),
-	MFP_ADDR(DF_IO15, 0x0290),
-
-	MFP_ADDR(GSIM_UIO, 0x0314),
-	MFP_ADDR(GSIM_UCLK, 0x0318),
-	MFP_ADDR(GSIM_UDET, 0x031c),
-	MFP_ADDR(GSIM_nURST, 0x0320),
-
-	MFP_ADDR(PMIC_INT, 0x06c8),
-
-	MFP_ADDR(RDY, 0x0200),
-
-	MFP_ADDR_END,
-};
-
-static struct mfp_addr_map pxa935_mfp_addr_map[] __initdata = {
-	MFP_ADDR(GPIO159, 0x0524),
-	MFP_ADDR(GPIO163, 0x0534),
-	MFP_ADDR(GPIO167, 0x0544),
-	MFP_ADDR(GPIO168, 0x0548),
-	MFP_ADDR(GPIO169, 0x054c),
-	MFP_ADDR(GPIO170, 0x0550),
-	MFP_ADDR(GPIO171, 0x0554),
-	MFP_ADDR(GPIO172, 0x0558),
-	MFP_ADDR(GPIO173, 0x055c),
-
-	MFP_ADDR_END,
-};
-
-static int __init pxa930_init(void)
-{
-	if (cpu_is_pxa930() || cpu_is_pxa935() || cpu_is_pxa950()) {
-		mfp_init_base(io_p2v(MFPR_BASE));
-		mfp_init_addr(pxa930_mfp_addr_map);
-	}
-
-	if (cpu_is_pxa935())
-		mfp_init_addr(pxa935_mfp_addr_map);
-
-	return 0;
-}
-
-core_initcall(pxa930_init);
diff --git a/arch/arm/mach-pxa/pxa93x.c b/arch/arm/mach-pxa/pxa93x.c
new file mode 100644
index 0000000..dc7fa9f
--- /dev/null
+++ b/arch/arm/mach-pxa/pxa93x.c
@@ -0,0 +1,471 @@
+/*
+ * linux/arch/arm/mach-pxa/pxa93x.c
+ *
+ * code specific to pxa93x aka Tavor
+ *
+ * Copyright (C) 2006 Marvell International Ltd.
+ *
+ * 2007-09-02: eric miao <eric.miao@marvell.com>
+ *             initial version
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/pm.h>
+#include <linux/platform_device.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+#include <linux/sysdev.h>
+
+#include <mach/hardware.h>
+#include <mach/gpio.h>
+#include <mach/pxa3xx-regs.h>
+#include <mach/pxa930.h>
+#include <mach/reset.h>
+#include <mach/pm.h>
+#include <mach/dma.h>
+#include <mach/regs-intc.h>
+#include <plat/i2c.h>
+
+#include "generic.h"
+#include "devices.h"
+#include "clock.h"
+
+/* Crystal clock: 13MHz */
+#define BASE_CLK	13000000
+
+/* Ring Oscillator Clock: 60MHz */
+#define RO_CLK		60000000
+
+#define ACCR_D0CS	(1 << 26)
+#define ACCR_PCCE	(1 << 11)
+
+#define PECR_IE(n)	((1 << ((n) * 2)) << 28)
+#define PECR_IS(n)	((1 << ((n) * 2)) << 29)
+
+/* crystal frequency to HSIO bus frequency multiplier (HSS) */
+static unsigned char hss_mult[4] = { 8, 12, 16, 24 };
+
+static struct mfp_addr_map pxa930_mfp_addr_map[] __initdata = {
+
+	MFP_ADDR(GPIO0, 0x02e0),
+	MFP_ADDR(GPIO1, 0x02dc),
+	MFP_ADDR(GPIO2, 0x02e8),
+	MFP_ADDR(GPIO3, 0x02d8),
+	MFP_ADDR(GPIO4, 0x02e4),
+	MFP_ADDR(GPIO5, 0x02ec),
+	MFP_ADDR(GPIO6, 0x02f8),
+	MFP_ADDR(GPIO7, 0x02fc),
+	MFP_ADDR(GPIO8, 0x0300),
+	MFP_ADDR(GPIO9, 0x02d4),
+	MFP_ADDR(GPIO10, 0x02f4),
+	MFP_ADDR(GPIO11, 0x02f0),
+	MFP_ADDR(GPIO12, 0x0304),
+	MFP_ADDR(GPIO13, 0x0310),
+	MFP_ADDR(GPIO14, 0x0308),
+	MFP_ADDR(GPIO15, 0x030c),
+	MFP_ADDR(GPIO16, 0x04e8),
+	MFP_ADDR(GPIO17, 0x04f4),
+	MFP_ADDR(GPIO18, 0x04f8),
+	MFP_ADDR(GPIO19, 0x04fc),
+	MFP_ADDR(GPIO20, 0x0518),
+	MFP_ADDR(GPIO21, 0x051c),
+	MFP_ADDR(GPIO22, 0x04ec),
+	MFP_ADDR(GPIO23, 0x0500),
+	MFP_ADDR(GPIO24, 0x04f0),
+	MFP_ADDR(GPIO25, 0x0504),
+	MFP_ADDR(GPIO26, 0x0510),
+	MFP_ADDR(GPIO27, 0x0514),
+	MFP_ADDR(GPIO28, 0x0520),
+	MFP_ADDR(GPIO29, 0x0600),
+	MFP_ADDR(GPIO30, 0x0618),
+	MFP_ADDR(GPIO31, 0x0610),
+	MFP_ADDR(GPIO32, 0x060c),
+	MFP_ADDR(GPIO33, 0x061c),
+	MFP_ADDR(GPIO34, 0x0620),
+	MFP_ADDR(GPIO35, 0x0628),
+	MFP_ADDR(GPIO36, 0x062c),
+	MFP_ADDR(GPIO37, 0x0630),
+	MFP_ADDR(GPIO38, 0x0634),
+	MFP_ADDR(GPIO39, 0x0638),
+	MFP_ADDR(GPIO40, 0x063c),
+	MFP_ADDR(GPIO41, 0x0614),
+	MFP_ADDR(GPIO42, 0x0624),
+	MFP_ADDR(GPIO43, 0x0608),
+	MFP_ADDR(GPIO44, 0x0604),
+	MFP_ADDR(GPIO45, 0x050c),
+	MFP_ADDR(GPIO46, 0x0508),
+	MFP_ADDR(GPIO47, 0x02bc),
+	MFP_ADDR(GPIO48, 0x02b4),
+	MFP_ADDR(GPIO49, 0x02b8),
+	MFP_ADDR(GPIO50, 0x02c8),
+	MFP_ADDR(GPIO51, 0x02c0),
+	MFP_ADDR(GPIO52, 0x02c4),
+	MFP_ADDR(GPIO53, 0x02d0),
+	MFP_ADDR(GPIO54, 0x02cc),
+	MFP_ADDR(GPIO55, 0x029c),
+	MFP_ADDR(GPIO56, 0x02a0),
+	MFP_ADDR(GPIO57, 0x0294),
+	MFP_ADDR(GPIO58, 0x0298),
+	MFP_ADDR(GPIO59, 0x02a4),
+	MFP_ADDR(GPIO60, 0x02a8),
+	MFP_ADDR(GPIO61, 0x02b0),
+	MFP_ADDR(GPIO62, 0x02ac),
+	MFP_ADDR(GPIO63, 0x0640),
+	MFP_ADDR(GPIO64, 0x065c),
+	MFP_ADDR(GPIO65, 0x0648),
+	MFP_ADDR(GPIO66, 0x0644),
+	MFP_ADDR(GPIO67, 0x0674),
+	MFP_ADDR(GPIO68, 0x0658),
+	MFP_ADDR(GPIO69, 0x0654),
+	MFP_ADDR(GPIO70, 0x0660),
+	MFP_ADDR(GPIO71, 0x0668),
+	MFP_ADDR(GPIO72, 0x0664),
+	MFP_ADDR(GPIO73, 0x0650),
+	MFP_ADDR(GPIO74, 0x066c),
+	MFP_ADDR(GPIO75, 0x064c),
+	MFP_ADDR(GPIO76, 0x0670),
+	MFP_ADDR(GPIO77, 0x0678),
+	MFP_ADDR(GPIO78, 0x067c),
+	MFP_ADDR(GPIO79, 0x0694),
+	MFP_ADDR(GPIO80, 0x069c),
+	MFP_ADDR(GPIO81, 0x06a0),
+	MFP_ADDR(GPIO82, 0x06a4),
+	MFP_ADDR(GPIO83, 0x0698),
+	MFP_ADDR(GPIO84, 0x06bc),
+	MFP_ADDR(GPIO85, 0x06b4),
+	MFP_ADDR(GPIO86, 0x06b0),
+	MFP_ADDR(GPIO87, 0x06c0),
+	MFP_ADDR(GPIO88, 0x06c4),
+	MFP_ADDR(GPIO89, 0x06ac),
+	MFP_ADDR(GPIO90, 0x0680),
+	MFP_ADDR(GPIO91, 0x0684),
+	MFP_ADDR(GPIO92, 0x0688),
+	MFP_ADDR(GPIO93, 0x0690),
+	MFP_ADDR(GPIO94, 0x068c),
+	MFP_ADDR(GPIO95, 0x06a8),
+	MFP_ADDR(GPIO96, 0x06b8),
+	MFP_ADDR(GPIO97, 0x0410),
+	MFP_ADDR(GPIO98, 0x0418),
+	MFP_ADDR(GPIO99, 0x041c),
+	MFP_ADDR(GPIO100, 0x0414),
+	MFP_ADDR(GPIO101, 0x0408),
+	MFP_ADDR(GPIO102, 0x0324),
+	MFP_ADDR(GPIO103, 0x040c),
+	MFP_ADDR(GPIO104, 0x0400),
+	MFP_ADDR(GPIO105, 0x0328),
+	MFP_ADDR(GPIO106, 0x0404),
+
+	MFP_ADDR(nXCVREN, 0x0204),
+	MFP_ADDR(DF_CLE_nOE, 0x020c),
+	MFP_ADDR(DF_nADV1_ALE, 0x0218),
+	MFP_ADDR(DF_SCLK_E, 0x0214),
+	MFP_ADDR(DF_SCLK_S, 0x0210),
+	MFP_ADDR(nBE0, 0x021c),
+	MFP_ADDR(nBE1, 0x0220),
+	MFP_ADDR(DF_nADV2_ALE, 0x0224),
+	MFP_ADDR(DF_INT_RnB, 0x0228),
+	MFP_ADDR(DF_nCS0, 0x022c),
+	MFP_ADDR(DF_nCS1, 0x0230),
+	MFP_ADDR(nLUA, 0x0254),
+	MFP_ADDR(nLLA, 0x0258),
+	MFP_ADDR(DF_nWE, 0x0234),
+	MFP_ADDR(DF_nRE_nOE, 0x0238),
+	MFP_ADDR(DF_ADDR0, 0x024c),
+	MFP_ADDR(DF_ADDR1, 0x0250),
+	MFP_ADDR(DF_ADDR2, 0x025c),
+	MFP_ADDR(DF_ADDR3, 0x0260),
+	MFP_ADDR(DF_IO0, 0x023c),
+	MFP_ADDR(DF_IO1, 0x0240),
+	MFP_ADDR(DF_IO2, 0x0244),
+	MFP_ADDR(DF_IO3, 0x0248),
+	MFP_ADDR(DF_IO4, 0x0264),
+	MFP_ADDR(DF_IO5, 0x0268),
+	MFP_ADDR(DF_IO6, 0x026c),
+	MFP_ADDR(DF_IO7, 0x0270),
+	MFP_ADDR(DF_IO8, 0x0274),
+	MFP_ADDR(DF_IO9, 0x0278),
+	MFP_ADDR(DF_IO10, 0x027c),
+	MFP_ADDR(DF_IO11, 0x0280),
+	MFP_ADDR(DF_IO12, 0x0284),
+	MFP_ADDR(DF_IO13, 0x0288),
+	MFP_ADDR(DF_IO14, 0x028c),
+	MFP_ADDR(DF_IO15, 0x0290),
+
+	MFP_ADDR(GSIM_UIO, 0x0314),
+	MFP_ADDR(GSIM_UCLK, 0x0318),
+	MFP_ADDR(GSIM_UDET, 0x031c),
+	MFP_ADDR(GSIM_nURST, 0x0320),
+
+	MFP_ADDR(PMIC_INT, 0x06c8),
+
+	MFP_ADDR(RDY, 0x0200),
+
+	MFP_ADDR_END,
+};
+
+static struct mfp_addr_map pxa935_mfp_addr_map[] __initdata = {
+	MFP_ADDR(GPIO159, 0x0524),
+	MFP_ADDR(GPIO163, 0x0534),
+	MFP_ADDR(GPIO167, 0x0544),
+	MFP_ADDR(GPIO168, 0x0548),
+	MFP_ADDR(GPIO169, 0x054c),
+	MFP_ADDR(GPIO170, 0x0550),
+	MFP_ADDR(GPIO171, 0x0554),
+	MFP_ADDR(GPIO172, 0x0558),
+	MFP_ADDR(GPIO173, 0x055c),
+
+	MFP_ADDR_END,
+};
+
+void pxa93x_clear_reset_status(unsigned int mask)
+{
+	/* RESET_STATUS_* has a 1:1 mapping with ARSR */
+	ARSR = mask;
+}
+
+/*
+ * Return the current HSIO bus clock frequency
+ */
+static unsigned long clk_pxa93x_hsio_getrate(struct clk *clk)
+{
+	unsigned long acsr;
+	unsigned int hss, hsio_clk;
+
+	acsr = ACSR;
+
+	hss = (acsr >> 14) & 0x3;
+	hsio_clk = (acsr & ACCR_D0CS) ? RO_CLK : hss_mult[hss] * BASE_CLK;
+
+	return hsio_clk;
+}
+
+void clk_pxa93x_cken_enable(struct clk *clk)
+{
+	unsigned long mask = 1ul << (clk->cken & 0x1f);
+
+	if (clk->cken < 32)
+		CKENA |= mask;
+	else
+		CKENB |= mask;
+}
+
+void clk_pxa93x_cken_disable(struct clk *clk)
+{
+	unsigned long mask = 1ul << (clk->cken & 0x1f);
+
+	if (clk->cken < 32)
+		CKENA &= ~mask;
+	else
+		CKENB &= ~mask;
+}
+
+const struct clkops clk_pxa93x_cken_ops = {
+	.enable		= clk_pxa93x_cken_enable,
+	.disable	= clk_pxa93x_cken_disable,
+};
+
+static const struct clkops clk_pxa93x_hsio_ops = {
+	.enable		= clk_pxa93x_cken_enable,
+	.disable	= clk_pxa93x_cken_disable,
+	.getrate	= clk_pxa93x_hsio_getrate,
+};
+
+static void clk_pout_enable(struct clk *clk)
+{
+	OSCC |= OSCC_PEN;
+}
+
+static void clk_pout_disable(struct clk *clk)
+{
+	OSCC &= ~OSCC_PEN;
+}
+
+static const struct clkops clk_pout_ops = {
+	.enable		= clk_pout_enable,
+	.disable	= clk_pout_disable,
+};
+
+static void clk_dummy_enable(struct clk *clk)
+{
+}
+
+static void clk_dummy_disable(struct clk *clk)
+{
+}
+
+static const struct clkops clk_dummy_ops = {
+	.enable		= clk_dummy_enable,
+	.disable	= clk_dummy_disable,
+};
+
+static struct clk clk_pxa93x_pout = {
+	.ops		= &clk_pout_ops,
+	.rate		= 13000000,
+	.delay		= 70,
+};
+
+static struct clk clk_dummy = {
+	.ops		= &clk_dummy_ops,
+};
+
+static DEFINE_PXA93_CK(pxa93x_lcd, LCD, &clk_pxa93x_hsio_ops);
+static DEFINE_PXA93_CK(pxa93x_camera, CAMERA, &clk_pxa93x_hsio_ops);
+static DEFINE_PXA93_CKEN(pxa93x_ffuart, FFUART, 14857000, 1);
+static DEFINE_PXA93_CKEN(pxa93x_btuart, BTUART, 14857000, 1);
+static DEFINE_PXA93_CKEN(pxa93x_stuart, STUART, 14857000, 1);
+static DEFINE_PXA93_CKEN(pxa93x_i2c, I2C, 32842000, 0);
+static DEFINE_PXA93_CKEN(pxa93x_keypad, KEYPAD, 32768, 0);
+static DEFINE_PXA93_CKEN(pxa93x_ssp1, SSP1, 13000000, 0);
+static DEFINE_PXA93_CKEN(pxa93x_ssp2, SSP2, 13000000, 0);
+static DEFINE_PXA93_CKEN(pxa93x_ssp3, SSP3, 13000000, 0);
+static DEFINE_PXA93_CKEN(pxa93x_ssp4, SSP4, 13000000, 0);
+static DEFINE_PXA93_CKEN(pxa93x_pwm0, PWM0, 13000000, 0);
+static DEFINE_PXA93_CKEN(pxa93x_pwm1, PWM1, 13000000, 0);
+static DEFINE_PXA93_CKEN(pxa93x_mmc1, MMC1, 19500000, 0);
+static DEFINE_PXA93_CKEN(pxa93x_mmc2, MMC2, 19500000, 0);
+
+static struct clk_lookup pxa93x_clkregs[] = {
+	INIT_CLKREG(&clk_pxa93x_pout, NULL, "CLK_POUT"),
+	/* Power I2C clock is always on */
+	INIT_CLKREG(&clk_dummy, "pxa3xx-pwri2c.1", NULL),
+	INIT_CLKREG(&clk_pxa93x_lcd, "pxa2xx-fb", NULL),
+	INIT_CLKREG(&clk_pxa93x_camera, NULL, "CAMCLK"),
+	INIT_CLKREG(&clk_pxa93x_ffuart, "pxa2xx-uart.0", NULL),
+	INIT_CLKREG(&clk_pxa93x_btuart, "pxa2xx-uart.1", NULL),
+	INIT_CLKREG(&clk_pxa93x_stuart, "pxa2xx-uart.2", NULL),
+	INIT_CLKREG(&clk_pxa93x_stuart, "pxa2xx-ir", "UARTCLK"),
+	INIT_CLKREG(&clk_pxa93x_i2c, "pxa2xx-i2c.0", NULL),
+	INIT_CLKREG(&clk_pxa93x_keypad, "pxa27x-keypad", NULL),
+	INIT_CLKREG(&clk_pxa93x_ssp1, "pxa27x-ssp.0", NULL),
+	INIT_CLKREG(&clk_pxa93x_ssp2, "pxa27x-ssp.1", NULL),
+	INIT_CLKREG(&clk_pxa93x_ssp3, "pxa27x-ssp.2", NULL),
+	INIT_CLKREG(&clk_pxa93x_ssp4, "pxa27x-ssp.3", NULL),
+	INIT_CLKREG(&clk_pxa93x_pwm0, "pxa27x-pwm.0", NULL),
+	INIT_CLKREG(&clk_pxa93x_pwm1, "pxa27x-pwm.1", NULL),
+};
+
+static struct clk_lookup pxa930_clkregs[] = {
+	INIT_CLKREG(&clk_pxa93x_mmc1, "pxa2xx-mci.0", NULL),
+	INIT_CLKREG(&clk_pxa93x_mmc2, "pxa2xx-mci.1", NULL),
+};
+
+static void pxa_ack_ext_wakeup(unsigned int irq)
+{
+	PECR |= PECR_IS(irq - IRQ_WAKEUP0);
+}
+
+static void pxa_mask_ext_wakeup(unsigned int irq)
+{
+	ICMR2 &= ~(1 << ((irq - PXA_IRQ(0)) & 0x1f));
+	PECR &= ~PECR_IE(irq - IRQ_WAKEUP0);
+}
+
+static void pxa_unmask_ext_wakeup(unsigned int irq)
+{
+	ICMR2 |= 1 << ((irq - PXA_IRQ(0)) & 0x1f);
+	PECR |= PECR_IE(irq - IRQ_WAKEUP0);
+}
+
+static int pxa_set_ext_wakeup_type(unsigned int irq, unsigned int flow_type)
+{
+	if (flow_type & IRQ_TYPE_EDGE_RISING)
+		PWER |= 1 << (irq - IRQ_WAKEUP0);
+
+	if (flow_type & IRQ_TYPE_EDGE_FALLING)
+		PWER |= 1 << (irq - IRQ_WAKEUP0 + 2);
+
+	return 0;
+}
+
+static struct irq_chip pxa_ext_wakeup_chip = {
+	.name		= "WAKEUP",
+	.ack		= pxa_ack_ext_wakeup,
+	.mask		= pxa_mask_ext_wakeup,
+	.unmask		= pxa_unmask_ext_wakeup,
+	.set_type	= pxa_set_ext_wakeup_type,
+};
+
+static void __init pxa_init_ext_wakeup_irq(set_wake_t fn)
+{
+	set_irq_chip(IRQ_WAKEUP0, &pxa_ext_wakeup_chip);
+	set_irq_handler(IRQ_WAKEUP0, handle_edge_irq);
+	set_irq_flags(IRQ_WAKEUP0, IRQF_VALID);
+
+	pxa_ext_wakeup_chip.set_wake = fn;
+}
+
+void __init pxa93x_init_irq(void)
+{
+	/* enable CP6 access */
+	u32 value;
+	__asm__ __volatile__("mrc p15, 0, %0, c15, c1, 0\n": "=r"(value));
+	value |= (1 << 6);
+	__asm__ __volatile__("mcr p15, 0, %0, c15, c1, 0\n": :"r"(value));
+
+	pxa_init_irq(96, NULL);
+	pxa_init_ext_wakeup_irq(NULL);
+	pxa_init_gpio(IRQ_GPIO_2_x, 2, 127, NULL);
+}
+
+/*
+ * device registration specific to PXA93x.
+ */
+
+void __init pxa93x_set_i2c_power_info(struct i2c_pxa_platform_data *info)
+{
+	pxa_register_device(&pxa3xx_device_i2c_power, info);
+}
+
+static struct platform_device *devices[] __initdata = {
+	&sa1100_device_rtc,
+	&pxa_device_rtc,
+	&pxa27x_device_ssp1,
+	&pxa27x_device_ssp2,
+	&pxa27x_device_ssp3,
+	&pxa3xx_device_ssp4,
+	&pxa27x_device_pwm0,
+	&pxa27x_device_pwm1,
+};
+
+static int __init pxa93x_init(void)
+{
+	int ret = 0;
+
+	if (cpu_is_pxa93x()) {
+		mfp_init_base(io_p2v(MFPR_BASE));
+		mfp_init_addr(pxa930_mfp_addr_map);
+
+		if (cpu_is_pxa935())
+			mfp_init_addr(pxa935_mfp_addr_map);
+
+		reset_status = ARSR;
+
+		/*
+		 * clear RDH bit every time after reset
+		 *
+		 * Note: the last 3 bits DxS are write-1-to-clear so carefully
+		 * preserve them here in case they will be referenced later
+		 */
+		ASCR &= ~(ASCR_RDH | ASCR_D1S | ASCR_D2S | ASCR_D3S);
+
+		clkdev_add_table(pxa93x_clkregs, ARRAY_SIZE(pxa93x_clkregs));
+		if (cpu_is_pxa930())
+			clkdev_add_table(pxa930_clkregs,
+				ARRAY_SIZE(pxa930_clkregs));
+
+		if ((ret = pxa_init_dma(IRQ_DMA, 32)))
+			return ret;
+
+		ret = platform_add_devices(devices, ARRAY_SIZE(devices));
+	}
+
+	return ret;
+}
+
+postcore_initcall(pxa93x_init);
diff --git a/arch/arm/mach-pxa/saar.c b/arch/arm/mach-pxa/saar.c
index c1ca8cb..4a166ce 100644
--- a/arch/arm/mach-pxa/saar.c
+++ b/arch/arm/mach-pxa/saar.c
@@ -598,7 +598,7 @@ MACHINE_START(SAAR, "PXA930 Handheld Platform (aka SAAR)")
 	/* Maintainer: Eric Miao <eric.miao@marvell.com> */
 	.boot_params    = 0xa0000100,
 	.map_io         = pxa3xx_map_io,
-	.init_irq       = pxa3xx_init_irq,
+	.init_irq       = pxa93x_init_irq,
 	.timer          = &pxa_timer,
 	.init_machine   = saar_init,
 MACHINE_END
diff --git a/arch/arm/mach-pxa/smemc.c b/arch/arm/mach-pxa/smemc.c
index 232b731..ebee414 100644
--- a/arch/arm/mach-pxa/smemc.c
+++ b/arch/arm/mach-pxa/smemc.c
@@ -59,13 +59,11 @@ static int __init smemc_init(void)
 {
 	int ret = 0;
 
-	if (cpu_is_pxa3xx()) {
-		ret = sysdev_class_register(&smemc_sysclass);
-		if (ret)
-			return ret;
+	ret = sysdev_class_register(&smemc_sysclass);
+	if (ret)
+		return ret;
 
-		ret = sysdev_register(&smemc_sysdev);
-	}
+	ret = sysdev_register(&smemc_sysdev);
 
 	return ret;
 }
diff --git a/arch/arm/mach-pxa/tavorevb.c b/arch/arm/mach-pxa/tavorevb.c
index 9cecf83..15ac912 100644
--- a/arch/arm/mach-pxa/tavorevb.c
+++ b/arch/arm/mach-pxa/tavorevb.c
@@ -491,7 +491,7 @@ MACHINE_START(TAVOREVB, "PXA930 Evaluation Board (aka TavorEVB)")
 	/* Maintainer: Eric Miao <eric.miao@marvell.com> */
 	.boot_params    = 0xa0000100,
 	.map_io         = pxa3xx_map_io,
-	.init_irq       = pxa3xx_init_irq,
+	.init_irq       = pxa93x_init_irq,
 	.timer          = &pxa_timer,
 	.init_machine   = tavorevb_init,
 MACHINE_END
diff --git a/arch/arm/plat-pxa/Makefile b/arch/arm/plat-pxa/Makefile
index 4aacdd1..4ac2fd9 100644
--- a/arch/arm/plat-pxa/Makefile
+++ b/arch/arm/plat-pxa/Makefile
@@ -6,6 +6,7 @@ obj-y	:= dma.o
 
 obj-$(CONFIG_GENERIC_GPIO)	+= gpio.o
 obj-$(CONFIG_PXA3xx)		+= mfp.o
+obj-$(CONFIG_PXA93x)		+= mfp.o
 obj-$(CONFIG_ARCH_MMP)		+= mfp.o
 
 obj-$(CONFIG_HAVE_PWM)		+= pwm.o
diff --git a/arch/arm/plat-pxa/include/plat/mfp.h b/arch/arm/plat-pxa/include/plat/mfp.h
index 9e604c8..a3a2a65 100644
--- a/arch/arm/plat-pxa/include/plat/mfp.h
+++ b/arch/arm/plat-pxa/include/plat/mfp.h
@@ -423,7 +423,7 @@ typedef unsigned long mfp_cfg_t;
 	((MFP_CFG_DEFAULT & ~(MFP_AF_MASK | MFP_DS_MASK | MFP_LPM_STATE_MASK)) |\
 	 (MFP_PIN(MFP_PIN_##pin) | MFP_##af | MFP_##drv | MFP_LPM_##lpm))
 
-#if defined(CONFIG_PXA3xx) || defined(CONFIG_ARCH_MMP)
+#if defined(CONFIG_PXA3xx) || defined(CONFIG_PXA93x) || defined(CONFIG_ARCH_MMP)
 /*
  * each MFP pin will have a MFPR register, since the offset of the
  * register varies between processors, the processor specific code
@@ -470,6 +470,6 @@ void mfp_write(int mfp, unsigned long mfpr_val);
 void mfp_config(unsigned long *mfp_cfgs, int num);
 void mfp_config_run(void);
 void mfp_config_lpm(void);
-#endif /* CONFIG_PXA3xx || CONFIG_ARCH_MMP */
+#endif /* CONFIG_PXA3xx || CONFIG_PXA93x || CONFIG_ARCH_MMP */
 
 #endif /* __ASM_PLAT_MFP_H */
-- 
1.5.6.5
