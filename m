From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Fri, 22 May 2015 12:13:09 +0100
Subject: [PATCH v3 5/6] arm64: Add DT support for Juno r1 board.
In-Reply-To: <1432293190-13012-1-git-send-email-Liviu.Dudau@arm.com>
References: <1432293190-13012-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1432293190-13012-6-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This board is based on Juno r0 with updated Cortex A5x revisions
and board errata fixes. It also contains coherent ThinLinks ports
on the expansion slot that allow for an AXI master on the daughter
card to participate in a coherency domain.

Support for SoC PCIe host bridge will be added as a separate series.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
Acked-by: Jon Medhurst <tixy@linaro.org>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/boot/dts/arm/Makefile    |   2 +-
 arch/arm64/boot/dts/arm/juno-r1.dts | 116 ++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/arm/juno-r1.dts

diff --git a/arch/arm64/boot/dts/arm/Makefile b/arch/arm64/boot/dts/arm/Makefile
index 301a0da..c5c98b9 100644
--- a/arch/arm64/boot/dts/arm/Makefile
+++ b/arch/arm64/boot/dts/arm/Makefile
@@ -1,5 +1,5 @@
 dtb-$(CONFIG_ARCH_VEXPRESS) += foundation-v8.dtb
-dtb-$(CONFIG_ARCH_VEXPRESS) += juno.dtb
+dtb-$(CONFIG_ARCH_VEXPRESS) += juno.dtb juno-r1.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb
 
 always		:= $(dtb-y)
diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
new file mode 100644
index 0000000..c627511
--- /dev/null
+++ b/arch/arm64/boot/dts/arm/juno-r1.dts
@@ -0,0 +1,116 @@
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
+	model = "ARM Juno development board (r1)";
+	compatible = "arm,juno-r1", "arm,juno", "arm,vexpress";
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
+		A57_0: cpu at 0 {
+			compatible = "arm,cortex-a57","arm,armv8";
+			reg = <0x0 0x0>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&A57_L2>;
+		};
+
+		A57_1: cpu at 1 {
+			compatible = "arm,cortex-a57","arm,armv8";
+			reg = <0x0 0x1>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&A57_L2>;
+		};
+
+		A53_0: cpu at 100 {
+			compatible = "arm,cortex-a53","arm,armv8";
+			reg = <0x0 0x100>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&A53_L2>;
+		};
+
+		A53_1: cpu at 101 {
+			compatible = "arm,cortex-a53","arm,armv8";
+			reg = <0x0 0x101>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&A53_L2>;
+		};
+
+		A53_2: cpu at 102 {
+			compatible = "arm,cortex-a53","arm,armv8";
+			reg = <0x0 0x102>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&A53_L2>;
+		};
+
+		A53_3: cpu at 103 {
+			compatible = "arm,cortex-a53","arm,armv8";
+			reg = <0x0 0x103>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&A53_L2>;
+		};
+
+		A57_L2: l2-cache0 {
+			compatible = "cache";
+		};
+
+		A53_L2: l2-cache1 {
+			compatible = "cache";
+		};
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_SPI 02 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 06 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&A57_0>,
+				     <&A57_1>,
+				     <&A53_0>,
+				     <&A53_1>,
+				     <&A53_2>,
+				     <&A53_3>;
+	};
+
+	#include "juno-base.dtsi"
+
+};
+
+&memtimer {
+	status = "okay";
+};
-- 
2.4.0
