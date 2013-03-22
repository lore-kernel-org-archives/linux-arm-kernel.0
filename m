From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 22 Mar 2013 10:23:49 +0900
Subject: [PATCH 3/6] ARM: shmobile: armadillo800eva: add a fixed voltage
 regulator for SDHI1
In-Reply-To: <1363915432-21720-1-git-send-email-horms+renesas@verge.net.au>
References: <1363915432-21720-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363915432-21720-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

The SDHI1 power supply on armadillo800eva can be switched on and off. In
the current version this is not used and the regulator is hard-wired to
"on." This patch switches SDHI1 to a proper fixed-voltage regulator,
using a GPIO to enable and disable it. Both SDHI0 and SDHI1 ports shall
now be specifying the MMC_CAP_POWER_OFF_CARD MMC capability. Both
interfaces tested with an SDIO card.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |   45 +++++++++++++++++++-----
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index f322a18..7a78f94 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -559,8 +559,6 @@ static struct platform_device gpio_keys_device = {
 
 /* Fixed 3.3V regulator to be used by SDHI1, MMCIF */
 static struct regulator_consumer_supply fixed3v3_power_consumers[] = {
-	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.1"),
-	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.1"),
 	REGULATOR_SUPPLY("vmmc", "sh_mmcif"),
 	REGULATOR_SUPPLY("vqmmc", "sh_mmcif"),
 };
@@ -645,6 +643,35 @@ static struct platform_device vccq_sdhi0 = {
 	},
 };
 
+/* Fixed 3.3V regulator to be used by SDHI1 */
+static struct regulator_consumer_supply vcc_sdhi1_consumers[] = {
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.1"),
+};
+
+static struct regulator_init_data vcc_sdhi1_init_data = {
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies  = ARRAY_SIZE(vcc_sdhi1_consumers),
+	.consumer_supplies      = vcc_sdhi1_consumers,
+};
+
+static struct fixed_voltage_config vcc_sdhi1_info = {
+	.supply_name = "SDHI1 Vcc",
+	.microvolts = 3300000,
+	.gpio = GPIO_PORT16,
+	.enable_high = 1,
+	.init_data = &vcc_sdhi1_init_data,
+};
+
+static struct platform_device vcc_sdhi1 = {
+	.name = "reg-fixed-voltage",
+	.id   = 2,
+	.dev  = {
+		.platform_data = &vcc_sdhi1_info,
+	},
+};
+
 /* SDHI0 */
 /*
  * FIXME
@@ -658,7 +685,8 @@ static struct platform_device vccq_sdhi0 = {
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
-	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
+	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
+			  MMC_CAP_POWER_OFF_CARD,
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_USE_GPIO_CD,
 	.cd_gpio	= GPIO_PORT167,
 };
@@ -699,7 +727,8 @@ static struct platform_device sdhi0_device = {
 static struct sh_mobile_sdhi_info sdhi1_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
-	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
+	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
+			  MMC_CAP_POWER_OFF_CARD,
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_USE_GPIO_CD,
 	/* Port72 cannot generate IRQs, will be used in polling mode. */
 	.cd_gpio	= GPIO_PORT72,
@@ -992,6 +1021,8 @@ static struct platform_device *eva_devices[] __initdata = {
 	&lcdc0_device,
 	&gpio_keys_device,
 	&sh_eth_device,
+	&vcc_sdhi0,
+	&vccq_sdhi0,
 	&sdhi0_device,
 	&sh_mmcif_device,
 	&hdmi_device,
@@ -1002,8 +1033,6 @@ static struct platform_device *eva_devices[] __initdata = {
 	&fsi_wm8978_device,
 	&fsi_hdmi_device,
 	&i2c_gpio_device,
-	&vcc_sdhi0,
-	&vccq_sdhi0,
 };
 
 static const struct pinctrl_map eva_pinctrl_map[] = {
@@ -1198,9 +1227,7 @@ static void __init eva_init(void)
 		pinctrl_register_mappings(eva_sdhi1_pinctrl_map,
 					  ARRAY_SIZE(eva_sdhi1_pinctrl_map));
 
-		/* SDSLOT2_PON */
-		gpio_request_one(16, GPIOF_OUT_INIT_HIGH, NULL);
-
+		platform_device_register(&vcc_sdhi1);
 		platform_device_register(&sdhi1_device);
 	}
 
-- 
1.7.10.4
