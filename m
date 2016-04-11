From: chanho.min@lge.com (Chanho Min)
Date: Mon, 11 Apr 2016 20:54:46 +0900
Subject: [PATCH v3 3/4] arm64: dts: Add dts files for LG Electronics's lg1312
 SoC
In-Reply-To: <1460375687-2375-1-git-send-email-chanho.min@lge.com>
References: <1460375687-2375-1-git-send-email-chanho.min@lge.com>
Message-ID: <1460375687-2375-4-git-send-email-chanho.min@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial dtsi file to support lg1312 SoC which based on
Cortex-A53. Also add dts file to support lg1312 reference board
which based on lg1312 SoC.

Signed-off-by: Chanho Min <chanho.min@lge.com>
---
Changes for v2:
	- remove self-defined macro.
	- change root node's #size-cells to <2>.
	- remove bootargs property.
	- update psci support to the arm,psci-0.2.
	- put fixed-clock property under the root node.
	- add stdout-path property.
	- update the GICC reg length to 0x2000
	- add the GICH and GICV interface.
	- change pmu compatible property to arm,coretex-a53-pmu.
	- remove clock-frequency property from timer.

Changes for v3:
	- change the order of arm,psci-0.2 and arm,psci
---
 arch/arm64/boot/dts/Makefile          |    1 +
 arch/arm64/boot/dts/lg/Makefile       |    5 +
 arch/arm64/boot/dts/lg/lg1312-ref.dts |   36 ++++
 arch/arm64/boot/dts/lg/lg1312.dtsi    |  351 +++++++++++++++++++++++++++++++++
 4 files changed, 393 insertions(+)
 create mode 100644 arch/arm64/boot/dts/lg/Makefile
 create mode 100644 arch/arm64/boot/dts/lg/lg1312-ref.dts
 create mode 100644 arch/arm64/boot/dts/lg/lg1312.dtsi

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index f832b8a..90ce525 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -16,6 +16,7 @@ dts-dirs += rockchip
 dts-dirs += socionext
 dts-dirs += sprd
 dts-dirs += xilinx
+dts-dirs += lg
 
 subdir-y	:= $(dts-dirs)
 
diff --git a/arch/arm64/boot/dts/lg/Makefile b/arch/arm64/boot/dts/lg/Makefile
new file mode 100644
index 0000000..b0cc649
--- /dev/null
+++ b/arch/arm64/boot/dts/lg/Makefile
@@ -0,0 +1,5 @@
+dtb-$(CONFIG_ARCH_LG1K) += lg1312-ref.dtb
+
+always		:= $(dtb-y)
+subdir-y	:= $(dts-dirs)
+clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/lg/lg1312-ref.dts b/arch/arm64/boot/dts/lg/lg1312-ref.dts
new file mode 100644
index 0000000..6d78d6b
--- /dev/null
+++ b/arch/arm64/boot/dts/lg/lg1312-ref.dts
@@ -0,0 +1,36 @@
+/*
+ * dts file for lg1312 Reference Board.
+ *
+ * Copyright (C) 2016, LG Electronics
+ */
+
+/dts-v1/;
+
+#include "lg1312.dtsi"
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <1>;
+
+	model = "LG Electronics, DTV SoC LG1312 Reference Board";
+	compatible = "lge,lg1312-ref", "lge,lg1312";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x00000000 0x20000000>;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/lg/lg1312.dtsi b/arch/arm64/boot/dts/lg/lg1312.dtsi
new file mode 100644
index 0000000..3a4e9a2
--- /dev/null
+++ b/arch/arm64/boot/dts/lg/lg1312.dtsi
@@ -0,0 +1,351 @@
+/*
+ * dts file for lg1312 SoC
+ *
+ * Copyright (C) 2016, LG Electronics
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	compatible = "lge,lg1312";
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x0>;
+			next-level-cache = <&L2_0>;
+		};
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+		};
+		cpu2: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x2>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+		};
+		cpu3: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x3>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+		};
+		L2_0: l2-cache0 {
+			compatible = "cache";
+		};
+	};
+
+	psci {
+		compatible  = "arm,psci-0.2", "arm,psci";
+		method = "smc";
+		cpu_suspend = <0x84000001>;
+		cpu_off = <0x84000002>;
+		cpu_on = <0x84000003>;
+	};
+
+	gic: interrupt-controller at c0001000 {
+		#interrupt-cells = <3>;
+		compatible = "arm,gic-400";
+		interrupt-controller;
+		reg = <0x0 0xc0001000 0x1000>,
+		      <0x0 0xc0002000 0x2000>,
+		      <0x0 0xc0004000 0x2000>,
+		      <0x0 0xc0006000 0x2000>;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>,
+				     <&cpu1>,
+				     <&cpu2>,
+				     <&cpu3>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(0x0f) |
+			      IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_RAW(0x0f) |
+			      IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_RAW(0x0f) |
+			      IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_RAW(0x0f) |
+			      IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	clk_bus: clk_bus {
+		#clock-cells = <0>;
+
+		compatible = "fixed-clock";
+		clock-frequency = <198000000>;
+		clock-output-names = "BUSCLK";
+	};
+
+	soc {
+		#address-cells = <2>;
+		#size-cells = <1>;
+
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+		ranges;
+
+		eth0: ethernet at c1b00000 {
+			compatible = "cdns,gem";
+			reg = <0x0 0xc1b00000 0x1000>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_bus>, <&clk_bus>;
+			clock-names = "hclk", "pclk";
+			phy-mode = "rmii";
+			/* Filled in by boot */
+			mac-address = [ 00 00 00 00 00 00 ];
+		};
+	};
+
+	amba {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		#interrupts-cells = <3>;
+
+		compatible = "arm,amba-bus";
+		interrupt-parent = <&gic>;
+		ranges;
+
+		timers: timer at fd100000 {
+			compatible = "arm,sp804";
+			reg = <0x0 0xfd100000 0x1000>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_bus>;
+			clock-names = "apb_pclk";
+		};
+		wdog: watchdog at fd200000 {
+			compatible = "arm,sp805", "arm,primecell";
+			reg = <0x0 0xfd200000 0x1000>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_bus>;
+			clock-names = "apb_pclk";
+		};
+		uart0: serial at fe000000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0xfe000000 0x1000>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_bus>;
+			clock-names = "apb_pclk";
+			status="disabled";
+		};
+		uart1: serial at fe100000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0xfe100000 0x1000>;
+			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_bus>;
+			clock-names = "apb_pclk";
+			status="disabled";
+		};
+		uart2: serial at fe200000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0xfe200000 0x1000>;
+			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_bus>;
+			clock-names = "apb_pclk";
+			status="disabled";
+		};
+		spi0: ssp at fe800000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x0 0xfe800000 0x1000>;
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_bus>;
+			clock-names = "apb_pclk";
+		};
+		spi1: ssp at fe900000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x0 0xfe900000 0x1000>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_bus>;
+			clock-names = "apb_pclk";
+		};
+		dmac0: dma at c1128000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x0 0xc1128000 0x1000>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_bus>;
+			clock-names = "apb_pclk";
+		};
+		gpio0: gpio at fd400000 {
+			#gpio-cells = <2>;
+			compatible = "arm,pl061", "arm,primecell";
+			gpio-controller;
+			reg = <0x0 0xfd400000 0x1000>;
+			clocks = <&clk_bus>;
+			clock-names = "apb_pclk";
+			status="disabled";
+		};
+		gpio1: gpio at fd410000 {
+			#gpio-cells = <2>;
+			compatible = "arm,pl061", "arm,primecell";
+			gpio-controller;
+			reg = <0x0 0xfd410000 0x1000>;
+			clocks = <&clk_bus>;
+			clock-names = "apb_pclk";
+			status="disabled";
+		};
+		gpio2: gpio at fd420000 {
+			#gpio-cells = <2>;
+			compatible = "arm,pl061", "arm,primecell";
+			gpio-controller;
+			reg = <0x0 0xfd420000 0x1000>;
+			clocks = <&clk_bus>;
+			clock-names = "apb_pclk";
+			status="disabled";
+		};
+		gpio3: gpio at fd430000 {
+			#gpio-cells = <2>;
+			compatible = "arm,pl061", "arm,primecell";
+			gpio-controller;
+			reg = <0x0 0xfd430000 0x1000>;
+			clocks = <&clk_bus>;
+			clock-names = "apb_pclk";
+		};
+		gpio4: gpio at fd440000 {
+			#gpio-cells = <2>;
+			compatible = "arm,pl061", "arm,primecell";
+			gpio-controller;
+			reg = <0x0 0xfd440000 0x1000>;
+			clocks = <&clk_bus>;
+			clock-names = "apb_pclk";
+			status="disabled";
+		};
+		gpio5: gpio at fd450000 {
+			#gpio-cells = <2>;
+			compatible = "arm,pl061", "arm,primecell";
+			gpio-controller;
+			reg = <0x0 0xfd450000 0x1000>;
+			clocks = <&clk_bus>;
+			clock-names = "apb_pclk";
+			status="disabled";
+		};
+		gpio6: gpio at fd460000 {
+			#gpio-cells = <2>;
+			compatible = "arm,pl061", "arm,primecell";
+			gpio-controller;
+			reg = <0x0 0xfd460000 0x1000>;
+			clocks = <&clk_bus>;
+			clock-names = "apb_pclk";
+			status="disabled";
+		};
+		gpio7: gpio at fd470000 {
+			#gpio-cells = <2>;
+			compatible = "arm,pl061", "arm,primecell";
+			gpio-controller;
+			reg = <0x0 0xfd470000 0x1000>;
+			clocks = <&clk_bus>;
+			clock-names = "apb_pclk";
+			status="disabled";
+		};
+		gpio8: gpio at fd480000 {
+			#gpio-cells = <2>;
+			compatible = "arm,pl061", "arm,primecell";
+			gpio-controller;
+			reg = <0x0 0xfd480000 0x1000>;
+			clocks = <&clk_bus>;
+			clock-names = "apb_pclk";
+			status="disabled";
+		};
+		gpio9: gpio at fd490000 {
+			#gpio-cells = <2>;
+			compatible = "arm,pl061", "arm,primecell";
+			gpio-controller;
+			reg = <0x0 0xfd490000 0x1000>;
+			clocks = <&clk_bus>;
+			clock-names = "apb_pclk";
+			status="disabled";
+		};
+		gpio10: gpio at fd4a0000 {
+			#gpio-cells = <2>;
+			compatible = "arm,pl061", "arm,primecell";
+			gpio-controller;
+			reg = <0x0 0xfd4a0000 0x1000>;
+			clocks = <&clk_bus>;
+			clock-names = "apb_pclk";
+			status="disabled";
+		};
+		gpio11: gpio at fd4b0000 {
+			#gpio-cells = <2>;
+			compatible = "arm,pl061", "arm,primecell";
+			gpio-controller;
+			reg = <0x0 0xfd4b0000 0x1000>;
+			clocks = <&clk_bus>;
+			clock-names = "apb_pclk";
+		};
+		gpio12: gpio at fd4c0000 {
+			#gpio-cells = <2>;
+			compatible = "arm,pl061", "arm,primecell";
+			gpio-controller;
+			reg = <0x0 0xfd4c0000 0x1000>;
+			clocks = <&clk_bus>;
+			clock-names = "apb_pclk";
+			status="disabled";
+		};
+		gpio13: gpio at fd4d0000 {
+			#gpio-cells = <2>;
+			compatible = "arm,pl061", "arm,primecell";
+			gpio-controller;
+			reg = <0x0 0xfd4d0000 0x1000>;
+			clocks = <&clk_bus>;
+			clock-names = "apb_pclk";
+			status="disabled";
+		};
+		gpio14: gpio at fd4e0000 {
+			#gpio-cells = <2>;
+			compatible = "arm,pl061", "arm,primecell";
+			gpio-controller;
+			reg = <0x0 0xfd4e0000 0x1000>;
+			clocks = <&clk_bus>;
+			clock-names = "apb_pclk";
+			status="disabled";
+		};
+		gpio15: gpio at fd4f0000 {
+			#gpio-cells = <2>;
+			compatible = "arm,pl061", "arm,primecell";
+			gpio-controller;
+			reg = <0x0 0xfd4f0000 0x1000>;
+			clocks = <&clk_bus>;
+			clock-names = "apb_pclk";
+			status="disabled";
+		};
+		gpio16: gpio at fd500000 {
+			#gpio-cells = <2>;
+			compatible = "arm,pl061", "arm,primecell";
+			gpio-controller;
+			reg = <0x0 0xfd500000 0x1000>;
+			clocks = <&clk_bus>;
+			clock-names = "apb_pclk";
+			status="disabled";
+		};
+		gpio17: gpio at fd510000 {
+			#gpio-cells = <2>;
+			compatible = "arm,pl061", "arm,primecell";
+			gpio-controller;
+			reg = <0x0 0xfd510000 0x1000>;
+			clocks = <&clk_bus>;
+			clock-names = "apb_pclk";
+		};
+	};
+};
-- 
1.7.9.5
