From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 25 Jun 2017 19:00:19 +0200
Subject: [PATCH 4/5] ARM: dts: Add Socionext MB86S71 and Fujitsu F-Cue
In-Reply-To: <20170625170020.11791-1-afaerber@suse.de>
References: <20170625170020.11791-1-afaerber@suse.de>
Message-ID: <20170625170020.11791-5-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Device Trees for Socionext MB86S71 SoC and Fujitsu F-Cue board.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/Makefile          |   2 +
 arch/arm/boot/dts/mb86s71-f-cue.dts |  38 ++++++++
 arch/arm/boot/dts/mb86s71.dtsi      | 178 ++++++++++++++++++++++++++++++++++++
 3 files changed, 218 insertions(+)
 create mode 100644 arch/arm/boot/dts/mb86s71-f-cue.dts
 create mode 100644 arch/arm/boot/dts/mb86s71.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4b17f35dc9a7..48dda2de0a3d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -526,6 +526,8 @@ dtb-$(CONFIG_ARCH_MXS) += \
 	imx28-m28evk.dtb \
 	imx28-sps1.dtb \
 	imx28-tx28.dtb
+dtb-$(CONFIG_ARCH_MB86S7X) += \
+	mb86s71-f-cue.dtb
 dtb-$(CONFIG_ARCH_NOMADIK) += \
 	ste-nomadik-s8815.dtb \
 	ste-nomadik-nhk15.dtb
diff --git a/arch/arm/boot/dts/mb86s71-f-cue.dts b/arch/arm/boot/dts/mb86s71-f-cue.dts
new file mode 100644
index 000000000000..148d1aee11a6
--- /dev/null
+++ b/arch/arm/boot/dts/mb86s71-f-cue.dts
@@ -0,0 +1,38 @@
+/*
+ * Fujitsu F-Cue board
+ *
+ * Copyright (c) 2017 Andreas F?rber
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+/dts-v1/;
+
+#include "mb86s71.dtsi"
+
+/ {
+	compatible = "fujitsu,f-cue", "fujitsu,mb86s71";
+	model = "Fujitsu F-Cue";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	/* vendor U-Boot looks for /memory */
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+};
+
+&arch_timer {
+	clock-frequency = <125000000>;
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/mb86s71.dtsi b/arch/arm/boot/dts/mb86s71.dtsi
new file mode 100644
index 000000000000..154f1ab89f0a
--- /dev/null
+++ b/arch/arm/boot/dts/mb86s71.dtsi
@@ -0,0 +1,178 @@
+/*
+ * Socionext MB86S71 SoC
+ *
+ * Copyright (c) 2017 Andreas F?rber
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "fujitsu,mb86s71";
+	interrupt-parent = <&gic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x0>;
+			cci-control-port = <&cci_control4>;
+			next-level-cache = <&l2_big>;
+		};
+
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x1>;
+			cci-control-port = <&cci_control4>;
+			next-level-cache = <&l2_big>;
+		};
+
+		cpu2: cpu at 100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x100>;
+			cci-control-port = <&cci_control3>;
+			next-level-cache = <&l2_little>;
+		};
+
+		cpu3: cpu at 101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x101>;
+			cci-control-port = <&cci_control3>;
+			next-level-cache = <&l2_little>;
+		};
+
+		l2_big: l2-cache-big {
+			compatible = "cache";
+		};
+
+		l2_little: l2-cache-little {
+			compatible = "cache";
+		};
+	};
+
+	arch_timer: timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+		             <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	pmu-big {
+		compatible = "arm,cortex-a15-pmu";
+		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+		             <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>;
+	};
+
+	pmu-little {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+		             <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu2>, <&cpu3>;
+	};
+
+	cci at 2c090000 {
+		compatible = "arm,cci-400";
+		reg = <0x2c090000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x2c090000 0x10000>;
+
+		cci_control0: slave-if at 1000 {
+			compatible = "arm,cci-400-ctrl-if";
+			reg = <0x1000 0x1000>;
+			interface-type = "ace-lite";
+		};
+
+		cci_control1: slave-if at 2000 {
+			compatible = "arm,cci-400-ctrl-if";
+			reg = <0x2000 0x1000>;
+			interface-type = "ace-lite";
+		};
+
+		cci_control2: slave-if at 3000 {
+			compatible = "arm,cci-400-ctrl-if";
+			reg = <0x3000 0x1000>;
+			interface-type = "ace-lite";
+		};
+
+		cci_control3: slave-if at 4000 {
+			compatible = "arm,cci-400-ctrl-if";
+			reg = <0x4000 0x1000>;
+			interface-type = "ace";
+		};
+
+		cci_control4: slave-if at 5000 {
+			compatible = "arm,cci-400-ctrl-if";
+			reg = <0x5000 0x1000>;
+			interface-type = "ace";
+		};
+
+		pmu at 9000 {
+			compatible = "arm,cci-400-pmu,r0";
+			reg = <0x9000 0x5000>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x80000000>;
+
+		gic: interrupt-controller at 2c001000 {
+			compatible = "arm,cortex-a15-gic";
+			reg = <0x2c001000 0x1000>,
+			      <0x2c002000 0x2000>,
+			      <0x2c004000 0x2000>,
+			      <0x2c006000 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+
+		uart0: serial at 31040000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x31040000 0x100>;
+			arm,primecell-periphid = <0x00341011>;
+			interrupts = <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart1: serial at 31050000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x31050000 0x100>;
+			arm,primecell-periphid = <0x00341011>;
+			interrupts = <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart2: serial at 31060000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x31060000 0x100>;
+			arm,primecell-periphid = <0x00341011>;
+			interrupts = <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		timer at 31080000 {
+			compatible = "arm,sp804";
+			reg = <0x31080000 0x10000>;
+			interrupts = <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+};
-- 
2.12.3
