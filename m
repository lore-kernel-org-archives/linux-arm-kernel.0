From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Oct 2016 13:48:58 +0200
Subject: [PATCH 1/6] ARM: sun5i: chip: Enable Wi-Fi SDIO chip
In-Reply-To: <cover.92d041a0a6fe40f1c8839cabb70247445eaffdfb.1476704881.git-series.maxime.ripard@free-electrons.com>
References: <cover.92d041a0a6fe40f1c8839cabb70247445eaffdfb.1476704881.git-series.maxime.ripard@free-electrons.com>
Message-ID: <468cbaad185a2bde92f1015a1c286f1e1ef55850.1476704881.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The WiFi chip is powered through a GPIO and two regulators in parallel.
Since that case is not supported yet, just set them as always on before we
rework the regulator framework to deal with those.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-r8-chip.dts | 41 ++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/sun5i-r8-chip.dts
index b68a12374b35..e616084b9495 100644
--- a/arch/arm/boot/dts/sun5i-r8-chip.dts
+++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
@@ -74,6 +74,13 @@
 			default-state = "on";
 		};
 	};
+
+	mmc0_pwrseq: mmc0_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&chip_wifi_reg_on_pin>;
+		reset-gpios = <&pio 2 19 GPIO_ACTIVE_LOW>; /* PC19 */
+	};
 };
 
 &be0 {
@@ -131,10 +138,15 @@
 	};
 };
 
+&mmc0_pins_a {
+	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
+	mmc-pwrseq = <&mmc0_pwrseq>;
 	bus-width = <4>;
 	non-removable;
 	status = "okay";
@@ -156,6 +168,13 @@
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
+	chip_wifi_reg_on_pin: chip_wifi_reg_on_pin at 0 {
+	        allwinner,pins = "PC19";
+	        allwinner,function = "gpio_out";
+	        allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+	        allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
 	chip_id_det_pin: chip_id_det_pin at 0 {
 		allwinner,pins = "PG2";
 		allwinner,function = "gpio_in";
@@ -189,6 +208,28 @@
 	regulator-always-on;
 };
 
+/*
+ * Both LDO3 and LDO4 are used in parallel to power up the WiFi/BT
+ * Chip.
+ *
+ * If those are not enabled, the SDIO part will not enumerate, and
+ * since there's no way currently to pass DT infos to an SDIO device,
+ * we cannot really do better than this ugly hack for now.
+ */
+&reg_ldo3 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi-1";
+	regulator-always-on;
+};
+
+&reg_ldo4 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi-2";
+	regulator-always-on;
+};
+
 &reg_ldo5 {
 	regulator-min-microvolt = <1800000>;
 	regulator-max-microvolt = <1800000>;
-- 
git-series 0.8.10
