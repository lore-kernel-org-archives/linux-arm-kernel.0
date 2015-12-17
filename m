From: damien.riegel@savoirfairelinux.com (Damien Riegel)
Date: Thu, 17 Dec 2015 16:16:53 -0500
Subject: [PATCH 2/2] ARM: dts: TS-4800: use weim IP to map the FPGA
In-Reply-To: <1450387013-3532-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1450387013-3532-1-git-send-email-damien.riegel@savoirfairelinux.com>
Message-ID: <1450387013-3532-2-git-send-email-damien.riegel@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously, the device tree mapped the FPGA like any other IPs inside
the SoC, but it is actually mapped through the WEIM (Wireless External
Interface Module). This patch updates the device tree to make use of it.

About the timings: in the image provided by the manufacturer, only
CS0GCR1 is changed. The other values are the default ones, but the WEIM
bindings expect them to be all explicitly set in the device tree, so I
just put the default values in the dt.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
 arch/arm/boot/dts/imx51-ts4800.dts | 60 +++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-ts4800.dts b/arch/arm/boot/dts/imx51-ts4800.dts
index 64ac55c..83352cb 100644
--- a/arch/arm/boot/dts/imx51-ts4800.dts
+++ b/arch/arm/boot/dts/imx51-ts4800.dts
@@ -21,27 +21,6 @@
 		reg = <0x90000000 0x10000000>;
 	};
 
-	soc {
-		fpga {
-			compatible = "simple-bus";
-			reg = <0xb0000000 0x1d000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			syscon: syscon at b0010000 {
-				compatible = "syscon", "simple-mfd";
-				reg = <0xb0010000 0x3d>;
-				reg-io-width = <2>;
-
-				wdt at e {
-					compatible = "technologic,ts4800-wdt";
-					syscon = <&syscon 0xe>;
-				};
-			};
-		};
-	};
-
 	clocks {
 		ckih1 {
 			clock-frequency = <22579200>;
@@ -99,6 +78,33 @@
 	status = "okay";
 };
 
+&weim {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_weim>;
+	status = "okay";
+
+	fpga at 0 {
+		compatible = "simple-bus";
+		fsl,weim-cs-timing = <0x0061008F 0x00000002 0x1c022000
+				      0x00000000 0x1c092480 0x00000000>;
+		reg = <0 0x0000000 0x1d000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0 0x1d000>;
+
+		syscon: syscon at b0010000 {
+			compatible = "syscon", "simple-mfd";
+			reg = <0x10000 0x3d>;
+			reg-io-width = <2>;
+
+			wdt at e {
+				compatible = "technologic,ts4800-wdt";
+				syscon = <&syscon 0xe>;
+			};
+		};
+	};
+};
+
 &iomuxc {
 	pinctrl_ecspi1: ecspi1grp {
 		fsl,pins = <
@@ -173,4 +179,16 @@
 			MX51_PAD_EIM_D26__UART3_TXD		0x1c5
 		>;
 	};
+
+	pinctrl_weim: weimgrp {
+		fsl,pins = <
+			MX51_PAD_EIM_DTACK__EIM_DTACK		0x85
+			MX51_PAD_EIM_CS0__EIM_CS0		0x0
+			MX51_PAD_EIM_CS1__EIM_CS1		0x0
+			MX51_PAD_EIM_EB0__EIM_EB0		0x85
+			MX51_PAD_EIM_EB1__EIM_EB1		0x85
+			MX51_PAD_EIM_OE__EIM_OE			0x85
+			MX51_PAD_EIM_LBA__EIM_LBA		0x85
+		>;
+	};
 };
-- 
2.5.0
