From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 22 Mar 2013 10:23:50 +0900
Subject: [PATCH 4/6] ARM: shmobile: kzm9g: add fixed voltage regulators for
 SDHI0 and SDHI2
In-Reply-To: <1363915432-21720-1-git-send-email-horms+renesas@verge.net.au>
References: <1363915432-21720-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363915432-21720-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Both SDHI0 and SDHI2 power supplies on kzm9g can be switched on and off. In
the current version this is not used and the regulators are hard-wired to
"on." This patch switches SDHI0 and SDHI2 to proper fixed-voltage
regulators, using GPIOs to enable and disable them. Both ports shall
now be specifying the MMC_CAP_POWER_OFF_CARD MMC capability. Only SDHI0
has been tested with an SDIO card, since SDHI2 is a microSD slot.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-kzm9g.c |   76 +++++++++++++++++++++++++++-------
 1 file changed, 62 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index e924b81..77a66ac 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -375,13 +375,64 @@ static struct platform_device mmc_device = {
 	.resource	= sh_mmcif_resources,
 };
 
-/* Fixed 3.3V regulators to be used by SDHI0 and SDHI2 */
-static struct regulator_consumer_supply fixed3v3_power_consumers[] =
+/* Fixed 3.3V regulators to be used by SDHI0 */
+static struct regulator_consumer_supply vcc_sdhi0_consumers[] =
 {
 	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
-	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
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
+	.gpio = 15,
+	.enable_high = 1,
+	.init_data = &vcc_sdhi0_init_data,
+};
+
+static struct platform_device vcc_sdhi0 = {
+	.name = "reg-fixed-voltage",
+	.id   = 0,
+	.dev  = {
+		.platform_data = &vcc_sdhi0_info,
+	},
+};
+
+/* Fixed 3.3V regulators to be used by SDHI2 */
+static struct regulator_consumer_supply vcc_sdhi2_consumers[] =
+{
 	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.2"),
-	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.2"),
+};
+
+static struct regulator_init_data vcc_sdhi2_init_data = {
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies  = ARRAY_SIZE(vcc_sdhi2_consumers),
+	.consumer_supplies      = vcc_sdhi2_consumers,
+};
+
+static struct fixed_voltage_config vcc_sdhi2_info = {
+	.supply_name = "SDHI2 Vcc",
+	.microvolts = 3300000,
+	.gpio = 14,
+	.enable_high = 1,
+	.init_data = &vcc_sdhi2_init_data,
+};
+
+static struct platform_device vcc_sdhi2 = {
+	.name = "reg-fixed-voltage",
+	.id   = 1,
+	.dev  = {
+		.platform_data = &vcc_sdhi2_info,
+	},
 };
 
 /* SDHI */
@@ -389,7 +440,8 @@ static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
-	.tmio_caps	= MMC_CAP_SD_HIGHSPEED,
+	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
+			  MMC_CAP_POWER_OFF_CARD,
 };
 
 static struct resource sdhi0_resources[] = {
@@ -432,7 +484,7 @@ static struct sh_mobile_sdhi_info sdhi2_info = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT |
 			  TMIO_MMC_USE_GPIO_CD |
 			  TMIO_MMC_WRPROTECT_DISABLE,
-	.tmio_caps	= MMC_CAP_SD_HIGHSPEED,
+	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_POWER_OFF_CARD,
 	.cd_gpio	= 13,
 };
 
@@ -592,6 +644,8 @@ static struct platform_device *kzm_devices[] __initdata = {
 	&usbhs_device,
 	&lcdc_device,
 	&mmc_device,
+	&vcc_sdhi0,
+	&vcc_sdhi2,
 	&sdhi0_device,
 	&sdhi2_device,
 	&gpio_keys_device,
@@ -712,11 +766,9 @@ device_initcall(as3711_enable_lcdc_backlight);
 
 static void __init kzm_init(void)
 {
-	regulator_register_always_on(0, "fixed-1.8V", fixed1v8_power_consumers,
+	regulator_register_always_on(2, "fixed-1.8V", fixed1v8_power_consumers,
 				     ARRAY_SIZE(fixed1v8_power_consumers), 1800000);
-	regulator_register_always_on(1, "fixed-3.3V", fixed3v3_power_consumers,
-				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
-	regulator_register_fixed(2, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+	regulator_register_fixed(3, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 
 	pinctrl_register_mappings(kzm_pinctrl_map, ARRAY_SIZE(kzm_pinctrl_map));
 
@@ -734,10 +786,6 @@ static void __init kzm_init(void)
 
 	/* enable SD */
 	gpio_request(GPIO_FN_SDHI0_VCCQ_MC0_ON,	NULL);
-	gpio_request_one(15, GPIOF_OUT_INIT_HIGH, NULL); /* power */
-
-	/* enable Micro SD */
-	gpio_request_one(14, GPIOF_OUT_INIT_HIGH, NULL); /* power */
 
 #ifdef CONFIG_CACHE_L2X0
 	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
-- 
1.7.10.4
