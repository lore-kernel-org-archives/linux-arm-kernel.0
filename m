From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 17 Feb 2017 16:04:09 +0100
Subject: [PATCH v3] arm64: dts: r8a7795: Add Cortex-A53 CPU cores
Message-ID: <1487343849-32616-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds Cortex-A53 CPU cores to r8a7795 SoC for a total of 8
cores (4 x Cortex-A57 + 4 x Cortex-A53).

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
[geert: Add power-domains and next-level-cache properties]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This patch describes the hardware; actual enabling of the CPU depends on
the PSCI firmware.

With the current firmware version (v2.16.0), only the CA57 CPU cores are
enabled, hence this patch does not introduce undeterministic scheduling
behavior due to migration between big and LITTLE cores.

v3:
  - Link recently added CPU nodes 100-103 to their L2 cache nodes,

v2:
  - Rebased.
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 58 ++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 7f2434adb757498f..6148e514eb648288 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -73,6 +73,42 @@
 			enable-method = "psci";
 		};
 
+		a53_0: cpu at 100 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x100>;
+			device_type = "cpu";
+			power-domains = <&sysc R8A7795_PD_CA53_CPU0>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+		};
+
+		a53_1: cpu at 101 {
+			compatible = "arm,cortex-a53","arm,armv8";
+			reg = <0x101>;
+			device_type = "cpu";
+			power-domains = <&sysc R8A7795_PD_CA53_CPU1>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+		};
+
+		a53_2: cpu at 102 {
+			compatible = "arm,cortex-a53","arm,armv8";
+			reg = <0x102>;
+			device_type = "cpu";
+			power-domains = <&sysc R8A7795_PD_CA53_CPU2>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+		};
+
+		a53_3: cpu at 103 {
+			compatible = "arm,cortex-a53","arm,armv8";
+			reg = <0x103>;
+			device_type = "cpu";
+			power-domains = <&sysc R8A7795_PD_CA53_CPU3>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+		};
+
 		L2_CA57: cache-controller at 0 {
 			compatible = "cache";
 			reg = <0>;
@@ -166,7 +202,7 @@
 			      <0x0 0xf1040000 0 0x20000>,
 			      <0x0 0xf1060000 0 0x20000>;
 			interrupts = <GIC_PPI 9
-					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&cpg CPG_MOD 408>;
 			clock-names = "clk";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
@@ -307,23 +343,31 @@
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-affinity = <&a57_0>,
 					     <&a57_1>,
 					     <&a57_2>,
-					     <&a57_3>;
+					     <&a57_3>,
+					     <&a53_0>,
+					     <&a53_1>,
+					     <&a53_2>,
+					     <&a53_3>;
 		};
 
 		timer {
 			compatible = "arm,armv8-timer";
 			interrupts = <GIC_PPI 13
-					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
 				     <GIC_PPI 14
-					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
 				     <GIC_PPI 11
-					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
 				     <GIC_PPI 10
-					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
 		};
 
 		cpg: clock-controller at e6150000 {
-- 
1.9.1
