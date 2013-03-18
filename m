From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:59:29 +0900
Subject: [PATCH 02/13] ARM: shmobile: switch SDHI0 to GPIO regulator on
 armadillo800eva
In-Reply-To: <1363607980-22153-1-git-send-email-horms+renesas@verge.net.au>
References: <1363607980-22153-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363607980-22153-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

When regulators are used with MMC devices, explicitly provided OCR masks
are ignored, they can be removed from platform data. Also switch SDHI0
from fixed regulator with hard-wired GPIO levels to a proper GPIO regulator
instance to enable dynamic voltage switching.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |  101 ++++++++++++++++++++----
 1 file changed, 86 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 60694e8..f322a18 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -28,8 +28,10 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
+#include <linux/regulator/driver.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/regulator/fixed.h>
+#include <linux/regulator/gpio-regulator.h>
 #include <linux/regulator/machine.h>
 #include <linux/sh_eth.h>
 #include <linux/videodev2.h>
@@ -555,17 +557,94 @@ static struct platform_device gpio_keys_device = {
 	},
 };
 
-/* Fixed 3.3V regulator to be used by SDHI0, SDHI1, MMCIF */
-static struct regulator_consumer_supply fixed3v3_power_consumers[] =
-{
-	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
-	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
+/* Fixed 3.3V regulator to be used by SDHI1, MMCIF */
+static struct regulator_consumer_supply fixed3v3_power_consumers[] = {
 	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.1"),
 	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.1"),
 	REGULATOR_SUPPLY("vmmc", "sh_mmcif"),
 	REGULATOR_SUPPLY("vqmmc", "sh_mmcif"),
 };
 
+/* Fixed 3.3V regulator to be used by SDHI0 */
+static struct regulator_consumer_supply vcc_sdhi0_consumers[] = {
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
+};
+
+static struct regulator_init_data vcc_sdhi0_init_data = {
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies  = ARRAY_SIZE(vcc_sdhi0_consumers),
+	.consumer_supplies      = vcc_sdhi0_consumers,
+};
+
+static struct fixed_voltage_config vcc_sdhi0_info = {
+	.supply_name = "SDHI0 Vcc",
+	.microvolts = 3300000,
+	.gpio = GPIO_PORT75,
+	.enable_high = 1,
+	.init_data = &vcc_sdhi0_init_data,
+};
+
+static struct platform_device vcc_sdhi0 = {
+	.name = "reg-fixed-voltage",
+	.id   = 1,
+	.dev  = {
+		.platform_data = &vcc_sdhi0_info,
+	},
+};
+
+/* 1.8 / 3.3V SDHI0 VccQ regulator */
+static struct regulator_consumer_supply vccq_sdhi0_consumers[] = {
+	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
+};
+
+static struct regulator_init_data vccq_sdhi0_init_data = {
+	.constraints = {
+		.input_uV	= 3300000,
+		.min_uV		= 1800000,
+		.max_uV         = 3300000,
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
+				  REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies  = ARRAY_SIZE(vccq_sdhi0_consumers),
+	.consumer_supplies      = vccq_sdhi0_consumers,
+};
+
+static struct gpio vccq_sdhi0_gpios[] = {
+	{GPIO_PORT17, GPIOF_OUT_INIT_LOW, "vccq-sdhi0" },
+};
+
+static struct gpio_regulator_state vccq_sdhi0_states[] = {
+	{ .value = 3300000, .gpios = (0 << 0) },
+	{ .value = 1800000, .gpios = (1 << 0) },
+};
+
+static struct gpio_regulator_config vccq_sdhi0_info = {
+	.supply_name = "vqmmc",
+
+	.enable_gpio = GPIO_PORT74,
+	.enable_high = 1,
+	.enabled_at_boot = 0,
+
+	.gpios = vccq_sdhi0_gpios,
+	.nr_gpios = ARRAY_SIZE(vccq_sdhi0_gpios),
+
+	.states = vccq_sdhi0_states,
+	.nr_states = ARRAY_SIZE(vccq_sdhi0_states),
+
+	.type = REGULATOR_VOLTAGE,
+	.init_data = &vccq_sdhi0_init_data,
+};
+
+static struct platform_device vccq_sdhi0 = {
+	.name = "gpio-regulator",
+	.id   = -1,
+	.dev  = {
+		.platform_data = &vccq_sdhi0_info,
+	},
+};
+
 /* SDHI0 */
 /*
  * FIXME
@@ -580,7 +659,6 @@ static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
-	.tmio_ocr_mask	= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_USE_GPIO_CD,
 	.cd_gpio	= GPIO_PORT167,
 };
@@ -622,7 +700,6 @@ static struct sh_mobile_sdhi_info sdhi1_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
-	.tmio_ocr_mask	= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_USE_GPIO_CD,
 	/* Port72 cannot generate IRQs, will be used in polling mode. */
 	.cd_gpio	= GPIO_PORT72,
@@ -673,7 +750,6 @@ static const struct pinctrl_map eva_sdhi1_pinctrl_map[] = {
 /* MMCIF */
 static struct sh_mmcif_plat_data sh_mmcif_plat = {
 	.sup_pclk	= 0,
-	.ocr		= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
 	.caps		= MMC_CAP_4_BIT_DATA |
 			  MMC_CAP_8_BIT_DATA |
 			  MMC_CAP_NONREMOVABLE,
@@ -926,6 +1002,8 @@ static struct platform_device *eva_devices[] __initdata = {
 	&fsi_wm8978_device,
 	&fsi_hdmi_device,
 	&i2c_gpio_device,
+	&vcc_sdhi0,
+	&vccq_sdhi0,
 };
 
 static const struct pinctrl_map eva_pinctrl_map[] = {
@@ -1060,13 +1138,6 @@ static void __init eva_init(void)
 		usb = &usbhsf_device;
 	}
 
-	/* SDHI0 */
-	gpio_request_one(17, GPIOF_OUT_INIT_LOW, NULL);  /* SDHI0_18/33_B */
-	gpio_request_one(74, GPIOF_OUT_INIT_HIGH, NULL); /* SDHI0_PON */
-	gpio_request_one(75, GPIOF_OUT_INIT_HIGH, NULL); /* SDSLOT1_PON */
-
-	/* we can use GPIO_FN_IRQ31_PORT167 here for SDHI0 CD irq */
-
 	/* CEU0 */
 	gpio_request(GPIO_FN_VIO0_D7,		NULL);
 	gpio_request(GPIO_FN_VIO0_D6,		NULL);
-- 
1.7.10.4
