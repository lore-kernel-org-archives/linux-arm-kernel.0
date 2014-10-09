From: mhei@heimpold.de (Michael Heimpold)
Date: Thu,  9 Oct 2014 23:46:19 +0200
Subject: [PATCH] ARM: dts: imx28-duckbill: enable spi0, auart0 and i2c0,
 fix usb0
Message-ID: <1412891179-16714-1-git-send-email-mhei@heimpold.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the pin default configuration as stated in the datasheet.

While at, explicitly define the working mode for USB0. This prevents
a warning about a missing vbus regulator:

[    1.425268] 80080000.usb supply vbus not found, using dummy regulator

Signed-off-by: Michael Heimpold <mhei@heimpold.de>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/imx28-duckbill.dts |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx28-duckbill.dts b/arch/arm/boot/dts/imx28-duckbill.dts
index ce1a7ef..3f700dd 100644
--- a/arch/arm/boot/dts/imx28-duckbill.dts
+++ b/arch/arm/boot/dts/imx28-duckbill.dts
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2013 Michael Heimpold <mhei@heimpold.de>
+ * Copyright (C) 2013-2014 Michael Heimpold <mhei@heimpold.de>
  *
  * The code contained herein is licensed under the GNU General Public
  * License. You may obtain a copy of the GNU General Public License
@@ -32,6 +32,13 @@
 				status = "okay";
 			};
 
+			ssp2: ssp at 80014000 {
+				compatible = "fsl,imx28-spi";
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi2_pins_a>;
+				status = "okay";
+			};
+
 			pinctrl at 80018000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&hog_pins_a>;
@@ -60,6 +67,18 @@
 		};
 
 		apbx at 80040000 {
+			i2c0: i2c at 80058000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&i2c0_pins_a>;
+				status = "okay";
+			};
+
+			auart0: serial at 8006a000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&auart0_2pins_a>;
+				status = "okay";
+			};
+
 			duart: serial at 80074000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&duart_pins_a>;
@@ -75,6 +94,7 @@
 	ahb at 80080000 {
 		usb0: usb at 80080000 {
 			status = "okay";
+			dr_mode = "peripheral";
 		};
 
 		mac0: ethernet at 800f0000 {
-- 
1.7.10.4
