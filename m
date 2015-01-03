From: 21cnbao@gmail.com (Barry Song)
Date: Sat,  3 Jan 2015 16:27:43 +0800
Subject: [PATCH V3 09/10] ARM: dts: add init dts file for CSR atlas7 SoC
In-Reply-To: <1420273664-10438-1-git-send-email-21cnbao@gmail.com>
References: <1420273664-10438-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1420273664-10438-10-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhiwu Song <Zhiwu.Song@csr.com>

CSR atlas7 uses Network on Chip(NoC) bus architecture, there are dozens
of MARCOs, in each MARCO, there are dozens of hardware modules.

Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
Signed-off-by: Hao Liu <Hao.Liu@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/Makefile       |   1 +
 arch/arm/boot/dts/atlas7-evb.dts | 110 ++++++
 arch/arm/boot/dts/atlas7.dtsi    | 813 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 924 insertions(+)
 create mode 100644 arch/arm/boot/dts/atlas7-evb.dts
 create mode 100644 arch/arm/boot/dts/atlas7.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 68feb8f..0048cb1 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -52,6 +52,7 @@ dtb-$(CONFIG_ARCH_AT91)	+= sama5d36ek.dtb
 dtb-$(CONFIG_ARCH_AT91)	+= at91-sama5d4ek.dtb
 
 dtb-$(CONFIG_ARCH_ATLAS6) += atlas6-evb.dtb
+dtb-$(CONFIG_ARCH_ATLAS7) += atlas7-evb.dtb
 dtb-$(CONFIG_ARCH_AXXIA) += axm5516-amarillo.dtb
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b-plus.dtb
diff --git a/arch/arm/boot/dts/atlas7-evb.dts b/arch/arm/boot/dts/atlas7-evb.dts
new file mode 100644
index 0000000..49cf59a
--- /dev/null
+++ b/arch/arm/boot/dts/atlas7-evb.dts
@@ -0,0 +1,110 @@
+/*
+ * DTS file for CSR SiRFatlas7 Evaluation Board
+ *
+ * Copyright (c) 2014 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+/dts-v1/;
+
+/include/ "atlas7.dtsi"
+
+/ {
+	model = "CSR SiRFatlas7 Evaluation Board";
+	compatible = "sirf,atlas7-cb", "sirf,atlas7";
+
+	chosen {
+		bootargs = "console=ttySiRF1,115200 earlyprintk";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x40000000 0x20000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		vpp_reserved: vpp_mem at 5e800000 {
+			compatible = "sirf,reserved-memory";
+			reg = <0x5e800000 0x800000>;
+		};
+
+		nanddisk_reserved: nanddisk at 46000000 {
+			reg = <0x46000000 0x200000>;
+			no-map;
+		};
+	};
+
+
+	noc {
+		mediam {
+			nand at 17050000 {
+				memory-region = <&nanddisk_reserved>;
+			};
+		};
+
+		gnssm {
+			spi1: spi at 18200000 {
+				status = "okay";
+				spiflash: macronix at 0{
+					status = "okay";
+					compatible = "macronix,mx25l6405d";
+					reg = <0>;
+					spi-max-frequency = <37500000>;
+					spi-cpha;
+					spi-cpol;
+					#address-cells = <1>;
+					#size-cells = <1>;
+					partitions at 0 {
+						label = "myspiboot";
+						reg = <0x0 0x800000>;
+					};
+				};
+			};
+		};
+
+		btm {
+			uart6: uart at 11000000 {
+				status = "okay";
+				sirf,uart-has-rtscts;
+			};
+		};
+
+		disp-iobg {
+			vpp at 13110000 {
+				memory-region = <&vpp_reserved>;
+			};
+		};
+
+		display0: display at 0 {
+			compatible = "lvds-panel";
+			source = "lvds.0";
+
+			bl-gpios = <&gpio_1 63 0>;
+			data-lines  = <24>;
+
+			display-timings {
+				native-mode = <&timing0>;
+				timing0: timing0 {
+					clock-frequency = <60000000>;
+					hactive = <1024>;
+					vactive = <600>;
+					hfront-porch = <220>;
+					hback-porch = <100>;
+					hsync-len = <1>;
+					vback-porch = <10>;
+					vfront-porch = <25>;
+					vsync-len = <1>;
+					hsync-active = <0>;
+					vsync-active = <0>;
+					de-active = <1>;
+					pixelclk-active = <1>;
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/atlas7.dtsi b/arch/arm/boot/dts/atlas7.dtsi
new file mode 100644
index 0000000..a753178
--- /dev/null
+++ b/arch/arm/boot/dts/atlas7.dtsi
@@ -0,0 +1,813 @@
+/*
+ * DTS file for CSR SiRFatlas7 SoC
+ *
+ * Copyright (c) 2014 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+/include/ "skeleton.dtsi"
+/ {
+	compatible = "sirf,atlas7";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&gic>;
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
+		serial6 = &uart6;
+		serial9 = &usp2;
+	};
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0>;
+		};
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <1>;
+		};
+	};
+
+	noc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x10000000 0x10000000 0xc0000000>;
+
+		gic: interrupt-controller at 10301000 {
+			compatible = "arm,cortex-a9-gic";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			reg = <0x10301000 0x1000>,
+			     <0x10302000 0x0100>;
+		};
+
+		pmu_regulator: pmu_regulator at 10E30020 {
+			compatible = "sirf,atlas7-pmu-ldo";
+			reg = <0x10E30020 0x4>;
+			ldo: ldo {
+				regulator-name = "ldo";
+			};
+		};
+
+		atlas7_codec: atlas7_codec at 10E30000 {
+			#sound-dai-cells = <0>;
+			compatible = "sirf,atlas7-codec";
+			reg = <0x10E30000 0x400>;
+			clocks = <&car 62>;
+			ldo-supply = <&ldo>;
+		};
+
+		atlas7_iacc: atlas7_iacc at 10D01000 {
+			#sound-dai-cells = <0>;
+			compatible = "sirf,atlas7-iacc";
+			reg = <0x10D01000 0x100>;
+			dmas = <&dmac3 0>, <&dmac3 7>, <&dmac3 8>,
+				<&dmac3 3>, <&dmac3 9>;
+			dma-names = "rx", "tx0", "tx1", "tx2", "tx3";
+			clocks = <&car 62>;
+		};
+
+		ipc at 13240000 {
+			compatible = "sirf,atlas7-ipc";
+			ranges = <0x13240000 0x13240000 0x00010000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			hwspinlock {
+				compatible = "sirf,hwspinlock";
+				reg = <0x13240000 0x00010000>;
+
+				num-spinlocks = <30>;
+			};
+
+			ns_m3_rproc at 0 {
+				compatible = "sirf,ns2m30-rproc";
+				reg = <0x13240000 0x00010000>;
+				interrupts = <0 123 0>;
+			};
+
+			ns_m3_rproc at 1 {
+				compatible = "sirf,ns2m31-rproc";
+				reg = <0x13240000 0x00010000>;
+				interrupts = <0 126 0>;
+			};
+
+			ns_kal_rproc at 0 {
+				compatible = "sirf,ns2kal0-rproc";
+				reg = <0x13240000 0x00010000>;
+				interrupts = <0 124 0>;
+			};
+
+			ns_kal_rproc at 1 {
+				compatible = "sirf,ns2kal1-rproc";
+				reg = <0x13240000 0x00010000>;
+				interrupts = <0 127 0>;
+			};
+		};
+
+		pinctrl: ioc at 18880000 {
+			compatible = "sirf,atlas7-ioc";
+			reg = <0x18880000 0x1000>,
+				<0x10E40000 0x1000>;
+		};
+
+		pmipc {
+			compatible = "arteris, flexnoc", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x13240000 0x13240000 0x00010000>;
+			pmipc at 0x13240000 {
+				compatible = "sirf,atlas7-pmipc";
+				reg = <0x13240000 0x00010000>;
+			};
+		};
+
+		dramfw {
+			compatible = "arteris, flexnoc", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x10830000 0x10830000 0x18000>;
+			dramfw at 10820000 {
+				compatible = "sirf,nocfw-dramfw";
+				reg = <0x10830000 0x18000>;
+			};
+		};
+
+		spramfw {
+			compatible = "arteris, flexnoc", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x10250000 0x10250000 0x3000>;
+			spramfw at 10820000 {
+				compatible = "sirf,nocfw-spramfw";
+				reg = <0x10250000 0x3000>;
+			};
+		};
+
+		cpum {
+			compatible = "arteris, flexnoc", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x10200000 0x10200000 0x3000>;
+			cpum at 10200000 {
+				compatible = "sirf,nocfw-cpum";
+				reg = <0x10200000 0x3000>;
+			};
+		};
+
+		cgum {
+			compatible = "arteris, flexnoc", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x18641000 0x18641000 0x3000>,
+					 <0x18620000 0x18620000 0x1000>;
+
+			cgum at 18641000 {
+				compatible = "sirf,nocfw-cgum";
+				reg = <0x18641000 0x3000>;
+			};
+
+			car: clock-controller at 18620000 {
+				compatible = "sirf,atlas7-car";
+				reg = <0x18620000 0x1000>;
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+		};
+
+		gnssm {
+			compatible = "arteris, flexnoc", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x18000000 0x18000000 0x0000ffff>,
+				<0x18010000 0x18010000 0x1000>,
+				<0x18020000 0x18020000 0x1000>,
+				<0x18030000 0x18030000 0x1000>,
+				<0x18040000 0x18040000 0x1000>,
+				<0x18050000 0x18050000 0x1000>,
+				<0x18060000 0x18060000 0x1000>,
+				<0x18100000 0x18100000 0x3000>,
+				<0x18250000 0x18250000 0x10000>,
+				<0x18200000 0x18200000 0x1000>;
+
+			dmac0: dma-controller at 18000000 {
+				cell-index = <0>;
+				compatible = "sirf,atlas7-dmac";
+				reg = <0x18000000 0x1000>;
+				interrupts = <0 12 0>;
+				clocks = <&car 89>;
+				dma-channels = <16>;
+				#dma-cells = <1>;
+			};
+
+			gnssmfw at 0x18100000 {
+				compatible = "sirf,nocfw-gnssm";
+				reg = <0x18100000 0x3000>;
+			};
+
+			uart0: uart at 18010000 {
+				cell-index = <0>;
+				compatible = "sirf,atlas7-uart";
+				reg = <0x18010000 0x1000>;
+				interrupts = <0 17 0>;
+				clocks = <&car 90>;
+				fifosize = <128>;
+				dmas = <&dmac0 3>, <&dmac0 2>;
+				dma-names = "rx", "tx";
+			};
+
+			uart1: uart at 18020000 {
+				cell-index = <1>;
+				compatible = "sirf,atlas7-uart";
+				reg = <0x18020000 0x1000>;
+				interrupts = <0 18 0>;
+				clocks = <&car 88>;
+				fifosize = <32>;
+			};
+
+			uart2: uart at 18030000 {
+				cell-index = <2>;
+				compatible = "sirf,atlas7-uart";
+				reg = <0x18030000 0x1000>;
+				interrupts = <0 19 0>;
+				clocks = <&car 91>;
+				fifosize = <128>;
+				dmas = <&dmac0 6>, <&dmac0 7>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+			uart3: uart at 18040000 {
+				cell-index = <3>;
+				compatible = "sirf,atlas7-uart";
+				reg = <0x18040000 0x1000>;
+				interrupts = <0 66 0>;
+				clocks = <&car 92>;
+				fifosize = <128>;
+				dmas = <&dmac0 4>, <&dmac0 5>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+			uart4: uart at 18050000 {
+				cell-index = <4>;
+				compatible = "sirf,atlas7-uart";
+				reg = <0x18050000 0x1000>;
+				interrupts = <0 69 0>;
+				clocks = <&car 93>;
+				fifosize = <128>;
+				dmas = <&dmac0 0>, <&dmac0 1>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+			uart5: uart at 18060000 {
+				cell-index = <5>;
+				compatible = "sirf,atlas7-uart";
+				reg = <0x18060000 0x1000>;
+				interrupts = <0 71 0>;
+				clocks = <&car 94>;
+				fifosize = <128>;
+				dmas = <&dmac0 8>, <&dmac0 9>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+			dspub at 18250000 {
+				compatible = "dx,cc44p";
+				reg = <0x18250000 0x10000>;
+				interrupts = <0 27 0>;
+			};
+
+			spi1: spi at 18200000 {
+				compatible = "sirf,prima2-spi";
+				reg = <0x18200000 0x1000>;
+				interrupts = <0 16 0>;
+				clocks = <&car 95>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				dmas = <&dmac0 12>, <&dmac0 13>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+		};
+
+
+		gpum {
+			compatible = "arteris, flexnoc", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x13000000 0x13000000 0x3000>;
+			gpum at 0x13000000 {
+				compatible = "sirf,nocfw-gpum";
+				reg = <0x13000000 0x3000>;
+			};
+		};
+
+		mediam {
+			compatible = "arteris, flexnoc", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x16000000 0x16000000 0x00200000>,
+				<0x17020000 0x17020000 0x1000>,
+				<0x17030000 0x17030000 0x1000>,
+				<0x17040000 0x17040000 0x1000>,
+				<0x17050000 0x17050000 0x10000>,
+				<0x17060000 0x17060000 0x200>,
+				<0x17060200 0x17060200 0x100>,
+				<0x17070000 0x17070000 0x200>,
+				<0x17070200 0x17070200 0x100>,
+				<0x170A0000 0x170A0000 0x3000>;
+
+			mediam at 170A0000 {
+				compatible = "sirf,nocfw-mediam";
+				reg = <0x170A0000 0x3000>;
+			};
+
+			gpio_0: gpio_mediam at 17040000 {
+				#gpio-cells = <2>;
+				#interrupt-cells = <2>;
+				compatible = "sirf,atlas7-gpio";
+				reg = <0x17040000 0x1000>;
+				interrupts = <0 13 0>, <0 14 0>;
+				clocks = <&car 107>;
+				clock-names = "gpio0_io";
+				gpio-controller;
+				interrupt-controller;
+			};
+
+			nand at 17050000 {
+				compatible = "sirf,atlas7-nand";
+				reg = <0x17050000 0x10000>;
+				interrupts = <0 41 0>;
+				clocks = <&car 108>, <&car 112>;
+				clock-names = "nand_io", "nand_nand";
+			};
+
+			sd0: sdhci at 16000000 {
+				cell-index = <0>;
+				compatible = "sirf,atlas7-sdhc";
+				reg = <0x16000000 0x100000>;
+				interrupts = <0 38 0>;
+				clocks = <&car 109>, <&car 111>;
+				clock-names = "core", "iface";
+				wp-inverted;
+				non-removable;
+				status = "disabled";
+				bus-width = <8>;
+			};
+
+			sd1: sdhci at 16100000 {
+				cell-index = <1>;
+				compatible = "sirf,atlas7-sdhc";
+				reg = <0x16100000 0x100000>;
+				interrupts = <0 38 0>;
+				clocks = <&car 109>, <&car 111>;
+				clock-names = "core", "iface";
+				non-removable;
+				status = "disabled";
+				bus-width = <8>;
+			};
+
+			usb0: usb at 17060000 {
+				cell-index = <0>;
+				compatible = "sirf,atlas7-usb";
+				reg = <0x17060000 0x200>;
+				interrupts = <0 10 0>;
+				clocks = <&car 113>;
+				sirf,usbphy = <&usbphy0>;
+				phy_type = "utmi";
+				dr_mode = "otg";
+				maximum-speed = "high-speed";
+				status = "okay";
+			};
+
+			usb1: usb at 17070000 {
+				cell-index = <1>;
+				compatible = "sirf,atlas7-usb";
+				reg = <0x17070000 0x200>;
+				interrupts = <0 11 0>;
+				clocks = <&car 114>;
+				sirf,usbphy = <&usbphy1>;
+				phy_type = "utmi";
+				dr_mode = "host";
+				maximum-speed = "high-speed";
+				status = "okay";
+			};
+
+			usbphy0: usbphy at 0 {
+				compatible = "sirf,atlas7-usbphy";
+				reg = <0x17060200 0x100>;
+				clocks = <&car 115>;
+				status = "okay";
+			};
+
+			usbphy1: usbphy at 1 {
+				compatible = "sirf,atlas7-usbphy";
+				reg = <0x17070200 0x100>;
+				clocks = <&car 116>;
+				status = "okay";
+			};
+
+			i2c0: i2c at 17020000 {
+				cell-index = <0>;
+				compatible = "sirf,prima2-i2c";
+				reg = <0x17020000 0x1000>;
+				interrupts = <0 24 0>;
+				clocks = <&car 105>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+		};
+
+		vdifm {
+			compatible = "arteris, flexnoc", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x13290000 0x13290000 0x3000>,
+				<0x13300000 0x13300000 0x1000>,
+				<0x14200000 0x14200000 0x600000>;
+
+			vdifm at 13290000 {
+				compatible = "sirf,nocfw-vdifm";
+				reg = <0x13290000 0x3000>;
+			};
+
+			gpio_1: gpio_vdifm at 13300000 {
+				#gpio-cells = <2>;
+				#interrupt-cells = <2>;
+				compatible = "sirf,atlas7-gpio";
+				reg = <0x13300000 0x1000>;
+				interrupts = <0 43 0>, <0 44 0>, <0 45 0>;
+				clocks = <&car 84>;
+				clock-names = "gpio1_io";
+				gpio-controller;
+				interrupt-controller;
+			};
+
+			sd2: sdhci at 14200000 {
+				cell-index = <2>;
+				compatible = "sirf,atlas7-sdhc";
+				reg = <0x14200000 0x100000>;
+				interrupts = <0 23 0>;
+				clocks = <&car 70>, <&car 75>;
+				clock-names = "core", "iface";
+				status = "disabled";
+				bus-width = <4>;
+				sd-uhs-sdr50;
+				vqmmc-supply = <&vqmmc>;
+				vqmmc: vqmmc at 2 {
+					regulator-min-microvolt = <1650000>;
+					regulator-max-microvolt = <1950000>;
+					regulator-name = "vqmmc-ldo";
+					regulator-type = "voltage";
+					regulator-boot-on;
+					regulator-allow-bypass;
+				};
+			};
+
+			sd3: sdhci at 14300000 {
+				cell-index = <3>;
+				compatible = "sirf,atlas7-sdhc";
+				reg = <0x14300000 0x100000>;
+				interrupts = <0 23 0>;
+				clocks = <&car 76>, <&car 81>;
+				clock-names = "core", "iface";
+				status = "disabled";
+				bus-width = <4>;
+			};
+
+			sd5: sdhci at 14500000 {
+				cell-index = <5>;
+				compatible = "sirf,atlas7-sdhc";
+				reg = <0x14500000 0x100000>;
+				interrupts = <0 39 0>;
+				clocks = <&car 71>, <&car 76>;
+				clock-names = "core", "iface";
+				status = "disabled";
+				bus-width = <4>;
+				loop-dma;
+			};
+
+			sd6: sdhci at 14600000 {
+				cell-index = <6>;
+				compatible = "sirf,atlas7-sdhc";
+				reg = <0x14600000 0x100000>;
+				interrupts = <0 98 0>;
+				clocks = <&car 72>, <&car 77>;
+				clock-names = "core", "iface";
+				status = "disabled";
+				bus-width = <4>;
+			};
+
+			sd7: sdhci at 14700000 {
+				cell-index = <7>;
+				compatible = "sirf,atlas7-sdhc";
+				reg = <0x14700000 0x100000>;
+				interrupts = <0 98 0>;
+				clocks = <&car 72>, <&car 77>;
+				clock-names = "core", "iface";
+				status = "disabled";
+				bus-width = <4>;
+			};
+		};
+
+		audiom {
+			compatible = "arteris, flexnoc", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x10d50000 0x10d50000 0x0000ffff>,
+					<0x10d60000 0x10d60000 0x0000ffff>,
+					<0x10d80000 0x10d80000 0x0000ffff>,
+					<0x10d90000 0x10d90000 0x0000ffff>,
+					<0x10ED0000 0x10ED0000 0x3000>,
+					<0x10dc8000 0x10dc8000 0x1000>,
+					<0x10dc0000 0x10dc0000 0x1000>,
+					<0x10db0000 0x10db0000 0x4000>,
+					<0x10d40000 0x10d40000 0x1000>,
+					<0x10d30000 0x10d30000 0x1000>;
+
+			timer at 10dc0000 {
+				compatible = "sirf,atlas7-tick";
+				reg = <0x10dc0000 0x1000>;
+				interrupts = <0 0 0>,
+					   <0 1 0>,
+					   <0 2 0>,
+					   <0 49 0>,
+					   <0 50 0>,
+					   <0 51 0>;
+				clocks = <&car 47>;
+			};
+
+			timerb at 10dc8000 {
+					compatible = "sirf,atlas7-tick";
+					reg = <0x10dc8000 0x1000>;
+					interrupts = <0 74 0>,
+							   <0 75 0>,
+							   <0 76 0>,
+							   <0 77 0>,
+							   <0 78 0>,
+							   <0 79 0>;
+					clocks = <&car 47>;
+			};
+
+			vip0 at 10db0000 {
+				compatible = "sirf,atlas7-vip0";
+				reg = <0x10db0000 0x2000>;
+				interrupts = <0 85 0>;
+				sirf,vip_cma_size = <0xC00000>;
+			};
+
+			cvd at 10db2000 {
+				compatible = "sirf,cvd";
+				reg = <0x10db2000 0x2000>;
+				clocks = <&car 46>;
+			};
+
+			dmac2: dma-controller at 10d50000 {
+				cell-index = <2>;
+				compatible = "sirf,atlas7-dmac";
+				reg = <0x10d50000 0xffff>;
+				interrupts = <0 55 0>;
+				clocks = <&car 60>;
+				dma-channels = <16>;
+				#dma-cells = <1>;
+			};
+
+			dmac3: dma-controller at 10d60000 {
+				cell-index = <3>;
+				compatible = "sirf,atlas7-dmac";
+				reg = <0x10d60000 0xffff>;
+				interrupts = <0 56 0>;
+				clocks = <&car 61>;
+				dma-channels = <16>;
+				#dma-cells = <1>;
+			};
+
+			adc: adc at 10d80000 {
+				compatible = "sirf,atlas7-adc";
+				reg = <0x10d80000 0xffff>;
+				interrupts = <0 34 0>;
+				clocks = <&car 49>;
+				#io-channel-cells = <1>;
+			};
+
+			pulsec at 10d90000 {
+				compatible = "sirf,prima2-pulsec";
+				reg = <0x10d90000 0xffff>;
+				interrupts = <0 42 0>;
+				clocks = <&car 54>;
+			};
+
+			audiom at 10ED0000 {
+				compatible = "sirf,nocfw-audiom";
+				reg = <0x10ED0000 0x3000>;
+				interrupts = <0 102 0>;
+			};
+
+			usp1: usp at 10d30000 {
+				cell-index = <1>;
+				reg = <0x10d30000 0x1000>;
+				fifosize = <512>;
+				clocks = <&car 58>;
+				dmas = <&dmac2 6>, <&dmac2 7>;
+				dma-names = "rx", "tx";
+			};
+
+			usp2: usp at 10d40000 {
+				cell-index = <2>;
+				reg = <0x10d40000 0x1000>;
+				interrupts = <0 22 0>;
+				clocks = <&car 59>;
+				dmas = <&dmac2 12>, <&dmac2 13>;
+				dma-names = "rx", "tx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
+		ddrm {
+			compatible = "arteris, flexnoc", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x10820000 0x10820000 0x3000>,
+					<0x10800000 0x10800000 0x2000>;
+			ddrm at 10820000 {
+				compatible = "sirf,nocfw-ddrm";
+				reg = <0x10820000 0x3000>;
+				interrupts = <0 105 0>;
+			};
+
+			memory-controller at 0x10800000 {
+				compatible = "sirf,atlas7-memc";
+				reg = <0x10800000 0x2000>;
+			};
+
+		};
+
+		btm {
+			compatible = "arteris, flexnoc", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x11002000 0x11002000 0x0000ffff>,
+			       <0x11010000 0x11010000 0x3000>,
+			       <0x11000000 0x11000000 0x1000>,
+			       <0x11001000 0x11001000 0x1000>;
+
+			dmac4: dma-controller at 11002000 {
+				cell-index = <4>;
+				compatible = "sirf,atlas7-dmac";
+				reg = <0x11002000 0x1000>;
+				interrupts = <0 99 0>;
+				clocks = <&car 130>;
+				dma-channels = <16>;
+				#dma-cells = <1>;
+			};
+			uart6: uart at 11000000 {
+				cell-index = <6>;
+				compatible = "sirf,atlas7-bt-uart",
+						"sirf,atlas7-uart";
+				reg = <0x11000000 0x1000>;
+				interrupts = <0 100 0>;
+				clocks = <&car 131>, <&car 133>, <&car 134>;
+				clock-names = "uart", "general", "noc";
+				fifosize = <128>;
+				dmas = <&dmac4 12>, <&dmac4 13>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
+			usp3: usp at 11001000 {
+				compatible = "sirf,atlas7-bt-usp",
+					   "sirf,prima2-usp-pcm";
+				cell-index = <3>;
+				reg = <0x11001000 0x1000>;
+				fifosize = <512>;
+				clocks = <&car 132>, <&car 129>, <&car 133>,
+					<&car 134>, <&car 135>;
+				clock-names = "usp3_io", "a7ca_btss", "a7ca_io",
+					"noc_btm_io", "thbtm_io";
+				dmas = <&dmac4 0>, <&dmac4 1>;
+				dma-names = "rx", "tx";
+			};
+
+			btm at 11010000 {
+				compatible = "sirf,nocfw-btm";
+				reg = <0x11010000 0x3000>;
+			};
+		};
+
+		rtcm {
+			compatible = "arteris, flexnoc", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x18810000 0x18810000 0x3000>,
+				<0x18840000 0x18840000 0x1000>,
+				<0x18890000 0x18890000 0x1000>,
+				<0x188B0000 0x188B0000 0x10000>,
+				<0x188D0000 0x188D0000 0x1000>;
+			rtcm at 18810000 {
+				compatible = "sirf,nocfw-rtcm";
+				reg = <0x18810000 0x3000>;
+				interrupts = <0 109 0>;
+			};
+
+			gpio_2: gpio_rtcm at 18890000 {
+				#gpio-cells = <2>;
+				#interrupt-cells = <2>;
+				compatible = "sirf,atlas7-gpio";
+				reg = <0x18890000 0x1000>;
+				interrupts = <0 47 0>;
+				gpio-controller;
+				interrupt-controller;
+			};
+
+			rtc-iobg at 18840000 {
+				compatible = "sirf,prima2-rtciobg",
+					"sirf-prima2-rtciobg-bus",
+					"simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x18840000 0x1000>;
+
+				sysrtc at 2000 {
+					compatible = "sirf,prima2-sysrtc";
+					reg = <0x2000 0x100>;
+					interrupts = <0 52 0>;
+				};
+				pwrc at 3000 {
+					compatible = "sirf,atlas7-pwrc";
+					reg = <0x3000 0x100>;
+				};
+			};
+
+			qspi: flash at 188B0000 {
+				cell-index = <0>;
+				compatible = "sirf,atlas7-qspi-nor";
+				reg = <0x188B0000 0x10000>;
+				interrupts = <0 15 0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			retain at 0x188D0000 {
+				compatible = "sirf,atlas7-retain";
+				reg = <0x188D0000 0x1000>;
+			};
+
+		};
+		disp-iobg {
+			/* lcdc0 */
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x13100000 0x13100000 0x20000>,
+				 <0x10e10000 0x10e10000 0x10000>;
+
+			lcd at 13100000 {
+				compatible = "sirf,atlas7-lcdc";
+				reg = <0x13100000 0x10000>;
+				interrupts = <0 30 0>;
+				clocks = <&car 79>;
+			};
+			vpp at 13110000 {
+				compatible = "sirf,atlas7-vpp";
+				reg = <0x13110000 0x10000>;
+				interrupts = <0 31 0>;
+				clocks = <&car 78>;
+				resets = <&car 29>;
+			};
+			lvds at 10e10000 {
+				compatible = "sirf,atlas7-lvdsc";
+				reg = <0x10e10000 0x10000>;
+				interrupts = <0 64 0>;
+				clocks = <&car 54>;
+				resets = <&car 29>;
+			};
+
+		};
+
+		graphics-iobg {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x12000000 0x12000000 0x1000000>;
+
+			graphics at 12000000 {
+				compatible = "powervr,sgx531";
+				reg = <0x12000000 0x1000000>;
+				interrupts = <0 6 0>;
+				clocks = <&car 126>;
+			};
+		};
+	};
+};
-- 
2.2.1
