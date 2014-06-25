From: marex@denx.de (Marek Vasut)
Date: Wed, 25 Jun 2014 20:48:33 +0200
Subject: [PATCH 2/2] ARM: dts: mxs: Split M28EVK into SoM and EVK parts
In-Reply-To: <1403722113-5721-1-git-send-email-marex@denx.de>
References: <1403722113-5721-1-git-send-email-marex@denx.de>
Message-ID: <1403722113-5721-2-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch splits the M28EVK device tree file into a common SoM
part and an EVK part. This is needed to make it easier for users
of the SoM to put it into different, non-reference baseboard.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx28-m28.dtsi   | 87 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx28-m28evk.dts | 62 +--------------------------
 2 files changed, 88 insertions(+), 61 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx28-m28.dtsi

diff --git a/arch/arm/boot/dts/imx28-m28.dtsi b/arch/arm/boot/dts/imx28-m28.dtsi
new file mode 100644
index 0000000..759cc56
--- /dev/null
+++ b/arch/arm/boot/dts/imx28-m28.dtsi
@@ -0,0 +1,87 @@
+/*
+ * Copyright (C) 2014 Marek Vasut <marex@denx.de>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include "imx28.dtsi"
+
+/ {
+	model = "DENX M28";
+	compatible = "denx,m28", "fsl,imx28";
+
+	memory {
+		reg = <0x40000000 0x08000000>;
+	};
+
+	apb at 80000000 {
+		apbh at 80000000 {
+			gpmi-nand at 8000c000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&gpmi_pins_a &gpmi_status_cfg>;
+				status = "okay";
+
+				partition at 0 {
+					label = "bootloader";
+					reg = <0x00000000 0x00300000>;
+					read-only;
+				};
+
+				partition at 1 {
+					label = "environment";
+					reg = <0x00300000 0x00080000>;
+				};
+
+				partition at 2 {
+					label = "redundant-environment";
+					reg = <0x00380000 0x00080000>;
+				};
+
+				partition at 3 {
+					label = "kernel";
+					reg = <0x00400000 0x00400000>;
+				};
+
+				partition at 4 {
+					label = "filesystem";
+					reg = <0x00800000 0x0f800000>;
+				};
+			};
+		};
+
+		apbx at 80040000 {
+			i2c0: i2c at 80058000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&i2c0_pins_a>;
+				status = "okay";
+
+				rtc: rtc at 68 {
+					compatible = "stm,m41t62";
+					reg = <0x68>;
+				};
+			};
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_3p3v: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "3P3V";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx28-m28evk.dts b/arch/arm/boot/dts/imx28-m28evk.dts
index f0ad7b9..b3c09ae 100644
--- a/arch/arm/boot/dts/imx28-m28evk.dts
+++ b/arch/arm/boot/dts/imx28-m28evk.dts
@@ -10,52 +10,14 @@
  */
 
 /dts-v1/;
-#include "imx28.dtsi"
+#include "imx28-m28.dtsi"
 
 / {
 	model = "DENX M28EVK";
 	compatible = "denx,m28evk", "fsl,imx28";
 
-	memory {
-		reg = <0x40000000 0x08000000>;
-	};
-
 	apb at 80000000 {
 		apbh at 80000000 {
-			gpmi-nand at 8000c000 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				pinctrl-names = "default";
-				pinctrl-0 = <&gpmi_pins_a &gpmi_status_cfg>;
-				status = "okay";
-
-				partition at 0 {
-					label = "bootloader";
-					reg = <0x00000000 0x00300000>;
-					read-only;
-				};
-
-				partition at 1 {
-					label = "environment";
-					reg = <0x00300000 0x00080000>;
-				};
-
-				partition at 2 {
-					label = "redundant-environment";
-					reg = <0x00380000 0x00080000>;
-				};
-
-				partition at 3 {
-					label = "kernel";
-					reg = <0x00400000 0x00400000>;
-				};
-
-				partition at 4 {
-					label = "filesystem";
-					reg = <0x00800000 0x0f800000>;
-				};
-			};
-
 			ssp0: ssp at 80010000 {
 				compatible = "fsl,imx28-mmc";
 				pinctrl-names = "default";
@@ -175,10 +137,6 @@
 			};
 
 			i2c0: i2c at 80058000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&i2c0_pins_a>;
-				status = "okay";
-
 				sgtl5000: codec at 0a {
 					compatible = "fsl,sgtl5000";
 					reg = <0x0a>;
@@ -192,11 +150,6 @@
 					reg = <0x51>;
 					pagesize = <32>;
 				};
-
-				rtc: rtc at 68 {
-					compatible = "stm,m41t62";
-					reg = <0x68>;
-				};
 			};
 
 			lradc at 80050000 {
@@ -284,19 +237,6 @@
 	};
 
 	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reg_3p3v: regulator at 0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "3P3V";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
-
 		reg_vddio_sd0: regulator at 1 {
 			compatible = "regulator-fixed";
 			reg = <1>;
-- 
2.0.0.rc2
