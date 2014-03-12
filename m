From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 12 Mar 2014 10:43:40 +0100
Subject: [PATCHv5 4/9] ARM: at91: dt: sam9rl: Device Tree for the at91sam9rlek
In-Reply-To: <1394617425-641-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1394617425-641-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1394617425-641-5-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device tree for the at91sam9rl-ek. For now it supports:
 - MMC
 - dbgu
 - usart1
 - watchdog
 - nand
 - leds
 - buttons

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/Makefile         |   2 +
 arch/arm/boot/dts/at91sam9rlek.dts | 151 +++++++++++++++++++++++++++++++++++++
 2 files changed, 153 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91sam9rlek.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 6d1e43d46187..ce58477cfa33 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -29,6 +29,8 @@ dtb-$(CONFIG_ARCH_AT91) += at91sam9m10g45ek.dtb
 dtb-$(CONFIG_ARCH_AT91) += pm9g45.dtb
 # sam9n12
 dtb-$(CONFIG_ARCH_AT91) += at91sam9n12ek.dtb
+# sam9rl
+dtb-$(CONFIG_ARCH_AT91) += at91sam9rlek.dtb
 # sam9x5
 dtb-$(CONFIG_ARCH_AT91) += at91-ariag25.dtb
 dtb-$(CONFIG_ARCH_AT91) += at91-cosino_mega2560.dtb
diff --git a/arch/arm/boot/dts/at91sam9rlek.dts b/arch/arm/boot/dts/at91sam9rlek.dts
new file mode 100644
index 000000000000..c3cec5d07648
--- /dev/null
+++ b/arch/arm/boot/dts/at91sam9rlek.dts
@@ -0,0 +1,151 @@
+/*
+ * at91sam9rlek.dts - Device Tree file for Atmel at91sam9rl reference board
+ *
+ *  Copyright (C) 2014  Alexandre Belloni <alexandre.belloni@free-electrons.com>
+ *
+ * Licensed under GPLv2 only
+ */
+/dts-v1/;
+#include "at91sam9rl.dtsi"
+
+/ {
+	model = "Atmel at91sam9rlek";
+	compatible = "atmel,at91sam9rlek", "atmel,at91sam9rl", "atmel,at91sam9";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 rootfstype=ubifs root=ubi0:rootfs ubi.mtd=5 rw";
+	};
+
+	memory {
+		reg = <0x20000000 0x4000000>;
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		main_clock: clock {
+			compatible = "atmel,osc", "fixed-clock";
+			clock-frequency = <12000000>;
+		};
+	};
+
+	ahb {
+		nand0: nand at 40000000 {
+			nand-bus-width = <8>;
+			nand-ecc-mode = "soft";
+			nand-on-flash-bbt = <1>;
+			status = "okay";
+
+			at91bootstrap at 0 {
+				label = "at91bootstrap";
+				reg = <0x0 0x40000>;
+			};
+
+			bootloader at 40000 {
+				label = "bootloader";
+				reg = <0x40000 0x80000>;
+			};
+
+			bootloaderenv at c0000 {
+				label = "bootloader env";
+				reg = <0xc0000 0xc0000>;
+			};
+
+			dtb at 180000 {
+				label = "device tree";
+				reg = <0x180000 0x80000>;
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
+
+		apb {
+			mmc0: mmc at fffa4000 {
+				pinctrl-0 = <
+					&pinctrl_board_mmc0
+					&pinctrl_mmc0_clk
+					&pinctrl_mmc0_slot0_cmd_dat0
+					&pinctrl_mmc0_slot0_dat1_3>;
+				status = "okay";
+				slot at 0 {
+					reg = <0>;
+					bus-width = <4>;
+					cd-gpios = <&pioA 15 GPIO_ACTIVE_HIGH>;
+				};
+			};
+
+			usart0: serial at fffb0000 {
+				pinctrl-0 = <
+					&pinctrl_usart0
+					&pinctrl_usart0_rts
+					&pinctrl_usart0_cts>;
+				status = "okay";
+			};
+
+			dbgu: serial at fffff200 {
+				status = "okay";
+			};
+
+			pinctrl at fffff400 {
+				mmc0 {
+					pinctrl_board_mmc0: mmc0-board {
+						atmel,pins =
+							<AT91_PIOA 15 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
+					};
+				};
+			};
+
+			watchdog at fffffd40 {
+				status = "okay";
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		ds1 {
+			label = "ds1";
+			gpios = <&pioD 15 GPIO_ACTIVE_LOW>;
+		};
+
+		ds2 {
+			label = "ds2";
+			gpios = <&pioD 16 GPIO_ACTIVE_LOW>;
+		};
+
+		ds3 {
+			label = "ds3";
+			gpios = <&pioD 14 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+
+		right_click {
+			label = "right_click";
+			gpios = <&pioB 0 GPIO_ACTIVE_LOW>;
+			linux,code = <273>;
+			gpio-key,wakeup;
+		};
+
+		left_click {
+			label = "left_click";
+			gpios = <&pioB 1 GPIO_ACTIVE_LOW>;
+			linux,code = <272>;
+			gpio-key,wakeup;
+		};
+	};
+};
-- 
1.8.3.2
