From: nobuhiro.iwamatsu.yj@renesas.com (Nobuhiro Iwamatsu)
Date: Thu, 13 Sep 2012 12:10:41 +0900
Subject: [PATCH] ARM: shmobile: armadillo800eva: Add support RTC
Message-ID: <1347505841-8594-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The armadillo800eva has S35390A which is RTC. This is controlled
using I2C of GPIO.
This commit supports RTC of armadillo800eva.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |   25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index cf10f92..81dfb88 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -37,6 +37,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
+#include <linux/i2c-gpio.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/r8a7740.h>
@@ -876,6 +877,21 @@ static struct platform_device fsi_hdmi_device = {
 	},
 };
 
+/* RTC: RTC connects i2c-gpio. */
+static struct i2c_gpio_platform_data i2c_gpio_data = {
+	.sda_pin	= GPIO_PORT208,
+	.scl_pin	= GPIO_PORT91,
+	.udelay		= 5, /* 100 kHz */
+};
+
+static struct platform_device i2c_gpio_device = {
+	.name = "i2c-gpio",
+	.id = 2,
+	.dev = {
+		.platform_data = &i2c_gpio_data,
+	},
+};
+
 /* I2C */
 static struct i2c_board_info i2c0_devices[] = {
 	{
@@ -887,6 +903,13 @@ static struct i2c_board_info i2c0_devices[] = {
 	},
 };
 
+static struct i2c_board_info i2c2_devices[] = {
+	{
+		I2C_BOARD_INFO("s35390a", 0x30),
+		.type = "s35390a",
+	},
+};
+
 /*
  * board devices
  */
@@ -903,6 +926,7 @@ static struct platform_device *eva_devices[] __initdata = {
 	&fsi_device,
 	&fsi_hdmi_device,
 	&fsi_wm8978_device,
+	&i2c_gpio_device,
 };
 
 static void __init eva_clock_init(void)
@@ -1173,6 +1197,7 @@ static void __init eva_init(void)
 #endif
 
 	i2c_register_board_info(0, i2c0_devices, ARRAY_SIZE(i2c0_devices));
+	i2c_register_board_info(2, i2c2_devices, ARRAY_SIZE(i2c2_devices));
 
 	r8a7740_add_standard_devices();
 
-- 
1.7.10.4
