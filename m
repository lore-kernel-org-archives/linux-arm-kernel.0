From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Wed, 29 Oct 2014 10:59:07 -0500
Subject: [PATCH] arm: dts: socfpga: Add a base DTSI for Altera's Arria10 SOC
Message-ID: <1414598347-26769-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

The Arria 10 is latest SOC+FPGA from the Altera SOCFPGA platform. The Arria10
SOC shares some similarities with the SOCFPGA Cyclone5 and Arria5, but there
are enough differences to warrant a new base dtsi.

The differences are:
* 3 EMAC controllers
* 5 I2C controllers
* 3 SPI controllers
* 1.5 GHZ dual A9s
* Support for DDR4

Besides the usual memory map and IRQ changes, the clock framework will be
different, so this patch just adds the fixed-clocks.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/socfpga_arria10.dtsi      | 374 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/socfpga_arria10_socdk.dts |  48 ++++
 3 files changed, 423 insertions(+)
 create mode 100644 arch/arm/boot/dts/socfpga_arria10.dtsi
 create mode 100755 arch/arm/boot/dts/socfpga_arria10_socdk.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 38c89ca..b1905a7 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -397,6 +397,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
 	r8a7779-marzen.dtb \
 	r8a7794-alt.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_arria5_socdk.dtb \
+	socfpga_arria10_socdk.dtb \
 	socfpga_cyclone5_socdk.dtb \
 	socfpga_cyclone5_sockit.dtb \
 	socfpga_cyclone5_socrates.dtb \
diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
new file mode 100644
index 0000000..56d5840
--- /dev/null
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -0,0 +1,374 @@
+/*
+ * Copyright Altera Corporation (C) 2014. All rights reserved.
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
+#include "skeleton.dtsi"
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+		ethernet2 = &gmac2;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		timer0 = &timer0;
+		timer1 = &timer1;
+		timer2 = &timer2;
+		timer3 = &timer3;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			reg = <0>;
+			next-level-cache = <&L2>;
+		};
+		cpu at 1 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			reg = <1>;
+			next-level-cache = <&L2>;
+		};
+	};
+
+	intc: intc at ffffd000 {
+		compatible = "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0xffffd000 0x1000>,
+		      <0xffffc100 0x100>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		device_type = "soc";
+		interrupt-parent = <&intc>;
+		ranges;
+
+		amba {
+			compatible = "arm,amba-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			pdma: pdma at ffda1000 {
+				compatible = "arm,pl330", "arm,primecell";
+				reg = <0xffda1000 0x1000>;
+				interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>,
+					     <0 84 IRQ_TYPE_LEVEL_HIGH>,
+					     <0 85 IRQ_TYPE_LEVEL_HIGH>,
+					     <0 86 IRQ_TYPE_LEVEL_HIGH>,
+					     <0 87 IRQ_TYPE_LEVEL_HIGH>,
+					     <0 88 IRQ_TYPE_LEVEL_HIGH>,
+					     <0 89 IRQ_TYPE_LEVEL_HIGH>,
+					     <0 90 IRQ_TYPE_LEVEL_HIGH>;
+				#dma-cells = <1>;
+				#dma-channels = <8>;
+				#dma-requests = <32>;
+			};
+		};
+
+		clkmgr at ffd04000 {
+				compatible = "altr,clk-mgr";
+				reg = <0xffd04000 0x1000>;
+
+				clocks {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					osc1: osc1 {
+						#clock-cells = <0>;
+						compatible = "fixed-clock";
+					};
+
+					main_pll: main_pll {
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-pll-clock";
+						clocks = <&osc1>;
+					};
+
+					periph_pll: periph_pll {
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-pll-clock";
+						clocks = <&osc1>;
+					};
+				};
+		};
+
+		gmac0: ethernet at ff800000 {
+			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.72a", "snps,dwmac";
+			reg = <0xff800000 0x2000>;
+			interrupts = <0 92 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			/* Filled in by bootloader */
+			mac-address = [00 00 00 00 00 00];
+			status = "disabled";
+		};
+
+		gmac1: ethernet at ff802000 {
+			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.72a", "snps,dwmac";
+		        reg = <0xff802000 0x2000>;
+			interrupts = <0 93 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			/* Filled in by bootloader */
+			mac-address = [00 00 00 00 00 00];
+			status = "disabled";
+		};
+
+		gmac2: ethernet at ff804000 {
+			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.72a", "snps,dwmac";
+			reg = <0xff804000 0x2000>;
+			interrupts = <0 94 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			/* Filled in by bootloader */
+			mac-address = [00 00 00 00 00 00];
+			status = "disabled";
+		};
+
+		gpio0: gpio at ffc02900 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dw-apb-gpio";
+			reg = <0xffc02900 0x100>;
+			status = "disabled";
+
+			porta: gpio-controller at 0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <29>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <0 112 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		gpio1: gpio at ffc02a00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dw-apb-gpio";
+			reg = <0xffc02a00 0x100>;
+			status = "disabled";
+
+			portb: gpio-controller at 0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <29>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <0 113 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		gpio2: gpio at ffc02b00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dw-apb-gpio";
+			reg = <0xffc02b00 0x100>;
+			status = "disabled";
+
+			portc: gpio-controller at 0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <27>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <0 114 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		i2c0: i2c at ffc02200 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,designware-i2c";
+			reg = <0xffc02200 0x100>;
+			interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		i2c1: i2c at ffc02300 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,designware-i2c";
+			reg = <0xffc02300 0x100>;
+			interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		i2c2: i2c at ffc02400 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,designware-i2c";
+			reg = <0xffc02400 0x100>;
+			interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		i2c3: i2c at ffc02500 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,designware-i2c";
+			reg = <0xffc02500 0x100>;
+			interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		i2c4: i2c at ffc02600 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,designware-i2c";
+			reg = <0xffc02600 0x100>;
+			interrupts = <0 109 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		L2: l2-cache at fffff000 {
+			compatible = "arm,pl310-cache";
+			reg = <0xfffff000 0x1000>;
+			interrupts = <0 18 IRQ_TYPE_LEVEL_HIGH>;
+			cache-unified;
+			cache-level = <2>;
+		};
+
+		mmc: dwmmc0 at ff808000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "altr,socfpga-dw-mshc";
+			reg = <0xff808000 0x1000>;
+			interrupts = <0 98 IRQ_TYPE_LEVEL_HIGH>;
+			fifo-depth = <0x400>;
+		};
+
+		ocram: sram at ffe00000 {
+			compatible = "mmio-sram";
+			reg = <0xffe00000 0x40000>
+		};
+
+		rst: rstmgr at ffd05000 {
+			#reset-cells = <1>;
+			compatible = "altr,rst-mgr";
+			reg = <0xffd05000 0x100>;
+		};
+
+		sysmgr: sysmgr at ffd06000 {
+			compatible = "altr,sys-mgr", "syscon";
+			reg = <0xffd06000 0x300>;
+		};
+
+		/* Local timer */
+		timer at ffffc600 {
+			compatible = "arm,cortex-a9-twd-timer";
+			reg = <0xffffc600 0x100>;
+			interrupts = <1 13 0xf04>;
+		};
+
+		timer0: timer0 at ffc02700 {
+			compatible = "snps,dw-apb-timer";
+			interrupts = <0 115 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0xffc02700 0x100>;
+		};
+
+		timer1: timer1 at ffc02800 {
+			compatible = "snps,dw-apb-timer";
+			interrupts = <0 116 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0xffc02800 0x100>;
+		};
+
+		timer2: timer2 at ffd00000 {
+			compatible = "snps,dw-apb-timer";
+			interrupts = <0 117 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0xffd00000 0x100>;
+		};
+
+		timer3: timer3 at ffd00100 {
+			compatible = "snps,dw-apb-timer";
+			interrupts = <0 118 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0xffd01000 0x100>;
+		};
+
+		uart0: serial0 at ffc02000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0xffc02000 0x100>;
+			interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+		};
+
+		uart1: serial1 at ffc02100 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0xffc02100 0x100>;
+			interrupts = <0 111 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
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
+			reg = <0xffb00000 0xffff>;
+			interrupts = <0 95 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usbphy0>;
+			phy-names = "usb2-phy";
+			status = "disabled";
+		};
+
+		usb1: usb at ffb40000 {
+			compatible = "snps,dwc2";
+			reg = <0xffb40000 0xffff>;
+			interrupts = <0 96 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usbphy0>;
+			phy-names = "usb2-phy";
+			status = "disabled";
+		};
+
+		watchdog0: watchdog at ffd00200 {
+			compatible = "snps,dw-wdt";
+			reg = <0xffd00200 0x100>;
+			interrupts = <0 119 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		watchdog1: watchdog at ffd00300 {
+			compatible = "snps,dw-wdt";
+			reg = <0xffd00300 0x100>;
+			interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk.dts b/arch/arm/boot/dts/socfpga_arria10_socdk.dts
new file mode 100755
index 0000000..3015ce8
--- /dev/null
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk.dts
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2014 Altera Corporation <www.altera.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/dts-v1/;
+#include "socfpga_arria10.dtsi"
+
+/ {
+	model = "Altera SOCFPGA Arria 10";
+	compatible = "altr,socfpga-arria10", "altr,socfpga";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 rootwait";
+	};
+
+	memory {
+		name = "memory";
+		device_type = "memory";
+		reg = <0x0 0x40000000>; /* 1GB */
+	};
+
+	soc {
+		clkmgr at ffd04000 {
+			clocks {
+				osc1 {
+					clock-frequency = <25000000>;
+				};
+			};
+		};
+
+		serial0 at ffc02000 {
+			status = "okay";
+		};
+	};
+};
-- 
2.0.3
