From: andrew@ncrmnt.org (Andrew Andrianov)
Date: Tue, 30 Jun 2015 18:15:05 +0300
Subject: [PATCH v2 3/5] ARM: dts: rcm-k1879xb1: Add dts files for K1879XB1YA
In-Reply-To: <1435677307-6526-1-git-send-email-andrew@ncrmnt.org>
References: <1435677307-6526-1-git-send-email-andrew@ncrmnt.org>
Message-ID: <1435677307-6526-4-git-send-email-andrew@ncrmnt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Andrianov <andrew@ncrmnt.org>
---
 arch/arm/boot/dts/Makefile                |   1 +
 arch/arm/boot/dts/rcm-k1879xb1-mb7707.dts | 146 +++++++++
 arch/arm/boot/dts/rcm-k1879xb1.dtsi       | 518 ++++++++++++++++++++++++++++++
 3 files changed, 665 insertions(+)
 create mode 100644 arch/arm/boot/dts/rcm-k1879xb1-mb7707.dts
 create mode 100644 arch/arm/boot/dts/rcm-k1879xb1.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 992736b..1ee1a60 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -454,6 +454,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-msm8660-surf.dtb \
 	qcom-msm8960-cdp.dtb \
 	qcom-msm8974-sony-xperia-honami.dtb
+dtb-$(CONFIG_ARCH_RCM_K1879XB1) += rcm-k1879xb1-mb7707.dtb
 dtb-$(CONFIG_ARCH_REALVIEW) += \
 	arm-realview-pb1176.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += \
diff --git a/arch/arm/boot/dts/rcm-k1879xb1-mb7707.dts b/arch/arm/boot/dts/rcm-k1879xb1-mb7707.dts
new file mode 100644
index 0000000..80d5a92
--- /dev/null
+++ b/arch/arm/boot/dts/rcm-k1879xb1-mb7707.dts
@@ -0,0 +1,146 @@
+/*
+ * Copyright Promwad inc(C) 2011
+ * Copyright RC Module      2015
+ *
+ * Michail Kurachkin <stelhs@ya.ru>
+ * Andrew Andrianov  <andrew@ncrmnt.org>
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
+ */
+
+/dts-v1/;
+#include "rcm-k1879xb1.dtsi"
+
+/ {
+	model = "RC Module MB77.07";
+	compatible = "rcm,mb7707";
+
+	memory {
+		device_type = "memory";
+		reg = <0x40000000 0x8000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,38400n8 earlyprintk=serial";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		one {
+			label = "mb7707::led1";
+			gpios = <&gpiofj 31 0>; /* LED1 */
+			linux,default-trigger = "heartbeat";
+		};
+		two {
+			label = "mb7707::led2";
+			gpios = <&gpiofj 30 0>; /* LED2 */
+			default-state = "off";
+		};
+	};
+
+	clocks {
+		oscillator_27m: oscillator at 27M {
+			/* On-board crystal, 27MHz clock */
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <27000000>;
+			clock-accuracy = <0>;
+			clock-output-names = "clk_27m";
+		};
+
+		oscillator_48m: oscillator at 48M {
+			/* On-board crystal, 48MHz clock */
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <48000000>;
+			clock-output-names = "clk_48m";
+		};
+
+		oscillator_74_25m: oscillator at 74M {
+			/* On-board crystal, 74.25MHz clock */
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <74250000>;
+			clock-output-names = "clk_74m";
+		};
+
+		oscillator_12_288m: oscillator at 12M {
+			/* On-board crystal, 12.288MHz clock */
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <12288000>;
+			clock-output-names = "clk_12m";
+		};
+	};
+};
+
+&ethernet {
+	local-mac-address = [ EC 17 66 77 07 00 ];
+	status = "okay";
+	mdio {
+	phy0: ethernet-phy at 0 {
+			reg = <0x1f>;
+		};
+	};
+};
+
+&ssp0 {
+	status = "okay";
+	spidev at 0 {
+		compatible = "rohm,dh2228fv";
+		reg = <0>;
+		spi-max-frequency = <25000000>;
+		spi-cpha;
+		pl022,hierarchy = <0>;
+		pl022,interface = <0>;
+		pl022,slave-tx-disable;
+		pl022,com-mode = <0x1>; /* polling mode */
+		pl022,rx-level-trig = <0>;
+		pl022,tx-level-trig = <0>;
+		pl022,ctrl-len = <0x11>;
+		pl022,wait-state = <0>;
+		pl022,duplex = <0>;
+	};
+};
+
+&i2c0 {
+	speed = <100000>;
+	clock-frequency = <54000000>;
+	status = "okay";
+	hdmi0: hdmi at 39 {
+		compatible = "rcm,hdmi";
+		reg = <0x39>;
+	};
+};
+
+&i2c2 {
+	status = "okay";
+	speed = <100000>;
+	clock-frequency = <54000000>;
+};
+
+&vdu {
+	status = "okay";
+};
+
+&sound {
+	status = "okay";
+	maudio,model = "RC Module MB77.07";
+};
+
+&usbehci {
+	status = "okay";
+};
+
+&video_decoder {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/rcm-k1879xb1.dtsi b/arch/arm/boot/dts/rcm-k1879xb1.dtsi
new file mode 100644
index 0000000..4437438
--- /dev/null
+++ b/arch/arm/boot/dts/rcm-k1879xb1.dtsi
@@ -0,0 +1,518 @@
+/*
+ * Copyright Promwad inc 2011
+ * Copyright RC Module 2010-2015
+ *
+ * Michail Kurachkin <stelhs@ya.ru>
+ * Andrew Andrianov  <andrew@ncrmnt.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "skeleton.dtsi"
+#include <dt-bindings/ion,physmem.h>
+
+/ {
+	model = "RC Module K1879XB1YA";
+	compatible = "rcm,k1879xb1ya";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,arm1176jzf-s", "arm,arm1176";
+			clock-frequency = <324000000>;
+			reg = <0>;
+			d-cache-line-size = <16>;
+			d-cache-size = <16384>;
+			i-cache-line-size = <16>;
+			i-cache-size = <16384>;
+		};
+	};
+
+	clocks {
+			clk_core: clk_core at 324M {
+				/* Core 324MHz clock. */
+				compatible = "fixed-factor-clock";
+				#clock-cells = <0>;
+				clocks = <&oscillator_27m>;
+				clock-div = <1>;
+				clock-mult = <12>;
+				clock-output-names = "clk_core";
+			};
+
+			clk_axi: clk_axi at 162M {
+				/* 162MHz clock */
+				compatible = "fixed-factor-clock";
+				#clock-cells = <0>;
+				clocks = <&oscillator_27m>;
+				clock-div = <1>;
+				clock-mult = <6>;
+				clock-output-names = "clk_axi";
+			};
+
+			clk_prf: clk_prf at 81M {
+				/* 81MHz clock */
+				compatible = "fixed-factor-clock";
+				#clock-cells = <0>;
+				clocks = <&oscillator_27m>;
+				clock-div = <1>;
+				clock-mult = <3>;
+				clock-output-names = "clk_prf";
+			};
+
+			pclk: pclk at 54M {
+				/* Reference 54MHz clock */
+				compatible = "fixed-factor-clock";
+				#clock-cells = <0>;
+				clocks = <&oscillator_27m>;
+				clock-div = <1>;
+				clock-mult = <2>;
+				clock-output-names = "apb_pclk";
+			};
+	};
+
+	axi {
+		compatible = "arm,amba-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x0 0xFFFFFFFF>;
+
+		usbehci: ehci at 0x10040000 {
+			compatible = "generic-ehci";
+			reg = <0x10040000 0x2000>;
+			interrupt-parent = <&vic1>;
+			interrupts = <3>; /* 35 */
+			status = "disabled";
+		};
+
+		usbohci: ohci at 0x10048000 {
+			compatible = "generic-ohci";
+			reg = <0x10048000 0x2000>;
+			interrupt-parent = <&vic1>;
+			interrupts = <3>; /* 35 */
+			status = "disabled";
+		};
+
+		dvb_ci0: dvb-ci at 10050000 {
+			compatible = "rcm,mdvbci";
+			reg = <0x10050000 0x10000>;
+			interrupts = <37>;
+		};
+
+		xdmac0: xdmac at 10070000 {
+			compatible = "rcm,xdmac";
+			reg = <0x10070000 0x10000>;
+			interrupts = <16 17 18 19 20 21 22 23>;
+		};
+
+		vic0: interrupt-controller at 20000000 {
+			reg = <0x20000000 0x10000>;
+			compatible = "arm,pl192-vic";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			valid-mask = <0xffffffff>;
+			valid-wakeup-mask = <0x00000000>;
+		};
+
+		vic1: interrupt-controller at 20010000 {
+			reg = <0x20010000 0x10000>;
+			compatible = "arm,pl192-vic";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			valid-mask = <0xffffffff>;
+			valid-wakeup-mask = <0x00000000>;
+		};
+
+		pinmux: sysconfigh at 0x20033084 {
+			compatible = "rcm,pinmux";
+			reg = <0x20033084 0x4>;
+			reg-names = "controlH";
+		};
+
+		crypto_aes: aes at 20040000 {
+			compatible = "rcm,mcrypto_aes";
+			reg = <0x20040000 0x80>;
+			interrupt-parent = <&vic1>;
+			interrupts = <7>;
+		};
+
+		apb_c {
+			compatible = "arm,amba-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x20020000 0x10000>;
+
+			i2c1: i2c at 1000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x1000 0x1000>;
+				compatible = "rcm,i2c-ocores";
+				interrupt-parent = <&vic0>;
+				interrupts = <28>;
+				clocks = <&pclk>;
+				clock-names = "apb_pclk";
+				reg-shift = <2>;
+				rcm-irq-fixup-id = <1>;
+				status = "disabled";
+			};
+
+			uart0: uart at b000 {
+				device-type = "serial";
+				reg = <0xb000 0x1000>;
+				compatible = "ns8250";
+				clocks = <&pclk>;
+				clock-names = "apb_pclk";
+				interrupt-parent = <&vic0>;
+				interrupts = <7>;
+				reg-shift = <2>;
+			};
+
+			uart2: uart at 2000 {
+				device-type = "serial";
+				reg = <0x2000 0x1000>;
+				compatible = "ns8250";
+				clocks = <&pclk>;
+				clock-names = "apb_pclk";
+				interrupt-parent = <&vic0>;
+				interrupts = <9>;
+				reg-shift = <2>;
+			};
+
+			ssp0: ssp at e000 {
+				compatible = "arm,pl022", "arm,primecell";
+				bus-id = <0>;
+				reg = <0xe000 0x1000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <0>; /* 32 */
+				interrupt-parent = <&vic1>;
+				clocks = <&pclk>;
+				clock-names = "apb_pclk";
+				num-cs = <2>;
+				status = "disabled";
+				arm,primecell-periphid = <0x41022>;
+			};
+
+			timer at 4000 {
+				compatible = "arm,sp804", "arm,primecell";
+				reg = <0x4000 0x1000>;
+				interrupts = <4 5>;
+				interrupt-parent = <&vic0>;
+				interrupt-names = "timer0", "timer1";
+				clocks = <&pclk>;
+				clock-names = "apb_pclk";
+			};
+
+			wd at 5000 {
+				reg = <0x5000 0x1000>;
+				compatible = "arm,sp805", "arm,primecell";
+				interrupts = <6>;
+				clocks = <&pclk>;
+				clock-names = "apb_pclk";
+				arm,primecell-periphid = <0x141805>;
+				};
+
+			i2c2: i2c at 6000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x6000 0x1000>;
+				compatible = "rcm,i2c-ocores";
+				interrupt-parent = <&vic0>;
+				interrupts = <29>;
+				clocks = <&pclk>;
+				clock-names = "apb_pclk";
+				reg-shift = <2>;
+				rcm-irq-fixup-id = <2>;
+				status = "disabled";
+			};
+
+			sci at 7000 {
+				reg = <0x7000 0x1000>;
+				compatible = "rcm,sci";
+				interrupts = <11>;
+			};
+
+			exirc at 8000 {
+				reg = <0x8000 0x1000>;
+				compatible = "rcm,exirc";
+				interrupts = <24>;
+			};
+
+			gpiofj: gpio at 9000 {
+				#gpio-cells = <2>;
+				reg = <0x9000 0x1000>;
+				reg-names = "regs";
+				gpio-controller;
+				compatible = "fujitsu,gpio";
+			};
+
+			gpio_a: gpio at a000 {
+				#gpio-cells = <2>;
+				compatible = "arm,pl061", "arm,primecell";
+				gpio-controller;
+				reg = <0xa000 0x1000>;
+				interrupt-parent = <&vic1>;
+				interrupts = <31>; /* 63 */
+				clocks = <&pclk>;
+				clock-names = "apb_pclk";
+			};
+
+			uart1: uart at c000 {
+				device-type = "serial";
+				reg = <0xc000 0x1000>;
+				compatible = "ns8250";
+				clocks = <&pclk>;
+				clock-names = "apb_pclk";
+				interrupt-parent = <&vic0>;
+				interrupts = <8>;
+				reg-shift = <2>;
+			};
+
+			i2c3: i2c at d000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0xd000 0x1000>;
+				compatible = "rcm,i2c-ocores";
+				interrupts = <30>;
+				interrupt-parent = <&vic0>;
+				clocks = <&pclk>;
+				clock-names = "apb_pclk";
+				reg-shift = <2>;
+				rcm-irq-fixup-id = <3>;
+				status = "disabled";
+			};
+
+			gpio_3: gpio at f000 {
+				#gpio-cells = <2>;
+				compatible = "arm,pl061", "arm,primecell";
+				gpio-controller;
+				reg = <0xf000 0x1000>;
+				interrupt-parent = <&vic1>;
+				interrupts = <25>; /* 57 */
+				clocks = <&pclk>;
+				clock-names = "apb_pclk";
+			};
+		};
+
+		apb_d {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x20030000 0x10000>;
+
+			ethernet: greth at 4000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "aeroflexgaisler,greth";
+				reg = <0x4000 0x1000>;
+				cell-index = <0>;
+				device_type = "network";
+				clocks = <&clk_axi>;
+				clock-names = "clk_axi";
+				interrupt-parent = <&vic1>;
+				interrupts = <2>; /* 34 */
+				status = "disabled";
+
+				mdio {
+					compatible = "greth-mdio";
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+			};
+
+			gpio_4: gpio at 5000 {
+				#gpio-cells = <2>;
+				compatible = "arm,pl061", "arm,primecell";
+				gpio-controller;
+				reg = <0x5000 0x1000>;
+				interrupt-parent = <&vic1>;
+				interrupts = <26>; /* 58 */
+				clocks = <&pclk>;
+				clock-names = "apb_pclk";
+			};
+
+			gpio_5: gpio at 6000 {
+				#gpio-cells = <2>;
+				compatible = "arm,pl061", "arm,primecell";
+				gpio-controller;
+				reg = <0x6000 0x1000>;
+				interrupt-parent = <&vic0>;
+				interrupts = <27>; /* 27 */
+				clocks = <&pclk>;
+				clock-names = "apb_pclk";
+			};
+
+			crypto_des: des at d000 {
+				compatible = "rcm,mcrypto_des";
+				reg = <0xd000 0x1000>;
+				interrupt-parent = <&vic1>;
+				interrupts = <8>;
+			};
+
+			nand0: nand at f000 {
+				reg = <0xf000 0x1000>;
+				compatible = "rcm,mnand";
+				interrupt-parent = <&vic1>;
+				interrupts = <4>;
+				clocks = <&clk_prf>;
+				clock-names = "clk_prf";
+			};
+		};
+
+		au at 0 {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x80150000 0x10000>;
+
+			i2s: i2s at 0 {
+				compatible = "rcm,i2s";
+				reg = <0 0x40>;
+				interrupts = <18>; /* 50 */
+				interrupt-parent = <&vic1>;
+			};
+		};
+
+		au at 1 {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x80160000 0x10000>;
+
+			spdif: spdif at 0 {
+				compatible = "rcm,spdif";
+				reg = <0x0 0x40>;
+				interrupts = <19>; /* 51 */
+				interrupt-parent = <&vic1>;
+			};
+		};
+
+		apb_mult {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x80170000 0x10000>;
+
+			i2c0: i2c at 1000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x1000 0x1000>;
+				compatible = "rcm,i2c-ocores";
+				interrupts = <1>;
+				interrupt-parent = <&vic1>;
+				clocks = <&clk_prf>;
+				clock-names = "clk_prf";
+				reg-shift = <2>;
+				rcm-irq-fixup-id = <0>;
+				status = "disabled";
+			};
+
+			dmac: dmac at 0x2800 {
+				/* Missing driver */
+				compatible = "rcm,dmac";
+				reg = <0x2800 0x200>;
+				interrupts = <21>;
+				interrupt-parent = <&vic1>;
+			};
+
+			vdu: vdu at 0x3000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "rcm,vdu";
+				reg = <0x3000 0x1000>;
+				interrupts = <10>;
+				interrupt-parent = <&vic1>;
+				supported_modes = <0x1FFE>;
+				default_mode = <0x4>;
+				output_flags = <0x200>;
+				axi_osd_param = <0x0f310000>;
+				axi_mvl_param = <0x0f310000>;
+				vbuffer-heap = &ion_em1;
+				status = "disabled";
+			};
+		};
+
+		sound: audio at 0x80175000 {
+			compatible = "rcm,audio";
+			reg = <0x80175000 0x40>; /* control */
+			interrupts = <21>;
+			interrupt-parent = <&vic1>;
+			maudio,dmac = <&dmac>;
+			maudio,i2s = <&i2s>;
+			maudio,spdif = <&spdif>;
+			status = "disabled";
+		};
+
+		ion_im0: ion at 0x00100000 {
+		     compatible = "ion,physmem";
+		     reg = <0x00100000 0x40000>;
+		     reg-names = "memory";
+		     ion-heap-id   = <2>;
+		     ion-heap-type = <ION_HEAP_TYPE_DMA>;
+		     ion-heap-align = <0x10>;
+		     ion-heap-name = "IM0";
+		};
+
+		ion_im2: ion at 80100000 {
+		     compatible = "ion,physmem";
+		     reg = <0x80100000 0x40000>;
+		     reg-names = "memory";
+		     ion-heap-id   = <1>;
+		     ion-heap-type = <ION_HEAP_TYPE_DMA>;
+		     ion-heap-align = <0x10>;
+		     ion-heap-name = "IM2";
+		};
+
+		ion_em1: ion at c0000000 {
+		     compatible = "ion,physmem";
+		     reg = <0xc0000000 0x8000000>;
+		     reg-names = "memory";
+		     ion-heap-id   = <0>;
+		     ion-heap-type = <ION_HEAP_TYPE_DMA>;
+		     ion-heap-align = <0x10>;
+		     ion-heap-name = "EM1";
+		};
+
+		video_decoder: video_decoder at 80180000 {
+			compatible = "rcm,msvdhd";
+			reg = <0x80180000 0x20000>;
+			reg-names = "regs";
+			interrupts = <12>; /* 44 */
+			vbuffer-heap = &ion_em1;
+			ibuffer-heap = &ion_im2;
+			interrupt-parent = <&vic1>;
+			status = "disabled";
+		};
+
+		nmcore0 {
+			compatible = "rcm,easynmc";
+			core-name = "K1879-nmc";
+			core-type = "nmc3";
+			device-id = <0>;
+			reg =
+				<0x00140000 0x00080000>, /* IM1 + IM3 */
+				<0x2003c010 0x4>,
+				<0x2003c004 0x4>,
+				<0x2003c034 0x4>,
+				<0x2003c030 0x4>,
+				<0x2003c038 0x4>,
+				<0x2003c03c 0x4>;
+			bank-count = <2>;
+			reg-names =
+				"imem",
+				"reset_reg",
+				"nmi_reg",
+				"hp_clr_reg",
+				"lp_clr_reg",
+				"hp_set_reg",
+				"lp_set_reg";
+			interrupt-parent = <&vic0>;
+			interrupts = <14>, <15>;
+			interrupt-names = "HP", "LP";
+			status = "okay";
+		};
+	};
+};
-- 
2.1.4
