From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 May 2016 10:54:38 +0900
Subject: [PATCH v3 1/3] arm64: dts: r8a7796: Add Renesas R8A7796 SoC support
In-Reply-To: <1464054880-25843-1-git-send-email-horms+renesas@verge.net.au>
References: <1464054880-25843-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1464054880-25843-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Basic support for the Gen 3 R-Car M3-W SoC.

Based on work for the r8a7795 and r8a7796 SoCs by
Takeshi Kihara, Dirk Behme and Geert Uytterhoeven.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3
* As suggested by Geert Uytterhoeven:
  - Drop 0x from unit address of gic
* As suggested by Khiem Nguyen:
  - Use psci-0.2
* Added Reviewed-by tag from Geert Uytterhoeven

v2
* As suggested by Geert Uytterhoeven:
  - Move L2_CA57 node under cpus node and include reg property
  - Omit status = "disabled" from scif_clk node
---
 Documentation/devicetree/bindings/arm/shmobile.txt |   4 +
 arch/arm64/Kconfig.platforms                       |   6 ++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 120 +++++++++++++++++++++
 3 files changed, 130 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7796.dtsi

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 9cf67e48f222..d5ed554830d7 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -29,6 +29,8 @@ SoCs:
     compatible = "renesas,r8a7794"
   - R-Car H3 (R8A77950)
     compatible = "renesas,r8a7795"
+  - R-Car M3-W (R8A77960)
+    compatible = "renesas,r8a7796"
 
 
 Boards:
@@ -61,5 +63,7 @@ Boards:
     compatible = "renesas,porter", "renesas,r8a7791"
   - Salvator-X (RTP0RC7795SIPB0010S)
     compatible = "renesas,salvator-x", "renesas,r8a7795";
+  - Salvator-X
+    compatible = "renesas,salvator-x", "renesas,r8a7796";
   - SILK (RTP0RC7794LCB00011S)
     compatible = "renesas,silk", "renesas,r8a7794"
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index efa77c146415..16d8d26839ea 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -114,6 +114,12 @@ config ARCH_R8A7795
 	help
 	  This enables support for the Renesas R-Car H3 SoC.
 
+config ARCH_R8A7796
+	bool "Renesas R-Car M3-W SoC Platform"
+	depends on ARCH_RENESAS
+	help
+	  This enables support for the Renesas R-Car M3-W SoC.
+
 config ARCH_STRATIX10
 	bool "Altera's Stratix 10 SoCFPGA Family"
 	help
diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
new file mode 100644
index 000000000000..178debf68318
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -0,0 +1,120 @@
+/*
+ * Device Tree Source for the r8a7796 SoC
+ *
+ * Copyright (C) 2016 Renesas Electronics Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <dt-bindings/clock/r8a7796-cpg-mssr.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "renesas,r8a7796";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* 1 core only at this point */
+		a57_0: cpu at 0 {
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x0>;
+			device_type = "cpu";
+			next-level-cache = <&L2_CA57>;
+			enable-method = "psci";
+		};
+
+		L2_CA57: cache-controller at 0 {
+			compatible = "cache";
+			reg = <0>;
+			cache-unified;
+			cache-level = <2>;
+		};
+	};
+
+	extal_clk: extal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board */
+		clock-frequency = <0>;
+	};
+
+	extalr_clk: extalr {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board */
+		clock-frequency = <0>;
+	};
+
+	/* External SCIF clock - to be overridden by boards that provide it */
+	scif_clk: scif {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gic: interrupt-controller at f1010000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x0 0xf1010000 0 0x1000>,
+			      <0x0 0xf1020000 0 0x20000>,
+			      <0x0 0xf1040000 0 0x20000>,
+			      <0x0 0xf1060000 0 0x20000>;
+			interrupts = <GIC_PPI 9
+					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
+		};
+
+		timer {
+			compatible = "arm,armv8-timer";
+			interrupts = <GIC_PPI 13
+					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 14
+					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 11
+					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 10
+					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
+		};
+
+		cpg: clock-controller at e6150000 {
+			compatible = "renesas,r8a7796-cpg-mssr";
+			reg = <0 0xe6150000 0 0x1000>;
+			clocks = <&extal_clk>, <&extalr_clk>;
+			clock-names = "extal", "extalr";
+			#clock-cells = <2>;
+			#power-domain-cells = <0>;
+		};
+
+		scif2: serial at e6e88000 {
+			compatible = "renesas,scif-r8a7796",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
+			reg = <0 0xe6e88000 0 64>;
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 310>,
+				 <&cpg CPG_CORE R8A7796_CLK_S3D1>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.1.4
