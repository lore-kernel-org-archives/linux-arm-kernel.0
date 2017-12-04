From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  4 Dec 2017 10:20:10 -0200
Subject: [PATCH v2 06/12] ARM: dts: imx6qdl-aristainetos: Move regulators out
 of simple-bus
In-Reply-To: <1512390016-703-1-git-send-email-festevam@gmail.com>
References: <1512390016-703-1-git-send-email-festevam@gmail.com>
Message-ID: <1512390016-703-6-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

It is not recommended to place regulator nodes inside simple-bus, so
move them out in order to fix the following build warnings with W=1:

arch/arm/boot/dts/imx6dl-aristainetos_4.dtb: Warning (unit_address_vs_reg): Node /regulators/regulator at 0 has a unit name, but no reg property
arch/arm/boot/dts/imx6dl-aristainetos_4.dtb: Warning (unit_address_vs_reg): Node /regulators/regulator at 1 has a unit name, but no reg property
arch/arm/boot/dts/imx6dl-aristainetos_4.dtb: Warning (unit_address_vs_reg): Node /regulators/regulator at 2 has a unit name, but no reg property
arch/arm/boot/dts/imx6dl-aristainetos_4.dtb: Warning (unit_address_vs_reg): Node /regulators/regulator at 3 has a unit name, but no reg property

Cc: Heiko Schocher <hs@denx.de>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Reviewed-by: Heiko Schocher <hs@denx.de>
Tested-by: Heiko Schocher <hs@denx.de>
---
Changes since v1:
- Removed 'Node /memory has a reg or ranges property, but no unit name' error

 arch/arm/boot/dts/imx6qdl-aristainetos.dtsi  | 73 +++++++++++++-------------
 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi | 76 +++++++++++++---------------
 2 files changed, 70 insertions(+), 79 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi b/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
index 7d64075..ee4d0f8 100644
--- a/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
@@ -12,48 +12,43 @@
 #include <dt-bindings/gpio/gpio.h>
 
 / {
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reg_2p5v: regulator at 0 {
-			compatible = "regulator-fixed";
-			regulator-name = "2P5V";
-			regulator-min-microvolt = <2500000>;
-			regulator-max-microvolt = <2500000>;
-			regulator-always-on;
-		};
 
-		reg_3p3v: regulator at 1 {
-			compatible = "regulator-fixed";
-			regulator-name = "3P3V";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
+	reg_2p5v: regulator-2p5v {
+		compatible = "regulator-fixed";
+		regulator-name = "2P5V";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+		regulator-always-on;
+	};
 
-		reg_usbh1_vbus: regulator at 2 {
-			compatible = "regulator-fixed";
-			enable-active-high;
-			gpio = <&gpio3 31 GPIO_ACTIVE_HIGH>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_aristainetos_usbh1_vbus>;
-			regulator-name = "usb_h1_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-		};
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
 
-		reg_usbotg_vbus: regulator at 3 {
-			compatible = "regulator-fixed";
-			enable-active-high;
-			gpio = <&gpio4 15 GPIO_ACTIVE_HIGH>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_aristainetos_usbotg_vbus>;
-			regulator-name = "usb_otg_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-		};
+	reg_usbh1_vbus: regulator-usbh1-vbus {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio3 31 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_aristainetos_usbh1_vbus>;
+		regulator-name = "usb_h1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_usbotg_vbus: regulator-usbotg-vbus {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio4 15 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_aristainetos_usbotg_vbus>;
+		regulator-name = "usb_otg_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi b/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
index 1b18728..3767508 100644
--- a/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
@@ -52,46 +52,42 @@
 		enable-gpios = <&gpio6 31 GPIO_ACTIVE_HIGH>;
 	};
 
-	regulators {
-		compatible = "simple-bus";
-
-		reg_2p5v: 2p5v {
-			compatible = "regulator-fixed";
-			regulator-name = "2P5V";
-			regulator-min-microvolt = <2500000>;
-			regulator-max-microvolt = <2500000>;
-			regulator-always-on;
-		};
-
-		reg_3p3v: 3p3v {
-			compatible = "regulator-fixed";
-			regulator-name = "3P3V";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
-
-		reg_usbh1_vbus: usb-h1-vbus {
-			compatible = "regulator-fixed";
-			enable-active-high;
-			gpio = <&gpio1 0 GPIO_ACTIVE_HIGH>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_aristainetos2_usbh1_vbus>;
-			regulator-name = "usb_h1_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-		};
-
-		reg_usbotg_vbus: usb-otg-vbus {
-			compatible = "regulator-fixed";
-			enable-active-high;
-			gpio = <&gpio4 15 GPIO_ACTIVE_HIGH>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_aristainetos2_usbotg_vbus>;
-			regulator-name = "usb_otg_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-		};
+	reg_2p5v: regulator-2p5v {
+		compatible = "regulator-fixed";
+		regulator-name = "2P5V";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+		regulator-always-on;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	reg_usbh1_vbus: regulator-usbh1-vbus {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio1 0 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_aristainetos2_usbh1_vbus>;
+		regulator-name = "usb_h1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_usbotg_vbus: regulator-usbotg-vbus {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio4 15 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_aristainetos2_usbotg_vbus>;
+		regulator-name = "usb_otg_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
 	};
 };
 
-- 
2.7.4
