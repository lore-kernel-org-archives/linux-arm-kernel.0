From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 22 Sep 2015 22:12:36 +0800
Subject: [PATCH 5/5] arm64: dts: berlin4ct: add pll and clock nodes
In-Reply-To: <1442931156-5877-1-git-send-email-jszhang@marvell.com>
References: <1442931156-5877-1-git-send-email-jszhang@marvell.com>
Message-ID: <1442931156-5877-6-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add syspll, mempll, cpupll, gate-clk and berlin-clk nodes.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi | 38 ++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
index e9409ec..92a1cf2 100644
--- a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
+++ b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
@@ -42,6 +42,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <dt-bindings/clock/berlin4ct.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
@@ -135,6 +136,22 @@
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		cpupll: cpupll {
+			compatible = "marvell,berlin-pll";
+			reg = <0x922000 0x14>, <0xea0710 4>;
+			#clock-cells = <0>;
+			clocks = <&osc>, <&clk CLK_CPUFASTREF>;
+			bypass-shift = /bits/ 8 <2>;
+		};
+
+		mempll: mempll {
+			compatible = "marvell,berlin-pll";
+			reg = <0x940034 0x14>, <0xea0710 4>;
+			#clock-cells = <0>;
+			clocks = <&osc>, <&clk CLK_MEMFASTREF>;
+			bypass-shift = /bits/ 8 <1>;
+		};
+
 		apb at e80000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
@@ -225,6 +242,27 @@
 			};
 		};
 
+		syspll: syspll {
+			compatible = "marvell,berlin-pll";
+			reg = <0xea0200 0x14>, <0xea0710 4>;
+			#clock-cells = <0>;
+			clocks = <&osc>;
+			bypass-shift = /bits/ 8 <0>;
+		};
+
+		gateclk: gateclk {
+			compatible = "marvell,berlin4ct-gateclk";
+			reg = <0xea0700 4>;
+			#clock-cells = <1>;
+		};
+
+		clk: clk {
+			compatible = "marvell,berlin4ct-clk";
+			reg = <0xea0720 0x144>;
+			#clock-cells = <1>;
+			clocks = <&syspll>;
+		};
+
 		soc_pinctrl: pinctrl at ea8000 {
 			compatible = "marvell,berlin4ct-soc-pinctrl";
 			reg = <0xea8000 0x14>;
-- 
2.5.3
