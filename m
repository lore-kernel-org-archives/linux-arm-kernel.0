From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 26 Jul 2017 16:28:32 +0800
Subject: [PATCH v2 9/9] ARM: sun8i: a83t: h8homlet-v2: Enable AC100 combo chip
 in AXP818 PMIC
In-Reply-To: <20170726082832.16789-1-wens@csie.org>
References: <20170726082832.16789-1-wens@csie.org>
Message-ID: <20170726082832.16789-10-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AXP813/AXP818 PMICs used with the A83T/H8 SoCs are actually 2 dies
in one package sharing the serial bus (I2C/RSB) pins. One die is the
actual PMIC. The other is an AC100 codec / RTC combo chip.

This patch adds the device nodes for the AC100 chip to the h8homlet-v2
device tree.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts  | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts b/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts
index 7e92baa63f1c..e0055180d29f 100644
--- a/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts
@@ -87,6 +87,30 @@
 		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 	};
+
+	ac100: codec at e89 {
+		compatible = "x-powers,ac100";
+		reg = <0xe89>;
+
+		ac100_codec: codec {
+			compatible = "x-powers,ac100-codec";
+			interrupt-parent = <&r_pio>;
+			interrupts = <0 11 IRQ_TYPE_LEVEL_LOW>; /* PL11 */
+			#clock-cells = <0>;
+			clock-output-names = "4M_adda";
+		};
+
+		ac100_rtc: rtc {
+			compatible = "x-powers,ac100-rtc";
+			interrupt-parent = <&r_intc>;
+			interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&ac100_codec>;
+			#clock-cells = <1>;
+			clock-output-names = "cko1_rtc",
+					     "cko2_rtc",
+					     "cko3_rtc";
+		};
+	};
 };
 
 &uart0 {
-- 
2.13.3
