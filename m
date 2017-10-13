From: dlan@gentoo.org (Yixun Lan)
Date: Sat, 14 Oct 2017 07:13:13 +0800
Subject: [PATCH 2/2] arm64: dts: meson-axg: add initial A113D SoC DT support
In-Reply-To: <20171013231313.22850-1-dlan@gentoo.org>
References: <20171013231313.22850-1-dlan@gentoo.org>
Message-ID: <20171013231313.22850-3-dlan@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Try to add basic DT support for the Amlogic's Meson-AXG A113D SoC,
which describe components as follows: Reserve Memory, CPU, GIC, IRQ,
Timer, UART. It's capable of booting up into the serial console.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 arch/arm64/boot/dts/amlogic/Makefile           |   1 +
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts |  22 +++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi     | 204 +++++++++++++++++++++++++
 3 files changed, 227 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-axg.dtsi

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 7a9f48c27b1f..aedecf088272 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -1,3 +1,4 @@
+dtb-$(CONFIG_ARCH_MESON) += meson-axg-s400.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nanopi-k2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nexbox-a95x.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-odroidc2.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
new file mode 100644
index 000000000000..70eca1f8736a
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -0,0 +1,22 @@
+/*
+ * Copyright (c) 2017 Amlogic, Inc. All rights reserved.
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+/dts-v1/;
+
+#include "meson-axg.dtsi"
+
+/ {
+	compatible = "amlogic,s400", "amlogic,a113d", "amlogic,meson-axg";
+	model = "Amlogic Meson AXG S400 Development Board";
+
+	aliases {
+		serial0 = &uart_AO;
+	};
+};
+
+&uart_AO {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
new file mode 100644
index 000000000000..003832890d2b
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -0,0 +1,204 @@
+/*
+ * Copyright (c) 2017 Amlogic, Inc. All rights reserved.
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "amlogic,meson-axg";
+
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* 16 MiB reserved for Hardware ROM Firmware */
+		hwrom_reserved: hwrom at 0 {
+			reg = <0x0 0x0 0x0 0x1000000>;
+			no-map;
+		};
+
+		/* Alternate 3 MiB reserved for ARM Trusted Firmware (BL31) */
+		secmon_reserved: secmon at 05000000 {
+			reg = <0x0 0x05000000 0x0 0x300000>;
+			no-map;
+		};
+	};
+
+	cpus {
+		#address-cells = <0x2>;
+		#size-cells = <0x0>;
+
+		cpu0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		cpu2: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x2>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		cpu3: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x3>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		l2: l2-cache0 {
+			compatible = "cache";
+		};
+	};
+
+	arm-pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13
+			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14
+			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11
+			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10
+			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	xtal: xtal-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "xtal";
+		#clock-cells = <0>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		cbus: cbus at ffd00000 {
+			compatible = "simple-bus";
+			reg = <0x0 0xffd00000 0x0 0x25000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x0 0x0 0x0 0xffd00000 0x0 0x25000>;
+
+			uart_A: serial at 24000 {
+				compatible = "amlogic,meson-gx-uart", "amlogic,meson-uart";
+				reg = <0x0 0x24000 0x0 0x14>;
+				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
+				status = "disabled";
+			};
+
+			uart_B: serial at 23000 {
+				compatible = "amlogic,meson-gx-uart", "amlogic,meson-uart";
+				reg = <0x0 0x23000 0x0 0x14>;
+				interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>;
+				status = "disabled";
+			};
+		};
+
+		gic: interrupt-controller at ffc01000 {
+			compatible = "arm,gic-400";
+			reg = <0x0 0xffc01000 0 0x1000>,
+			      <0x0 0xffc02000 0 0x2000>,
+			      <0x0 0xffc04000 0 0x2000>,
+			      <0x0 0xffc06000 0 0x2000>;
+			interrupt-controller;
+			interrupts = <GIC_PPI 9
+				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+		};
+
+		mailbox: mailbox at ff63dc00 {
+			compatible = "amlogic,meson-gx-mhu", "amlogic,meson-gxbb-mhu";
+			reg = <0 0xff63dc00 0 0x400>;
+			interrupts = <GIC_SPI 208 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 209 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 210 IRQ_TYPE_EDGE_RISING>;
+			#mbox-cells = <1>;
+		};
+
+		sram: sram at fffc0000 {
+			compatible = "amlogic,meson-axg-sram", "mmio-sram";
+			reg = <0x0 0xfffc0000 0x0 0x20000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x0 0xfffc0000 0x20000>;
+
+			cpu_scp_lpri: scp-shmem at 0 {
+				compatible = "amlogic,meson-axg-scp-shmem";
+				reg = <0x13000 0x400>;
+			};
+
+			cpu_scp_hpri: scp-shmem at 200 {
+				compatible = "amlogic,meson-axg-scp-shmem";
+				reg = <0x13400 0x400>;
+			};
+		};
+
+		aobus: aobus at ff800000 {
+			compatible = "simple-bus";
+			reg = <0x0 0xff800000 0x0 0x100000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x0 0x0 0x0 0xff800000 0x0 0x100000>;
+
+			uart_AO: serial at 3000 {
+				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
+				reg = <0x0 0x3000 0x0 0x18>;
+				interrupts = <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&xtal>, <&xtal>, <&xtal>;
+				clock-names = "xtal", "pclk", "baud";
+				status = "disabled";
+			};
+
+			uart_AO_B: serial at 4000 {
+				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
+				reg = <0x0 0x4000 0x0 0x18>;
+				interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&xtal>, <&xtal>, <&xtal>;
+				clock-names = "xtal", "pclk", "baud";
+				status = "disabled";
+			};
+		};
+	};
+};
-- 
2.14.1
