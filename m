From: raashidmuhammed@zilogic.com (Raashid Muhammed)
Date: Wed, 18 May 2016 18:02:46 +0530
Subject: [PATCH] ARM: at91: Add DT support for Olimex SAM9-L9260 board.
Message-ID: <1463574766-15568-1-git-send-email-raashidmuhammed@zilogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Raashid Muhammed <raashidmuhammed@zilogic.com>

sam9-l9260 is a low cost board designed by Olimex.

More infomation is available at:
https://www.olimex.com/Products/ARM/Atmel/SAM9-L9260/

Signed-off-by: Raashid Muhammed <raashidmuhammed@zilogic.com>
Reviewed-by: Vijay Kumar B. <vijaykumar@bravegnu.org>
---
 .../devicetree/bindings/arm/olimex-at91.txt        |   6 ++
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/sam9-l9260.dts                   | 108 +++++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/olimex-at91.txt
 create mode 100644 arch/arm/boot/dts/sam9-l9260.dts

diff --git a/Documentation/devicetree/bindings/arm/olimex-at91.txt b/Documentation/devicetree/bindings/arm/olimex-at91.txt
new file mode 100644
index 0000000..0587d63
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/olimex-at91.txt
@@ -0,0 +1,6 @@
+Olimex AT91 Device Tree Bindings
+--------------------------------
+
+SAM9-L9260 Board
+Required root node properties:
+    - compatible = "olimex,sam9-l9260", "atmel,at91sam9260";
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 95c1923..ae3b50f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -19,6 +19,7 @@ dtb-$(CONFIG_SOC_SAM_V4_V5) += \
	usb_a9260.dtb \
	at91sam9261ek.dtb \
	at91sam9263ek.dtb \
+	sam9-l9260.dtb \
	tny_a9263.dtb \
	usb_a9263.dtb \
	at91-foxg20.dtb \
diff --git a/arch/arm/boot/dts/sam9-l9260.dts b/arch/arm/boot/dts/sam9-l9260.dts
new file mode 100644
index 0000000..3ddf7af
--- /dev/null
+++ b/arch/arm/boot/dts/sam9-l9260.dts
@@ -0,0 +1,108 @@
+/*
+ * sam9-l9260.dts - Device Tree file for Olimex SAM9-L9260 board
+ *
+ *  Copyright (C) 2016 Raashid Muhammed <raashidmuhammed@zilogic.com>
+ *
+ * Licensed under GPLv2 or later.
+ */
+/dts-v1/;
+#include "at91sam9260.dtsi"
+
+/ {
+	model = "Olimex sam9-l9260";
+	compatible = "olimex,sam9-l9260", "atmel,at91sam9260", "atmel,at91sam9";
+
+	chosen {
+		bootargs = "mem=64M console=ttyS0,115200 root=/dev/mtdblock5 rw rootfstype=ubifs";
+	 };
+
+	 memory {
+		reg = <0x20000000 0x4000000>;
+	 };
+
+	 clocks {
+		slow_xtal {
+			clock-frequency = <32768>;
+		};
+
+		main_xtal {
+			clock-frequency = <18432000>;
+		};
+	 };
+
+	 ahb {
+		apb {
+			dbgu: serial at fffff200 {
+				status = "okay";
+			 };
+
+			macb0: ethernet at fffc4000 {
+				phy-mode = "mii";
+				status = "okay";
+			 };
+
+			spi0: spi at fffc8000 {
+				status = "okay";
+				cs-gpios = <&pioC 11 0>, <0>, <0>, <0>;
+				mtd_dataflash at 0 {
+					compatible = "atmel,at45", "atmel,dataflash";
+					spi-max-frequency = <15000000>;
+					reg = <0>;
+				};
+			};
+
+			mmc0: mmc at fffa8000 {
+				pinctrl-0 = <
+					&pinctrl_board_mmc0
+					&pinctrl_mmc0_clk
+					&pinctrl_mmc0_slot1_cmd_dat0
+					&pinctrl_mmc0_slot1_dat1_3>;
+				status = "okay";
+				slot at 1 {
+					reg = <1>;
+					bus-width = <4>;
+					cd-gpios = <&pioC 8 GPIO_ACTIVE_HIGH>;
+					wp-gpios = <&pioC 4 GPIO_ACTIVE_HIGH>;
+				};
+			};
+
+			pinctrl at fffff400 {
+				mmc0 {
+					pinctrl_board_mmc0: mmc0-board {
+						atmel,pins =
+							<AT91_PIOC 8 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH	/* PC08 gpio CD pin pull up and deglitch */
+							 AT91_PIOC 4 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;	/* PC04 gpio WP pin pull up */
+					};
+				};
+			};
+
+
+		 };
+
+		 usb0: ohci at 00500000 {
+		       status = "okay";
+		 };
+
+		 nand0: nand at 40000000 {
+		       nand-bus-width = <8>;
+		       nand-ecc-mode = "soft";
+		       nand-on-flash-bbt = <1>;
+		       status = "okay";
+		 };
+	 };
+
+	 i2c at 0 {
+		status = "okay";
+	 };
+
+	 leds {
+		compatible = "gpio-leds";
+
+		b0 {
+			label = "b0";
+			gpios = <&pioA 6 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+
+	};
+};
--
2.1.4
