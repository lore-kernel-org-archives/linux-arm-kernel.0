From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 17 Jul 2017 17:35:37 +0200
Subject: [PATCH] ARM64: dts: fixup libretech cc definition
Message-ID: <20170717153537.18330-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The libretech CC derives less from the p212 than initially thought.
Several voltage regulators are different and the capabilities of the
sdcard and emmc also differ.

Deriving from the p212 is not convient anymore so the libretech is now
derived from s905x definition directly.

Fixes: cd84aff1d981 ("ARM64: dts: meson-gxl: Add Libre Technology CC support")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../dts/amlogic/meson-gxl-s905x-libretech-cc.dts   | 103 ++++++++++++++++++---
 1 file changed, 91 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index 890821d6e52b..266fbcf3e47f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -10,12 +10,20 @@
 
 #include <dt-bindings/input/input.h>
 
-#include "meson-gxl-s905x-p212.dtsi"
+#include "meson-gxl-s905x.dtsi"
 
 / {
 	compatible = "libretech,cc", "amlogic,s905x", "amlogic,meson-gxl";
 	model = "Libre Technology CC";
 
+	aliases {
+		serial0 = &uart_AO;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
 	cvbs-connector {
 		compatible = "composite-video-connector";
 
@@ -26,6 +34,11 @@
 		};
 	};
 
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
+	};
+
 	hdmi-connector {
 		compatible = "hdmi-connector";
 		type = "a";
@@ -53,6 +66,39 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	memory at 0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+
+	vcc_3v3: regulator-vcc_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	vcc_card: regulator-vcc-card {
+		compatible = "regulator-gpio";
+
+		regulator-name = "VCC_CARD";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_HIGH>;
+		gpios-states = <0>;
+
+		states = <3300000 0>,
+			 <1800000 1>;
+	};
+
+	vddio_boot: regulator-vddio_boot {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_BOOT";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 };
 
 &cvbs_vdac_port {
@@ -61,6 +107,16 @@
 	};
 };
 
+&ethmac {
+	status = "okay";
+};
+
+&ir {
+	status = "okay";
+	pinctrl-0 = <&remote_input_ao_pins>;
+	pinctrl-names = "default";
+};
+
 &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
@@ -73,20 +129,43 @@
 	};
 };
 
-/*
- * The following devices exists but are exposed on the general
- * purpose GPIO header. End user may well decide to use those pins
- * for another purpose
- */
+/* SD card */
+&sd_emmc_b {
+	status = "okay";
+	pinctrl-0 = <&sdcard_pins>;
+	pinctrl-names = "default";
+
+	bus-width = <4>;
+	cap-sd-highspeed;
+	max-frequency = <100000000>;
+	disable-wp;
+
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
+	cd-inverted;
 
-&sd_emmc_a {
-	status = "disabled";
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vcc_card>;
 };
 
-&uart_A {
-	status = "disabled";
+/* eMMC */
+&sd_emmc_c {
+	status = "okay";
+	pinctrl-0 = <&emmc_pins>;
+	pinctrl-names = "default";
+
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	max-frequency = <50000000>;
+	non-removable;
+	disable-wp;
+
+	mmc-pwrseq = <&emmc_pwrseq>;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vddio_boot>;
 };
 
-&wifi32k {
-	status = "disabled";
+&uart_AO {
+	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
 };
-- 
2.9.4
