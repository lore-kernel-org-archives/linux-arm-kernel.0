From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:14:50 +0200
Subject: [PATCH 028/102] arm64: dts: renesas: Add Renesas R8A77990 SoC support
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <f37a7767f6c4ec66c3df227ad4028e5390322202.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds basic support for the Renesas R-Car E3 (R8A77990) SoC:
  - PSCI
  - CPU (single)
  - Cache controller
  - Main clocks and controller
  - Interrupt controller
  - Timer
  - PMU
  - Reset controller
  - Product register
  - System controller
  - UART for console

Inspried by a patch by Takeshi Kihara in the BSP.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77990.dtsi | 127 ++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77990.dtsi

diff --git a/arch/arm64/boot/dts/renesas/r8a77990.dtsi b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
new file mode 100644
index 000000000000..3a19b9ebdd6e
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
@@ -0,0 +1,127 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Device Tree Source for the r8a77990 SoC
+ *
+ * Copyright (C) 2018 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/clock/renesas-cpg-mssr.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "renesas,r8a77990";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* 1 core only at this point */
+		a53_0: cpu at 0 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0>;
+			device_type = "cpu";
+			power-domains = <&sysc 5>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+		};
+
+		L2_CA53: cache-controller at 0 {
+			compatible = "cache";
+			reg = <0>;
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
+	pmu_a53 {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts-extended = <&gic GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&a53_0>;
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	soc: soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		cpg: clock-controller at e6150000 {
+			compatible = "renesas,r8a77990-cpg-mssr";
+			reg = <0 0xe6150000 0 0x1000>;
+			clocks = <&extal_clk>;
+			clock-names = "extal";
+			#clock-cells = <2>;
+			#power-domain-cells = <0>;
+			#reset-cells = <1>;
+		};
+
+		rst: reset-controller at e6160000 {
+			compatible = "renesas,r8a77990-rst";
+			reg = <0 0xe6160000 0 0x0200>;
+		};
+
+		sysc: system-controller at e6180000 {
+			compatible = "renesas,r8a77990-sysc";
+			reg = <0 0xe6180000 0 0x0400>;
+			#power-domain-cells = <1>;
+		};
+
+		scif2: serial at e6e88000 {
+			compatible = "renesas,scif-r8a77990",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
+			reg = <0 0xe6e88000 0 64>;
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 310>;
+			clock-names = "fck";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 310>;
+			status = "disabled";
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
+			interrupts = <GIC_PPI 9
+					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
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
+		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+};
-- 
2.11.0
