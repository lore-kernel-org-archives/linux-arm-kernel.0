From: lost.distance@yahoo.com (Paul Parsons)
Date: Thu, 11 Aug 2011 16:26:21 +0000
Subject: [PATCH v2 1/2] pxa/hx4700: Add Synaptics NavPoint (PXA27x SSP/SPI)
	driver
Message-ID: <E1QrY5P-0000yE-H1@outmx01.plus.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the Synaptics NavPoint connected to a PXA27x SSP port in SPI
slave mode. The driver implements a simple navigation pad. The four raised dots
are mapped to UP/DOWN/LEFT/RIGHT buttons and the centre of the touchpad is
mapped to the ENTER button.

Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
---

V2: Split into 2 parts for hx4700 specific code and navpoint driver. Added
GPIO23_SSP1_SCLK_IN and GPIO102_NAVPOINT_PWR to mfp-pxa27x.h. Replaced power
on/off callback with gpio number. Added msleep() to SSP port ready loop.

diff -uprN clean-3.0.1/arch/arm/mach-pxa/hx4700.c linux-3.0.1/arch/arm/mach-pxa/hx4700.c
--- clean-3.0.1/arch/arm/mach-pxa/hx4700.c	2011-08-05 05:59:21.000000000 +0100
+++ linux-3.0.1/arch/arm/mach-pxa/hx4700.c	2011-08-11 16:49:42.900736676 +0100
@@ -22,6 +22,7 @@
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
+#include <linux/input/navpoint.h>
 #include <linux/lcd.h>
 #include <linux/mfd/htc-egpio.h>
 #include <linux/mfd/asic3.h>
@@ -111,10 +112,11 @@ static unsigned long hx4700_pin_config[]
 	GPIO113_I2S_SYSCLK,
 
 	/* SSP 1 (NavPoint) */
-	GPIO23_SSP1_SCLK,
+	GPIO23_SSP1_SCLK_IN,
 	GPIO24_SSP1_SFRM,
 	GPIO25_SSP1_TXD,
 	GPIO26_SSP1_RXD,
+	GPIO102_NAVPOINT_PWR,
 
 	/* SSP 2 (TSC2046) */
 	GPIO19_SSP2_SCLK,
@@ -217,6 +219,23 @@ static struct platform_device gpio_keys
 };
 
 /*
+ * Synaptics NavPoint connected to SSP1
+ */
+
+static struct navpoint_platform_data navpoint_platform_data = {
+	.port	= 1,
+	.gpio	= GPIO102_HX4700_SYNAPTICS_POWER_ON,
+};
+
+static struct platform_device navpoint = {
+	.name	= "navpoint",
+	.id	= -1,
+	.dev = {
+		.platform_data = &navpoint_platform_data,
+	},
+};
+
+/*
  * ASIC3
  */
 
@@ -818,6 +837,7 @@ static struct platform_device pcmcia = {
 static struct platform_device *devices[] __initdata = {
 	&asic3,
 	&gpio_keys,
+	&navpoint,
 	&backlight,
 	&w3220,
 	&hx4700_lcd,
