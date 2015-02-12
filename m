From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Thu, 12 Feb 2015 01:55:13 +0100
Subject: [PATCH 5/5] ARM: dts: zynq: Add USB for Parallella
In-Reply-To: <1423702513-4032-1-git-send-email-afaerber@suse.de>
References: <1423702513-4032-1-git-send-email-afaerber@suse.de>
Message-ID: <1423702513-4032-6-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Microserver edition does not feature USB - only the Kickstarter,
pre-order, Desktop and Embedded editions.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/zynq-parallella.dts   | 16 +++++++
 arch/arm/boot/dts/zynq-parallella1.dtsi | 74 +++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
index 99ee6551ae8d..b2eede1c708f 100644
--- a/arch/arm/boot/dts/zynq-parallella.dts
+++ b/arch/arm/boot/dts/zynq-parallella.dts
@@ -17,3 +17,19 @@
 / {
 	model = "Adapteva Parallella Board";
 };
+
+&usb_phy0 {
+	status = "okay";
+};
+
+&usb_phy1 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/zynq-parallella1.dtsi b/arch/arm/boot/dts/zynq-parallella1.dtsi
index 8b2895c06c8e..1395aaadf3be 100644
--- a/arch/arm/boot/dts/zynq-parallella1.dtsi
+++ b/arch/arm/boot/dts/zynq-parallella1.dtsi
@@ -47,6 +47,18 @@
 			default-state = "on";
 		};
 	};
+
+	usb_phy0: phy0 {
+		compatible = "usb-nop-xceiv";
+		#phy-cells = <0>;
+		status = "disabled";
+	};
+
+	usb_phy1: phy1 {
+		compatible = "usb-nop-xceiv";
+		#phy-cells = <0>;
+		status = "disabled";
+	};
 };
 
 &clkc {
@@ -208,6 +220,54 @@
 			bias-disable = <0>;
 		};
 	};
+
+	pinctrl_usb0_default: usb0-default {
+		mux {
+			function = "usb0";
+			groups = "usb0_0_grp";
+		};
+
+		conf {
+			groups = "usb0_0_grp";
+			slew-rate = <0>;
+			io-standard = <1>;
+		};
+
+		conf-rx {
+			pins = "MIO29", "MIO31", "MIO36";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO28", "MIO30", "MIO32", "MIO33", "MIO34",
+			       "MIO35", "MIO37", "MIO38", "MIO39";
+			bias-disable;
+		};
+	};
+
+	pinctrl_usb1_default: usb1-default {
+		mux {
+			function = "usb1";
+			groups = "usb1_0_grp";
+		};
+
+		conf {
+			groups = "usb1_0_grp";
+			slew-rate = <0>;
+			io-standard = <1>;
+		};
+
+		conf-rx {
+			pins = "MIO41", "MIO43", "MIO48";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO40", "MIO42", "MIO44", "MIO45", "MIO46",
+			       "MIO47", "MIO49", "MIO50", "MIO51";
+			bias-disable;
+		};
+	};
 };
 
 &sdhci1 {
@@ -221,3 +281,17 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1_default>;
 };
+
+&usb0 {
+	dr_mode = "host";
+	usb-phy = <&usb_phy0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb0_default>;
+};
+
+&usb1 {
+	dr_mode = "peripheral";
+	usb-phy = <&usb_phy1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb1_default>;
+};
-- 
2.2.2
