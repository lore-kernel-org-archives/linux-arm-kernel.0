From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 22 Feb 2014 13:32:34 +0400
Subject: [PATCH 2/3] ARM: dts: imx27-phytec-phycore-rdk: Add USBH2 node
In-Reply-To: <1393061555-26707-1-git-send-email-shc_work@mail.ru>
References: <1393061555-26707-1-git-send-email-shc_work@mail.ru>
Message-ID: <1393061555-26707-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds USBH2 devicetree node of Phytec PCM970 RDK.
Additionally, adds fixed regulator to provide functionality
without dummy-regulator in the kernel.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts  | 31 +++++++++++++++++++++++++
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi |  8 +++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
index 9a07543..df3b2e7 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
@@ -81,6 +81,23 @@
 			>;
 		};
 
+		pinctrl_usbh2: usbh2grp {
+			fsl,pins = <
+				MX27_PAD_USBH2_CLK__USBH2_CLK 0x0
+				MX27_PAD_USBH2_DIR__USBH2_DIR 0x0
+				MX27_PAD_USBH2_NXT__USBH2_NXT 0x0
+				MX27_PAD_USBH2_STP__USBH2_STP 0x0
+				MX27_PAD_CSPI2_SCLK__USBH2_DATA0 0x0
+				MX27_PAD_CSPI2_MOSI__USBH2_DATA1 0x0
+				MX27_PAD_CSPI2_MISO__USBH2_DATA2 0x0
+				MX27_PAD_CSPI2_SS1__USBH2_DATA3 0x0
+				MX27_PAD_CSPI2_SS2__USBH2_DATA4 0x0
+				MX27_PAD_CSPI1_SS2__USBH2_DATA5 0x0
+				MX27_PAD_CSPI2_SS0__USBH2_DATA6 0x0
+				MX27_PAD_USBH2_DATA7__USBH2_DATA7 0x0
+			>;
+		};
+
 		pinctrl_weim: weimgrp {
 			fsl,pins = <
 				MX27_PAD_CS4_B__CS4_B		0x0 /* CS4 */
@@ -170,6 +187,20 @@
 	status = "okay";
 };
 
+&usbh2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbh2>;
+	dr_mode = "host";
+	phy_type = "ulpi";
+	vbus-supply = <&reg_5v0>;
+	disable-over-current;
+	status = "okay";
+};
+
+&usbphy2 {
+	vcc-supply = <&reg_5v0>;
+};
+
 &weim {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_weim>;
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
index 258eafa..05b0ecd 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
@@ -32,6 +32,14 @@
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
 		};
+
+		reg_5v0: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "5V0";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+		};
 	};
 };
 
-- 
1.8.3.2
