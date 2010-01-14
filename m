From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 14 Jan 2010 12:29:37 +0100
Subject: [PATCH 19/21] ARM: S5PC1XX: add framebuffer platform helpers for
	s5pc110 sub-platform
In-Reply-To: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
References: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1263468579-5732-20-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pawel Osciak <p.osciak@samsung.com>

Samsung S5PC110 SoC are newer Samsung SoCs. Like S5PC100 they are based
on CortexA8 ARM CPU, but have much more powerfull integrated periperals.
This patch adds common framebuffer device helpers and register defines
for S5PC110 sub-platform.

Signed-off-by: Pawel Osciak <p.osciak@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-s5pc110/Kconfig                |    5 ++
 arch/arm/mach-s5pc110/Makefile               |    1 +
 arch/arm/mach-s5pc110/include/mach/regs-fb.h |   91 ++++++++++++++++++++++++++
 arch/arm/mach-s5pc110/setup-fb-24bpp.c       |   67 +++++++++++++++++++
 arch/arm/plat-s3c/include/plat/fb.h          |    7 ++
 5 files changed, 171 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pc110/include/mach/regs-fb.h
 create mode 100644 arch/arm/mach-s5pc110/setup-fb-24bpp.c

diff --git a/arch/arm/mach-s5pc110/Kconfig b/arch/arm/mach-s5pc110/Kconfig
index 0e13f54..ef2f940 100644
--- a/arch/arm/mach-s5pc110/Kconfig
+++ b/arch/arm/mach-s5pc110/Kconfig
@@ -14,6 +14,11 @@ config CPU_S5PC110
 	help
 	  Enable S5PC110 CPU support
 
+config S5PC110_SETUP_FB_24BPP
+	bool
+	help
+          Common setup code for S5PC110 with an 24bpp RGB display helper.
+
 config S5PC110_SETUP_I2C0
 	bool
 	default y
diff --git a/arch/arm/mach-s5pc110/Makefile b/arch/arm/mach-s5pc110/Makefile
index cf8f4ef..d7e03b6 100644
--- a/arch/arm/mach-s5pc110/Makefile
+++ b/arch/arm/mach-s5pc110/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_CPU_S5PC110)	+= plls.o
 obj-$(CONFIG_CPU_S5PC110)	+= uarts.o
 
 # Helper and device support
+obj-$(CONFIG_S5PC110_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
 obj-$(CONFIG_S5PC110_SETUP_I2C0)	+= setup-i2c0.o
 obj-$(CONFIG_S5PC110_SETUP_I2C1)	+= setup-i2c1.o
 obj-$(CONFIG_S5PC110_SETUP_I2C2)	+= setup-i2c2.o
diff --git a/arch/arm/mach-s5pc110/include/mach/regs-fb.h b/arch/arm/mach-s5pc110/include/mach/regs-fb.h
new file mode 100644
index 0000000..27fa497
--- /dev/null
+++ b/arch/arm/mach-s5pc110/include/mach/regs-fb.h
@@ -0,0 +1,91 @@
+/*
+ * Copyright 2009 Samsung Electronics Co.
+ *   Pawel Osciak <p.osciak@samsung.com>
+ *
+ * Machine-specific framebuffer definitions for Samsung S5PC110.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_ARCH_MACH_REGS_FB_H
+#define __ASM_ARCH_MACH_REGS_FB_H __FILE__
+
+#include <plat/regs-fb-v5.h>
+
+/* WINCONx */
+#define WINCONx_BUFSTATUS_H				(1 << 31)
+#define WINCONx_BUFSEL_H				(1 << 30)
+#define WINCONx_LIMIT_ON				(1 << 29)
+#define WINCONx_EQ709					(1 << 28)
+
+
+/* VIDCON3 */
+#define VIDCON3						(0x0c)
+#define VIDCON3_VE_ON					(1 << 20)
+#define VIDCON3_CG_ON					(1 << 18)
+#define VIDCON3_GM_ON					(1 << 16)
+#define VIDCON3_HU_CSC_F_NARROW				(1 << 14)
+#define VIDCON3_HU_CSC_F_EQ709				(1 << 13)
+#define VIDCON3_HU_CSC_F_EN				(1 << 12)
+#define VIDCON3_HU_CSC_B_NARROW				(1 << 10)
+#define VIDCON3_HU_CSC_B_EQ709				(1 << 9)
+#define VIDCON3_HU_CSC_B_EN				(1 << 8)
+#define VIDCON3_HUE_EN					(1 << 7)
+#define VIDCON3_PC_DIR_NEG				(1 << 1)
+#define VIDCON3_PC_EN					(1 << 0)
+
+
+/* VIDTCON3 */
+#define VIDTCON3					(0x1c)
+#define VIDTCON3_VSYNC_EN				(1 << 31)
+#define VIDTCON3_FRM_EN					(1 << 29)
+#define VIDTCON3_INVFRM_LOW				(1 << 28)
+#define VIDTCON3_FRMVRATE_MASK				0xf
+#define VIDTCON3_FRMVRATE_SHIFT				(24)
+#define VIDTCON3_FRMVFPD_MASK				0xff
+#define VIDTCON3_FRMVFPD_SHIFT				(8)
+#define VIDTCON3_FRMVSPW_MASK				0xff
+#define VIDTCON3_FRMVSPW_SHIFT				(0)
+
+
+#define SHADOWCON					(0x34)
+/* Set to disable window 4-0 shadow registers' update */
+#define SHADOWCON_W4_PROTECT				(1 << 14)
+#define SHADOWCON_W3_PROTECT				(1 << 13)
+#define SHADOWCON_W2_PROTECT				(1 << 12)
+#define SHADOWCON_W1_PROTECT				(1 << 11)
+#define SHADOWCON_W0_PROTECT				(1 << 10)
+
+
+/* Video buffer address shadow registers (read-only) */
+#define VIDW_BUF_START_SHADOW(_buf)			(0x20a0 + ((_buf) * 8))
+#define VIDW_BUF_END_SHADOW(_buf)			(0x20d0 + ((_buf) * 8))
+
+/* For windows 1-4 */
+#define WxKEY_ALPHA(_win)				(0x160 + ((_win) * 4))
+
+#define COLORGAINCON					(0x1c0)
+#define VESFRCON0					(0x1c4)
+#define VESFRCON1					(0x1c8)
+#define VESFRCON2					(0x1cc)
+
+/* Hue matrix coefficients */
+#define HUECOEF00					(0x1ec)
+#define HUECOEF01					(0x1f0)
+#define HUECOEF10					(0x1f4)
+#define HUECOEF11					(0x1f8)
+#define HUEOFFSET					(0x1fc)
+
+/* RTQOS control for windows 0-4*/
+#define WxRTQOSCON(_win)				(0x264 + ((_win) * 4))
+
+/* Gamma LUT data for index I1 and I0, where
+ * I0 = _index, I1 = _index + 1.
+ */
+#define GAMMALUT_BASE					(0x37c)
+#define GAMMALUT_I1I0(_index)			(GAMMALUT_BASE + ((_index) * 4))
+
+#endif /* __ASM_ARCH_MACH_REGS_FB_H */
+
diff --git a/arch/arm/mach-s5pc110/setup-fb-24bpp.c b/arch/arm/mach-s5pc110/setup-fb-24bpp.c
new file mode 100644
index 0000000..993504e
--- /dev/null
+++ b/arch/arm/mach-s5pc110/setup-fb-24bpp.c
@@ -0,0 +1,67 @@
+/*
+ * linux/arch/arm/plat-s5pc100/setup-fb-24bpp.c
+ *
+ * Copyright 2009 Samsung Electronics
+ *
+ * Base S5PC110 setup information for 24bpp LCD framebuffer
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
+#include <plat/regs-clock.h>
+#include <plat/gpio-cfg.h>
+#include <plat/gpio-cfg-s5pc1xx.h>
+
+void s5pc110_fb_gpio_setup_24bpp(void)
+{
+	unsigned int gpio = 0;
+
+	for (gpio = S5PC110_GPF0(0); gpio <= S5PC110_GPF0(7); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		s5p_gpio_set_drvstr(gpio, gpio-S5PC110_GPF0(0),
+				    S5P_GPIO_DRVSTR_LV4);
+	}
+
+	for (gpio = S5PC110_GPF1(0); gpio <= S5PC110_GPF1(7); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		s5p_gpio_set_drvstr(gpio, gpio-S5PC110_GPF1(0),
+				    S5P_GPIO_DRVSTR_LV4);
+	}
+
+	for (gpio = S5PC110_GPF2(0); gpio <= S5PC110_GPF2(7); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		s5p_gpio_set_drvstr(gpio, gpio-S5PC110_GPF2(0),
+				    S5P_GPIO_DRVSTR_LV4);
+	}
+
+	for (gpio = S5PC110_GPF3(0); gpio <= S5PC110_GPF3(3); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		s5p_gpio_set_drvstr(gpio, gpio-S5PC110_GPF3(0),
+				    S5P_GPIO_DRVSTR_LV4);
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
+	writel(0x2, S5PC110_MDNIE_SEL);
+}
diff --git a/arch/arm/plat-s3c/include/plat/fb.h b/arch/arm/plat-s3c/include/plat/fb.h
index f8db879..ee5cdd0 100644
--- a/arch/arm/plat-s3c/include/plat/fb.h
+++ b/arch/arm/plat-s3c/include/plat/fb.h
@@ -77,4 +77,11 @@ extern void s3c64xx_fb_gpio_setup_24bpp(void);
  */
 extern void s5pc100_fb_gpio_setup_24bpp(void);
 
+/**
+ * s5pc110_fb_gpio_setup_24bpp() - S5PC110 setup function for 24bpp LCD
+ *
+ * Initialise the GPIO for an 24bpp LCD display on the RGB interface.
+ */
+extern void s5pc110_fb_gpio_setup_24bpp(void);
+
 #endif /* __PLAT_S3C_FB_H */
-- 
1.6.4
