From: tsahee@annapurnalabs.com (Tsahee Zidenberg)
Date: Sun, 25 Jan 2015 20:30:59 +0200
Subject: [PATCH 4/4] ARM: dts: Add initial support for Alpine platform
Message-ID: <54c53663.0OSd3sO9f1oYd3El%tsahee@annapurnalabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces an initial device-tree for the Alpine platform.

Signed-off-by: Barak Wasserstrom <barak@annapurnalabs.com>
Signed-off-by: Tsahee Zidenberg <tsahee@annapurnalabs.com>
---
 .../bindings/arm/annapurna-labs,alpine.txt         |  96 +++++++++++
 .../cpu-enable-method/annapurna-labs,alpine-smp    |  64 ++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/alpine.dts                       | 181 +++++++++++++++++++++
 5 files changed, 344 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/annapurna-labs,alpine.txt
 create mode 100644 Documentation/devicetree/bindings/arm/cpu-enable-method/annapurna-labs,alpine-smp
 create mode 100644 arch/arm/boot/dts/alpine.dts

diff --git a/Documentation/devicetree/bindings/arm/annapurna-labs,alpine.txt b/Documentation/devicetree/bindings/arm/annapurna-labs,alpine.txt
new file mode 100644
index 0000000..b10a058
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/annapurna-labs,alpine.txt
@@ -0,0 +1,96 @@
+Annapurna Labs Alpine Platform Device Tree Bindings
+---------------------------------------------------------------
+
+Boards in the Alpine family shall have the following properties:
+
+* Required root node properties:
+compatible: must contain "annapurna-labs,alpine"
+
+* Example:
+
+/ {
+	model = "Annapurna Labs Alpine Dev Board";
+	compatible = "annapurna-labs,alpine";
+
+	...
+}
+
+* CPU node:
+
+The Alpine platform includes cortex-a15 cores.
+enable-method: must be "annapurna-labs,alpine-smp" to allow smp  [1]
+
+Example:
+
+cpus {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	enable-method = "annapurna-labs,alpine-smp";
+
+	cpu at 0 {
+		compatible = "arm,cortex-a15";
+		device_type = "cpu";
+		reg = <0>;
+		clocks = <&cpuclk>;
+		clock-names = "cpu";
+	};
+
+	cpu at 1 {
+		compatible = "arm,cortex-a15";
+		device_type = "cpu";
+		reg = <1>;
+		clocks = <&cpuclk>;
+		clock-names = "cpu";
+	};
+
+	cpu at 2 {
+		compatible = "arm,cortex-a15";
+		device_type = "cpu";
+		reg = <2>;
+		clocks = <&cpuclk>;
+		clock-names = "cpu";
+	};
+
+	cpu at 3 {
+		compatible = "arm,cortex-a15";
+		device_type = "cpu";
+		reg = <3>;
+		clocks = <&cpuclk>;
+		clock-names = "cpu";
+	};
+};
+
+
+* Alpine CPU resume registers
+
+The CPU resume register are used to define required resume address after
+reset.
+
+Properties:
+- compatible : Should contain "annapurna-labs,al-cpu-resume".
+- reg : Offset and length of the register set for the device
+
+Example:
+
+cpu_resume {
+	compatible = "annapurna-labs,al-cpu-resume";
+	reg = <0xfbff5ed0 0x30>;
+};
+
+* Alpine System-Fabric Service Registers
+
+The System-Fabric Service Registers allow various operation on CPU and
+system fabric, like powering CPUs off.
+
+Properties:
+- compatible : Should contain "annapurna-labs,al-sysfabric-service".
+- reg : Offset and length of the register set for the device
+
+Example:
+
+nb_service {
+        compatible = "annapurna-labs,al-sysfabric-service";
+        reg = <0xfb070000 0x10000>;
+};
+
+[1] arm/cpu-enable-method/annapurna-labs,alpine-smp
diff --git a/Documentation/devicetree/bindings/arm/cpu-enable-method/annapurna-labs,alpine-smp b/Documentation/devicetree/bindings/arm/cpu-enable-method/annapurna-labs,alpine-smp
new file mode 100644
index 0000000..6245aa9
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cpu-enable-method/annapurna-labs,alpine-smp
@@ -0,0 +1,64 @@
+========================================================
+Secondary CPU enable-method "annapurna-labs,alpine-smp" binding
+========================================================
+
+This document describes the "annapurna-labs,alpine-smp" method for
+enabling secondary CPUs. To apply to all CPUs, a single
+"annapurna-labs,alpine-smp" enable method should be defined in the
+"cpus" node.
+
+Enable method name:	"annapurna-labs,alpine-smp"
+Compatible machines:	"annapurna-labs,alpine"
+Compatible CPUs:	"arm,cortex-a15"
+Related properties:	(none)
+
+Note:
+This enable method needs valid nodes compatible with
+"annapurna-labs,al-cpu-resume" and "annapurna-labs,al-nb-service"[1].
+
+Example:
+
+cpus {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	enable-method = "annapurna-labs,alpine-smp";
+
+	cpu at 0 {
+		compatible = "arm,cortex-a15";
+		device_type = "cpu";
+		reg = <0>;
+		clocks = <&cpuclk>;
+		clock-names = "cpu";
+		clock-frequency = <0>; /* Filled by loader */
+	};
+
+	cpu at 1 {
+		compatible = "arm,cortex-a15";
+		device_type = "cpu";
+		reg = <1>;
+		clocks = <&cpuclk>;
+		clock-names = "cpu";
+		clock-frequency = <0>; /* Filled by loader */
+	};
+
+	cpu at 2 {
+		compatible = "arm,cortex-a15";
+		device_type = "cpu";
+		reg = <2>;
+		clocks = <&cpuclk>;
+		clock-names = "cpu";
+		clock-frequency = <0>; /* Filled by loader */
+	};
+
+	cpu at 3 {
+		compatible = "arm,cortex-a15";
+		device_type = "cpu";
+		reg = <3>;
+		clocks = <&cpuclk>;
+		clock-names = "cpu";
+		clock-frequency = <0>; /* Filled by loader */
+	};
+};
+
+--
+[1] arm/annapurna-labs,alpine.txt
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index b1df0ad..e1225b8 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -17,6 +17,7 @@ amd	Advanced Micro Devices (AMD), Inc.
 amlogic	Amlogic, Inc.
 ams	AMS AG
 amstaos	AMS-Taos Inc.
+annapurna-labs Annapurna Labs
 apm	Applied Micro Circuits Corporation (APM)
 arm	ARM Ltd.
 armadeus	ARMadeus Systems SARL
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 91bd5bd..71610ea 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1,5 +1,7 @@
 ifeq ($(CONFIG_OF),y)
 
+dtb-$(CONFIG_ARCH_ALPINE) += alpine_db.dtb
+
 # Keep at91 dtb files sorted alphabetically for each SoC
 # rm9200
 dtb-$(CONFIG_ARCH_AT91) += at91rm9200ek.dtb
diff --git a/arch/arm/boot/dts/alpine.dts b/arch/arm/boot/dts/alpine.dts
new file mode 100644
index 0000000..fa0da66
--- /dev/null
+++ b/arch/arm/boot/dts/alpine.dts
@@ -0,0 +1,181 @@
+/*
+ * Copyright 2015 Annapurna Labs Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include "skeleton64.dtsi"
+
+/ {
+	version = "2.4";
+	compatible = "annapurna-labs,alpine";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	clock-ranges;
+
+	/* CPU Configuration */
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		enable-method = "annapurna-labs,alpine-smp";
+
+		cpu at 0 {
+			compatible = "arm,cortex-a15";
+			device_type = "cpu";
+			reg = <0>;
+			clocks = <&cpuclk>;
+			clock-names = "cpu";
+		};
+
+		cpu at 1 {
+			compatible = "arm,cortex-a15";
+			device_type = "cpu";
+			reg = <1>;
+			clocks = <&cpuclk>;
+			clock-names = "cpu";
+		};
+
+		cpu at 2 {
+			compatible = "arm,cortex-a15";
+			device_type = "cpu";
+			reg = <2>;
+			clocks = <&cpuclk>;
+			clock-names = "cpu";
+		};
+
+		cpu at 3 {
+			compatible = "arm,cortex-a15";
+			device_type = "cpu";
+			reg = <3>;
+			clocks = <&cpuclk>;
+			clock-names = "cpu";
+		};
+	};
+
+	soc {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		interrupt-parent = <&gic_main>;
+		ranges;
+
+		arch-timer {
+			compatible = "arm,cortex-a15-timer",
+				     "arm,armv7-timer";
+			interrupts =
+				<GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+			clock-frequency = <0>; /* Filled by loader */
+		};
+
+		/* Interrupt Controller */
+		gic_main: gic_main {
+			compatible = "arm,cortex-a15-gic";
+			#interrupt-cells = <3>;
+			#size-cells = <0>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x0 0xfb001000 0x0 0x1000>,
+			      <0x0 0xfb002000 0x0 0x2000>,
+			      <0x0 0xfb004000 0x0 0x1000>,
+			      <0x0 0xfb006000 0x0 0x2000>;
+		    interrupts = <GIC_PPI 9
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		};
+
+		/* CPU Resume registers */
+		cpu_resume {
+			compatible = "annapurna-labs,al-cpu-resume";
+			reg = <0x0 0xfbff5ec0 0x0 0x30>;
+		};
+
+		/* North Bridge Service Registers */
+		nb_service {
+			compatible = "annapurna-labs,al-sysfabric-service";
+			reg = <0x0 0xfb070000 0x0 0x10000>;
+		};
+
+		/* Performance Monitor Unit */
+		pmu {
+			compatible = "arm,cortex-a15-pmu";
+			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		wdt0 {
+			compatible = "arm,sp805", "arm,primecell";
+			reg = <0x0 0xfd88c000 0x0 0x1000>;
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sbclk>;
+			clock-names = "apb_pclk";
+		};
+
+		uart0 {
+			compatible = "ns16550a";
+			reg = <0x0 0xfd883000 0x0 0x1000>;
+			clock-frequency = <0>; /* Filled by loader */
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+		};
+
+		uart1 {
+			compatible = "ns16550a";
+			reg = <0x0 0xfd884000 0x0 0x1000>;
+			clock-frequency = <0>; /* Filled by loader */
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+		};
+
+		clocks {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* Reference clock */
+			refclk: refclk {
+				#clock-cells = <0>;
+				compatible = "fixed-clock";
+				clock-frequency = <0>; /* Filled by loader */
+			};
+
+			/* South Bridge Clock */
+			sbclk: sbclk {
+				#clock-cells = <0>;
+				compatible = "fixed-clock";
+				clock-frequency = <0>; /* Filled by loader */
+			};
+
+			/* North Bridge Clock */
+			nbclk: nbclk {
+				#clock-cells = <0>;
+				compatible = "fixed-clock";
+				clock-frequency = <0>; /* Filled by loader */
+			};
+
+			/* CPU Clock */
+			cpuclk: cpuclk {
+				#clock-cells = <0>;
+				compatible = "fixed-clock";
+				clock-frequency = <0>; /* Filled by loader */
+			};
+		};
+	};
+};
-- 
1.9.1
