From: giometti@linux.it (Rodolfo Giometti)
Date: Wed,  6 Nov 2013 17:19:27 +0100
Subject: [PATCH 1/1] arm mach-at91: add support for Cosino board series by HCE
 Engineering
Message-ID: <1383754767-5398-1-git-send-email-giometti@linux.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This board has been registered at #4607 on http://www.arm.linux.org.uk:

    http://www.arm.linux.org.uk/developer/machines/list.php?id=4607

Signed-off-by: Rodolfo Giometti <giometti@linux.it>
---
 arch/arm/boot/dts/Makefile            |   1 +
 arch/arm/boot/dts/cosino.dtsi         | 131 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/cosino_mega2560.dts | 101 ++++++++++++++++++++++++++
 3 files changed, 233 insertions(+)
 create mode 100644 arch/arm/boot/dts/cosino.dtsi
 create mode 100644 arch/arm/boot/dts/cosino_mega2560.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ab6a9f5..15ae041 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -35,6 +35,7 @@ dtb-$(CONFIG_ARCH_AT91) += at91sam9g25ek.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91sam9g35ek.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91sam9x25ek.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91sam9x35ek.dtb
+dtb-$(CONFIG_ARCH_AT91) += cosino_mega2560.dtb
 # sama5d3
 dtb-$(CONFIG_ARCH_AT91)	+= sama5d31ek.dtb
 dtb-$(CONFIG_ARCH_AT91)	+= sama5d33ek.dtb
diff --git a/arch/arm/boot/dts/cosino.dtsi b/arch/arm/boot/dts/cosino.dtsi
new file mode 100644
index 0000000..2ae4578
--- /dev/null
+++ b/arch/arm/boot/dts/cosino.dtsi
@@ -0,0 +1,131 @@
+/*
+ * cosino.dtsi - Device Tree file for Cosino core module
+ *
+ * Copyright (C) 2013 - Rodolfo Giometti <giometti@linux.it>
+ *			HCE Engineering
+ *
+ * Derived from at91sam9x5ek.dtsi by:
+ *	Copyright (C) 2012 Atmel,
+ *	2012 Nicolas Ferre <nicolas.ferre@atmel.com>
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include "at91sam9x5.dtsi"
+
+/ {
+	model = "HCE Cosino core module";
+	compatible = "hce,cosino", "atmel,at91sam9x5ek",
+			"atmel,at91sam9x5", "atmel,at91sam9";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait";
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
+	};
+
+	ahb {
+		apb {
+			mmc0: mmc at f0008000 {
+				pinctrl-0 = <
+					&pinctrl_board_mmc0
+					&pinctrl_mmc0_slot0_clk_cmd_dat0
+					&pinctrl_mmc0_slot0_dat1_3>;
+				status = "okay";
+				slot at 0 {
+					reg = <0>;
+					bus-width = <4>;
+					cd-gpios = <&pioD 15 GPIO_ACTIVE_HIGH>;
+				};
+			};
+
+			dbgu: serial at fffff200 {
+				status = "okay";
+			};
+
+			usart0: serial at f801c000 {
+				status = "okay";
+			};
+
+			i2c0: i2c at f8010000 {
+				status = "okay";
+			};
+
+			adc0: adc at f804c000 {
+				atmel,adc-clock-rate = <1000000>;
+				atmel,adc-ts-wires = <4>;
+				atmel,adc-ts-pressure-threshold = <10000>;
+				status = "okay";
+			};
+
+			pinctrl at fffff400 {
+				atmel,mux-mask = <
+					/*   A	        B	   C    */
+					0xffffffff 0xffe0399f 0xc000000c  /* pioA */
+					0x000406ff 0x00047e3f 0x00000000  /* pioB */
+					0xfdffffff 0x00000000 0xb83fffff  /* pioC */
+					0x003fffff 0x003f8000 0x00000000  /* pioD */
+				>;
+
+				mmc0 {
+					pinctrl_board_mmc0: mmc0-board {
+						atmel,pins =
+							<AT91_PIOD 15 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;	/* PD15 gpio CD pin pull up and deglitch */
+					};
+				};
+			};
+
+			watchdog at fffffe40 {
+				status = "okay";
+			};
+		};
+
+		nand0: nand at 40000000 {
+			nand-bus-width = <8>;
+			nand-ecc-mode = "hw";
+			atmel,has-pmecc;	/* Enable PMECC */
+			atmel,pmecc-cap = <4>;
+			atmel,pmecc-sector-size = <512>;
+			nand-on-flash-bbt;
+			status = "okay";
+
+			at91bootstrap at 0 {
+				label = "at91bootstrap";
+				reg = <0x0 0x40000>;
+			};
+
+			uboot at 40000 {
+				label = "u-boot";
+				reg = <0x40000 0x80000>;
+			};
+
+			ubootenv at c0000 {
+				label = "U-Boot Env";
+				reg = <0xc0000 0x140000>;
+			};
+
+			kernel at 200000 {
+				label = "kernel";
+				reg = <0x200000 0x600000>;
+			};
+
+			rootfs at 800000 {
+				label = "rootfs";
+				reg = <0x800000 0x0f800000>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/cosino_mega2560.dts b/arch/arm/boot/dts/cosino_mega2560.dts
new file mode 100644
index 0000000..677ac6e
--- /dev/null
+++ b/arch/arm/boot/dts/cosino_mega2560.dts
@@ -0,0 +1,101 @@
+/*
+ * cosino_mega2560.dts - Device Tree file for Cosino board with Mega 2560
+ *			 extension
+ *
+ * Copyright (C) 2013 - Rodolfo Giometti <giometti@linux.it>
+ *			HCE Engineering
+ *
+ * Derived from at91sam9g35ek.dts by:
+ * 	Copyright (C) 2012 Atmel,
+ *      2012 Nicolas Ferre <nicolas.ferre@atmel.com>
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+/dts-v1/;
+#include "cosino.dtsi"
+
+/ {
+	model = "HCE Cosino Mega 2560";
+	compatible = "hce,cosino_mega2560", "atmel,at91sam9x5ek",
+			"atmel,at91sam9x5", "atmel,at91sam9";
+
+	ahb {
+		apb {
+			macb0: ethernet at f802c000 {
+				phy-mode = "rmii";
+				status = "okay";
+			};
+
+			adc0: adc at f804c000 {
+				atmel,adc-clock-rate = <1000000>;
+				atmel,adc-ts-wires = <4>;
+				atmel,adc-ts-pressure-threshold = <10000>;
+				status = "okay";
+			};
+
+
+			tsadcc: tsadcc at f804c000 {
+				status = "okay";
+			};
+
+			lcd_bus at f8038000 {
+				status = "okay";
+				lcd at f8038000 {
+					status = "okay";
+				};
+
+				lcdovl1 at f8038100 {
+					status = "okay";
+				};
+
+				lcdheo1 at f8038280 {
+					status = "okay";
+				};
+			};
+
+			rtc at fffffeb0 {
+				status = "okay";
+			};
+
+			usart1: serial at f8020000 {
+			       status = "okay";
+			};
+
+			usart2: serial at f8024000 {
+			       status = "okay";
+			};
+
+			usb2: gadget at f803c000 {
+				atmel,vbus-gpio = <&pioB 16 GPIO_ACTIVE_HIGH>;
+				status = "okay";
+			};
+
+			mmc1: mmc at f000c000 {
+				pinctrl-0 = <
+					&pinctrl_board_mmc0
+					&pinctrl_mmc1_slot0_clk_cmd_dat0
+					&pinctrl_mmc1_slot0_dat1_3>;
+				status = "okay";
+				slot at 0 {
+					reg = <0>;
+					bus-width = <4>;
+					non-removable;
+				};
+			};
+		};
+
+		usb0: ohci at 00600000 {
+			status = "okay";
+			num-ports = <3>;
+			atmel,vbus-gpio = <0 /* &pioD 18 GPIO_ACTIVE_LOW *//* Activate to have access to port A */
+					   &pioD 19 GPIO_ACTIVE_LOW
+					   &pioD 20 GPIO_ACTIVE_LOW
+					  >;
+		};
+
+		usb1: ehci at 00700000 {
+			status = "okay";
+		};
+	};
+};
-- 
1.8.1.2
