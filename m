From: lost.distance@yahoo.com (Paul Parsons)
Date: Sat, 12 May 2012 12:31:02 +0100
Subject: [PATCH 2/2 v7] ARM: pxa: hx4700: Add Synaptics NavPoint touchpad
Message-ID: <mailman.18.1336822270.1417.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the Synaptics NavPoint touchpad to the hx4700 platform:
1. Change GPIO23_SSP1_SCLK value in hx4700_pin_config[] from an output
to an input, since the NavPoint is connected to SSP in SPI slave mode.
2. Add GPIO102_GPIO (NavPoint power) to hx4700_pin_config[].
3. Add navpoint platform_device to devices[].

Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
Cc: Philipp Zabel <philipp.zabel@gmail.com>
---

V7:
Changed subject line which was duplicated in patch 1/2.
Add GPIO102 to hx4700_pin_config[].
Remove GPIO102 from global_gpios[].
Don't rename GPIO102_HX4700_SYNAPTICS_POWER_ON.
Rebased from linux-3.2 to linux-3.4-rc6.

 arch/arm/mach-pxa/hx4700.c                  |   24 +++++++++++++++++++++++-
 arch/arm/mach-pxa/include/mach/mfp-pxa27x.h |    1 +
 2 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index 6bd692d..2acf66a 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -22,6 +22,7 @@
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
+#include <linux/input/navpoint.h>
 #include <linux/lcd.h>
 #include <linux/mfd/htc-egpio.h>
 #include <linux/mfd/asic3.h>
@@ -117,7 +118,7 @@ static unsigned long hx4700_pin_config[] __initdata = {
 	GPIO113_I2S_SYSCLK,
 
 	/* SSP 1 (NavPoint) */
-	GPIO23_SSP1_SCLK,
+	GPIO23_SSP1_SCLK_IN,
 	GPIO24_SSP1_SFRM,
 	GPIO25_SSP1_TXD,
 	GPIO26_SSP1_RXD,
@@ -133,6 +134,9 @@ static unsigned long hx4700_pin_config[] __initdata = {
 	GPIO13_GPIO,	/* W3220_IRQ */
 	GPIO14_GPIO,	/* nWLAN_IRQ */
 
+	/* HX4700 specific output GPIOs */
+	GPIO102_GPIO | MFP_LPM_DRIVE_LOW,	/* SYNAPTICS_POWER_ON */
+
 	GPIO10_GPIO,	/* GSM_IRQ */
 	GPIO13_GPIO,	/* CPLD_IRQ */
 	GPIO107_GPIO,	/* DS1WM_IRQ */
@@ -187,6 +191,23 @@ static struct platform_device gpio_keys = {
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
 
@@ -833,6 +854,7 @@ static struct platform_device audio = {
 static struct platform_device *devices[] __initdata = {
 	&asic3,
 	&gpio_keys,
+	&navpoint,
 	&backlight,
 	&w3220,
 	&hx4700_lcd,
diff --git a/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h b/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
index a658672..a611ad3 100644
--- a/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
+++ b/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
@@ -208,6 +208,7 @@
 #define GPIO113_I2S_SYSCLK	MFP_CFG_OUT(GPIO113, AF1, DRIVE_LOW)
 
 /* SSP 1 */
+#define GPIO23_SSP1_SCLK_IN	MFP_CFG_IN(GPIO23, AF2)
 #define GPIO23_SSP1_SCLK	MFP_CFG_OUT(GPIO23, AF2, DRIVE_LOW)
 #define GPIO29_SSP1_SCLK	MFP_CFG_IN(GPIO29, AF3)
 #define GPIO27_SSP1_SYSCLK	MFP_CFG_OUT(GPIO27, AF1, DRIVE_LOW)
-- 
1.7.3.4
