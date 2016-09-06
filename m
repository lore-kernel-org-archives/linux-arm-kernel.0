From: jun.nie@linaro.org (Jun Nie)
Date: Tue,  6 Sep 2016 14:04:20 +0800
Subject: [PATCH v4 2/3] arm64: dts: Add ZTE ZX296718 SoC dts and Makefile
In-Reply-To: <1473141861-5033-1-git-send-email-jun.nie@linaro.org>
References: <1473141861-5033-1-git-send-email-jun.nie@linaro.org>
Message-ID: <1473141861-5033-3-git-send-email-jun.nie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree support for ZX296718 SoC and evaluation board based on it.
Also document new values.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 Documentation/devicetree/bindings/arm/zte.txt |  24 +++
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/zte/Makefile              |   5 +
 arch/arm64/boot/dts/zte/zx296718-evb.dts      |  25 +++
 arch/arm64/boot/dts/zte/zx296718.dtsi         | 254 ++++++++++++++++++++++++++
 5 files changed, 309 insertions(+)
 create mode 100644 arch/arm64/boot/dts/zte/Makefile
 create mode 100644 arch/arm64/boot/dts/zte/zx296718-evb.dts
 create mode 100644 arch/arm64/boot/dts/zte/zx296718.dtsi

diff --git a/Documentation/devicetree/bindings/arm/zte.txt b/Documentation/devicetree/bindings/arm/zte.txt
index 3ff5c9e..8336978 100644
--- a/Documentation/devicetree/bindings/arm/zte.txt
+++ b/Documentation/devicetree/bindings/arm/zte.txt
@@ -13,3 +13,27 @@ Low power management required properties:
 
 Bus matrix required properties:
       - compatible = "zte,zx-bus-matrix"
+
+
+---------------------------------------
+-  ZX296718 SoC:
+    Required root node properties:
+      - compatible = "zte,zx296718"
+
+ZX296718 EVB board:
+      - "zte,zx296718-evb"
+
+System management required properties:
+      - compatible = "zte,zx296718-aon-sysctrl"
+      - compatible = "zte,zx296718-sysctrl"
+
+Example:
+aon_sysctrl: aon-sysctrl at 116000 {
+	compatible = "zte,zx296718-aon-sysctrl", "syscon";
+	reg = <0x116000 0x1000>;
+};
+
+sysctrl: sysctrl at 1463000 {
+	compatible = "zte,zx296718-sysctrl", "syscon";
+	reg = <0x1463000 0x1000>;
+};
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 6e199c9..6684f97 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -19,6 +19,7 @@ dts-dirs += socionext
 dts-dirs += sprd
 dts-dirs += xilinx
 dts-dirs += lg
+dts-dirs += zte
 
 subdir-y	:= $(dts-dirs)
 
diff --git a/arch/arm64/boot/dts/zte/Makefile b/arch/arm64/boot/dts/zte/Makefile
new file mode 100644
index 0000000..6678066
--- /dev/null
+++ b/arch/arm64/boot/dts/zte/Makefile
@@ -0,0 +1,5 @@
+dtb-$(CONFIG_ARCH_ZX) += zx296718-evb.dtb
+
+always		:= $(dtb-y)
+subdir-y	:= $(dts-dirs)
+clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/zte/zx296718-evb.dts b/arch/arm64/boot/dts/zte/zx296718-evb.dts
new file mode 100644
index 0000000..d7cefb4
--- /dev/null
+++ b/arch/arm64/boot/dts/zte/zx296718-evb.dts
@@ -0,0 +1,25 @@
+/*
+ * ZTE Ltd. zx296718 Plaform
+ *
+ */
+/dts-v1/;
+#include "zx296718.dtsi"
+
+/ {
+	model = "ZTE zx296718 evaluation board";
+	compatible = "zte,zx296718-evb", "zte,zx296718";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory at 40000000 {
+		device_type = "memory";
+		reg = <0x40000000 0x40000000>;
+	};
+
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
new file mode 100644
index 0000000..c75a819
--- /dev/null
+++ b/arch/arm64/boot/dts/zte/zx296718.dtsi
@@ -0,0 +1,254 @@
+/*
+ * DTS File for ZTE ZX296718 Plaform
+ *
+ * Copyright (c) 2016 ZTE Semiconductor Co., Ltd.
+ */
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	compatible = "zte,zx296718";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		serial0 = &uart0;
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
+		};
+
+		cpu0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53","arm,armv8";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+		};
+
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53","arm,armv8";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+		};
+
+		cpu2: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53","arm,armv8";
+			reg = <0x0 0x2>;
+			enable-method = "psci";
+		};
+
+		cpu3: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53","arm,armv8";
+			reg = <0x0 0x3>;
+			enable-method = "psci";
+		};
+	};
+
+	osc12m: osc12m-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <12000000>;
+		clock-output-names = "osc12m";
+	};
+
+	osc24m: osc24m-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "osc24m";
+	};
+
+	osc25m: osc25m-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+		clock-output-names = "osc25m";
+	};
+
+	clk24k: clk-24k {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000>;
+		clock-output-names = "rtcclk";
+	};
+
+	osc32k: osc32k-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32000>;
+		clock-output-names = "osc32k";
+	};
+
+	osc60m: osc60m-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <60000000>;
+		clock-output-names = "osc60m";
+	};
+
+	osc99m: osc99m-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <99000000>;
+		clock-output-names = "osc99m";
+	};
+
+	osc125m: osc125m-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+		clock-output-names = "osc125m";
+	};
+
+	osc198m: osc198m-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <198000000>;
+		clock-output-names = "osc198m";
+	};
+
+	pll_vga: pll-1073m-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1073000000>;
+		clock-output-names = "pll_vga";
+	};
+
+	pll_ddr: pll-932m-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <932000000>;
+		clock-output-names = "pll_ddr";
+	};
+
+	pll_mac: pll-1000m-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1000000000>;
+		clock-output-names = "pll_mac";
+	};
+
+	pll_mm0: pll-1188m-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1188000000>;
+		clock-output-names = "pll_mm0";
+	};
+
+	pll_mm1: pll-1296m-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1296000000>;
+		clock-output-names = "pll_mm1";
+	};
+
+	pll_audio: pll-884m-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <884000000>;
+		clock-output-names = "pll_audio";
+	};
+
+	pll_hsic: pll-960m-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <960000000>;
+		clock-output-names = "pll_hsic";
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+		ranges;
+
+		timer {
+			compatible = "arm,armv8-timer";
+			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+		};
+
+		pmu {
+			compatible = "arm,cortex-a53-pmu";
+			interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		aon_sysctrl: aon-sysctrl at 116000 {
+			compatible = "zte,zx296718-aon-sysctrl", "syscon";
+			reg = <0x116000 0x1000>;
+		};
+
+		uart0: uart at 11f000 {
+			compatible = "arm,pl011", "arm,primecell";
+			arm,primecell-periphid = <0x001feffe>;
+			reg = <0x11f000 0x1000>;
+			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc24m>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+		};
+
+		dma: dma-controller at 1460000 {
+			compatible = "zte,zx296702-dma";
+			reg = <0x01460000 0x1000>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc24m>;
+			clock-names = "dmaclk";
+			#dma-cells = <1>;
+			dma-channels = <32>;
+			dma-requests = <32>;
+		};
+
+		sysctrl: sysctrl at 1463000 {
+			compatible = "zte,zx296718-sysctrl", "syscon";
+			reg = <0x1463000 0x1000>;
+		};
+
+		gic: interrupt-controller at 2a00000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			#redistributor-regions = <6>;
+			redistributor-stride = <0x0 0x40000>;
+			interrupt-controller;
+			reg = <0x02a00000 0x10000>,
+			      <0x02b00000 0x20000>,
+			      <0x02b20000 0x20000>,
+			      <0x02b40000 0x20000>,
+			      <0x02b60000 0x20000>,
+			      <0x02b80000 0x20000>,
+			      <0x02ba0000 0x20000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+};
-- 
1.9.1
