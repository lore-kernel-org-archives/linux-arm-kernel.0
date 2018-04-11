From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 11 Apr 2018 16:54:00 +0800
Subject: [PATCH v2 07/12] arm: dts: mt6323: move node mt6323 leds to
 mt6323.dtsi
In-Reply-To: <cover.1523434757.git.sean.wang@mediatek.com>
References: <cover.1523434757.git.sean.wang@mediatek.com>
Message-ID: <d6a553c1d01596d7317520c6121eeef9b2741d62.1523434758.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Since those LEDs are parts of PMIC MT6323, it is reasonable to merge
those LEDs node definition back into mt6323.dtsi. This way can improve
the reusability of those nodes among different boards with the same PMIC.

And LED is very much board specific and thus the mt6323.dtsi only includes
the parent node here and leave these child nodes in the board specific
dts file.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
---
 arch/arm/boot/dts/mt6323.dtsi                 |  9 ++++-
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 50 ++++++++++++---------------
 2 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/arch/arm/boot/dts/mt6323.dtsi b/arch/arm/boot/dts/mt6323.dtsi
index 958980c..ba39740 100644
--- a/arch/arm/boot/dts/mt6323.dtsi
+++ b/arch/arm/boot/dts/mt6323.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2017 MediaTek Inc.
+ * Copyright (c) 2017-2018 MediaTek Inc.
  * Author: John Crispin <john@phrozen.org>
  *	   Sean Wang <sean.wang@mediatek.com>
  *
@@ -14,6 +14,13 @@
 		interrupt-controller;
 		#interrupt-cells = <2>;
 
+		mt6323_leds: leds {
+			compatible = "mediatek,mt6323-led";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		mt6323regulator: mt6323regulator{
 			compatible = "mediatek,mt6323-regulator";
 
diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index 1fd6f55..395912e 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -237,6 +237,28 @@
 	vqmmc-supply = <&reg_3p3v>;
 };
 
+&mt6323_leds {
+	status = "okay";
+
+	led at 0 {
+		reg = <0>;
+		label = "bpi-r2:isink:green";
+		default-state = "off";
+	};
+
+	led at 1 {
+		reg = <1>;
+		label = "bpi-r2:isink:red";
+		default-state = "off";
+	};
+
+	led at 2 {
+		reg = <2>;
+		label = "bpi-r2:isink:blue";
+		default-state = "off";
+	};
+};
+
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie_default>;
@@ -482,34 +504,6 @@
 	status = "okay";
 };
 
-&pwrap {
-	mt6323 {
-		mt6323led: led {
-			compatible = "mediatek,mt6323-led";
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			led at 0 {
-				reg = <0>;
-				label = "bpi-r2:isink:green";
-				default-state = "off";
-			};
-
-			led at 1 {
-				reg = <1>;
-				label = "bpi-r2:isink:red";
-				default-state = "off";
-			};
-
-			led at 2 {
-				reg = <2>;
-				label = "bpi-r2:isink:blue";
-				default-state = "off";
-			};
-		};
-	};
-};
-
 &spi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi0_pins_a>;
-- 
2.7.4
