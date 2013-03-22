From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 22 Mar 2013 10:23:47 +0900
Subject: [PATCH 1/6] ARM: shmobile: kzm9g: SDHI0 and SDHI1 use a 3.3V power
 supply
In-Reply-To: <1363915432-21720-1-git-send-email-horms+renesas@verge.net.au>
References: <1363915432-21720-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363915432-21720-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

kzm9g supplies 3.3V to its SDHI0 and SDHI2 interfaces. Specifying 2.8V
prevents some (e.g. certain SDIO) cards from working. This patch fixes the
voltage and removes redundant OCR masks from platform data.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |   12 ++++++------
 arch/arm/mach-shmobile/board-kzm9g.c         |   10 ++++------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 7fad4b9..cadcf30 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -36,11 +36,11 @@
 		regulator-boot-on;
 	};
 
-	reg_2p8v: regulator at 1 {
+	reg_3p3v: regulator at 1 {
 		compatible = "regulator-fixed";
-		regulator-name = "fixed-2.8V";
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
 		regulator-boot-on;
 	};
@@ -52,7 +52,7 @@
 		interrupts = <0 83 4
 				0 84 4
 				0 85 4>;
-		vmmc-supply = <&reg_2p8v>;
+		vmmc-supply = <&reg_3p3v>;
 		bus-width = <4>;
 		toshiba,mmc-has-idle-wait;
 	};
@@ -63,7 +63,7 @@
 		interrupt-parent = <&gic>;
 		interrupts = <0 104 4
 				0 105 4>;
-		vmmc-supply = <&reg_2p8v>;
+		vmmc-supply = <&reg_3p3v>;
 		bus-width = <4>;
 		broken-cd;
 		toshiba,mmc-wrprotect-disable;
diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index d2ace3a..e924b81 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -375,8 +375,8 @@ static struct platform_device mmc_device = {
 	.resource	= sh_mmcif_resources,
 };
 
-/* Fixed 2.8V regulators to be used by SDHI0 and SDHI2 */
-static struct regulator_consumer_supply fixed2v8_power_consumers[] =
+/* Fixed 3.3V regulators to be used by SDHI0 and SDHI2 */
+static struct regulator_consumer_supply fixed3v3_power_consumers[] =
 {
 	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
 	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
@@ -390,7 +390,6 @@ static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED,
-	.tmio_ocr_mask	= MMC_VDD_27_28 | MMC_VDD_28_29,
 };
 
 static struct resource sdhi0_resources[] = {
@@ -434,7 +433,6 @@ static struct sh_mobile_sdhi_info sdhi2_info = {
 			  TMIO_MMC_USE_GPIO_CD |
 			  TMIO_MMC_WRPROTECT_DISABLE,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED,
-	.tmio_ocr_mask	= MMC_VDD_27_28 | MMC_VDD_28_29,
 	.cd_gpio	= 13,
 };
 
@@ -716,8 +714,8 @@ static void __init kzm_init(void)
 {
 	regulator_register_always_on(0, "fixed-1.8V", fixed1v8_power_consumers,
 				     ARRAY_SIZE(fixed1v8_power_consumers), 1800000);
-	regulator_register_always_on(1, "fixed-2.8V", fixed2v8_power_consumers,
-				     ARRAY_SIZE(fixed2v8_power_consumers), 2800000);
+	regulator_register_always_on(1, "fixed-3.3V", fixed3v3_power_consumers,
+				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
 	regulator_register_fixed(2, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 
 	pinctrl_register_mappings(kzm_pinctrl_map, ARRAY_SIZE(kzm_pinctrl_map));
-- 
1.7.10.4
