From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Wed, 30 Sep 2015 15:46:39 +0200
Subject: [RESEND][PATCH v3 2/9] ARM: dts: imx6qdl-nitrogen6x: add wifi wl1271
 support
In-Reply-To: <1443620806-14792-1-git-send-email-gary.bisson@boundarydevices.com>
References: <1441645069-27263-1-git-send-email-gary.bisson@boundarydevices.com>
 <1443620806-14792-1-git-send-email-gary.bisson@boundarydevices.com>
Message-ID: <1443620806-14792-3-git-send-email-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 55 +++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index dadc01a..24e2d3c 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -65,6 +65,19 @@
 			pinctrl-0 = <&pinctrl_can_xcvr>;
 			gpio = <&gpio1 2 GPIO_ACTIVE_LOW>;
 		};
+
+		reg_wlan_vmmc: regulator at 4 {
+			compatible = "regulator-fixed";
+			reg = <4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_wlan_vmmc>;
+			regulator-name = "reg_wlan_vmmc";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio6 15 GPIO_ACTIVE_HIGH>;
+			startup-delay-us = <70000>;
+			enable-active-high;
+		};
 	};
 
 	gpio-keys {
@@ -411,6 +424,18 @@
 			>;
 		};
 
+		pinctrl_usdhc2: usdhc2grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD2_CMD__SD2_CMD		0x17071
+				MX6QDL_PAD_SD2_CLK__SD2_CLK		0x10071
+				MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x17071
+				MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x17071
+				MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x17071
+				MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x17071
+				MX6QDL_PAD_NANDF_CS2__GPIO6_IO15	0x000b0
+			>;
+		};
+
 		pinctrl_usdhc3: usdhc3grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD3_CMD__SD3_CMD		0x17059
@@ -434,6 +459,15 @@
 				MX6QDL_PAD_NANDF_D6__GPIO2_IO06 0x1b0b0	/* CD */
 			>;
 		};
+
+		pinctrl_wlan_vmmc: wlan_vmmcgrp {
+			fsl,pins = <
+				MX6QDL_PAD_NANDF_CS0__GPIO6_IO11	0x100b0
+				MX6QDL_PAD_NANDF_CS2__GPIO6_IO15	0x000b0
+				MX6QDL_PAD_NANDF_CS3__GPIO6_IO16	0x000b0
+				MX6QDL_PAD_SD1_CLK__OSC32K_32K_OUT	0x000b0
+			>;
+		};
 	};
 };
 
@@ -505,6 +539,27 @@
 	status = "okay";
 };
 
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	bus-width = <4>;
+	non-removable;
+	vmmc-supply = <&reg_wlan_vmmc>;
+	cap-power-off-card;
+	keep-power-in-suspend;
+	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	wlcore: wlcore at 2 {
+		compatible = "ti,wl1271";
+		reg = <2>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <14 IRQ_TYPE_LEVEL_HIGH>;
+		ref-clock-frequency = <38400000>;
+	};
+};
+
 &usdhc3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc3>;
-- 
2.5.3
