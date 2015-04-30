From: g.portay@overkiz.com (=?UTF-8?q?Ga=C3=ABl=20PORTAY?=)
Date: Thu, 30 Apr 2015 09:33:33 +0200
Subject: [PATCH v3 2/7] ARM: at91/dt: at91-kizbox: sanitize file
In-Reply-To: <1430379218-13758-1-git-send-email-g.portay@overkiz.com>
References: <1430379218-13758-1-git-send-email-g.portay@overkiz.com>
Message-ID: <1430379218-13758-3-git-send-email-g.portay@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Consists in:
 * sorting nodes by address as possible or alphabetically,
 * adding myself as new maintainer and
 * update license.

Signed-off-by: Ga?l PORTAY <g.portay@overkiz.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/at91-kizbox.dts | 65 +++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/arch/arm/boot/dts/at91-kizbox.dts b/arch/arm/boot/dts/at91-kizbox.dts
index e07afae..00c86c1 100644
--- a/arch/arm/boot/dts/at91-kizbox.dts
+++ b/arch/arm/boot/dts/at91-kizbox.dts
@@ -1,16 +1,16 @@
 /*
  * at91-kizbox.dts - Device Tree file for Overkiz Kizbox board
  *
- * Copyright (C) 2012 Boris BREZILLON <linux-arm@overkiz.com>
+ * Copyright (C) 2012-2014 Boris BREZILLON <b.brezillon@overkiz.com>
+ *               2014-2015 Ga?l PORTAY <g.portay@overkiz.com>
  *
- * Licensed under GPLv2.
+ * Licensed under GPLv2 or later.
  */
 /dts-v1/;
 #include "at91sam9g20.dtsi"
 
 / {
-
-	model = "Overkiz kizbox";
+	model = "Overkiz Kizbox";
 	compatible = "overkiz,kizbox", "atmel,at91sam9g20", "atmel,at91sam9";
 
 	chosen {
@@ -38,10 +38,6 @@
 
 	ahb {
 		apb {
-			dbgu: serial at fffff200 {
-				status = "okay";
-			};
-
 			usart0: serial at fffb0000 {
 				status = "okay";
 			};
@@ -57,6 +53,10 @@
 				status = "okay";
 			};
 
+			dbgu: serial at fffff200 {
+				status = "okay";
+			};
+
 			watchdog at fffffd40 {
 				timeout-sec = <15>;
 				atmel,max-heartbeat-sec = <16>;
@@ -65,6 +65,11 @@
 			};
 		};
 
+		usb0: ohci at 00500000 {
+			num-ports = <1>;
+			status = "okay";
+		};
+
 		nand0: nand at 40000000 {
 			nand-bus-width = <8>;
 			nand-ecc-mode = "soft";
@@ -79,24 +84,36 @@
 				label = "ubi";
 				reg = <0xc0000 0x7f40000>;
 			};
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
 
+		reset {
+			label = "reset";
+			gpios = <&pioB 30 GPIO_ACTIVE_LOW>;
+			linux,code = <0x100>;
+			gpio-key,wakeup;
 		};
 
-		usb0: ohci at 00500000 {
-			num-ports = <1>;
-			status = "okay";
+		mode {
+			label = "mode";
+			gpios = <&pioB 31 GPIO_ACTIVE_LOW>;
+			linux,code = <0x101>;
+			gpio-key,wakeup;
 		};
 	};
 
 	i2c at 0 {
 		status = "okay";
 
-		pcf8563 at 51 {
-			/* nxp pcf8563 rtc */
+		rtc: pcf8563 at 51 {
 			compatible = "nxp,pcf8563";
 			reg = <0x51>;
 		};
-
 	};
 
 	leds {
@@ -127,24 +144,4 @@
 			linux,default-trigger = "none";
 		};
 	};
-
-	gpio_keys {
-		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reset {
-			label = "reset";
-			gpios = <&pioB 30 GPIO_ACTIVE_LOW>;
-			linux,code = <0x100>;
-			gpio-key,wakeup;
-		};
-
-		mode {
-			label = "mode";
-			gpios = <&pioB 31 GPIO_ACTIVE_LOW>;
-			linux,code = <0x101>;
-			gpio-key,wakeup;
-		};
-	};
 };
-- 
1.9.1
