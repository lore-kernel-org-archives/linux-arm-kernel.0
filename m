From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 14 Jan 2010 12:29:25 +0100
Subject: [PATCH 07/21] ARM: S5PC1XX: cleanup of s5pc1xx common code
In-Reply-To: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
References: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1263468579-5732-8-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes all useless definitions from plat/s5pc100.h and
introduces new common plat/s5pc1xx.h include.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pc100/cpu.c                     |    2 +-
 arch/arm/mach-s5pc100/include/plat/regs-clock.h |    8 ++--
 arch/arm/mach-s5pc100/mach-smdkc100.c           |    2 +-
 arch/arm/mach-s5pc100/plls.c                    |    2 +-
 arch/arm/mach-s5pc100/uarts.c                   |    5 +-
 arch/arm/plat-s5pc1xx/cpu.c                     |    2 +-
 arch/arm/plat-s5pc1xx/include/plat/s5pc100.h    |   51 ++++++-----------------
 arch/arm/plat-s5pc1xx/include/plat/s5pc1xx.h    |   21 +++++++++
 8 files changed, 45 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm/plat-s5pc1xx/include/plat/s5pc1xx.h

diff --git a/arch/arm/mach-s5pc100/cpu.c b/arch/arm/mach-s5pc100/cpu.c
index 41fdecf..f383e33 100644
--- a/arch/arm/mach-s5pc100/cpu.c
+++ b/arch/arm/mach-s5pc100/cpu.c
@@ -41,7 +41,7 @@
 #include <plat/clock.h>
 #include <plat/sdhci.h>
 #include <plat/iic-core.h>
-#include <plat/s5pc100.h>
+#include <plat/s5pc1xx.h>
 
 /* Initial IO mappings */
 
diff --git a/arch/arm/mach-s5pc100/include/plat/regs-clock.h b/arch/arm/mach-s5pc100/include/plat/regs-clock.h
index fc6ec1b..03ecc0c 100644
--- a/arch/arm/mach-s5pc100/include/plat/regs-clock.h
+++ b/arch/arm/mach-s5pc100/include/plat/regs-clock.h
@@ -234,10 +234,10 @@
 #define S5PC100_HDMI_PHY_CON0	S5PC100_CLKREG_OTHER(0x420)
 
 #define S5PC100_SWRESET_RESETVAL	0xc100
-#define S5PC100_OTHER_SYS_INT	24
-#define S5PC100_OTHER_STA_TYPE	23
-#define STA_TYPE_EXPON		0
-#define STA_TYPE_SFR		1
+#define S5PC100_OTHERS_PMU_INT_DISALBE		(1 << 24)
+#define S5PC100_OTHERS_STABLE_COUNTER_TYPE_MASK	(1 << 23)
+#define S5PC100_OTHERS_STABLE_COUNTER_TYPE_SFR	(1 << 23)
+#define S5PC100_OTHERS_STABLE_COUNTER_TYPE_EXP	(0 << 23)
 
 #define S5PC100_SLEEP_CFG_OSC_EN	0
 
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index ae3c52c..29b95f1 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -40,7 +40,7 @@
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/s5pc100.h>
+#include <plat/s5pc1xx.h>
 #include <plat/fb.h>
 #include <plat/iic.h>
 
diff --git a/arch/arm/mach-s5pc100/plls.c b/arch/arm/mach-s5pc100/plls.c
index 49c51a0..32fb0ca 100644
--- a/arch/arm/mach-s5pc100/plls.c
+++ b/arch/arm/mach-s5pc100/plls.c
@@ -33,7 +33,7 @@
 #include <plat/cpu.h>
 #include <plat/pll.h>
 #include <plat/devs.h>
-#include <plat/s5pc100.h>
+#include <plat/s5pc1xx.h>
 
 /* fin_apll, fin_mpll and fin_epll are all the same clock, which we call
  * ext_xtal_mux for want of an actual name from the manual.
diff --git a/arch/arm/mach-s5pc100/uarts.c b/arch/arm/mach-s5pc100/uarts.c
index 32972f2..6bab6d2 100644
--- a/arch/arm/mach-s5pc100/uarts.c
+++ b/arch/arm/mach-s5pc100/uarts.c
@@ -13,14 +13,15 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/init.h>
+#include <linux/clk.h>
 
 #include <plat/cpu.h>
 #include <plat/devs.h>
-#include <plat/s5pc100.h>
+#include <plat/s5pc1xx.h>
 
 /* uart registration process */
 
-void __init s5pc100_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
+void __init s5pc100_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 {
 	/* The driver name is s3c6400-uart to reuse s3c6400_serial_drv  */
 	s3c24xx_init_uartdevs("s3c6400-uart", s5pc1xx_uart_resources, cfg, no);
diff --git a/arch/arm/plat-s5pc1xx/cpu.c b/arch/arm/plat-s5pc1xx/cpu.c
index ecd6d38..d30998d 100644
--- a/arch/arm/plat-s5pc1xx/cpu.c
+++ b/arch/arm/plat-s5pc1xx/cpu.c
@@ -31,7 +31,7 @@
 #include <plat/devs.h>
 #include <plat/clock.h>
 
-#include <plat/s5pc100.h>
+#include <plat/s5pc1xx.h>
 
 /* table of supported CPUs */
 
diff --git a/arch/arm/plat-s5pc1xx/include/plat/s5pc100.h b/arch/arm/plat-s5pc1xx/include/plat/s5pc100.h
index 2531f34..32eb6e7 100644
--- a/arch/arm/plat-s5pc1xx/include/plat/s5pc100.h
+++ b/arch/arm/plat-s5pc1xx/include/plat/s5pc100.h
@@ -13,52 +13,27 @@
 */
 
 /* Common init code for S5PC100 related SoCs */
+
+#ifdef CONFIG_CPU_S5PC100
+
 extern  int s5pc100_init(void);
 extern void s5pc100_map_io(void);
 extern void s5pc100_init_clocks(int xtal);
 extern  int s5pc100_register_baseclocks(unsigned long xtal);
 extern void s5pc100_init_irq(void);
 extern void s5pc100_init_io(struct map_desc *mach_desc, int size);
-extern void s5pc100_common_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+extern void s5pc100_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 extern void s5pc100_register_clocks(void);
 extern void s5pc100_setup_clocks(void);
-extern struct sysdev_class s5pc100_sysclass;
-
-#define s5pc100_init_uarts s5pc100_common_init_uarts
-
-/* Some day, belows will be moved to plat-s5pc/include/plat/cpu.h */
-extern void s5pc1xx_init_irq(u32 *vic_valid, int num);
-extern void s5pc1xx_init_io(struct map_desc *mach_desc, int size);
-
-/* Some day, belows will be moved to plat-s5pc/include/plat/clock.h */
-extern struct clk clk_hpll;
-extern struct clk clk_hd0;
-extern struct clk clk_pd0;
+extern  int s5pc100_sclk0_ctrl(struct clk *clk, int enable);
+extern  int s5pc100_sclk1_ctrl(struct clk *clk, int enable);
 extern struct clk clk_54m;
-extern void s5pc1xx_register_clocks(void);
-extern int s5pc100_sclk0_ctrl(struct clk *clk, int enable);
-extern int s5pc100_sclk1_ctrl(struct clk *clk, int enable);
 
-/* Some day, belows will be moved to plat-s5pc/include/plat/devs.h */
-extern struct s3c24xx_uart_resources s5pc1xx_uart_resources[];
-extern struct platform_device s3c_device_g2d;
-extern struct platform_device s3c_device_g3d;
-extern struct platform_device s3c_device_vpp;
-extern struct platform_device s3c_device_tvenc;
-extern struct platform_device s3c_device_tvscaler;
-extern struct platform_device s3c_device_rotator;
-extern struct platform_device s3c_device_jpeg;
-extern struct platform_device s3c_device_onenand;
-extern struct platform_device s3c_device_usb_otghcd;
-extern struct platform_device s3c_device_keypad;
-extern struct platform_device s3c_device_ts;
-extern struct platform_device s3c_device_g3d;
-extern struct platform_device s3c_device_smc911x;
-extern struct platform_device s3c_device_fimc0;
-extern struct platform_device s3c_device_fimc1;
-extern struct platform_device s3c_device_mfc;
-extern struct platform_device s3c_device_ac97;
-extern struct platform_device s3c_device_fimc0;
-extern struct platform_device s3c_device_fimc1;
-extern struct platform_device s3c_device_fimc2;
+#else
+
+#define s5pc100_map_io NULL
+#define s5pc100_init_clocks NULL
+#define s5pc100_init_uarts NULL
+#define s5pc100_init NULL
 
+#endif
diff --git a/arch/arm/plat-s5pc1xx/include/plat/s5pc1xx.h b/arch/arm/plat-s5pc1xx/include/plat/s5pc1xx.h
new file mode 100644
index 0000000..398251f
--- /dev/null
+++ b/arch/arm/plat-s5pc1xx/include/plat/s5pc1xx.h
@@ -0,0 +1,21 @@
+/* arch/arm/plat-s5pc1xx/include/plat/s5pc100.h
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *	Marek Szyprowski <m.szyprowski@samsung.com>
+ *
+ * Header file for s5pc1xx cpu support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/* Common init code for S5PC1XX related SoCs */
+
+extern void s5pc1xx_init_irq(u32 *vic_valid, int num);
+extern void s5pc1xx_init_io(struct map_desc *mach_desc, int size);
+extern void s5pc1xx_register_clocks(void);
+
+extern struct s3c24xx_uart_resources s5pc1xx_uart_resources[];
+
+#include <plat/s5pc100.h>
-- 
1.6.4
