From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 19 Jun 2017 03:08:28 +0200
Subject: [PATCH v5 10/27] ARM: dts: Add Actions Semi S500 and LeMaker Guitar
In-Reply-To: <3a132688-07d9-cc3f-b4d1-85a95199ec93@suse.de>
References: <3a132688-07d9-cc3f-b4d1-85a95199ec93@suse.de>
Message-ID: <20170619010828.3401-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Device Trees for Actions Semiconductor S500 SoC and LeMaker Guitar SoM
and base board.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v4 -> v5:
 * Renamed files from s500* to owl-s500*

 v3 -> v4:
 * Adopted lower-case timer interrupt-names (Mark)
 
 v2 -> v3:
 * Fixed uart2 reg offset
 * Enlarged timer reg size
 * Added 2 Hz timer interrupts, interrupt-names
 * Disabled CPUs 1-3 for now (cf. later patches)
 * Added Cortex-A9 SCU, global timer, TWD timer/wdt nodes
 * Added HOSC clock for timer
 
 v1 -> v2:
 * Reworded subject
 * Updated ARCH_OWL to ARCH_ACTIONS (Arnd)
 * Adopted "actions" vendor prefix
 * Dropped irq.h include
 * Added memory at 0 node for Guitar SoM
 * Dropped bogus uart3 clock-frequency
 * Added device_type for CPU nodes
 * Fixed UART reg size
 * Adopted SPDX-License-Identifier (Rob)
 * Added remaining UART nodes
 * Added timer node
 
 arch/arm/boot/dts/Makefile                     |   2 +
 arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts |  26 ++++
 arch/arm/boot/dts/owl-s500-guitar.dtsi         |  22 ++++
 arch/arm/boot/dts/owl-s500.dtsi                | 176 +++++++++++++++++++++++++
 4 files changed, 226 insertions(+)
 create mode 100644 arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
 create mode 100644 arch/arm/boot/dts/owl-s500-guitar.dtsi
 create mode 100644 arch/arm/boot/dts/owl-s500.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e81d87db22cc..ff9671c27fc8 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -669,6 +669,8 @@ dtb-$(CONFIG_ARCH_ORION5X) += \
 	orion5x-maxtor-shared-storage-2.dtb \
 	orion5x-netgear-wnr854t.dtb \
 	orion5x-rd88f5182-nas.dtb
+dtb-$(CONFIG_ARCH_ACTIONS) += \
+	owl-s500-guitar-bb-rev-b.dtb
 dtb-$(CONFIG_ARCH_PRIMA2) += \
 	prima2-evb.dtb
 dtb-$(CONFIG_ARCH_OXNAS) += \
diff --git a/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts b/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
new file mode 100644
index 000000000000..521463d4cac6
--- /dev/null
+++ b/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
@@ -0,0 +1,26 @@
+/*
+ * Copyright (c) 2016-2017 Andreas F?rber
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+/dts-v1/;
+
+#include "owl-s500-guitar.dtsi"
+
+/ {
+	compatible = "lemaker,guitar-bb-rev-b", "lemaker,guitar", "actions,s500";
+	model = "LeMaker Guitar Base Board rev. B";
+
+	aliases {
+		serial3 = &uart3;
+	};
+
+	chosen {
+		stdout-path = "serial3:115200n8";
+	};
+};
+
+&uart3 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/owl-s500-guitar.dtsi b/arch/arm/boot/dts/owl-s500-guitar.dtsi
new file mode 100644
index 000000000000..079b2c02cc13
--- /dev/null
+++ b/arch/arm/boot/dts/owl-s500-guitar.dtsi
@@ -0,0 +1,22 @@
+/*
+ * LeMaker Guitar SoM
+ *
+ * Copyright (c) 2016-2017 Andreas F?rber
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+#include "owl-s500.dtsi"
+
+/ {
+	compatible = "lemaker,guitar", "actions,s500";
+
+	memory at 0 {
+		device_type = "memory";
+		reg = <0x0 0x40000000>;
+	};
+};
+
+&timer {
+	clocks = <&hosc>;
+};
diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
new file mode 100644
index 000000000000..fc9f71a4106a
--- /dev/null
+++ b/arch/arm/boot/dts/owl-s500.dtsi
@@ -0,0 +1,176 @@
+/*
+ * Actions Semi S500 SoC
+ *
+ * Copyright (c) 2016-2017 Andreas F?rber
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "actions,s500";
+	interrupt-parent = <&gic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+	};
+
+	chosen {
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0x0>;
+		};
+
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0x1>;
+		};
+
+		cpu2: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0x2>;
+		};
+
+		cpu3: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0x3>;
+		};
+	};
+
+	arm-pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+		             <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+		             <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+		             <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
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
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		scu: scu at b0020000 {
+			compatible = "arm,cortex-a9-scu";
+			reg = <0xb0020000 0x100>;
+		};
+
+		global_timer: timer at b0020200 {
+			compatible = "arm,cortex-a9-global-timer";
+			reg = <0xb0020200 0x100>;
+			interrupts = <GIC_PPI 0 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
+			status = "disabled";
+		};
+
+		twd_timer: timer at b0020600 {
+			compatible = "arm,cortex-a9-twd-timer";
+			reg = <0xb0020600 0x20>;
+			interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
+			status = "disabled";
+		};
+
+		twd_wdt: wdt at b0020620 {
+			compatible = "arm,cortex-a9-twd-wdt";
+			reg = <0xb0020620 0xe0>;
+			interrupts = <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
+			status = "disabled";
+		};
+
+		gic: interrupt-controller at b0021000 {
+			compatible = "arm,cortex-a9-gic";
+			reg = <0xb0021000 0x1000>,
+			      <0xb0020100 0x0100>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+
+		l2: cache-controller at b0022000 {
+			compatible = "arm,pl310-cache";
+			reg = <0xb0022000 0x1000>;
+			cache-unified;
+			cache-level = <2>;
+			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+			arm,tag-latency = <3 3 2>;
+			arm,data-latency = <5 3 3>;
+		};
+
+		uart0: serial at b0120000 {
+			compatible = "actions,s500-uart", "actions,owl-uart";
+			reg = <0xb0120000 0x2000>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart1: serial at b0122000 {
+			compatible = "actions,s500-uart", "actions,owl-uart";
+			reg = <0xb0122000 0x2000>;
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart2: serial at b0124000 {
+			compatible = "actions,s500-uart", "actions,owl-uart";
+			reg = <0xb0124000 0x2000>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart3: serial at b0126000 {
+			compatible = "actions,s500-uart", "actions,owl-uart";
+			reg = <0xb0126000 0x2000>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart4: serial at b0128000 {
+			compatible = "actions,s500-uart", "actions,owl-uart";
+			reg = <0xb0128000 0x2000>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart5: serial at b012a000 {
+			compatible = "actions,s500-uart", "actions,owl-uart";
+			reg = <0xb012a000 0x2000>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart6: serial at b012c000 {
+			compatible = "actions,s500-uart", "actions,owl-uart";
+			reg = <0xb012c000 0x2000>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		timer: timer at b0168000 {
+			compatible = "actions,s500-timer";
+			reg = <0xb0168000 0x8000>;
+			interrupts = <GIC_SPI  8 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI  9 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "2hz0", "2hz1", "timer0", "timer1";
+		};
+	};
+};
-- 
2.12.3
