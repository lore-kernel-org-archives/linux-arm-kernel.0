From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 20 May 2010 08:13:04 +0200
Subject: [PATCH 4/7] ARM: S5PV210: add framebuffer platform helpers for s5pv210
	based machines
In-Reply-To: <1274335987-1141-1-git-send-email-m.szyprowski@samsung.com>
References: <1274335987-1141-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1274335987-1141-5-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds common framebuffer device helpers and register defines
for S5PV210 based machines.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig                   |    5 ++
 arch/arm/mach-s5pv210/Makefile                  |    1 +
 arch/arm/mach-s5pv210/include/mach/irqs.h       |    5 ++
 arch/arm/mach-s5pv210/include/mach/map.h        |    3 +
 arch/arm/mach-s5pv210/include/mach/regs-clock.h |    1 +
 arch/arm/mach-s5pv210/setup-fb-24bpp.c          |   62 +++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/fb.h         |    7 +++
 7 files changed, 84 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pv210/setup-fb-24bpp.c

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 195ac8f..9a05e16 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -17,6 +17,11 @@ config CPU_S5PV210
 	help
 	  Enable S5PV210 CPU support
 
+config S5PV210_SETUP_FB_24BPP
+	bool
+	help
+          Common setup code for S5PV210 with an 24bpp RGB display helper.
+
 config MACH_SMDKV210
 	bool "SMDKV210"
 	select CPU_S5PV210
diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index 8f23acf..f73975d 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -24,3 +24,4 @@ obj-$(CONFIG_MACH_AQUILA)	+= mach-aquila.o
 # device support
 
 obj-y				+= dev-audio.o
+obj-$(CONFIG_S5PV210_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-s5pv210/include/mach/irqs.h
index 69712bb..9689537 100644
--- a/arch/arm/mach-s5pv210/include/mach/irqs.h
+++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
@@ -124,4 +124,9 @@
 /* Set the default NR_IRQS */
 #define NR_IRQS			(IRQ_EINT(31) + 1)
 
+/* Compatibility */
+#define IRQ_LCD_FIFO		IRQ_LCD0
+#define IRQ_LCD_VSYNC		IRQ_LCD1
+#define IRQ_LCD_SYSTEM		IRQ_LCD2
+
 #endif /* ASM_ARCH_IRQS_H */
diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-s5pv210/include/mach/map.h
index 5adcb9f..e6bb12c 100644
--- a/arch/arm/mach-s5pv210/include/mach/map.h
+++ b/arch/arm/mach-s5pv210/include/mach/map.h
@@ -47,6 +47,8 @@
 #define S5PV210_PA_PDMA0	0xE0900000
 #define S5PV210_PA_PDMA1	0xE0A00000
 
+#define S5PV210_PA_FB		(0xF8000000)
+
 #define S5PV210_PA_VIC0		(0xF2000000)
 #define S5P_PA_VIC0		S5PV210_PA_VIC0
 
@@ -78,5 +80,6 @@
 /* compatibiltiy defines. */
 #define S3C_PA_UART		S5PV210_PA_UART
 #define S3C_PA_IIC		S5PV210_PA_IIC0
+#define S3C_PA_FB		S5PV210_PA_FB
 
 #endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-s5pv210/include/mach/regs-clock.h b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
index 40dd24f..0a3d7ad 100644
--- a/arch/arm/mach-s5pv210/include/mach/regs-clock.h
+++ b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
@@ -128,6 +128,7 @@
 
 #define S5P_RST_STAT		S5P_CLKREG(0xA000)
 #define S5P_OSC_CON		S5P_CLKREG(0x8000)
+#define S5P_MDNIE_SEL		S5P_CLKREG(0x7008)
 #define S5P_MIPI_PHY_CON0	S5P_CLKREG(0x7200)
 #define S5P_MIPI_PHY_CON1	S5P_CLKREG(0x7204)
 #define S5P_MIPI_CONTROL	S5P_CLKREG(0xE814)
diff --git a/arch/arm/mach-s5pv210/setup-fb-24bpp.c b/arch/arm/mach-s5pv210/setup-fb-24bpp.c
new file mode 100644
index 0000000..a50cbac
--- /dev/null
+++ b/arch/arm/mach-s5pv210/setup-fb-24bpp.c
@@ -0,0 +1,62 @@
+/* linux/arch/arm/plat-s5pv210/setup-fb-24bpp.c
+ *
+ * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * Base s5pv210 setup information for 24bpp LCD framebuffer
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/fb.h>
+
+#include <mach/regs-fb.h>
+#include <mach/gpio.h>
+#include <mach/map.h>
+#include <plat/fb.h>
+#include <mach/regs-clock.h>
+#include <plat/gpio-cfg.h>
+
+void s5pv210_fb_gpio_setup_24bpp(void)
+{
+	unsigned int gpio = 0;
+
+	for (gpio = S5PV210_GPF0(0); gpio <= S5PV210_GPF0(7); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
+	}
+
+	for (gpio = S5PV210_GPF1(0); gpio <= S5PV210_GPF1(7); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
+	}
+
+	for (gpio = S5PV210_GPF2(0); gpio <= S5PV210_GPF2(7); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
+	}
+
+	for (gpio = S5PV210_GPF3(0); gpio <= S5PV210_GPF3(3); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
+	}
+
+	/* Set DISPLAY_CONTROL register for Display path selection.
+	 *
+	 * ouput   |   RGB   |   I80   |   ITU
+	 * -----------------------------------
+	 *  00     |   MIE   |  FIMD   |  FIMD
+	 *  01     | MDNIE   | MDNIE   |  FIMD
+	 *  10     |  FIMD   |  FIMD   |  FIMD
+	 *  11     |  FIMD   |  FIMD   |  FIMD
+	 */
+	writel(0x2, S5P_MDNIE_SEL);
+}
diff --git a/arch/arm/plat-samsung/include/plat/fb.h b/arch/arm/plat-samsung/include/plat/fb.h
index 1f85649..27d3b49 100644
--- a/arch/arm/plat-samsung/include/plat/fb.h
+++ b/arch/arm/plat-samsung/include/plat/fb.h
@@ -84,4 +84,11 @@ extern void s3c64xx_fb_gpio_setup_24bpp(void);
  */
 extern void s5pc100_fb_gpio_setup_24bpp(void);
 
+/**
+ * s5pv210_fb_gpio_setup_24bpp() - S5PV210/S5PC110 setup function for 24bpp LCD
+ *
+ * Initialise the GPIO for an 24bpp LCD display on the RGB interface.
+ */
+extern void s5pv210_fb_gpio_setup_24bpp(void);
+
 #endif /* __PLAT_S3C_FB_H */
-- 
1.6.4
