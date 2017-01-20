From: jnair@caviumnetworks.com (Jayachandran C)
Date: Fri, 20 Jan 2017 20:46:39 +0000
Subject: [PATCH 1/3] arm64: add THUNDER2 processor family
In-Reply-To: <1484945201-17248-1-git-send-email-jnair@caviumnetworks.com>
References: <1484945201-17248-1-git-send-email-jnair@caviumnetworks.com>
Message-ID: <1484945201-17248-2-git-send-email-jnair@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for ThunderX2 CN99XX arm64 server processors.

Introduce a new arm64 platform config option ARCH_THUNDER2 for these
processors. Add device tree files boot/dts/cavium/thunder-99xx.dtsi for
on-chip devices and boot/dts/cavium/thunder-99xx.dts for the evaluation
board.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
---
 arch/arm64/Kconfig.platforms                 |   7 ++
 arch/arm64/boot/dts/cavium/Makefile          |   1 +
 arch/arm64/boot/dts/cavium/thunder-99xx.dts  |  34 +++++++
 arch/arm64/boot/dts/cavium/thunder-99xx.dtsi | 147 +++++++++++++++++++++++++++
 4 files changed, 189 insertions(+)
 create mode 100644 arch/arm64/boot/dts/cavium/thunder-99xx.dts
 create mode 100644 arch/arm64/boot/dts/cavium/thunder-99xx.dtsi

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 715ef12..129cc5a 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -190,6 +190,13 @@ config ARCH_THUNDER
 	help
 	  This enables support for Cavium's Thunder Family of SoCs.
 
+config ARCH_THUNDER2
+	bool "Cavium ThunderX2 Server Processors"
+	select GPIOLIB
+	help
+	  This enables support for Cavium's ThunderX2 CN99XX family of
+	  server processors.
+
 config ARCH_UNIPHIER
 	bool "Socionext UniPhier SoC Family"
 	select ARCH_HAS_RESET_CONTROLLER
diff --git a/arch/arm64/boot/dts/cavium/Makefile b/arch/arm64/boot/dts/cavium/Makefile
index e34f89d..557c8be 100644
--- a/arch/arm64/boot/dts/cavium/Makefile
+++ b/arch/arm64/boot/dts/cavium/Makefile
@@ -1,4 +1,5 @@
 dtb-$(CONFIG_ARCH_THUNDER) += thunder-88xx.dtb
+dtb-$(CONFIG_ARCH_THUNDER2) += thunder-99xx.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/cavium/thunder-99xx.dts b/arch/arm64/boot/dts/cavium/thunder-99xx.dts
new file mode 100644
index 0000000..ed6715a
--- /dev/null
+++ b/arch/arm64/boot/dts/cavium/thunder-99xx.dts
@@ -0,0 +1,34 @@
+/*
+ * dts file for Cavium ThunderX2 CN99XX based Evaluation Boards
+ *
+ * Copyright (c) 2017 Cavium Inc.
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
+#include "thunder-99xx.dtsi"
+
+/ {
+	model = "Cavium ThunderX2 CN99XX";
+	compatible = "cavium,thunder-99xx";
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
diff --git a/arch/arm64/boot/dts/cavium/thunder-99xx.dtsi b/arch/arm64/boot/dts/cavium/thunder-99xx.dtsi
new file mode 100644
index 0000000..1c07732
--- /dev/null
+++ b/arch/arm64/boot/dts/cavium/thunder-99xx.dtsi
@@ -0,0 +1,147 @@
+/*
+ * dtsi file for Cavium ThunderX2 CN99XX processor
+ *
+ * Copyright (c) 2017 Cavium Inc.
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
+	model = "Cavium ThunderX2 CN99xx";
+	compatible = "cavium,thunder-99xx";
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
+			compatible = "cavium,thunder2", "arm,armv8";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "cavium,thunder2", "arm,armv8";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+		};
+
+		cpu at 2 {
+			device_type = "cpu";
+			compatible = "cavium,thunder2", "arm,armv8";
+			reg = <0x0 0x2>;
+			enable-method = "psci";
+		};
+
+		cpu at 3 {
+			device_type = "cpu";
+			compatible = "cavium,thunder2", "arm,armv8";
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
+		/*
+		 * PCI ranges:
+		 *   IO		no supported
+		 *   MEM        0x4000_0000 - 0x6000_0000
+		 *   MEM64 pref 0x40_0000_0000 - 0x60_0000_0000
+		 */
+		ranges =
+		  <0x02000000    0 0x40000000    0 0x40000000    0 0x20000000
+		   0x43000000 0x40 0x00000000 0x40 0x00000000 0x20 0x00000000>;
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
+};
-- 
2.7.4
