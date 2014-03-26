From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 26 Mar 2014 11:54:38 -0300
Subject: [PATCH v2 1/2] ARM: dts: imx51-babbage: Add USB Host1 support
Message-ID: <1395845679-5744-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Signed-off by: Dave Ebright <dave.ebright@parsons.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Does not touch the common imx51.dtsi file and provide the usbphy node locally

 arch/arm/boot/dts/imx51-babbage.dts | 55 +++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 121dadd..1084607 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -119,6 +119,35 @@
 			gpios = <&gpio4 26 GPIO_ACTIVE_LOW>;
 		};
 	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_usb_vbus: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "usb_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio2 5 0>;
+			enable-active-high;
+		};
+	};
+
+	usbphy {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "simple-bus";
+
+		usbh1phy: usbh1phy at 0 {
+			compatible = "usb-nop-xceiv";
+			reg = <0>;
+			clocks = <&clks 0>;
+			clock-names = "main_clk";
+		};
+	};
 };
 
 &esdhc1 {
@@ -461,6 +490,23 @@
 				MX51_PAD_EIM_D24__UART3_CTS		0x1c5
 			>;
 		};
+
+		pinctrl_usbh1: usbh1grp {
+			fsl,pins = <
+				MX51_PAD_USBH1_CLK__USBH1_CLK		0x80000000
+				MX51_PAD_USBH1_DIR__USBH1_DIR		0x80000000
+				MX51_PAD_USBH1_NXT__USBH1_NXT		0x80000000
+				MX51_PAD_USBH1_DATA0__USBH1_DATA0	0x80000000
+				MX51_PAD_USBH1_DATA1__USBH1_DATA1	0x80000000
+				MX51_PAD_USBH1_DATA2__USBH1_DATA2	0x80000000
+				MX51_PAD_USBH1_DATA3__USBH1_DATA3	0x80000000
+				MX51_PAD_USBH1_DATA4__USBH1_DATA4	0x80000000
+				MX51_PAD_USBH1_DATA5__USBH1_DATA5	0x80000000
+				MX51_PAD_USBH1_DATA6__USBH1_DATA6	0x80000000
+				MX51_PAD_USBH1_DATA7__USBH1_DATA7	0x80000000
+				MX51_PAD_EIM_D21__GPIO2_5		0x80000000
+			>;
+		};
 	};
 };
 
@@ -529,3 +575,12 @@
 		>;
 	status = "okay";
 };
+
+&usbh1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbh1>;
+	vbus-supply = <&reg_usb_vbus>;
+	fsl,usbphy = <&usbh1phy>;
+	phy_type = "ulpi";
+	status = "okay";
+};
-- 
1.8.1.2
