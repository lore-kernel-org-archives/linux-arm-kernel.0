From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 18 Mar 2015 20:16:03 +0100
Subject: [PATCH/RFC 4/5] ARM: shmobile: r8a7791: Add INTC-SYS clock to device
 tree
In-Reply-To: <1426706164-28309-1-git-send-email-geert+renesas@glider.be>
References: <1426706164-28309-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1426706164-28309-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Link the ARM GIC to the INTC-SYS module clock, so it can be power
managed using that clock in the future.

Note that currently the GIC driver doesn't support module clocks nor
Runtime PM.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791.dtsi            | 7 ++++---
 include/dt-bindings/clock/r8a7791-clock.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 20ab7668088493b9..9191acce98a6eeb2 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -79,6 +79,7 @@
 			<0 0xf1004000 0 0x2000>,
 			<0 0xf1006000 0 0x2000>;
 		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+		clocks = <&mstp4_clks R8A7791_CLK_INTC_SYS>;
 	};
 
 	gpio0: gpio at e6050000 {
@@ -1164,10 +1165,10 @@
 		mstp4_clks: mstp4_clks at e6150140 {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150140 0 4>, <0 0xe615004c 0 4>;
-			clocks = <&cp_clk>;
+			clocks = <&cp_clk>, <&zs_clk>;
 			#clock-cells = <1>;
-			clock-indices = <R8A7791_CLK_IRQC>;
-			clock-output-names = "irqc";
+			clock-indices = <R8A7791_CLK_IRQC R8A7791_CLK_INTC_SYS>;
+			clock-output-names = "irqc", "intc-sys";
 		};
 		mstp5_clks: mstp5_clks at e6150144 {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7791-clock.h b/include/dt-bindings/clock/r8a7791-clock.h
index 402268384b99093c..102b47a797116dce 100644
--- a/include/dt-bindings/clock/r8a7791-clock.h
+++ b/include/dt-bindings/clock/r8a7791-clock.h
@@ -72,6 +72,7 @@
 
 /* MSTP4 */
 #define R8A7791_CLK_IRQC		7
+#define R8A7791_CLK_INTC_SYS		8
 
 /* MSTP5 */
 #define R8A7791_CLK_AUDIO_DMAC1		1
-- 
1.9.1
