From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 2 Feb 2018 21:33:39 +0300
Subject: [PATCH 05/11] arm64: dts: renesas: initial R8A77980 SoC device tree
In-Reply-To: <46fca582-220d-e5a7-62cd-2fc77a29846b@cogentembedded.com>
References: <46fca582-220d-e5a7-62cd-2fc77a29846b@cogentembedded.com>
Message-ID: <32142684-d5cf-035f-8401-86a36dcbafd6@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The initial R8A77980 SoC device tree including Cortex-A53 CPU, GIC, timer,
CPG, RST, and SYSC.

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm64/boot/dts/renesas/r8a77980.dtsi |  122 ++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
===================================================================
--- /dev/null
+++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the r8a77980 SoC
+ *
+ * Copyright (C) 2018 Renesas Electronics Corp.
+ * Copyright (C) 2018 Cogent Embedded, Inc.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/renesas-cpg-mssr.h>
+
+/ {
+	compatible = "renesas,r8a77980";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		a53_0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0>;
+			clocks = <&cpg CPG_CORE 0>;
+			power-domains = <&sysc 5>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+		};
+
+		L2_CA53: cache-controller {
+			compatible = "cache";
+			power-domains = <&sysc 21>;
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
+	psci {
+		compatible = "arm,psci-1.0", "arm,psci-0.2";
+		method = "smc";
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
+			compatible = "renesas,r8a77980-cpg-mssr";
+			reg = <0 0xe6150000 0 0x1000>;
+			clocks = <&extal_clk>, <&extalr_clk>;
+			clock-names = "extal", "extalr";
+			#clock-cells = <2>;
+			#power-domain-cells = <0>;
+			#reset-cells = <1>;
+		};
+
+		rst: reset-controller at e6160000 {
+			compatible = "renesas,r8a77980-rst";
+			reg = <0 0xe6160000 0 0x200>;
+		};
+
+		sysc: system-controller at e6180000 {
+			compatible = "renesas,r8a77980-sysc";
+			reg = <0 0xe6180000 0 0x440>;
+			#power-domain-cells = <1>;
+		};
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
+			interrupts = <GIC_PPI 9	(GIC_CPU_MASK_SIMPLE(1) |
+				      IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&cpg CPG_MOD 408>;
+			clock-names = "clk";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 408>;
+		};
+
+		prr: chipid at fff00044 {
+			compatible = "renesas,prr";
+			reg = <0 0xfff00044 0 4>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) |
+				       IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) |
+				       IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) |
+				       IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) |
+				       IRQ_TYPE_LEVEL_LOW)>;
+	};
+};
