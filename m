From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 24 Jul 2013 09:32:57 +0900
Subject: [PATCH 18/19] ARM: shmobile: kzm9g-reference: Move SDHI regulators to
 DT
In-Reply-To: <cover.1374625203.git.horms+renesas@verge.net.au>
References: <cover.1374625203.git.horms+renesas@verge.net.au>
Message-ID: <f8f77ce940b84c17378db432a05186476bd8dd04.1374625203.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Create two GPIO-controlled fixed-voltage regulators in the
kzm9g-reference DT and remove manual configuration of the corresponding
GPIOs from board code.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts   | 23 +++++++++++++++++++++--
 arch/arm/mach-shmobile/board-kzm9g-reference.c |  6 ------
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 11ae9ad..d2b2c9f 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -13,6 +13,7 @@
 
 /dts-v1/;
 /include/ "sh73a0.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "KZM-A9-GT";
@@ -58,6 +59,24 @@
 		regulator-boot-on;
 	};
 
+	vmmc_sdhi0: regulator at 2 {
+	        compatible = "regulator-fixed";
+		regulator-name = "SDHI0 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pfc 15 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vmmc_sdhi2: regulator at 3 {
+	        compatible = "regulator-fixed";
+		regulator-name = "SDHI2 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pfc 14 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	lan9220 at 10000000 {
 		compatible = "smsc,lan9220", "smsc,lan9115";
 		reg = <0x10000000 0x100>;
@@ -200,7 +219,7 @@
 	pinctrl-0 = <&sdhi0_pins>;
 	pinctrl-names = "default";
 
-	vmmc-supply = <&reg_3p3v>;
+	vmmc-supply = <&vmmc_sdhi0>;
 	bus-width = <4>;
 	status = "okay";
 };
@@ -209,7 +228,7 @@
 	pinctrl-0 = <&sdhi2_pins>;
 	pinctrl-names = "default";
 
-	vmmc-supply = <&reg_3p3v>;
+	vmmc-supply = <&vmmc_sdhi2>;
 	bus-width = <4>;
 	broken-cd;
 	status = "okay";
diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index fc2bb37..1847b4d 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -21,7 +21,6 @@
  */
 
 #include <linux/delay.h>
-#include <linux/gpio.h>
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
@@ -37,11 +36,6 @@ static void __init kzm_init(void)
 {
 	sh73a0_add_standard_devices_dt();
 
-	/* enable SD */
-	gpio_request_one(15, GPIOF_OUT_INIT_HIGH, NULL); /* power */
-
-	gpio_request_one(14, GPIOF_OUT_INIT_HIGH, NULL); /* power */
-
 #ifdef CONFIG_CACHE_L2X0
 	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
 	l2x0_init(IOMEM(0xf0100000), 0x40460000, 0x82000fff);
-- 
1.8.2.1
