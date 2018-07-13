From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Fri, 13 Jul 2018 17:26:26 +0800
Subject: [PATCH 3/3] arm64: dts: synaptics: add dtsi file for Synaptics
 AS370 SoC
In-Reply-To: <20180713171712.05f58a74@xhacker.debian>
References: <20180713171712.05f58a74@xhacker.debian>
Message-ID: <20180713172626.5ca0e30f@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial dtsi file to support Synaptics AS370 SoC with quad
Cortex-A53 CPUs.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm64/boot/dts/synaptics/as370.dtsi | 177 +++++++++++++++++++++++
 1 file changed, 177 insertions(+)
 create mode 100644 arch/arm64/boot/dts/synaptics/as370.dtsi

diff --git a/arch/arm64/boot/dts/synaptics/as370.dtsi b/arch/arm64/boot/dts/synaptics/as370.dtsi
new file mode 100644
index 000000000000..20f3d658c566
--- /dev/null
+++ b/arch/arm64/boot/dts/synaptics/as370.dtsi
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2018 Synaptics Incorporated
+ *
+ * Author: Jisheng Zhang <jszhang@kernel.org>
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "syna,as370";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 0 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+			cpu-idle-states = <&CPU_SLEEP_0>;
+		};
+
+		cpu1: cpu at 1 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x1>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+			cpu-idle-states = <&CPU_SLEEP_0>;
+		};
+
+		cpu2: cpu at 2 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x2>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+			cpu-idle-states = <&CPU_SLEEP_0>;
+		};
+
+		cpu3: cpu at 3 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x3>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+			cpu-idle-states = <&CPU_SLEEP_0>;
+		};
+
+		l2: cache {
+			compatible = "cache";
+		};
+
+		idle-states {
+			entry-method = "psci";
+			CPU_SLEEP_0: cpu-sleep-0 {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x0010000>;
+				entry-latency-us = <75>;
+				exit-latency-us = <155>;
+				min-residency-us = <1000>;
+			};
+		};
+	};
+
+	osc: osc {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>,
+				     <&cpu1>,
+				     <&cpu2>,
+				     <&cpu3>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	soc at f7000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0xf7000000 0x1000000>;
+
+		gic: interrupt-controller at 901000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x901000 0x1000>,
+			      <0x902000 0x2000>,
+			      <0x904000 0x2000>,
+			      <0x906000 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		};
+
+		apb at e80000 {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0xe80000 0x10000>;
+
+			uart0: uart at 0c00 {
+				compatible = "snps,dw-apb-uart";
+				reg = <0x0c00 0x100>;
+				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&osc>;
+				reg-shift = <2>;
+				status = "disabled";
+			};
+
+			gpio0: gpio at 1800 {
+				compatible = "snps,dw-apb-gpio";
+				reg = <0x1800 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				porta: gpio-port at 0 {
+					compatible = "snps,dw-apb-gpio-port";
+					gpio-controller;
+					#gpio-cells = <2>;
+					snps,nr-gpios = <32>;
+					reg = <0>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+				};
+			};
+
+			gpio1: gpio at 2000 {
+				compatible = "snps,dw-apb-gpio";
+				reg = <0x2000 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				portb: gpio-port at 1 {
+					compatible = "snps,dw-apb-gpio-port";
+					gpio-controller;
+					#gpio-cells = <2>;
+					snps,nr-gpios = <32>;
+					reg = <0>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+				};
+			};
+		};
+	};
+};
-- 
2.18.0
