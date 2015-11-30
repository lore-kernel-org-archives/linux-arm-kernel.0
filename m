From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Nov 2015 16:29:06 +0100
Subject: [PATCH 2/2] ARM: sunxi: chip: Add Wifi chip
In-Reply-To: <1448897346-17780-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1448897346-17780-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1448897346-17780-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CHIP has a WiFi/BT chip on an SDIO bus. That controller is maintained
in reset through a GPIO and uses two independent regulators to be powered
that must be kept in sync.

Model this using an MMC power sequence and a coupled voltage regulator.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-r8-chip.dts | 44 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/sun5i-r8-chip.dts
index 530ab28e9ca2..b5ef4eb5b6b4 100644
--- a/arch/arm/boot/dts/sun5i-r8-chip.dts
+++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
@@ -64,6 +64,24 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	mmc0_pwrseq: mmc0_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&chip_wifi_reg_on_pin>;
+		reset-gpios = <&pio 2 19 GPIO_ACTIVE_LOW>; /* PC19 */
+	};
+
+	/*
+	 * Both LDO3 and LDO4 are used in parallel to power up the
+	 * WiFi/BT Chip.
+	 */
+	vcc_wifi: wifi_reg {
+		compatible = "coupled-voltage-regulator";
+		regulator-name = "vcc-wifi";
+		vin0-supply = <&reg_ldo3>;
+		vin1-supply = <&reg_ldo4>;
+	};
 };
 
 &codec {
@@ -113,10 +131,15 @@
 	};
 };
 
+&mmc0_pins_a {
+	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>;
-	vmmc-supply = <&reg_vcc3v3>;
+	vmmc-supply = <&vcc_wifi>;
+	mmc-pwrseq = <&mmc0_pwrseq>;
 	bus-width = <4>;
 	non-removable;
 	status = "okay";
@@ -138,6 +161,13 @@
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
+	chip_wifi_reg_on_pin: chip_wifi_reg_on_pin at 0 {
+		allwinner,pins = "PC19";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
 	chip_id_det_pin: chip_id_det_pin at 0 {
 		allwinner,pins = "PG2";
 		allwinner,function = "gpio_in";
@@ -171,6 +201,18 @@
 	regulator-always-on;
 };
 
+&reg_ldo3 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi-1";
+};
+
+&reg_ldo4 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi-2";
+};
+
 &reg_ldo5 {
 	regulator-min-microvolt = <1800000>;
 	regulator-max-microvolt = <1800000>;
-- 
2.6.3
