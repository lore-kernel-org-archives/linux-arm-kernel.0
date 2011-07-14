From: tanmay.upadhyay@einfochips.com (Tanmay Upadhyay)
Date: Thu, 14 Jul 2011 15:07:15 +0530
Subject: [PATCH 1/2] ARM: pxa168: gplugD: Get rid of mfp-gplugd.h
In-Reply-To: <no>
References: <no>
Message-ID: <1310636236-3104-1-git-send-email-tanmay.upadhyay@einfochips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move definitions from mfp-gplugd.h to mfp-pxa168.h as they aren't
gplugD specific.

Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
---
 arch/arm/mach-mmp/gplugd.c                  |   18 +++++++---
 arch/arm/mach-mmp/include/mach/mfp-gplugd.h |   52 ---------------------------
 arch/arm/mach-mmp/include/mach/mfp-pxa168.h |   37 ++++++++++++++++---
 3 files changed, 45 insertions(+), 62 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/include/mach/mfp-gplugd.h

diff --git a/arch/arm/mach-mmp/gplugd.c b/arch/arm/mach-mmp/gplugd.c
index c070c24..0770e51 100644
--- a/arch/arm/mach-mmp/gplugd.c
+++ b/arch/arm/mach-mmp/gplugd.c
@@ -16,16 +16,18 @@
 #include <mach/gpio.h>
 #include <mach/pxa168.h>
 #include <mach/mfp-pxa168.h>
-#include <mach/mfp-gplugd.h>
 
 #include "common.h"
 
 static unsigned long gplugd_pin_config[] __initdata = {
 	/* UART3 */
-	GPIO8_UART3_SOUT,
-	GPIO9_UART3_SIN,
-	GPI1O_UART3_CTS,
-	GPI11_UART3_RTS,
+	GPIO8_UART3_TXD,
+	GPIO9_UART3_RXD,
+	GPIO1O_UART3_CTS,
+	GPIO11_UART3_RTS,
+
+	/* USB OTG PEN */
+	GPIO18_GPIO,
 
 	/* MMC2 */
 	GPIO28_MMC2_CMD,
@@ -109,6 +111,12 @@ static unsigned long gplugd_pin_config[] __initdata = {
 	GPIO105_CI2C_SDA,
 	GPIO106_CI2C_SCL,
 
+	/* SPI NOR Flash on SSP2 */
+	GPIO107_SSP2_RXD,
+	GPIO108_SSP2_TXD,
+	GPIO110_GPIO,     /* SPI_CSn */
+	GPIO111_SSP2_CLK,
+
 	/* Select JTAG */
 	GPIO109_GPIO,
 
diff --git a/arch/arm/mach-mmp/include/mach/mfp-gplugd.h b/arch/arm/mach-mmp/include/mach/mfp-gplugd.h
deleted file mode 100644
index b8cf38d..0000000
--- a/arch/arm/mach-mmp/include/mach/mfp-gplugd.h
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * linux/arch/arm/mach-mmp/include/mach/mfp-gplugd.h
- *
- *   MFP definitions used in gplugD
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __MACH_MFP_GPLUGD_H
-#define __MACH_MFP_GPLUGD_H
-
-#include <plat/mfp.h>
-#include <mach/mfp.h>
-
-/* UART3 */
-#define GPIO8_UART3_SOUT       MFP_CFG(GPIO8, AF2)
-#define GPIO9_UART3_SIN        MFP_CFG(GPIO9, AF2)
-#define GPI1O_UART3_CTS        MFP_CFG(GPIO10, AF2)
-#define GPI11_UART3_RTS        MFP_CFG(GPIO11, AF2)
-
-/* MMC2 */
-#define	GPIO28_MMC2_CMD		MFP_CFG_DRV(GPIO28, AF6, FAST)
-#define	GPIO29_MMC2_CLK		MFP_CFG_DRV(GPIO29, AF6, FAST)
-#define	GPIO30_MMC2_DAT0	MFP_CFG_DRV(GPIO30, AF6, FAST)
-#define	GPIO31_MMC2_DAT1	MFP_CFG_DRV(GPIO31, AF6, FAST)
-#define	GPIO32_MMC2_DAT2	MFP_CFG_DRV(GPIO32, AF6, FAST)
-#define	GPIO33_MMC2_DAT3	MFP_CFG_DRV(GPIO33, AF6, FAST)
-
-/* I2S */
-#undef GPIO114_I2S_FRM
-#undef GPIO115_I2S_BCLK
-
-#define GPIO114_I2S_FRM	        MFP_CFG_DRV(GPIO114, AF1, FAST)
-#define GPIO115_I2S_BCLK        MFP_CFG_DRV(GPIO115, AF1, FAST)
-#define GPIO116_I2S_TXD         MFP_CFG_DRV(GPIO116, AF1, FAST)
-
-/* MMC4 */
-#define GPIO125_MMC4_DAT3       MFP_CFG_DRV(GPIO125, AF7, FAST)
-#define GPIO126_MMC4_DAT2       MFP_CFG_DRV(GPIO126, AF7, FAST)
-#define GPIO127_MMC4_DAT1       MFP_CFG_DRV(GPIO127, AF7, FAST)
-#define GPIO0_2_MMC4_DAT0       MFP_CFG_DRV(GPIO0_2, AF7, FAST)
-#define GPIO1_2_MMC4_CMD        MFP_CFG_DRV(GPIO1_2, AF7, FAST)
-#define GPIO2_2_MMC4_CLK        MFP_CFG_DRV(GPIO2_2, AF7, FAST)
-
-/* OTG GPIO */
-#define GPIO_USB_OTG_PEN        18
-#define GPIO_USB_OIDIR          20
-
-/* Other GPIOs are 35, 84, 85 */
-#endif /* __MACH_MFP_GPLUGD_H */
diff --git a/arch/arm/mach-mmp/include/mach/mfp-pxa168.h b/arch/arm/mach-mmp/include/mach/mfp-pxa168.h
index 8c78232..92aaa3c 100644
--- a/arch/arm/mach-mmp/include/mach/mfp-pxa168.h
+++ b/arch/arm/mach-mmp/include/mach/mfp-pxa168.h
@@ -203,6 +203,10 @@
 #define GPIO33_CF_nCD2		MFP_CFG(GPIO33, AF3)
 
 /* UART */
+#define GPIO8_UART3_TXD		MFP_CFG(GPIO8, AF2)
+#define GPIO9_UART3_RXD		MFP_CFG(GPIO9, AF2)
+#define GPIO1O_UART3_CTS	MFP_CFG(GPIO10, AF2)
+#define GPIO11_UART3_RTS	MFP_CFG(GPIO11, AF2)
 #define GPIO88_UART2_TXD	MFP_CFG(GPIO88, AF2)
 #define GPIO89_UART2_RXD	MFP_CFG(GPIO89, AF2)
 #define GPIO107_UART1_TXD	MFP_CFG_DRV(GPIO107, AF1, FAST)
@@ -232,6 +236,22 @@
 #define GPIO53_MMC1_CD		MFP_CFG(GPIO53, AF1)
 #define GPIO46_MMC1_WP		MFP_CFG(GPIO46, AF1)
 
+/* MMC2 */
+#define	GPIO28_MMC2_CMD		MFP_CFG_DRV(GPIO28, AF6, FAST)
+#define	GPIO29_MMC2_CLK		MFP_CFG_DRV(GPIO29, AF6, FAST)
+#define	GPIO30_MMC2_DAT0	MFP_CFG_DRV(GPIO30, AF6, FAST)
+#define	GPIO31_MMC2_DAT1	MFP_CFG_DRV(GPIO31, AF6, FAST)
+#define	GPIO32_MMC2_DAT2	MFP_CFG_DRV(GPIO32, AF6, FAST)
+#define	GPIO33_MMC2_DAT3	MFP_CFG_DRV(GPIO33, AF6, FAST)
+
+/* MMC4 */
+#define GPIO125_MMC4_DAT3       MFP_CFG_DRV(GPIO125, AF7, FAST)
+#define GPIO126_MMC4_DAT2       MFP_CFG_DRV(GPIO126, AF7, FAST)
+#define GPIO127_MMC4_DAT1       MFP_CFG_DRV(GPIO127, AF7, FAST)
+#define GPIO0_2_MMC4_DAT0       MFP_CFG_DRV(GPIO0_2, AF7, FAST)
+#define GPIO1_2_MMC4_CMD        MFP_CFG_DRV(GPIO1_2, AF7, FAST)
+#define GPIO2_2_MMC4_CLK        MFP_CFG_DRV(GPIO2_2, AF7, FAST)
+
 /* LCD */
 #define GPIO84_LCD_CS		MFP_CFG(GPIO84, AF1)
 #define GPIO60_LCD_DD0		MFP_CFG(GPIO60, AF1)
@@ -269,11 +289,12 @@
 #define GPIO106_CI2C_SCL	MFP_CFG(GPIO106, AF1)
 
 /* I2S */
-#define GPIO113_I2S_MCLK	MFP_CFG(GPIO113,AF6)
-#define GPIO114_I2S_FRM		MFP_CFG(GPIO114,AF1)
-#define GPIO115_I2S_BCLK	MFP_CFG(GPIO115,AF1)
-#define GPIO116_I2S_RXD		MFP_CFG(GPIO116,AF2)
-#define GPIO117_I2S_TXD		MFP_CFG(GPIO117,AF2)
+#define GPIO113_I2S_MCLK	MFP_CFG(GPIO113, AF6)
+#define GPIO114_I2S_FRM		MFP_CFG(GPIO114, AF1)
+#define GPIO115_I2S_BCLK	MFP_CFG(GPIO115, AF1)
+#define GPIO116_I2S_RXD		MFP_CFG(GPIO116, AF2)
+#define GPIO116_I2S_TXD         MFP_CFG(GPIO116, AF1)
+#define GPIO117_I2S_TXD		MFP_CFG(GPIO117, AF2)
 
 /* PWM */
 #define GPIO96_PWM3_OUT		MFP_CFG(GPIO96, AF1)
@@ -324,4 +345,10 @@
 #define GPIO101_MII_MDIO	MFP_CFG(GPIO101, AF5)
 #define GPIO103_RX_DV		MFP_CFG(GPIO103, AF5)
 
+/* SSP2 */
+#define GPIO107_SSP2_RXD	MFP_CFG(GPIO107, AF4)
+#define GPIO108_SSP2_TXD	MFP_CFG(GPIO108, AF4)
+#define GPIO111_SSP2_CLK	MFP_CFG(GPIO111, AF4)
+#define GPIO112_SSP2_FRM	MFP_CFG(GPIO112, AF4)
+
 #endif /* __ASM_MACH_MFP_PXA168_H */
-- 
1.7.0.4
