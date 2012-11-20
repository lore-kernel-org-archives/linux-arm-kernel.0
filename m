From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 20 Nov 2012 22:34:38 +0100
Subject: [PATCH 1/1] ARM: at91: add Somfy Animeo IP board support
Message-ID: <1353447278-32107-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Sylvain FARGIER <sylvain.fargier@somfy.com>
---
 arch/arm/boot/dts/Makefile      |    1 +
 arch/arm/boot/dts/animeo_ip.dts |  166 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 167 insertions(+)
 create mode 100644 arch/arm/boot/dts/animeo_ip.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4a4337b..52c6b46 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -4,6 +4,7 @@ ifeq ($(CONFIG_OF),y)
 # rm9200
 dtb-$(CONFIG_ARCH_AT91) += at91rm9200ek.dtb
 # sam9260
+dtb-$(CONFIG_ARCH_AT91) += animeo_ip.dtb
 dtb-$(CONFIG_ARCH_AT91) += aks-cdu.dtb
 dtb-$(CONFIG_ARCH_AT91) += ethernut5.dtb
 dtb-$(CONFIG_ARCH_AT91) += evk-pro3.dtb
diff --git a/arch/arm/boot/dts/animeo_ip.dts b/arch/arm/boot/dts/animeo_ip.dts
new file mode 100644
index 0000000..518baed
--- /dev/null
+++ b/arch/arm/boot/dts/animeo_ip.dts
@@ -0,0 +1,166 @@
+/*
+ * animeo_ip.dts - Device Tree file for Somfy Animeo IP Boards
+ *
+ *  Copyright (C) 2011-2012 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Licensed under GPLv2 only.
+ */
+
+/dts-v1/;
+/include/ "at91sam9260.dtsi"
+
+/ {
+	model = "Somfy Animeo IP";
+	compatible = "somfy,animeo-ip", "atmel,at91sam9260", "atmel,at91sam9";
+
+	aliases {
+		serial0 = &usart1;
+		serial1 = &usart2;
+		serial2 = &usart0;
+		serial3 = &dbgu;
+		serial4 = &usart3;
+		serial5 = &uart0;
+		serial6 = &uart1;
+	};
+
+	chosen {
+		linux,stdout-path = &usart2;
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
+		main_clock: clock at 0 {
+			compatible = "atmel,osc", "fixed-clock";
+			clock-frequency = <18432000>;
+		};
+	};
+
+	ahb {
+		apb {
+			usart0: serial at fffb0000 {
+				pinctrl-0 = <&pinctrl_usart0 &pinctrl_usart0_rts>;
+				linux,rs485-enabled-at-boot-time;
+				status = "okay";
+			};
+
+			usart1: serial at fffb4000 {
+				pinctrl-0 = <&pinctrl_usart1 &pinctrl_usart1_rts>;
+				linux,rs485-enabled-at-boot-time;
+				status = "okay";
+			};
+
+			usart2: serial at fffb8000 {
+				pinctrl-0 = <&pinctrl_usart2>;
+				status = "okay";
+			};
+
+			macb0: ethernet at fffc4000 {
+				pinctrl-0 = <&pinctrl_macb_rmii &pinctrl_macb_rmii_mii>;
+				phy-mode = "mii";
+				status = "okay";
+			};
+		};
+
+		nand0: nand at 40000000 {
+			nand-bus-width = <8>;
+			nand-ecc-mode = "soft";
+			nand-on-flash-bbt;
+			status = "okay";
+
+			at91bootstrap at 0 {
+				label = "at91bootstrap";
+				reg = <0x0 0x8000>;
+			};
+
+			barebox at 8000 {
+				label = "barebox";
+				reg = <0x8000 0x40000>;
+			};
+
+			bareboxenv at 48000 {
+				label = "bareboxenv";
+				reg = <0x48000 0x8000>;
+			};
+
+			user_block at 0x50000 {
+				label = "user_block";
+				reg = <0x50000 0xb0000>;
+			};
+
+			kernel at 100000 {
+				label = "kernel";
+				reg = <0x100000 0x1b0000>;
+			};
+
+			root at 2b0000 {
+				label = "root";
+				reg = <0x2b0000 0x1D50000>;
+			};
+		};
+
+		usb0: ohci at 00500000 {
+			num-ports = <2>;
+			atmel,vbus-gpio = <&pioB 15 1>;
+			status = "okay";
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		power_green {
+			label = "power_green";
+			gpios = <&pioC 17 0>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		power_red {
+			label = "power_red";
+			gpios = <&pioA 2 0>;
+		};
+
+		tx_green {
+			label = "tx_green";
+			gpios = <&pioC 19 0>;
+		};
+
+		tx_red {
+			label = "tx_red";
+			gpios = <&pioC 18 0>;
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		keyswitch_in {
+			label = "keyswitch_in";
+			gpios = <&pioB 1 0>;
+			linux,code = <28>;
+			gpio-key,wakeup;
+		};
+
+		error_in {
+			label = "error_in";
+			gpios = <&pioB 2 0>;
+			linux,code = <29>;
+			gpio-key,wakeup;
+		};
+
+		btn {
+			label = "btn";
+			gpios = <&pioC 23 0>;
+			linux,code = <31>;
+			gpio-key,wakeup;
+		};
+	};
+};
-- 
1.7.10.4
