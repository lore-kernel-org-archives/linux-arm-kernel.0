From: michal.simek@xilinx.com (Michal Simek)
Date: Mon,  9 Mar 2015 09:41:04 +0100
Subject: [PATCH v3] ARM64: Add new Xilinx ZynqMP SoC
Message-ID: <8dea13bec5470b0b18c586ce62c1fea467f9f647.1425890447.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initial version of device tree for Xilinx ZynqMP SoC.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Acked-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>
---

Changes in v3:
- Add the missing GIC maintenance interrupt
  Reported-by Marc Zyngier <marc.zyngier@arm.com>
- Fix PPI interrupt mask to reflect 4 cores
- Remove cortex-a9-gic compatible string and add arm,gic-400 one
  Reported-by Mark Rutland

Changes in v2:
-  move timer out of amba_apu bus because it is not on bus
   Reported by Mark
- FIC GICC and GICV addresses - Reported by Rob
- Fix copyright
- Enable cadence IP in defconfig
- Add support for macb multiqueue

 arch/arm64/Kconfig                          |   5 +
 arch/arm64/boot/dts/Makefile                |   1 +
 arch/arm64/boot/dts/xilinx/Makefile         |   5 +
 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts |  47 +++++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi      | 305 ++++++++++++++++++++++++++++
 arch/arm64/configs/defconfig                |   3 +
 6 files changed, 366 insertions(+)
 create mode 100644 arch/arm64/boot/dts/xilinx/Makefile
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp.dtsi

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b8e97331ffb..9f805cf2e0b0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -228,6 +228,11 @@ config ARCH_XGENE
 	help
 	  This enables support for AppliedMicro X-Gene SOC Family
 
+config ARCH_ZYNQMP
+	bool "Xilinx ZynqMP Family"
+	help
+	  This enables support for Xilinx ZynqMP Family
+
 endmenu
 
 menu "Bus support"
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index e0350caf049e..ff088ec6ca5f 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -5,5 +5,6 @@ dts-dirs += cavium
 dts-dirs += exynos
 dts-dirs += freescale
 dts-dirs += mediatek
+dts-dirs += xilinx
 
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
new file mode 100644
index 000000000000..ae16427f6a4a
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/Makefile
@@ -0,0 +1,5 @@
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-ep108.dtb
+
+always		:= $(dtb-y)
+subdir-y	:= $(dts-dirs)
+clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
new file mode 100644
index 000000000000..0a3f40ecd06d
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
@@ -0,0 +1,47 @@
+/*
+ * dts file for Xilinx ZynqMP ep108 development board
+ *
+ * (C) Copyright 2014 - 2015, Xilinx, Inc.
+ *
+ * Michal Simek <michal.simek@xilinx.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+/dts-v1/;
+
+/include/ "zynqmp.dtsi"
+
+/ {
+	model = "ZynqMP EP108";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0 0x40000000>;
+	};
+};
+
+&gem0 {
+	status = "okay";
+	phy-handle = <&phy0>;
+	phy-mode = "rgmii-id";
+	phy0: phy at 0{
+		reg = <0>;
+		max-speed = <100>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
new file mode 100644
index 000000000000..11e0b00045cf
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -0,0 +1,305 @@
+/*
+ * dts file for Xilinx ZynqMP
+ *
+ * (C) Copyright 2014 - 2015, Xilinx, Inc.
+ *
+ * Michal Simek <michal.simek@xilinx.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+/ {
+	compatible = "xlnx,zynqmp";
+	#address-cells = <2>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			enable-method = "psci";
+			reg = <0x0>;
+		};
+
+		cpu at 1 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			enable-method = "psci";
+			reg = <0x1>;
+		};
+
+		cpu at 2 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			enable-method = "psci";
+			reg = <0x2>;
+		};
+
+		cpu at 3 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			enable-method = "psci";
+			reg = <0x3>;
+		};
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <0 143 4>,
+			     <0 144 4>,
+			     <0 145 4>,
+			     <0 146 4>;
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <1 13 0xf01>,
+			     <1 14 0xf01>,
+			     <1 11 0xf01>,
+			     <1 10 0xf01>;
+	};
+
+	amba_apu {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+
+		gic: interrupt-controller at f9010000 {
+			compatible = "arm,gic-400", "arm,cortex-a15-gic";
+			#interrupt-cells = <3>;
+			reg = <0x0 0xf9010000 0x10000>,
+			      <0x0 0xf902f000 0x2000>,
+			      <0x0 0xf9040000 0x20000>,
+			      <0x0 0xf906f000 0x2000>;
+			interrupt-controller;
+			interrupt-parent = <&gic>;
+			interrupts = <1 9 0xf04>;
+		};
+	};
+
+	amba {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+
+		misc_clk: misc_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <25000000>;
+		};
+
+		ttc0: timer at ff110000 {
+			compatible = "cdns,ttc";
+			status = "disabled";
+			interrupt-parent = <&gic>;
+			interrupts = <0 36 4>, <0 37 4>, <0 38 4>;
+			reg = <0x0 0xff110000 0x1000>;
+			clocks = <&misc_clk>;
+			timer-width = <32>;
+		};
+
+		ttc1: timer at ff120000 {
+			compatible = "cdns,ttc";
+			status = "disabled";
+			interrupt-parent = <&gic>;
+			interrupts = <0 39 4>, <0 40 4>, <0 41 4>;
+			reg = <0x0 0xff120000 0x1000>;
+			clocks = <&misc_clk>;
+			timer-width = <32>;
+		};
+
+		ttc2: timer at ff130000 {
+			compatible = "cdns,ttc";
+			status = "disabled";
+			interrupt-parent = <&gic>;
+			interrupts = <0 42 4>, <0 43 4>, <0 44 4>;
+			reg = <0x0 0xff130000 0x1000>;
+			clocks = <&misc_clk>;
+			timer-width = <32>;
+		};
+
+		ttc3: timer at ff140000 {
+			compatible = "cdns,ttc";
+			status = "disabled";
+			interrupt-parent = <&gic>;
+			interrupts = <0 45 4>, <0 46 4>, <0 47 4>;
+			reg = <0x0 0xff140000 0x1000>;
+			clocks = <&misc_clk>;
+			timer-width = <32>;
+		};
+
+		uart0: serial at ff000000 {
+			compatible = "cdns,uart-r1p8";
+			status = "disabled";
+			interrupt-parent = <&gic>;
+			interrupts = <0 21 4>;
+			reg = <0x0 0xff000000 0x1000>;
+			clock-names = "uart_clk", "pclk";
+			clocks = <&misc_clk &misc_clk>;
+		};
+
+		uart1: serial at ff010000 {
+			compatible = "cdns,uart-r1p8";
+			status = "disabled";
+			interrupt-parent = <&gic>;
+			interrupts = <0 22 4>;
+			reg = <0x0 0xff010000 0x1000>;
+			clock-names = "uart_clk", "pclk";
+			clocks = <&misc_clk &misc_clk>;
+		};
+
+		gpio: gpio at ff0a0000 {
+			compatible = "xlnx,zynq-gpio-1.0";
+			status = "disabled";
+			#gpio-cells = <0x2>;
+			clocks = <&misc_clk>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 16 4>;
+			reg = <0x0 0xff0a0000 0x1000>;
+		};
+
+		gem0: ethernet at ff0b0000 {
+			compatible = "cdns,gem";
+			status = "disabled";
+			interrupt-parent = <&gic>;
+			interrupts = <0 57 4>, <0 57 4>;
+			reg = <0x0 0xff0b0000 0x1000>;
+			clock-names = "pclk", "hclk", "tx_clk";
+			clocks = <&misc_clk>, <&misc_clk>, <&misc_clk>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		gem1: ethernet at ff0c0000 {
+			compatible = "cdns,gem";
+			status = "disabled";
+			interrupt-parent = <&gic>;
+			interrupts = <0 59 4>, <0 59 4>;
+			reg = <0x0 0xff0c0000 0x1000>;
+			clock-names = "pclk", "hclk", "tx_clk";
+			clocks = <&misc_clk>, <&misc_clk>, <&misc_clk>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		gem2: ethernet at ff0d0000 {
+			compatible = "cdns,gem";
+			status = "disabled";
+			interrupt-parent = <&gic>;
+			interrupts = <0 61 4>, <0 61 4>;
+			reg = <0x0 0xff0d0000 0x1000>;
+			clock-names = "pclk", "hclk", "tx_clk";
+			clocks = <&misc_clk>, <&misc_clk>, <&misc_clk>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		gem3: ethernet at ff0e0000 {
+			compatible = "cdns,gem";
+			status = "disabled";
+			interrupt-parent = <&gic>;
+			interrupts = <0 63 4>, <0 63 4>;
+			reg = <0x0 0xff0e0000 0x1000>;
+			clock-names = "pclk", "hclk", "tx_clk";
+			clocks = <&misc_clk>, <&misc_clk>, <&misc_clk>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		spi0: spi at ff040000 {
+			compatible = "cdns,spi-r1p6";
+			status = "disabled";
+			interrupt-parent = <&gic>;
+			interrupts = <0 19 4>;
+			reg = <0x0 0xff040000 0x1000>;
+			clock-names = "ref_clk", "pclk";
+			clocks = <&misc_clk &misc_clk>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		spi1: spi at ff050000 {
+			compatible = "cdns,spi-r1p6";
+			status = "disabled";
+			interrupt-parent = <&gic>;
+			interrupts = <0 20 4>;
+			reg = <0x0 0xff050000 0x1000>;
+			clock-names = "ref_clk", "pclk";
+			clocks = <&misc_clk &misc_clk>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_clk: i2c_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0x0>;
+			clock-frequency = <111111111>;
+		};
+
+		i2c0: i2c at ff020000 {
+			compatible = "cdns,i2c-r1p10";
+			status = "disabled";
+			interrupt-parent = <&gic>;
+			interrupts = <0 17 4>;
+			reg = <0x0 0xff020000 0x1000>;
+			clocks = <&i2c_clk>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c1: i2c at ff030000 {
+			compatible = "cdns,i2c-r1p10";
+			status = "disabled";
+			interrupt-parent = <&gic>;
+			interrupts = <0 18 4>;
+			reg = <0x0 0xff030000 0x1000>;
+			clocks = <&i2c_clk>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		sdhci0: sdhci at ff160000 {
+			compatible = "arasan,sdhci-8.9a";
+			status = "disabled";
+			interrupt-parent = <&gic>;
+			interrupts = <0 48 4>;
+			reg = <0x0 0xff160000 0x1000>;
+			clock-names = "clk_xin", "clk_ahb";
+			clocks = <&misc_clk>, <&misc_clk>;
+		};
+
+		sdhci1: sdhci at ff170000 {
+			compatible = "arasan,sdhci-8.9a";
+			status = "disabled";
+			interrupt-parent = <&gic>;
+			interrupts = <0 49 4>;
+			reg = <0x0 0xff170000 0x1000>;
+			clock-names = "clk_xin", "clk_ahb";
+			clocks = <&misc_clk>, <&misc_clk>;
+		};
+
+		watchdog0: watchdog at fd4d0000 {
+			compatible = "cdns,wdt-r1p2";
+			status = "disabled";
+			clocks= <&misc_clk>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 52 1>;
+			reg = <0x0 0xfd4d0000 0x1000>;
+			timeout-sec = <10>;
+		};
+	};
+};
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index be1f12a5a5f0..c34bfa002303 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -36,6 +36,7 @@ CONFIG_ARCH_MEDIATEK=y
 CONFIG_ARCH_THUNDER=y
 CONFIG_ARCH_VEXPRESS=y
 CONFIG_ARCH_XGENE=y
+CONFIG_ARCH_ZYNQMP=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_PCI_XGENE=y
@@ -94,6 +95,8 @@ CONFIG_SERIAL_8250_MT6577=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_SERIAL_XILINX_PS_UART=y
+CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
 CONFIG_VIRTIO_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_SPI=y
-- 
1.8.2.3
