From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 22 Jun 2017 12:08:33 +0800
Subject: [PATCH 6/6] ARM: sun8i: a83t: Enable AC100 codec / RTC combo chip in
 AXP813 PMIC
In-Reply-To: <20170622040833.15329-1-wens@csie.org>
References: <20170622040833.15329-1-wens@csie.org>
Message-ID: <20170622040833.15329-7-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AXP813/AXP818 PMICs used with the A83T/H8 SoCs are actually 2 dies
in one package sharing the serial bus (I2C/RSB) pins. One die is the
actual PMIC. The other is an AC100 codec / RTC combo chip.

This patch enables the RSB controller and adds the device nodes for
the AC100 chip under it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
index 027602ce03d1..933245758603 100644
--- a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
@@ -111,6 +111,30 @@
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
 
 &spdif {
-- 
2.11.0
