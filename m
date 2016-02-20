From: jchandra@broadcom.com (Jayachandran C)
Date: Sat, 20 Feb 2016 19:49:20 +0530
Subject: [PATCH v2 1/5] arm64: Broadcom Vulcan support
In-Reply-To: <1455977964-8099-1-git-send-email-jchandra@broadcom.com>
References: <1455977964-8099-1-git-send-email-jchandra@broadcom.com>
Message-ID: <1455977964-8099-2-git-send-email-jchandra@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zi Shen Lim <zlim@broadcom.com>

Add a configuration option and a device tree for Broadcom's Vulcan
ARM64 processor. vulcan.dtsi has the on-chip blocks like the PCIe
controller, GICv3 with ITS, PMU, system timer and the pl011 UART.
vulcan-eval.dts has definitions for a basic evaluation board.

Vulcan's processor cores support the ARMv8.1 instruction set and
will use "brcm,vulcan" as the compatible property. The firmware
has PSCI 0.2 support for cpu wakeup.

Signed-off-by: Zi Shen Lim <zlim@broadcom.com>
[ updated and split dts - jchandra at broadcom.com ]
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/arm64/Kconfig.platforms                 |   5 +
 arch/arm64/boot/dts/broadcom/Makefile        |   1 +
 arch/arm64/boot/dts/broadcom/vulcan-eval.dts |  33 ++++++
 arch/arm64/boot/dts/broadcom/vulcan.dtsi     | 144 +++++++++++++++++++++++++++
 4 files changed, 183 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/vulcan-eval.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/vulcan.dtsi

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 21074f6..75e1bfe 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -131,6 +131,11 @@ config ARCH_VEXPRESS
 	  This enables support for the ARMv8 software model (Versatile
 	  Express).
 
+config ARCH_VULCAN
+	bool "Broadcom Vulcan SOC Family"
+	help
+	  This enables support for Broadcom Vulcan SoC Family
+
 config ARCH_XGENE
 	bool "AppliedMicro X-Gene SOC Family"
 	help
diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
index e21fe66..bec1f8b 100644
--- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -1,4 +1,5 @@
 dtb-$(CONFIG_ARCH_BCM_IPROC) += ns2-svk.dtb
+dtb-$(CONFIG_ARCH_VULCAN) += vulcan-eval.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/broadcom/vulcan-eval.dts b/arch/arm64/boot/dts/broadcom/vulcan-eval.dts
new file mode 100644
index 0000000..9ee8d3d
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/vulcan-eval.dts
@@ -0,0 +1,33 @@
+/*
+ * dts file for Broadcom (BRCM) Vulcan Evaluation Platform
+ *
+ * Copyright (c) 2013-2016 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+/dts-v1/;
+
+#include "vulcan.dtsi"
+
+/ {
+	model = "Broadcom Vulcan Eval Platform";
+	compatible = "brcm,vulcan-eval", "brcm,vulcan-soc";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x80000000 0x0 0x80000000>,  /* 2G @ 2G  */
+		      <0x00000008 0x80000000 0x0 0x80000000>;  /* 2G @ 34G */
+	};
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
diff --git a/arch/arm64/boot/dts/broadcom/vulcan.dtsi b/arch/arm64/boot/dts/broadcom/vulcan.dtsi
new file mode 100644
index 0000000..c49b5a8
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/vulcan.dtsi
@@ -0,0 +1,144 @@
+/*
+ * dtsi file for Broadcom (BRCM) Vulcan processor
+ *
+ * Copyright (c) 2013-2016 Broadcom
+ * Author: Zi Shen Lim <zlim@broadcom.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	model = "Broadcom Vulcan";
+	compatible = "brcm,vulcan-soc";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	/* just 4 cpus now, 128 needed in full config */
+	cpus {
+		#address-cells = <0x2>;
+		#size-cells = <0x0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "brcm,vulcan", "arm,armv8";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "brcm,vulcan", "arm,armv8";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+		};
+
+		cpu at 2 {
+			device_type = "cpu";
+			compatible = "brcm,vulcan", "arm,armv8";
+			reg = <0x0 0x2>;
+			enable-method = "psci";
+		};
+
+		cpu at 3 {
+			device_type = "cpu";
+			compatible = "brcm,vulcan", "arm,armv8";
+			reg = <0x0 0x3>;
+			enable-method = "psci";
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	gic: interrupt-controller at 400080000 {
+		compatible = "arm,gic-v3";
+		#interrupt-cells = <3>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		interrupt-controller;
+		#redistributor-regions = <1>;
+		reg = <0x04 0x00080000 0x0 0x20000>,	/* GICD */
+		      <0x04 0x01000000 0x0 0x1000000>;	/* GICR */
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+
+		gicits: gic-its at 40010000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			reg = <0x04 0x00100000 0x0 0x20000>;	/* GIC ITS */
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>; /* PMU overflow */
+	};
+
+	clk125mhz: uart_clk125mhz {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+		clock-output-names = "clk125mhz";
+	};
+
+	pci {
+		compatible = "pci-host-ecam-generic";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+
+		/* ECAM at 0x3000_0000 - 0x4000_0000 */
+		reg = <0x0 0x30000000  0x0 0x10000000>;
+		reg-names = "PCI ECAM";
+
+			  /* IO 0x4000_0000 - 0x4001_0000 */
+		ranges = <0x01000000 0 0x40000000 0 0x40000000 0 0x00010000
+			  /* MEM 0x4800_0000 - 0x5000_0000 */
+			  0x02000000 0 0x48000000 0 0x48000000 0 0x08000000
+			  /* MEM64 pref 0x6_0000_0000 - 0x7_0000_0000 */
+			  0x43000000 6 0x00000000 6 0x00000000 1 0x00000000>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map =
+		      /* addr  pin  ic   icaddr  icintr */
+			<0 0 0  1  &gic   0 0    GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH
+			 0 0 0  2  &gic   0 0    GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH
+			 0 0 0  3  &gic   0 0    GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH
+			 0 0 0  4  &gic   0 0    GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+		msi-parent = <&gicits>;
+		dma-coherent;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		uart0: serial at 402020000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x04 0x02020000 0x0 0x1000>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk125mhz>;
+			clock-names = "apb_pclk";
+		};
+	};
+
+};
-- 
1.9.1
