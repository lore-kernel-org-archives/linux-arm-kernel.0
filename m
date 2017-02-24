From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 24 Feb 2017 04:40:51 +0100
Subject: [RFC v2 13/17] ARM64: dts: Add Actions Semi S900 and Bubblegum-96
In-Reply-To: <20170224034055.18807-1-afaerber@suse.de>
References: <20170224034055.18807-1-afaerber@suse.de>
Message-ID: <20170224034055.18807-14-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: 96boards at ucrobotics.com
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v1 -> v2:
 * Reworded subject
 * Added memory at 0 node for Bubblegum-96 (Mark)
 * Filled in reserved-memory sub-node for Bubblegum-96 (Mark)
 * Added arm-pmu interrupt-affinity property (Mark)
 * Changed second GIC reg size 0x1000 -> 0x2000 for Bubblegum-96 (Mark)
 * Updated ARCH_OWL to ARCH_ACTIONS (Arnd)
 * Renamed s900-bubblegum96.dts to s900-bubblegum-96.dts
 * Adopted "actions" vendor prefix
 * Dropped irq.h include
 * Adopted SPDX-License-Identifier (Rob)
 
 arch/arm64/boot/dts/Makefile                      |   1 +
 arch/arm64/boot/dts/actions/Makefile              |   5 +
 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts |  31 ++++++
 arch/arm64/boot/dts/actions/s900.dtsi             | 109 ++++++++++++++++++++++
 4 files changed, 146 insertions(+)
 create mode 100644 arch/arm64/boot/dts/actions/Makefile
 create mode 100644 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
 create mode 100644 arch/arm64/boot/dts/actions/s900.dtsi

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 080232b..d1a6b0a 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -1,3 +1,4 @@
+dts-dirs += actions
 dts-dirs += al
 dts-dirs += allwinner
 dts-dirs += altera
diff --git a/arch/arm64/boot/dts/actions/Makefile b/arch/arm64/boot/dts/actions/Makefile
new file mode 100644
index 0000000..62922d6
--- /dev/null
+++ b/arch/arm64/boot/dts/actions/Makefile
@@ -0,0 +1,5 @@
+dtb-$(CONFIG_ARCH_ACTIONS) += s900-bubblegum-96.dtb
+
+always		:= $(dtb-y)
+subdir-y	:= $(dts-dirs)
+clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
new file mode 100644
index 0000000..a4ab7df
--- /dev/null
+++ b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
@@ -0,0 +1,31 @@
+/*
+ * Copyright (c) 2017 Andreas F?rber
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+/dts-v1/;
+
+#include "s900.dtsi"
+
+/ {
+	compatible = "ucrobotics,bubblegum-96", "actions,s900";
+	model = "Bubblegum-96";
+
+	aliases {
+		serial5 = &uart5;
+	};
+
+	chosen {
+		stdout-path = "serial5:115200n8";
+	};
+
+	memory at 0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+};
+
+&uart5 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
new file mode 100644
index 0000000..75e1dea2
--- /dev/null
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -0,0 +1,109 @@
+/*
+ * Copyright (c) 2017 Andreas F?rber
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "actions,s900";
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
+		uart5: serial at e012a000 {
+			compatible = "actions,s900-uart", "actions,owl-uart";
+			reg = <0x0 0xe012a000 0x0 0x1000>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.10.2
