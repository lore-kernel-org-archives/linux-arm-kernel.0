From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 16 Apr 2014 14:10:17 -0300
Subject: [PATCH 3/3] ARM: dts: imx27-pdk: Add USB OTG support
In-Reply-To: <1397668217-17551-1-git-send-email-festevam@gmail.com>
References: <1397668217-17551-1-git-send-email-festevam@gmail.com>
Message-ID: <1397668217-17551-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
It applies on top of "[PATCH v3] ARM: dts: imx27-pdk: Add PMIC support"

 arch/arm/boot/dts/imx27-pdk.dts | 48 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-pdk.dts b/arch/arm/boot/dts/imx27-pdk.dts
index 37d7bde..6bb274b 100644
--- a/arch/arm/boot/dts/imx27-pdk.dts
+++ b/arch/arm/boot/dts/imx27-pdk.dts
@@ -19,6 +19,28 @@
 	memory {
 		reg = <0xa0000000 0x08000000>;
 	};
+
+	clocks {
+		clk_26M: codec_clock {
+			compatible = "fixed-clock";
+			reg = <0>;
+			#clock-cells = <0>;
+			clock-frequency = <26000000>;
+		};
+	};
+
+	usbphy {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usbphy0: usbphy at 0 {
+			compatible = "usb-nop-xceiv";
+			reg = <0>;
+			clocks = <&clk_26M>;
+			clock-names = "main_clk";
+		};
+	};
 };
 
 &cspi2 {
@@ -80,6 +102,15 @@
 	status = "okay";
 };
 
+&usbotg {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	dr_mode = "otg";
+	fsl,usbphy = <&usbphy0>;
+	phy_type = "ulpi";
+	status = "okay";
+};
+
 &iomuxc {
 	imx27-pdk {
 		pinctrl_cspi2: cspi2grp {
@@ -128,5 +159,22 @@
 				MX27_PAD_UART1_RTS__UART1_RTS 0x0
 			>;
 		};
+
+		pinctrl_usbotg: usbotggrp {
+			fsl,pins = <
+				MX27_PAD_USBOTG_NXT__USBOTG_NXT 0x0
+				MX27_PAD_USBOTG_STP__USBOTG_STP 0x0
+				MX27_PAD_USBOTG_DIR__USBOTG_DIR 0x0
+				MX27_PAD_USBOTG_CLK__USBOTG_CLK 0x0
+				MX27_PAD_USBOTG_DATA0__USBOTG_DATA0 0x0
+				MX27_PAD_USBOTG_DATA1__USBOTG_DATA1 0x0
+				MX27_PAD_USBOTG_DATA2__USBOTG_DATA2 0x0
+				MX27_PAD_USBOTG_DATA3__USBOTG_DATA3 0x0
+				MX27_PAD_USBOTG_DATA4__USBOTG_DATA4 0x0
+				MX27_PAD_USBOTG_DATA5__USBOTG_DATA5 0x0
+				MX27_PAD_USBOTG_DATA6__USBOTG_DATA6 0x0
+				MX27_PAD_USBOTG_DATA7__USBOTG_DATA7 0x0
+			>;
+		};
 	};
 };
-- 
1.8.3.2
