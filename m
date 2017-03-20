From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 20 Mar 2017 09:58:01 +0100
Subject: [PATCH 22/31] ARM: dts: r8a7793: Add INTC-SYS clock to device tree
In-Reply-To: <cover.1489999062.git.horms+renesas@verge.net.au>
References: <cover.1489999062.git.horms+renesas@verge.net.au>
Message-ID: <2f25c2d1cdf04ab0f247351e286d3fdefbdad09b.1489999063.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Link the ARM GIC to the INTC-SYS module clock, and add it to the "always
on" PM Domain, so it can be power managed using that clock.

Note that currently the GIC-400 driver doesn't support module clocks nor
Runtime PM, so this must be handled as a critical clock.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi            | 11 ++++++++---
 include/dt-bindings/clock/r8a7793-clock.h |  5 +++--
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 53c89b47eaf0..9fcf3a9ca084 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -108,6 +108,9 @@
 			<0 0xf1004000 0 0x2000>,
 			<0 0xf1006000 0 0x2000>;
 		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+		clocks = <&mstp4_clks R8A7793_CLK_INTC_SYS>;
+		clock-names = "clk";
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 	};
 
 	gpio0: gpio at e6050000 {
@@ -1178,10 +1181,12 @@
 		mstp4_clks: mstp4_clks at e6150140 {
 			compatible = "renesas,r8a7793-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150140 0 4>, <0 0xe615004c 0 4>;
-			clocks = <&cp_clk>;
+			clocks = <&cp_clk>, <&zs_clk>;
 			#clock-cells = <1>;
-			clock-indices = <R8A7793_CLK_IRQC>;
-			clock-output-names = "irqc";
+			clock-indices = <
+				R8A7793_CLK_IRQC R8A7793_CLK_INTC_SYS
+			>;
+			clock-output-names = "irqc", "intc-sys";
 		};
 		mstp5_clks: mstp5_clks at e6150144 {
 			compatible = "renesas,r8a7793-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7793-clock.h b/include/dt-bindings/clock/r8a7793-clock.h
index efcbc594fe82..7318d45d4e7e 100644
--- a/include/dt-bindings/clock/r8a7793-clock.h
+++ b/include/dt-bindings/clock/r8a7793-clock.h
@@ -77,10 +77,11 @@
 
 /* MSTP4 */
 #define R8A7793_CLK_IRQC		7
+#define R8A7793_CLK_INTC_SYS		8
 
 /* MSTP5 */
-#define R8A7793_CLK_AUDIO_DMAC1         1
-#define R8A7793_CLK_AUDIO_DMAC0         2
+#define R8A7793_CLK_AUDIO_DMAC1		1
+#define R8A7793_CLK_AUDIO_DMAC0		2
 #define R8A7793_CLK_ADSP_MOD		6
 #define R8A7793_CLK_THERMAL		22
 #define R8A7793_CLK_PWM			23
-- 
2.7.0.rc3.207.g0ac5344
