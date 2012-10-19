From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 19 Oct 2012 04:19:28 +0200
Subject: [PATCH 1/1] arm: at91: add Ronetix pm9g45 board support
Message-ID: <1350613168-22689-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPU Module with ATMEL AT91SAM9G45
http://www.ronetix.at/pm9g45.html

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/Makefile   |    1 +
 arch/arm/boot/dts/pm9g45.dts |  144 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+)
 create mode 100644 arch/arm/boot/dts/pm9g45.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a9b051a..627b6ad 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -19,6 +19,7 @@ dtb-$(CONFIG_ARCH_AT91) += tny_a9g20.dtb
 dtb-$(CONFIG_ARCH_AT91) += usb_a9g20.dtb
 # sam9g45
 dtb-$(CONFIG_ARCH_AT91) += at91sam9m10g45ek.dtb
+dtb-$(CONFIG_ARCH_AT91) += pm9g45.dtb
 # sam9n12
 dtb-$(CONFIG_ARCH_AT91) += at91sam9n12ek.dtb
 # sam9x5
diff --git a/arch/arm/boot/dts/pm9g45.dts b/arch/arm/boot/dts/pm9g45.dts
new file mode 100644
index 0000000..b0c258d
--- /dev/null
+++ b/arch/arm/boot/dts/pm9g45.dts
@@ -0,0 +1,144 @@
+/*
+ * pm9g45.dts - Device Tree file for Ronetix pm9g45 board
+ *
+ *  Copyright (C) 2012 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Licensed under GPLv2.
+ */
+/dts-v1/;
+/include/ "at91sam9g45.dtsi"
+
+/ {
+	model = "Ronetix pm9g45";
+	compatible = "ronetix,pm9g45", "atmel,at91sam9g45", "atmel,at91sam9";
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+	};
+
+	memory {
+		reg = <0x70000000 0x8000000>;
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
+			dbgu: serial at ffffee00 {
+				status = "okay";
+			};
+
+			pinctrl at fffff200 {
+
+				board {
+					pinctrl_board_nand: nand0-board {
+						atmel,pins =
+							<3 3 0x0 0x1	/* PD3 gpio RDY pin pull_up*/
+							 2 14 0x0 0x1>;	/* PC14 gpio enable pin pull_up */
+					};
+				};
+			};
+
+			macb0: ethernet at fffbc000 {
+				phy-mode = "rmii";
+				status = "okay";
+			};
+		};
+
+		nand0: nand at 40000000 {
+			nand-bus-width = <8>;
+			nand-ecc-mode = "soft";
+			nand-on-flash-bbt;
+			pinctrl-0 = <&pinctrl_board_nand>;
+
+			gpios = <&pioD 3 0
+				 &pioC 14 0
+				 0
+				>;
+
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
+				reg = <0x60000 0x1A0000>;
+			};
+
+			kernel at 200000 {
+				label = "bareboxenv2";
+				reg = <0x200000 0x300000>;
+			};
+
+			kernel at 500000 {
+				label = "root";
+				reg = <0x500000 0x400000>;
+			};
+
+			data at 900000 {
+				label = "data";
+				reg = <0x900000 0x8340000>;
+			};
+		};
+
+		usb0: ohci at 00700000 {
+			status = "okay";
+			num-ports = <2>;
+		};
+
+		usb1: ehci at 00800000 {
+			status = "okay";
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led0 {
+			label = "led0";
+			gpios = <&pioD 0 1>;
+			linux,default-trigger = "nand-disk";
+		};
+
+		led1 {
+			label = "led1";
+			gpios = <&pioD 31 0>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		right {
+			label = "SW4";
+			gpios = <&pioE 7 1>;
+			linux,code = <106>;
+		};
+
+		up {
+			label = "SW3";
+			gpios = <&pioE 8 1>;
+			linux,code = <103>;
+		};
+	};
+};
-- 
1.7.10.4
