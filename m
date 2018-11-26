From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 26 Nov 2018 16:45:55 -0200
Subject: [RFC 2/2] ARM: dts: imx7: Correct mask for GIC PPI interrupts
In-Reply-To: <1543257955-8910-1-git-send-email-festevam@gmail.com>
References: <1543257955-8910-1-git-send-email-festevam@gmail.com>
Message-ID: <1543257955-8910-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GIC_CPU_MASK_SIMPLE() macro should take as its argument the actual
number of CPU cores the interrupt controller is wired to.

i.MX7S contains a single Cortex-A7, hence the second interrupt specifier
cell for Private Peripheral Interrupts should use "GIC_CPU_MASK_SIMPLE(1)".

Likewise, i.MX7D contains two Cortex-A7 cores, so it should use
"GIC_CPU_MASK_SIMPLE(2)" instead.

Tested on a imx7s-warp.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 9 +++++++++
 arch/arm/boot/dts/imx7s.dtsi | 8 ++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 826224b..b066749 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -24,6 +24,15 @@
 		};
 	};
 
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupt-parent = <&intc>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
 	cpu0_opp_table: opp-table {
 		compatible = "operating-points-v2";
 		opp-shared;
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 477901c..be02a10 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -160,10 +160,10 @@
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupt-parent = <&intc>;
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
 	soc {
-- 
2.7.4
