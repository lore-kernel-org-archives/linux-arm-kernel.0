From: puck.chen@hisilicon.com (Chen Feng)
Date: Tue, 24 Jan 2017 16:57:28 +0800
Subject: [V3 2/3] arm64: dts: Add dts files for Hisilicon Hi3660 SoC
In-Reply-To: <1485248249-117383-1-git-send-email-puck.chen@hisilicon.com>
References: <1485248249-117383-1-git-send-email-puck.chen@hisilicon.com>
Message-ID: <1485248249-117383-2-git-send-email-puck.chen@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial dtsi file to support Hisilicon Hi3660 SoC with
support of Octal core CPUs in two clusters(4 * A53 & 4 * A73).

Also add dts file to support HiKey960 development board which
based on Hi3660 SoC.
The output console is earlycon "earlycon=pl011,0xfdf05000".
And the con_init uart5 with a fixed clock, which already
configured at bootloader.

When clock is available, the uart5 will be modified.

Tested on HiKey960 Board.

Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/Makefile            |   1 +
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts |  35 +++++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi         | 160 ++++++++++++++++++++++
 3 files changed, 196 insertions(+)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi3660.dtsi

diff --git a/arch/arm64/boot/dts/hisilicon/Makefile b/arch/arm64/boot/dts/hisilicon/Makefile
index c8b8f80..c3a6c19 100644
--- a/arch/arm64/boot/dts/hisilicon/Makefile
+++ b/arch/arm64/boot/dts/hisilicon/Makefile
@@ -1,3 +1,4 @@
+dtb-$(CONFIG_ARCH_HISI) += hi3660-hikey960.dtb
 dtb-$(CONFIG_ARCH_HISI) += hi6220-hikey.dtb
 dtb-$(CONFIG_ARCH_HISI) += hip05-d02.dtb
 dtb-$(CONFIG_ARCH_HISI) += hip06-d03.dtb
diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
new file mode 100644
index 0000000..9ed9e68
--- /dev/null
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -0,0 +1,35 @@
+/*
+ * dts file for Hisilicon HiKey960 Development Board
+ *
+ * Copyright (C) 2016, Hisilicon Ltd.
+ *
+ */
+
+/dts-v1/;
+
+#include "hi3660.dtsi"
+
+/ {
+	model = "HiKey960";
+	compatible = "hisilicon,hi3660";
+
+	aliases {
+		serial5 = &uart5;       /* console UART */
+	};
+
+	chosen {
+		stdout-path = "serial5:115200n8";
+	};
+
+	memory at 0 {
+		device_type = "memory";
+		/* rewrite this at bootloader */
+		reg = <0x0 0x0 0x0 0x0>;
+	};
+
+	soc {
+		uart5: uart at fdf05000 {
+			status = "okay";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
new file mode 100644
index 0000000..3983086
--- /dev/null
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -0,0 +1,160 @@
+/*
+ * dts file for Hisilicon Hi3660 SoC
+ *
+ * Copyright (C) 2016, Hisilicon Ltd.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "hisilicon,hi3660";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
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
+					cpu = <&cpu0>;
+				};
+				core1 {
+					cpu = <&cpu1>;
+				};
+				core2 {
+					cpu = <&cpu2>;
+				};
+				core3 {
+					cpu = <&cpu3>;
+				};
+			};
+			cluster1 {
+				core0 {
+					cpu = <&cpu4>;
+				};
+				core1 {
+					cpu = <&cpu5>;
+				};
+				core2 {
+					cpu = <&cpu6>;
+				};
+				core3 {
+					cpu = <&cpu7>;
+				};
+			};
+		};
+
+		cpu0: cpu at 0 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+		};
+
+		cpu1: cpu at 1 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+		};
+
+		cpu2: cpu at 2 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x2>;
+			enable-method = "psci";
+		};
+
+		cpu3: cpu at 3 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x3>;
+			enable-method = "psci";
+		};
+
+		cpu4: cpu at 100 {
+			compatible = "arm,cortex-a73", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+		};
+
+		cpu5: cpu at 101 {
+			compatible = "arm,cortex-a73", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x101>;
+			enable-method = "psci";
+		};
+
+		cpu6: cpu at 102 {
+			compatible = "arm,cortex-a73", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x102>;
+			enable-method = "psci";
+		};
+
+		cpu7: cpu at 103 {
+			compatible = "arm,cortex-a73", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x103>;
+			enable-method = "psci";
+		};
+	};
+
+	gic: interrupt-controller at e82b0000 {
+		compatible = "arm,gic-400";
+		reg = <0x0 0xe82b1000 0 0x1000>, /* GICD */
+		      <0x0 0xe82b2000 0 0x2000>, /* GICC */
+		      <0x0 0xe82b4000 0 0x2000>, /* GICH */
+		      <0x0 0xe82b6000 0 0x2000>; /* GICV */
+		#address-cells = <0>;
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8) |
+					 IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) |
+					  IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		fixed_uart5: fixed_19_2M {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <19200000>;
+			clock-output-names = "fixed:uart5";
+		};
+
+		uart5: uart at fdf05000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0xfdf05000 0x0 0x1000>;
+			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&fixed_uart5 &fixed_uart5>;
+			clock-names = "uartclk", "apb_pclk";
+			status = "disabled";
+		};
+	};
+};
-- 
1.9.1
