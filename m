From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 20 Mar 2017 09:57:40 +0100
Subject: [PATCH 01/31] ARM: dts: r7s72100: update sdhi clock bindings
In-Reply-To: <cover.1489999062.git.horms+renesas@verge.net.au>
References: <cover.1489999062.git.horms+renesas@verge.net.au>
Message-ID: <3d2abda02ad2d06d5f22de7f6b0f39126670bc48.1489999062.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Brandt <chris.brandt@renesas.com>

The SDHI controller in the RZ/A1 has 2 clock sources per channel and both
need to be enabled/disabled for proper operation. This fixes the fact that
the define for R7S72100_CLK_SDHI1 was not correct to begin with (typo), and
that all 4 clock sources need to be defined an used.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100.dtsi            | 17 ++++++++++++-----
 include/dt-bindings/clock/r7s72100-clock.h |  6 ++++--
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index b8aa256bd515..614ba79a9774 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -162,9 +162,12 @@
 			#clock-cells = <1>;
 			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0xfcfe0444 4>;
-			clocks = <&p1_clk>, <&p1_clk>;
-			clock-indices = <R7S72100_CLK_SDHI1 R7S72100_CLK_SDHI0>;
-			clock-output-names = "sdhi1", "sdhi0";
+			clocks = <&p1_clk>, <&p1_clk>, <&p1_clk>, <&p1_clk>;
+			clock-indices = <
+				R7S72100_CLK_SDHI00 R7S72100_CLK_SDHI01
+				R7S72100_CLK_SDHI10 R7S72100_CLK_SDHI11
+			>;
+			clock-output-names = "sdhi00", "sdhi01", "sdhi10", "sdhi11";
 		};
 	};
 
@@ -488,7 +491,9 @@
 			      GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH
 			      GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
 
-		clocks = <&mstp12_clks R7S72100_CLK_SDHI0>;
+		clocks = <&mstp12_clks R7S72100_CLK_SDHI00>,
+			 <&mstp12_clks R7S72100_CLK_SDHI01>;
+		clock-names = "core", "cd";
 		cap-sd-highspeed;
 		cap-sdio-irq;
 		status = "disabled";
@@ -501,7 +506,9 @@
 			      GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH
 			      GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>;
 
-		clocks = <&mstp12_clks R7S72100_CLK_SDHI1>;
+		clocks = <&mstp12_clks R7S72100_CLK_SDHI10>,
+			 <&mstp12_clks R7S72100_CLK_SDHI11>;
+		clock-names = "core", "cd";
 		cap-sd-highspeed;
 		cap-sdio-irq;
 		status = "disabled";
diff --git a/include/dt-bindings/clock/r7s72100-clock.h b/include/dt-bindings/clock/r7s72100-clock.h
index ce09915c298f..cd2ed5194255 100644
--- a/include/dt-bindings/clock/r7s72100-clock.h
+++ b/include/dt-bindings/clock/r7s72100-clock.h
@@ -49,7 +49,9 @@
 #define R7S72100_CLK_SPI4	3
 
 /* MSTP12 */
-#define R7S72100_CLK_SDHI0	3
-#define R7S72100_CLK_SDHI1	2
+#define R7S72100_CLK_SDHI00	3
+#define R7S72100_CLK_SDHI01	2
+#define R7S72100_CLK_SDHI10	1
+#define R7S72100_CLK_SDHI11	0
 
 #endif /* __DT_BINDINGS_CLOCK_R7S72100_H__ */
-- 
2.7.0.rc3.207.g0ac5344
