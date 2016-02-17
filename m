From: stefan@agner.ch (Stefan Agner)
Date: Wed, 17 Feb 2016 15:40:59 -0800
Subject: [PATCH v3 2/3] ARM: dts: vf-colibri: add basic supply regulators
In-Reply-To: <1455752460-2770-1-git-send-email-stefan@agner.ch>
References: <1455752460-2770-1-git-send-email-stefan@agner.ch>
Message-ID: <1455752460-2770-2-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Colibri modules need to be powered using the power pins 3V3 and
AVDD_AUDIO. Add fixed regulators which represent this power rails.
Potentially, those power rails could be switched on a carrier
board. A carrier board device tree could add a own regulator with
a GPIO, and reference that regulator in a vin-supply property of
those new module level system regulators.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Changes since v2:
- remove regulator-always-on

Changes since v1:
- Add module prefix to avoid namespace issue with Carrier Board regulators
- Name the regulators according to schematics

 arch/arm/boot/dts/vf-colibri.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
index ff6f58e..ed4cfc5 100644
--- a/arch/arm/boot/dts/vf-colibri.dtsi
+++ b/arch/arm/boot/dts/vf-colibri.dtsi
@@ -48,14 +48,30 @@
 		enable-gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
 		status = "disabled";
 	};
+
+	reg_module_3v3: regulator-module-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "+V3.3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reg_module_3v3_avdd: regulator-module-3v3-avdd {
+		compatible = "regulator-fixed";
+		regulator-name = "+V3.3_AVDD_AUDIO";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 };
 
 &adc0 {
 	status = "okay";
+	vref-supply = <&reg_module_3v3_avdd>;
 };
 
 &adc1 {
 	status = "okay";
+	vref-supply = <&reg_module_3v3_avdd>;
 };
 
 &can0 {
@@ -96,6 +112,7 @@
 
 &fec1 {
 	phy-mode = "rmii";
+	phy-supply = <&reg_module_3v3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec1>;
 };
-- 
2.7.1
