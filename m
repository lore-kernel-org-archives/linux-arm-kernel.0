From: javier.martin@vista-silicon.com (Javier Martin)
Date: Wed, 29 Feb 2012 13:17:33 +0100
Subject: [PATCH] i.MX27: visstrim_m10: Add led support.
Message-ID: <1330517853-30870-1-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vista Silicon Visstrim_m10 board has 4
leds to signal several working conditions.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 This patch has to be applied on top of the following series:
   [PATCH 0/4] i.MX27: visstrim_m10: Add several peripherals.

---
 arch/arm/mach-imx/Kconfig                   |    1 +
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |   31 +++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 8102e7f..a3125ac 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -323,6 +323,7 @@ config MACH_IMX27_VISSTRIM_M10
 	select IMX_HAVE_PLATFORM_MX2_CAMERA
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_MMC
+	select LEDS_GPIO_REGISTER
 	help
 	  Include support for Visstrim_m10 platform and its different variants.
 	  This includes specific configurations for the board and its
diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 7208a9e..0a1643c 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -31,6 +31,7 @@
 #include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
+#include <linux/leds.h>
 #include <linux/memblock.h>
 #include <media/soc_camera.h>
 #include <sound/tlv320aic32x4.h>
@@ -232,6 +233,35 @@ static const struct gpio_keys_platform_data
 	.nbuttons	= ARRAY_SIZE(visstrim_gpio_keys),
 };
 
+/* led */
+static const struct gpio_led visstrim_m10_leds[] __initconst = {
+	{
+		.name = "visstrim:ld0",
+		.default_trigger = "nand-disk",
+		.gpio = (GPIO_PORTC + 29),
+	},
+	{
+		.name = "visstrim:ld1",
+		.default_trigger = "nand-disk",
+		.gpio = (GPIO_PORTC + 24),
+	},
+	{
+		.name = "visstrim:ld2",
+		.default_trigger = "nand-disk",
+		.gpio = (GPIO_PORTC + 28),
+	},
+	{
+		.name = "visstrim:ld3",
+		.default_trigger = "nand-disk",
+		.gpio = (GPIO_PORTC + 25),
+	},
+};
+
+static const struct gpio_led_platform_data visstrim_m10_led_data __initconst = {
+	.leds = visstrim_m10_leds,
+	.num_leds = ARRAY_SIZE(visstrim_m10_leds),
+};
+
 /* Visstrim_SM10 has a microSD slot connected to sdhc1 */
 static int visstrim_m10_sdhc1_init(struct device *dev,
 		irq_handler_t detect_irq, void *data)
@@ -365,6 +395,7 @@ static void __init visstrim_m10_board_init(void)
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 	platform_device_register_resndata(NULL, "soc-camera-pdrv", 0, NULL, 0,
 				      &iclink_tvp5150, sizeof(iclink_tvp5150));
+	gpio_led_register_device(0, &visstrim_m10_led_data);
 	visstrim_camera_init();
 }
 
-- 
1.7.0.4
