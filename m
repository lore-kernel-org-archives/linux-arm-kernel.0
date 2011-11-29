From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 29 Nov 2011 13:30:31 +0000
Subject: [PATCH 7/7] ARM: S3C64XX: Hook up Littlemill audio card on Cragganmore
In-Reply-To: <1322573431-8923-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20111129133006.GA26800@opensource.wolfsonmicro.com>
 <1322573431-8923-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1322573431-8923-7-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Littlemill audio card is an adaptor card which can take any 6220-EV1
CODEC daughtercard. Provide standard support for the use of WM8994 class
devices on the Littlemill card, configuring the MFD for WM8958 usage as
this part is a superset of all others and the driver will use runtime
detection to identify the actually fitted part given the configuration for
the superset.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/include/mach/crag6410.h |    6 ++++--
 arch/arm/mach-s3c64xx/include/mach/irqs.h     |    2 +-
 arch/arm/mach-s3c64xx/mach-crag6410-module.c  |   21 +++++++++++++++++++++
 arch/arm/mach-s3c64xx/mach-crag6410.c         |    6 ++++++
 4 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/include/mach/crag6410.h b/arch/arm/mach-s3c64xx/include/mach/crag6410.h
index be9074e..5d55ab0 100644
--- a/arch/arm/mach-s3c64xx/include/mach/crag6410.h
+++ b/arch/arm/mach-s3c64xx/include/mach/crag6410.h
@@ -15,9 +15,11 @@
 
 #define BANFF_PMIC_IRQ_BASE		IRQ_BOARD_START
 #define GLENFARCLAS_PMIC_IRQ_BASE	(IRQ_BOARD_START + 64)
+#define CODEC_IRQ_BASE			(IRQ_BOARD_START + 128)
 
 #define PCA935X_GPIO_BASE		GPIO_BOARD_START
-#define CODEC_GPIO_BASE		(GPIO_BOARD_START + 8)
-#define GLENFARCLAS_PMIC_GPIO_BASE	(GPIO_BOARD_START + 16)
+#define CODEC_GPIO_BASE			(GPIO_BOARD_START + 8)
+#define GLENFARCLAS_PMIC_GPIO_BASE	(GPIO_BOARD_START + 32)
+#define BANFF_PMIC_GPIO_BASE		(GPIO_BOARD_START + 64)
 
 #endif
diff --git a/arch/arm/mach-s3c64xx/include/mach/irqs.h b/arch/arm/mach-s3c64xx/include/mach/irqs.h
index 443f85b..96d60e0 100644
--- a/arch/arm/mach-s3c64xx/include/mach/irqs.h
+++ b/arch/arm/mach-s3c64xx/include/mach/irqs.h
@@ -169,7 +169,7 @@
 #define IRQ_BOARD_START (IRQ_EINT_GROUP9_BASE + IRQ_EINT_GROUP9_NR + 1)
 
 #ifdef CONFIG_MACH_WLF_CRAGG_6410
-#define IRQ_BOARD_NR 128
+#define IRQ_BOARD_NR 160
 #elif defined(CONFIG_SMDK6410_WM1190_EV1)
 #define IRQ_BOARD_NR 64
 #elif defined(CONFIG_SMDK6410_WM1192_EV1)
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
index c492f75..3fa7ebc 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
@@ -14,6 +14,7 @@
 
 #include <linux/mfd/wm831x/irq.h>
 #include <linux/mfd/wm831x/gpio.h>
+#include <linux/mfd/wm8994/pdata.h>
 
 #include <sound/wm5100.h>
 #include <sound/wm8996.h>
@@ -133,6 +134,24 @@ static const struct i2c_board_info wm1259_devs[] = {
 	},
 };
 
+static struct wm8994_pdata wm8994_pdata = {
+	.gpio_base = CODEC_GPIO_BASE,
+	.gpio_defaults = {
+		0x3,          /* IRQ out, active high, CMOS */
+	},
+	.irq_base = CODEC_IRQ_BASE,
+	.ldo = {
+		{ .supply = "WALLVDD" },
+		{ .supply = "WALLVDD" },
+	},
+};
+
+static const struct i2c_board_info wm1277_devs[] = {
+	{ I2C_BOARD_INFO("wm8958", 0x1a),  /* WM8958 is the superset */
+	  .platform_data = &wm8994_pdata,
+	  .irq = GLENFARCLAS_PMIC_IRQ_BASE + WM831X_IRQ_GPIO_2,
+	},
+};
 
 static __devinitdata const struct {
 	u8 id;
@@ -154,6 +173,8 @@ static __devinitdata const struct {
 	{ .id = 0x3b, .name = "1255-EV1 Kilchoman",
 	  .i2c_devs = wm1255_devs, .num_i2c_devs = ARRAY_SIZE(wm1255_devs) },
 	{ .id = 0x3c, .name = "1273-EV1 Longmorn" },
+	{ .id = 0x3d, .name = "1277-EV1 Littlemill",
+	  .i2c_devs = wm1277_devs, .num_i2c_devs = ARRAY_SIZE(wm1277_devs) },
 };
 
 static __devinit int wlf_gf_module_probe(struct i2c_client *i2c,
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 05f598f..ac9514a 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -289,6 +289,11 @@ static struct platform_device speyside_wm8962_device = {
 	.id		= -1,
 };
 
+static struct platform_device littlemill_device = {
+	.name		= "littlemill",
+	.id		= -1,
+};
+
 static struct regulator_consumer_supply wallvdd_consumers[] = {
 	REGULATOR_SUPPLY("SPKVDD1", "1-001a"),
 	REGULATOR_SUPPLY("SPKVDD2", "1-001a"),
@@ -341,6 +346,7 @@ static struct platform_device *crag6410_devices[] __initdata = {
 	&crag6410_backlight_device,
 	&speyside_device,
 	&speyside_wm8962_device,
+	&littlemill_device,
 	&lowland_device,
 	&wallvdd_device,
 };
-- 
1.7.7.3
