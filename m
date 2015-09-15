From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Tue, 15 Sep 2015 16:47:05 -0500
Subject: [RESEND PATCHv3] arm64: dts: Add base stratix 10 dtsi
Message-ID: <1442353625-4552-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Add the base DTS for Altera's SoCFPGA Stratix 10 platform.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
v3: change #address-cells and #size-cells to <2>
    change the GIC address to 0xfffc1000
    update the GIC virtual CPU reg length to 0x2000
v2: use interrupt-affinity for pmu node
---
 arch/arm64/Kconfig.platforms                       |   5 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/altera/Makefile                |   5 +
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  | 357 +++++++++++++++++++++
 .../boot/dts/altera/socfpga_stratix10_socdk.dts    |  39 +++
 arch/arm64/configs/defconfig                       |   1 +
 6 files changed, 408 insertions(+)
 create mode 100644 arch/arm64/boot/dts/altera/Makefile
 create mode 100644 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
 create mode 100644 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 23800a1..36303c8 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -66,6 +66,11 @@ config ARCH_SEATTLE
 	help
 	  This enables support for AMD Seattle SOC Family
 
+config ARCH_STRATIX10
+	bool "Altera's Stratix 10 SoCFPGA Family"
+	help
+	  This enables support for Altera's Stratix 10 SoCFPGA Family.
+
 config ARCH_TEGRA
 	bool "NVIDIA Tegra SoC Family"
 	select ARCH_HAS_RESET_CONTROLLER
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index d9f8833..f585606 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -1,3 +1,4 @@
+dts-dirs += altera
 dts-dirs += amd
 dts-dirs += apm
 dts-dirs += arm
diff --git a/arch/arm64/boot/dts/altera/Makefile b/arch/arm64/boot/dts/altera/Makefile
new file mode 100644
index 0000000..d7a6416
--- /dev/null
+++ b/arch/arm64/boot/dts/altera/Makefile
@@ -0,0 +1,5 @@
+dtb-$(CONFIG_ARCH_STRATIX10) += socfpga_stratix10_socdk.dtb
+
+always		:= $(dtb-y)
+subdir-y	:= $(dts-dirs)
+clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
new file mode 100644
index 0000000..bec613f
--- /dev/null
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -0,0 +1,357 @@
+/*
+ * Copyright Altera Corporation (C) 2015. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/dts-v1/;
+
+/ {
+	compatible = "altr,socfpga-stratix10";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 0 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			enable-method = "psci";
+			reg = <0x0>;
+		};
+
+		cpu1: cpu at 1 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			enable-method = "psci";
+			reg = <0x1>;
+		};
+
+		cpu2: cpu at 2 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			enable-method = "psci";
+			reg = <0x2>;
+		};
+
+		cpu3: cpu at 3 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			enable-method = "psci";
+			reg = <0x3>;
+		};
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <0 120 8>,
+			     <0 121 8>,
+			     <0 122 8>,
+			     <0 123 8>;
+		interrupt-affinity = <&cpu0>,
+				     <&cpu1>,
+				     <&cpu2>,
+				     <&cpu3>;
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	intc: intc at fffc1000 {
+		compatible = "arm,gic-400", "arm,cortex-a15-gic";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x0 0xfffc1000 0x1000>,
+		      <0x0 0xfffc2000 0x2000>,
+		      <0x0 0xfffc4000 0x2000>,
+		      <0x0 0xfffc6000 0x2000>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		device_type = "soc";
+		interrupt-parent = <&intc>;
+
+		clkmgr at ffd1000 {
+			compatible = "altr,clk-mgr";
+			reg = <0xffd10000 0x1000>;
+		};
+
+		gmac0: ethernet at ff800000 {
+			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
+			reg = <0xff800000 0x2000>;
+			interrupts = <0 90 4>;
+			interrupt-names = "macirq";
+			mac-address = [00 00 00 00 00 00];
+			status = "disabled";
+		};
+
+		gmac1: ethernet at ff802000 {
+			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
+			reg = <0xff802000 0x2000>;
+			interrupts = <0 91 4>;
+			interrupt-names = "macirq";
+			mac-address = [00 00 00 00 00 00];
+			status = "disabled";
+		};
+
+		gmac2: ethernet at ff804000 {
+			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
+			reg = <0xff804000 0x2000>;
+			interrupts = <0 92 4>;
+			interrupt-names = "macirq";
+			mac-address = [00 00 00 00 00 00];
+			status = "disabled";
+		};
+
+		gpio0: gpio at ffc03200 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dw-apb-gpio";
+			reg = <0xffc03200 0x100>;
+			status = "disabled";
+
+			porta: gpio-controller at 0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <24>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <0 110 4>;
+			};
+		};
+
+		gpio1: gpio at ffc03300 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dw-apb-gpio";
+			reg = <0xffc03300 0x100>;
+			status = "disabled";
+
+			portb: gpio-controller at 0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <24>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <0 110 4>;
+			};
+		};
+
+		i2c0: i2c at ffc02800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,designware-i2c";
+			reg = <0xffc02800 0x100>;
+			interrupts = <0 103 4>;
+			status = "disabled";
+		};
+
+		i2c1: i2c at ffc02900 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,designware-i2c";
+			reg = <0xffc02900 0x100>;
+			interrupts = <0 104 4>;
+			status = "disabled";
+		};
+
+		i2c2: i2c at ffc02a00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,designware-i2c";
+			reg = <0xffc02a00 0x100>;
+			interrupts = <0 105 4>;
+			status = "disabled";
+		};
+
+		i2c3: i2c at ffc02b00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,designware-i2c";
+			reg = <0xffc02b00 0x100>;
+			interrupts = <0 106 4>;
+			status = "disabled";
+		};
+
+		i2c4: i2c at ffc02c00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,designware-i2c";
+			reg = <0xffc02c00 0x100>;
+			interrupts = <0 107 4>;
+			status = "disabled";
+		};
+
+		mmc: dwmmc0 at ff808000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "altr,socfpga-dw-mshc";
+			reg = <0xff808000 0x1000>;
+			interrupts = <0 96 4>;
+			fifo-depth = <0x400>;
+			status = "disabled";
+		};
+
+		ocram: sram at ffe00000 {
+			compatible = "mmio-sram";
+			reg = <0xffe00000 0x100000>;
+		};
+
+		rst: rstmgr at ffd11000 {
+			#reset-cells = <1>;
+			compatible = "altr,rst-mgr";
+			reg = <0xffd11000 0x1000>;
+		};
+
+		spi0: spi at ffda4000 {
+			compatible = "snps,dw-apb-ssi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0xffda4000 0x1000>;
+			interrupts = <0 101 4>;
+			num-chipselect = <4>;
+			bus-num = <0>;
+			status = "disabled";
+		};
+
+		spi1: spi at ffda5000 {
+			compatible = "snps,dw-apb-ssi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0xffda5000 0x1000>;
+			interrupts = <0 102 4>;
+			num-chipselect = <4>;
+			bus-num = <0>;
+			status = "disabled";
+		};
+
+		sysmgr: sysmgr at ffd12000 {
+			compatible = "altr,sys-mgr", "syscon";
+			reg = <0xffd12000 0x1000>;
+		};
+
+		/* Local timer */
+		timer {
+			compatible = "arm,armv8-timer";
+			interrupts = <1 13 0xf01>,
+				     <1 14 0xf01>,
+				     <1 11 0xf01>,
+				     <1 10 0xf01>;
+		};
+
+		timer0: timer0 at ffc03000 {
+			compatible = "snps,dw-apb-timer";
+			interrupts = <0 113 4>;
+			reg = <0xffc03000 0x100>;
+		};
+
+		timer1: timer1 at ffc03100 {
+			compatible = "snps,dw-apb-timer";
+			interrupts = <0 114 4>;
+			reg = <0xffc03100 0x100>;
+		};
+
+		timer2: timer2 at ffd00000 {
+			compatible = "snps,dw-apb-timer";
+			interrupts = <0 115 4>;
+			reg = <0xffd00000 0x100>;
+		};
+
+		timer3: timer3 at ffd00100 {
+			compatible = "snps,dw-apb-timer";
+			interrupts = <0 116 4>;
+			reg = <0xffd00100 0x100>;
+		};
+
+		uart0: serial0 at ffc02000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0xffc02000 0x100>;
+			interrupts = <0 108 4>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart1: serial1 at ffc02100 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0xffc02100 0x100>;
+			interrupts = <0 109 4>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		usbphy0: usbphy at 0 {
+			#phy-cells = <0>;
+			compatible = "usb-nop-xceiv";
+			status = "okay";
+		};
+
+		usb0: usb at ffb00000 {
+			compatible = "snps,dwc2";
+			reg = <0xffb00000 0x40000>;
+			interrupts = <0 93 4>;
+			phys = <&usbphy0>;
+			phy-names = "usb2-phy";
+			status = "disabled";
+		};
+
+		usb1: usb at ffb40000 {
+			compatible = "snps,dwc2";
+			reg = <0xffb40000 0x40000>;
+			interrupts = <0 94 4>;
+			phys = <&usbphy0>;
+			phy-names = "usb2-phy";
+			status = "disabled";
+		};
+
+		watchdog0: watchdog at ffd00200 {
+			compatible = "snps,dw-wdt";
+			reg = <0xffd00200 0x100>;
+			interrupts = <0 117 4>;
+			status = "disabled";
+		};
+
+		watchdog1: watchdog at ffd00300 {
+			compatible = "snps,dw-wdt";
+			reg = <0xffd00300 0x100>;
+			interrupts = <0 118 4>;
+			status = "disabled";
+		};
+
+		watchdog2: watchdog at ffd00400 {
+			compatible = "snps,dw-wdt";
+			reg = <0xffd00400 0x100>;
+			interrupts = <0 125 4>;
+			status = "disabled";
+		};
+
+		watchdog3: watchdog at ffd00500 {
+			compatible = "snps,dw-wdt";
+			reg = <0xffd00500 0x100>;
+			interrupts = <0 126 4>;
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
new file mode 100644
index 0000000..41ea2db
--- /dev/null
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -0,0 +1,39 @@
+/*
+ * Copyright Altera Corporation (C) 2015. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/include/ "socfpga_stratix10.dtsi"
+
+/ {
+	model = "SoCFPGA Stratix 10 SoCDK";
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
+		/* We expect the bootloader to fill in the reg */
+		reg = <0 0 0 0>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 34d71dd..7f78e18 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -39,6 +39,7 @@ CONFIG_ARCH_HISI=y
 CONFIG_ARCH_MEDIATEK=y
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_ARCH_SEATTLE=y
+CONFIG_ARCH_STRATIX10=y
 CONFIG_ARCH_TEGRA=y
 CONFIG_ARCH_TEGRA_132_SOC=y
 CONFIG_ARCH_QCOM=y
-- 
2.4.5
