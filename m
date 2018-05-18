From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:16:39 +0200
Subject: [PATCH 06/69] ARM: dts: r8a77470: Initial SoC device tree
In-Reply-To: <cover.1526641667.git.horms+renesas@verge.net.au>
References: <cover.1526641667.git.horms+renesas@verge.net.au>
Message-ID: <6929dfc5918049272e07653b1760b0b305f098e6.1526641667.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

The initial R8A77470 SoC device tree including CPU0, GIC, timer, SYSC, RST,
CPG, and the required clock descriptions.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a77470.dtsi | 154 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a77470.dtsi

diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/r8a77470.dtsi
new file mode 100644
index 000000000000..45785828771b
--- /dev/null
+++ b/arch/arm/boot/dts/r8a77470.dtsi
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the r8a77470 SoC
+ *
+ * Copyright (C) 2018 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/renesas-cpg-mssr.h>
+/ {
+	compatible = "renesas,r8a77470";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0>;
+			clock-frequency = <1000000000>;
+			clocks = <&cpg CPG_CORE 0>;
+			power-domains = <&sysc 5>;
+			next-level-cache = <&L2_CA7>;
+		};
+
+
+		L2_CA7: cache-controller-0 {
+			compatible = "cache";
+			cache-unified;
+			cache-level = <2>;
+			power-domains = <&sysc 21>;
+		};
+	};
+
+	/* External root clock */
+	extal_clk: extal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
+
+	/* External SCIF clock */
+	scif_clk: scif {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		cpg: clock-controller at e6150000 {
+			compatible = "renesas,r8a77470-cpg-mssr";
+			reg = <0 0xe6150000 0 0x1000>;
+			clocks = <&extal_clk>, <&usb_extal_clk>;
+			clock-names = "extal", "usb_extal";
+			#clock-cells = <2>;
+			#power-domain-cells = <0>;
+			#reset-cells = <1>;
+		};
+
+		rst: reset-controller at e6160000 {
+			compatible = "renesas,r8a77470-rst";
+			reg = <0 0xe6160000 0 0x100>;
+		};
+
+		sysc: system-controller at e6180000 {
+			compatible = "renesas,r8a77470-sysc";
+			reg = <0 0xe6180000 0 0x200>;
+			#power-domain-cells = <1>;
+		};
+
+		icram0:	sram at e63a0000 {
+			compatible = "mmio-sram";
+			reg = <0 0xe63a0000 0 0x12000>;
+		};
+
+		icram1:	sram at e63c0000 {
+			compatible = "mmio-sram";
+			reg = <0 0xe63c0000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0xe63c0000 0x1000>;
+
+			smp-sram at 0 {
+				compatible = "renesas,smp-sram";
+				reg = <0 0x100>;
+			};
+		};
+
+		icram2:	sram at e6300000 {
+			compatible = "mmio-sram";
+			reg = <0 0xe6300000 0 0x20000>;
+		};
+
+		scif1: serial at e6e68000 {
+			compatible = "renesas,scif-r8a77470",
+				     "renesas,rcar-gen2-scif", "renesas,scif";
+			reg = <0 0xe6e68000 0 0x40>;
+			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&cpg CPG_MOD 720>,
+				 <&cpg CPG_CORE 6>, <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 720>;
+			status = "disabled";
+		};
+
+		gic: interrupt-controller at f1001000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0 0xf1001000 0 0x1000>, <0 0xf1002000 0 0x2000>,
+			      <0 0xf1004000 0 0x2000>, <0 0xf1006000 0 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&cpg CPG_MOD 408>;
+			clock-names = "clk";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 408>;
+		};
+
+		prr: chipid at ff000044 {
+			compatible = "renesas,prr";
+			reg = <0 0xff000044 0 4>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	/* External USB clock - can be overridden by the board */
+	usb_extal_clk: usb_extal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <48000000>;
+	};
+};
-- 
2.11.0
