From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 29 Nov 2011 13:30:30 +0000
Subject: [PATCH 6/7] ARM: S3C64XX: Hook up platform data for Kilchomin module
 on Cragganmore
In-Reply-To: <1322573431-8923-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20111129133006.GA26800@opensource.wolfsonmicro.com>
 <1322573431-8923-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1322573431-8923-6-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the WM5100 driver is merged add some initial platform data for
the WM5100 on Kilchomin.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410-module.c |   30 ++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
index 6387ced..c492f75 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
@@ -15,12 +15,41 @@
 #include <linux/mfd/wm831x/irq.h>
 #include <linux/mfd/wm831x/gpio.h>
 
+#include <sound/wm5100.h>
 #include <sound/wm8996.h>
 #include <sound/wm8962.h>
 #include <sound/wm9081.h>
 
 #include <mach/crag6410.h>
 
+static struct wm5100_pdata wm5100_pdata = {
+	.ldo_ena = S3C64XX_GPN(7),
+	.irq_flags = IRQF_TRIGGER_HIGH,
+	.gpio_base = CODEC_GPIO_BASE,
+
+	.in_mode = {
+		WM5100_IN_DIFF,
+		WM5100_IN_DIFF,
+		WM5100_IN_DIFF,
+		WM5100_IN_SE,
+	},
+
+	.hp_pol = CODEC_GPIO_BASE + 3,
+	.jack_modes = {
+		{ WM5100_MICDET_MICBIAS3, 0, 0 },
+		{ WM5100_MICDET_MICBIAS2, 1, 1 },
+	},
+
+	.gpio_defaults = {
+		0,
+		0,
+		0,
+		0,
+		0x2, /* IRQ: CMOS output */
+		0x3, /* CLKOUT: CMOS output */
+	},
+};
+
 static struct wm8996_retune_mobile_config wm8996_retune[] = {
 	{
 		.name = "Sub LPF",
@@ -90,6 +119,7 @@ static const struct i2c_board_info wm1254_devs[] = {
 
 static const struct i2c_board_info wm1255_devs[] = {
 	{ I2C_BOARD_INFO("wm5100", 0x1a),
+	  .platform_data = &wm5100_pdata,
 	  .irq = GLENFARCLAS_PMIC_IRQ_BASE + WM831X_IRQ_GPIO_2,
 	},
 	{ I2C_BOARD_INFO("wm9081", 0x6c),
-- 
1.7.7.3
