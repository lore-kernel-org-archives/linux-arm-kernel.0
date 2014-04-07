From: denis@eukrea.com (Denis Carikli)
Date: Mon,  7 Apr 2014 18:04:00 +0200
Subject: [PATCH v2][ 2/3] ARM: dts: mbimxsd51 baseboard: Add USB support.
In-Reply-To: <1396886641-26985-1-git-send-email-denis@eukrea.com>
References: <1396886641-26985-1-git-send-email-denis@eukrea.com>
Message-ID: <1396886641-26985-2-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
Changelog v1->v2:
- This patch has been splitted out of my previous imx25/35/51 USB patchset.
  It's made from the "ARM: dts: i.MX51: Add a second usbphy." and the
  "ARM: dts: mbimxsd51 baseboard: Add USB host support" patchset.
  - USB OTG support was added.
  - The second USB phy was moved outside of imx51.dtsi
  - "phy_type = "ulpi";" was added to the usbh1 node, like with the imx51 babbage.
  - Now depends on the "chipidea: usbmisc_imx: Allow USB OTG to work on mx51" patch
    which is queued by Peter Chen.
---
 .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  |   58 ++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
index 5cec4f3..8b1098e 100644
--- a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
+++ b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
@@ -57,6 +57,20 @@
 		fsl,mux-int-port = <2>;
 		fsl,mux-ext-port = <3>;
 	};
+
+	usbphy {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "simple-bus";
+
+		usbh1phy: usbh1phy at 0 {
+			compatible = "usb-nop-xceiv";
+			reg = <0>;
+			clocks = <&clks IMX5_CLK_USB_PHY_GATE>;
+			clock-names = "main_clk";
+			clock-frequency = <19200000>;
+		};
+	};
 };
 
 &audmux {
@@ -151,6 +165,29 @@
 				MX51_PAD_CSI1_D9__GPIO3_13 0x1f5
 			>;
 		};
+
+		pinctrl_usbh1: usbh1grp {
+			fsl,pins = <
+				MX51_PAD_USBH1_CLK__USBH1_CLK     0x1e5
+				MX51_PAD_USBH1_DIR__USBH1_DIR     0x1e5
+				MX51_PAD_USBH1_NXT__USBH1_NXT     0x1e5
+				MX51_PAD_USBH1_DATA0__USBH1_DATA0 0x1e5
+				MX51_PAD_USBH1_DATA1__USBH1_DATA1 0x1e5
+				MX51_PAD_USBH1_DATA2__USBH1_DATA2 0x1e5
+				MX51_PAD_USBH1_DATA3__USBH1_DATA3 0x1e5
+				MX51_PAD_USBH1_DATA4__USBH1_DATA4 0x1e5
+				MX51_PAD_USBH1_DATA5__USBH1_DATA5 0x1e5
+				MX51_PAD_USBH1_DATA6__USBH1_DATA6 0x1e5
+				MX51_PAD_USBH1_DATA7__USBH1_DATA7 0x1e5
+				MX51_PAD_USBH1_STP__USBH1_STP     0x1e5
+			>;
+		};
+
+		pinctrl_usbh1_vbus: usbh1-vbusgrp {
+			fsl,pins = <
+				MX51_PAD_EIM_CS3__GPIO2_28 0x1f5
+			>;
+		};
 	};
 };
 
@@ -173,3 +210,24 @@
 	fsl,uart-has-rtscts;
 	status = "okay";
 };
+
+&usbh1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbh1>;
+	fsl,usbphy = <&usbh1phy>;
+	dr_mode = "host";
+	phy_type = "ulpi";
+	status = "okay";
+};
+
+&usbotg {
+	dr_mode = "otg";
+	phy_type = "utmi_wide";
+	status = "okay";
+};
+
+&usbphy0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbh1_vbus>;
+	reset-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>;
+};
-- 
1.7.9.5
