From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 24 May 2017 11:43:41 +0300
Subject: [PATCH] ARM: dts: am43xx-clocks: Add support for CLKOUT2
Message-ID: <20170524084341.16698-1-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the needed clock nodes for the CLKOUT2 to be usable by boards.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am43xx-clocks.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
index d1d73b725f47..430be5829f8f 100644
--- a/arch/arm/boot/dts/am43xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
@@ -833,4 +833,40 @@
 		ti,bit-shift = <23>;
 		reg = <0x4100>;
 	};
+
+	clkout2_src_mux_ck: clkout2_src_mux_ck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&clk_rc32k_ck>, <&sysclk_div>, <&dpll_ddr_m2_ck>,
+			 <&dpll_per_m2_ck>, <&dpll_disp_m2_ck>,
+			 <&dpll_mpu_m2_ck>, <&dpll_extdev_ck>;
+		reg = <0x4108>;
+	};
+
+	clkout2_pre_div_ck: clkout2_pre_div_ck {
+		#clock-cells = <0>;
+		compatible = "ti,divider-clock";
+		clocks = <&clkout2_src_mux_ck>;
+		ti,bit-shift = <4>;
+		ti,max-div = <8>;
+		reg = <0x4108>;
+	};
+
+	clkout2_post_div_ck: clkout2_post_div_ck {
+		#clock-cells = <0>;
+		compatible = "ti,divider-clock";
+		clocks = <&clkout2_pre_div_ck>;
+		ti,bit-shift = <8>;
+		ti,max-div = <32>;
+		ti,index-power-of-two;
+		reg = <0x4108>;
+	};
+
+	clkout2_ck: clkout2_ck {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&clkout2_post_div_ck>;
+		ti,bit-shift = <16>;
+		reg = <0x4108>;
+	};
 };
-- 
2.13.0
