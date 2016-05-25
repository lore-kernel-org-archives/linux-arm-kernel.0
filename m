From: raashidmuhammed@zilogic.com (Raashid Muhammed)
Date: Wed, 25 May 2016 13:45:06 +0530
Subject: [PATCH 2/2] ARM: at91: Add DT support for Olimex SAM9-L9260 board.
In-Reply-To: <1464164106-28359-1-git-send-email-raashidmuhammed@zilogic.com>
References: <1464164106-28359-1-git-send-email-raashidmuhammed@zilogic.com>
Message-ID: <1464164106-28359-2-git-send-email-raashidmuhammed@zilogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Raashid Muhammed <raashidmuhammed@zilogic.com>

sam9-l9260 is a low cost board designed by Olimex.

More information is available at:
https://www.olimex.com/Products/ARM/Atmel/SAM9-L9260/

Signed-off-by: Raashid Muhammed <raashidmuhammed@zilogic.com>
Reviewed-by: Vijay Kumar B. <vijaykumar@bravegnu.org>
---
 Documentation/devicetree/bindings/arm/olimex.txt |   8 +-
 arch/arm/boot/dts/Makefile                       |   1 +
 arch/arm/boot/dts/at91-sam9_l9260.dts            | 115 +++++++++++++++++++++++
 3 files changed, 122 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-sam9_l9260.dts

diff --git a/Documentation/devicetree/bindings/arm/olimex.txt b/Documentation/devicetree/bindings/arm/olimex.txt
index 007fb5c..d726aec 100644
--- a/Documentation/devicetree/bindings/arm/olimex.txt
+++ b/Documentation/devicetree/bindings/arm/olimex.txt
@@ -1,5 +1,9 @@
-Olimex i.MX Platforms Device Tree Bindings
-------------------------------------------
+Olimex Device Tree Bindings
+---------------------------
+
+SAM9-L9260 Board
+Required root node properties:
+    - compatible = "olimex,sam9-l9260", "atmel,at91sam9260";
 
 i.MX23 Olinuxino Low Cost Board
 Required root node properties:
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0f89d87..d27f09d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -19,6 +19,7 @@ dtb-$(CONFIG_SOC_SAM_V4_V5) += \
 	usb_a9260.dtb \
 	at91sam9261ek.dtb \
 	at91sam9263ek.dtb \
+	at91-sam9_l9260.dtb \
 	tny_a9263.dtb \
 	usb_a9263.dtb \
 	at91-foxg20.dtb \
diff --git a/arch/arm/boot/dts/at91-sam9_l9260.dts b/arch/arm/boot/dts/at91-sam9_l9260.dts
new file mode 100644
index 0000000..e2da9b906
--- /dev/null
+++ b/arch/arm/boot/dts/at91-sam9_l9260.dts
@@ -0,0 +1,115 @@
+/*
+ * at91-sam9_l9260.dts - Device Tree file for Olimex SAM9-L9260 board
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
+		stdout-path = "serial0:115200n8";
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
+			mmc0: mmc at fffa8000 {
+				pinctrl-0 = <
+					&pinctrl_board_mmc0
+					&pinctrl_mmc0_clk
+					&pinctrl_mmc0_slot1_cmd_dat0
+					&pinctrl_mmc0_slot1_dat1_3>;
+				status = "okay";
+
+				slot at 1 {
+					reg = <1>;
+					bus-width = <4>;
+					cd-gpios = <&pioC 8 GPIO_ACTIVE_HIGH>;
+					wp-gpios = <&pioC 4 GPIO_ACTIVE_HIGH>;
+				};
+			};
+
+			macb0: ethernet at fffc4000 {
+				phy-mode = "mii";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "okay";
+
+				ethernet-phy at 1 {
+					reg = <0x1>;
+				};
+			 };
+
+			spi0: spi at fffc8000 {
+				cs-gpios = <&pioC 11 0>, <0>, <0>, <0>;
+				status = "okay";
+
+				mtd_dataflash at 0 {
+					compatible = "atmel,at45", "atmel,dataflash";
+					spi-max-frequency = <15000000>;
+					reg = <0>;
+				};
+			};
+
+			dbgu: serial at fffff200 {
+				status = "okay";
+			 };
+
+			pinctrl at fffff400 {
+				mmc0 {
+					pinctrl_board_mmc0: mmc0-board {
+						atmel,pins =
+							<AT91_PIOC 8 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH	/* CD pin */
+							 AT91_PIOC 4 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;	/* WP pin */
+					};
+				};
+			};
+		 };
+
+		nand0: nand at 40000000 {
+		       nand-bus-width = <8>;
+		       nand-ecc-mode = "soft";
+		       nand-on-flash-bbt = <1>;
+		       status = "okay";
+		 };
+
+		 usb0: ohci at 500000 {
+		       status = "okay";
+		 };
+
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
