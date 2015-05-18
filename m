From: eric@anholt.net (Eric Anholt)
Date: Mon, 18 May 2015 12:43:38 -0700
Subject: [PATCH 6/7] ARM: bcm2835: Use the RPi firmware clocks for uart.
In-Reply-To: <1431978219-14226-1-git-send-email-eric@anholt.net>
References: <1431978219-14226-1-git-send-email-eric@anholt.net>
Message-ID: <1431978219-14226-7-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This gets us a correct apb_pclk, which previously was accidentally
using the "20201000.uart" clock from clk-bcm2835.c, due to the
fallback clk_get_sys() path.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 7 +++++++
 arch/arm/boot/dts/bcm2835.dtsi     | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index ac5f84c..53285a3 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -1,3 +1,4 @@
+#include <dt-bindings/clk/raspberrypi.h>
 #include "bcm2835.dtsi"
 
 / {
@@ -62,3 +63,9 @@
 	status = "okay";
 	bus-width = <4>;
 };
+
+&uart0 {
+	clocks = <&firmware_clocks RPI_CLOCK_UART0>,
+		 <&firmware_clocks RPI_CLOCK_CORE>;
+	clock-names = "uartclk", "apb_pclk";
+};
diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 32f5830..5be2862 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -92,7 +92,7 @@
 			#interrupt-cells = <2>;
 		};
 
-		uart at 7e201000 {
+		uart0: uart at 7e201000 {
 			compatible = "brcm,bcm2835-pl011", "arm,pl011", "arm,primecell";
 			reg = <0x7e201000 0x1000>;
 			interrupts = <2 25>;
-- 
2.1.4
