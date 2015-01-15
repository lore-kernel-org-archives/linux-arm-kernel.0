From: gregory.hermant@calao-systems.com (Gregory Hermant)
Date: Thu, 15 Jan 2015 15:09:35 +0100
Subject: =?UTF-8?q?=5BPATCH=5D=20add=20dt=20support=20for=20the=20haba-knx-lite=20controller?=
Message-ID: <1421330975-19824-1-git-send-email-gregory.hermant@calao-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Gregory Hermant <gregory.hermant@calao-systems.com>
---
 arch/arm/boot/dts/Makefile          |    1 +
 arch/arm/boot/dts/haba_knx_lite.dts |  206 +++++++++++++++++++++++++++++++++++
 2 files changed, 207 insertions(+)
 create mode 100644 arch/arm/boot/dts/haba_knx_lite.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 38c89ca..80fe6cd 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -23,6 +23,7 @@ dtb-$(CONFIG_ARCH_AT91) += at91-foxg20.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91sam9g20ek.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91sam9g20ek_2mmc.dtb
 dtb-$(CONFIG_ARCH_AT91) += kizbox.dtb
+dtb-$(CONFIG_ARCH_AT91) += haba_knx_lite.dtb
 dtb-$(CONFIG_ARCH_AT91) += tny_a9g20.dtb
 dtb-$(CONFIG_ARCH_AT91) += usb_a9g20.dtb
 dtb-$(CONFIG_ARCH_AT91) += usb_a9g20_lpw.dtb
diff --git a/arch/arm/boot/dts/haba_knx_lite.dts b/arch/arm/boot/dts/haba_knx_lite.dts
new file mode 100644
index 0000000..7769a71
--- /dev/null
+++ b/arch/arm/boot/dts/haba_knx_lite.dts
@@ -0,0 +1,206 @@
+/*
+ * haba_knx_lite.dts - Device Tree file for Calao HABA-KNX-LITE board
+ *
+ *  Copyright (C) 2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *  Copyright (C) 2014 Gr?gory Hermant <gregory.hermant@calao-systems.com>
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+/dts-v1/;
+#include "at91sam9g20.dtsi"
+
+/ {
+	model = "Calao HABA KNX LITE";
+	compatible = "calao,haba-knx-lite", "atmel,at91sam9g20", "atmel,at91sam9";
+
+	chosen {
+		bootargs = "mem=128M console=ttyS0,115200 root=/dev/mtdblock6 rw rootfstype=ubifs";
+	};
+
+	memory {
+		reg = <0x20000000 0x8000000>;
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		main_clock: clock at 0 {
+			compatible = "atmel,osc", "fixed-clock";
+			clock-frequency = <12000000>;
+		};
+
+		slow_xtal {
+			clock-frequency = <32768>;
+		};
+
+		main_xtal {
+			clock-frequency = <12000000>;
+		};
+	};
+
+	ahb {
+		apb {
+			usart0: serial at fffb0000 {
+				pinctrl-0 =
+					<&pinctrl_usart0
+					 &pinctrl_usart0_rts
+					 &pinctrl_usart0_cts
+					 &pinctrl_usart0_dtr_dsr
+					 &pinctrl_usart0_dcd
+					 &pinctrl_usart0_ri>;
+				status = "okay";
+			};
+
+			usart1: serial at fffb4000 {
+				pinctrl-0 =
+					<&pinctrl_usart1
+					 &pinctrl_usart1_rts
+					 &pinctrl_usart1_cts>;
+				status = "okay";
+			};
+
+			uart0: serial at fffd4000 {
+				pinctrl-0 = <&pinctrl_uart0>;
+				status = "okay";
+			};
+
+			dbgu: serial at fffff200 {
+				status = "okay";
+			};
+
+			macb0: ethernet at fffc4000 {
+				phy-mode = "rmii";
+				status = "okay";
+			};
+
+			usb1: gadget at fffa4000 {
+				atmel,vbus-gpio = <&pioB 2 GPIO_ACTIVE_HIGH>;
+				status = "okay";
+			};
+
+			spi0: spi at fffc8000 {
+				status = "okay";
+				cs-gpios = <&pioA 3 0>, <&pioA 4 0>, <&pioA 27 1>;
+
+				flash: m25p80 at 0 {
+					#address-cells = <1>;
+					#size-cells = <1>;
+					compatible = "sst,sst25vf016b";
+					reg = <0>;
+					spi-max-frequency = <40000000>;
+					m25p,fast-read;
+				};
+
+				mmc-slot at 2 {
+					compatible = "mmc-spi-slot";
+					reg = <2>;
+					voltage-ranges = <3200 3400>;
+					spi-max-frequency = <25000000>;
+					interrupt-parent = <&pioB>;
+					interrupts = <0 IRQ_TYPE_EDGE_BOTH>;
+				};
+			};
+
+			shdwc at fffffd10 {
+				atmel,wakeup-mode = "low";
+				atmel,wakeup-counter = <10>;
+				atmel,wakeup-rtt-timer;
+			};
+
+	};
+
+		nand0: nand at 40000000 {
+			nand-bus-width = <8>;
+			nand-ecc-mode = "soft";
+			nand-on-flash-bbt;
+			status = "okay";
+
+			at91bootstrap at 0 {
+				label = "at91bootstrap";
+				reg = <0x0 0x20000>;
+			};
+
+			barebox at 20000 {
+				label = "barebox";
+				reg = <0x20000 0x40000>;
+			};
+
+			bareboxenv at 60000 {
+				label = "bareboxenv";
+				reg = <0x60000 0x20000>;
+			};
+
+			bareboxenv2 at 80000 {
+				label = "bareboxenv2";
+				reg = <0x80000 0x20000>;
+			};
+
+			oftree at 80000 {
+				label = "oftree";
+				reg = <0xa0000 0x20000>;
+			};
+
+			kernel at a0000 {
+				label = "kernel";
+				reg = <0xc0000 0x400000>;
+			};
+
+			rootfs at 4a0000 {
+				label = "rootfs";
+				reg = <0x4c0000 0x7800000>;
+			};
+
+			data at 7ca0000 {
+				label = "data";
+				reg = <0x7cc0000 0x8340000>;
+			};
+		};
+
+		usb0: ohci at 00500000 {
+			num-ports = <2>;
+			status = "okay";
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		user_led {
+			label = "user_led";
+			gpios = <&pioA 28 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		user_pb {
+			label = "user_pb";
+			gpios = <&pioC 3 GPIO_ACTIVE_LOW>;
+			linux,code = <28>;
+			gpio-key,wakeup;
+		};
+	};
+
+	i2c at 0 {
+		status = "okay";
+
+		eeprom at 50 {
+			compatible = "microchip,24c02";
+			reg = <0x50>;
+		};
+
+		rv3029c2 at 56 {
+			compatible = "rv3029c2";
+			reg = <0x56>;
+		};
+	};
+
+};
+
-- 
1.7.9.5
