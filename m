From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 14 Nov 2017 00:34:24 +0100
Subject: [PATCH v2 5/8] arm64: dts: actions: Add S700 and CubieBoard7
In-Reply-To: <20171113233427.5386-1-afaerber@suse.de>
References: <20171113233427.5386-1-afaerber@suse.de>
Message-ID: <20171113233427.5386-6-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Device Trees for S700 SoC and Cubietech CubieBoard7.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v1 -> v2: Unchanged
 
 arch/arm64/boot/dts/actions/Makefile             |   2 +
 arch/arm64/boot/dts/actions/s700-cubieboard7.dts |  47 +++++++
 arch/arm64/boot/dts/actions/s700.dtsi            | 164 +++++++++++++++++++++++
 3 files changed, 213 insertions(+)
 create mode 100644 arch/arm64/boot/dts/actions/s700-cubieboard7.dts
 create mode 100644 arch/arm64/boot/dts/actions/s700.dtsi

diff --git a/arch/arm64/boot/dts/actions/Makefile b/arch/arm64/boot/dts/actions/Makefile
index cc4661256356..d8b923480f5a 100644
--- a/arch/arm64/boot/dts/actions/Makefile
+++ b/arch/arm64/boot/dts/actions/Makefile
@@ -1 +1,3 @@
+dtb-$(CONFIG_ARCH_ACTIONS) += s700-cubieboard7.dtb
+
 dtb-$(CONFIG_ARCH_ACTIONS) += s900-bubblegum-96.dtb
diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
new file mode 100644
index 000000000000..e562f04c2490
--- /dev/null
+++ b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
@@ -0,0 +1,47 @@
+/*
+ * Copyright (c) 2017 Andreas F?rber
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+/dts-v1/;
+
+#include "s700.dtsi"
+
+/ {
+	compatible = "cubietech,cubieboard7", "actions,s700";
+	model = "CubieBoard7";
+
+	aliases {
+		serial3 = &uart3;
+	};
+
+	chosen {
+		stdout-path = "serial3:115200n8";
+	};
+
+	memory at 0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+
+	memory at 1,e0000000 {
+		device_type = "memory";
+		reg = <0x1 0xe0000000 0x0 0x0>;
+	};
+
+	uart3_clk: uart3-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <921600>;
+		#clock-cells = <0>;
+	};
+};
+
+&timer {
+	clocks = <&hosc>;
+};
+
+&uart3 {
+	status = "okay";
+	clocks = <&uart3_clk>;
+};
diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
new file mode 100644
index 000000000000..b54df405aaeb
--- /dev/null
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -0,0 +1,164 @@
+/*
+ * Copyright (c) 2017 Andreas F?rber
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "actions,s700";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+		};
+
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+		};
+
+		cpu2: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x2>;
+			enable-method = "psci";
+		};
+
+		cpu3: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x3>;
+			enable-method = "psci";
+		};
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		secmon at 1f000000 {
+			reg = <0x0 0x1f000000 0x0 0x1000000>;
+			no-map;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	arm-pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+		             <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+		             <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+		             <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	hosc: hosc {
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		#clock-cells = <0>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gic: interrupt-controller at e00f1000 {
+			compatible = "arm,gic-400";
+			reg = <0x0 0xe00f1000 0x0 0x1000>,
+			      <0x0 0xe00f2000 0x0 0x2000>,
+			      <0x0 0xe00f4000 0x0 0x2000>,
+			      <0x0 0xe00f6000 0x0 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+
+		uart0: serial at e0120000 {
+			compatible = "actions,s900-uart", "actions,owl-uart";
+			reg = <0x0 0xe0120000 0x0 0x2000>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart1: serial at e0122000 {
+			compatible = "actions,s900-uart", "actions,owl-uart";
+			reg = <0x0 0xe0122000 0x0 0x2000>;
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart2: serial at e0124000 {
+			compatible = "actions,s900-uart", "actions,owl-uart";
+			reg = <0x0 0xe0124000 0x0 0x2000>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart3: serial at e0126000 {
+			compatible = "actions,s900-uart", "actions,owl-uart";
+			reg = <0x0 0xe0126000 0x0 0x2000>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart4: serial at e0128000 {
+			compatible = "actions,s900-uart", "actions,owl-uart";
+			reg = <0x0 0xe0128000 0x0 0x2000>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart5: serial at e012a000 {
+			compatible = "actions,s900-uart", "actions,owl-uart";
+			reg = <0x0 0xe012a000 0x0 0x2000>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart6: serial at e012c000 {
+			compatible = "actions,s900-uart", "actions,owl-uart";
+			reg = <0x0 0xe012c000 0x0 0x2000>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		timer: timer at e024c000 {
+			compatible = "actions,s700-timer";
+			reg = <0x0 0xe024c000 0x0 0x4000>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "timer1";
+		};
+	};
+};
-- 
2.13.6
