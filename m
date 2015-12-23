From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 23 Dec 2015 12:10:11 +0000
Subject: [PATCH] arm64: Add DT support for Juno r2 board
Message-ID: <1450872611-15326-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Juno r2 is identical to Juno r1 with Cortex A57 cores replaced by
Cortex A72 cores.

Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 Documentation/devicetree/bindings/arm/arm-boards |   1 +
 Documentation/devicetree/bindings/arm/cpus.txt   |   1 +
 arch/arm64/boot/dts/arm/Makefile                 |   2 +-
 arch/arm64/boot/dts/arm/juno-r2.dts              | 200 +++++++++++++++++++++++
 4 files changed, 203 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/arm/juno-r2.dts

diff --git a/Documentation/devicetree/bindings/arm/arm-boards b/Documentation/devicetree/bindings/arm/arm-boards
index 1a709970e7f7..70601a58c433 100644
--- a/Documentation/devicetree/bindings/arm/arm-boards
+++ b/Documentation/devicetree/bindings/arm/arm-boards
@@ -180,6 +180,7 @@ described under the RS1 memory mapping.
 Required properties (in root node):
 	compatible = "arm,juno";	/* For Juno r0 board */
 	compatible = "arm,juno-r1";	/* For Juno r1 board */
+	compatible = "arm,juno-r2";	/* For Juno r2 board */
 
 Required nodes:
 The description for the board must include:
diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 3a07a87fef20..58e240d75169 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -157,6 +157,7 @@ nodes to be present and contain the properties described below.
 			    "arm,cortex-a17"
 			    "arm,cortex-a53"
 			    "arm,cortex-a57"
+			    "arm,cortex-a72"
 			    "arm,cortex-m0"
 			    "arm,cortex-m0+"
 			    "arm,cortex-m1"
diff --git a/arch/arm64/boot/dts/arm/Makefile b/arch/arm64/boot/dts/arm/Makefile
index bb3c07209676..c0bf56b9ce3d 100644
--- a/arch/arm64/boot/dts/arm/Makefile
+++ b/arch/arm64/boot/dts/arm/Makefile
@@ -1,5 +1,5 @@
 dtb-$(CONFIG_ARCH_VEXPRESS) += foundation-v8.dtb
-dtb-$(CONFIG_ARCH_VEXPRESS) += juno.dtb juno-r1.dtb
+dtb-$(CONFIG_ARCH_VEXPRESS) += juno.dtb juno-r1.dtb juno-r2.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += vexpress-v2f-1xv7-ca53x2.dtb
 
diff --git a/arch/arm64/boot/dts/arm/juno-r2.dts b/arch/arm64/boot/dts/arm/juno-r2.dts
new file mode 100644
index 000000000000..7ca939032373
--- /dev/null
+++ b/arch/arm64/boot/dts/arm/juno-r2.dts
@@ -0,0 +1,200 @@
+/*
+ * ARM Ltd. Juno Platform
+ *
+ * Copyright (c) 2015 ARM Ltd.
+ *
+ * This file is licensed under a dual GPLv2 or BSD license.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	model = "ARM Juno development board (r2)";
+	compatible = "arm,juno-r2", "arm,juno", "arm,vexpress";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &soc_uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&A72_0>;
+				};
+				core1 {
+					cpu = <&A72_1>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&A53_0>;
+				};
+				core1 {
+					cpu = <&A53_1>;
+				};
+				core2 {
+					cpu = <&A53_2>;
+				};
+				core3 {
+					cpu = <&A53_3>;
+				};
+			};
+		};
+
+		idle-states {
+			entry-method = "arm,psci";
+
+			CPU_SLEEP_0: cpu-sleep-0 {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x0010000>;
+				local-timer-stop;
+				entry-latency-us = <300>;
+				exit-latency-us = <1200>;
+				min-residency-us = <2000>;
+			};
+
+			CLUSTER_SLEEP_0: cluster-sleep-0 {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x1010000>;
+				local-timer-stop;
+				entry-latency-us = <300>;
+				exit-latency-us = <1200>;
+				min-residency-us = <2500>;
+			};
+		};
+
+		A72_0: cpu at 0 {
+			compatible = "arm,cortex-a72","arm,armv8";
+			reg = <0x0 0x0>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&A72_L2>;
+			clocks = <&scpi_dvfs 0>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+		};
+
+		A72_1: cpu at 1 {
+			compatible = "arm,cortex-a72","arm,armv8";
+			reg = <0x0 0x1>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&A72_L2>;
+			clocks = <&scpi_dvfs 0>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+		};
+
+		A53_0: cpu at 100 {
+			compatible = "arm,cortex-a53","arm,armv8";
+			reg = <0x0 0x100>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&A53_L2>;
+			clocks = <&scpi_dvfs 1>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+		};
+
+		A53_1: cpu at 101 {
+			compatible = "arm,cortex-a53","arm,armv8";
+			reg = <0x0 0x101>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&A53_L2>;
+			clocks = <&scpi_dvfs 1>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+		};
+
+		A53_2: cpu at 102 {
+			compatible = "arm,cortex-a53","arm,armv8";
+			reg = <0x0 0x102>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&A53_L2>;
+			clocks = <&scpi_dvfs 1>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+		};
+
+		A53_3: cpu at 103 {
+			compatible = "arm,cortex-a53","arm,armv8";
+			reg = <0x0 0x103>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&A53_L2>;
+			clocks = <&scpi_dvfs 1>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+		};
+
+		A72_L2: l2-cache0 {
+			compatible = "cache";
+		};
+
+		A53_L2: l2-cache1 {
+			compatible = "cache";
+		};
+	};
+
+	pmu_a72 {
+		compatible = "arm,cortex-a72-pmu";
+		interrupts = <GIC_SPI 02 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 06 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&A72_0>,
+				     <&A72_1>;
+	};
+
+	pmu_a53 {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&A53_0>,
+				     <&A53_1>,
+				     <&A53_2>,
+				     <&A53_3>;
+	};
+
+	#include "juno-base.dtsi"
+
+	pcie-controller at 40000000 {
+		compatible = "arm,juno-r1-pcie", "plda,xpressrich3-axi", "pci-host-ecam-generic";
+		device_type = "pci";
+		reg = <0 0x40000000 0 0x10000000>;	/* ECAM config space */
+		bus-range = <0 255>;
+		linux,pci-domain = <0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		dma-coherent;
+		ranges = <0x01000000 0x00 0x5f800000 0x00 0x5f800000 0x0 0x00800000>,
+			 <0x02000000 0x00 0x50000000 0x00 0x50000000 0x0 0x08000000>,
+			 <0x42000000 0x40 0x00000000 0x40 0x00000000 0x1 0x00000000>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &gic 0 0 0 136 4>,
+				<0 0 0 2 &gic 0 0 0 137 4>,
+				<0 0 0 3 &gic 0 0 0 138 4>,
+				<0 0 0 4 &gic 0 0 0 139 4>;
+		msi-parent = <&v2m_0>;
+	};
+};
+
+&memtimer {
+	status = "okay";
+};
-- 
1.9.1
