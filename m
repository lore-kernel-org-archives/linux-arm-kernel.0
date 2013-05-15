From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 15 May 2013 02:18:17 +0200
Subject: [PATCH v3 17/20] ARM: shmobile: kzm9g-reference: Move SDHI regulators
 to DT
In-Reply-To: <1368577100-3530-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1368577100-3530-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1368577100-3530-18-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create two GPIO-controlled fixed-voltage regulators in the
kzm9g-reference DT and remove manual configuration of the corresponding
GPIOs from board code.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts   | 22 ++++++++++++++++++++--
 arch/arm/mach-shmobile/board-kzm9g-reference.c |  6 ------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 475535f..cdfd71a 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -58,6 +58,24 @@
 		regulator-boot-on;
 	};
 
+	vmmc_sdhi0: regulator at 2 {
+	        compatible = "regulator-fixed";
+		regulator-name = "SDHI0 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pfc 15 0>;
+		enable-active-high;
+	};
+
+	vmmc_sdhi2: regulator at 3 {
+	        compatible = "regulator-fixed";
+		regulator-name = "SDHI2 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pfc 14 0>;
+		enable-active-high;
+	};
+
 	lan9220 at 10000000 {
 		compatible = "smsc,lan9220", "smsc,lan9115";
 		reg = <0x10000000 0x100>;
@@ -200,7 +218,7 @@
 	pinctrl-0 = <&sdhi0_pins>;
 	pinctrl-names = "default";
 
-	vmmc-supply = <&reg_3p3v>;
+	vmmc-supply = <&vmmc_sdhi0>;
 	bus-width = <4>;
 	status = "okay";
 };
@@ -209,7 +227,7 @@
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
1.8.1.5
