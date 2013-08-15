From: rogerq@ti.com (Roger Quadros)
Date: Thu, 15 Aug 2013 13:18:26 +0300
Subject: [PATCH v2 6/9] ARM: dts: omap4-panda: Use reset-gpios for hsusb1_reset
In-Reply-To: <1376561909-4406-1-git-send-email-rogerq@ti.com>
References: <1376561909-4406-1-git-send-email-rogerq@ti.com>
Message-ID: <1376561909-4406-7-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We no longer need to model the RESET line as a regulator since
the USB phy-nop driver accepts "reset-gpios" property.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap4-panda-common.dtsi |   18 +-----------------
 1 files changed, 1 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index faa95b5..c60ebd0 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -60,22 +60,6 @@
 			"AFMR", "Line In";
 	};
 
-	/*
-	 * Temp hack: Need to be replaced with the proper gpio-controlled
-	 * reset driver as soon it will be merged.
-	 * http://thread.gmane.org/gmane.linux.drivers.devicetree/36830
-	 */
-	/* HS USB Port 1 RESET */
-	hsusb1_reset: hsusb1_reset_reg {
-		compatible = "regulator-fixed";
-		regulator-name = "hsusb1_reset";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio2 30 0>;	/* gpio_62 */
-		startup-delay-us = <70000>;
-		enable-active-high;
-	};
-
 	/* HS USB Port 1 Power */
 	hsusb1_power: hsusb1_power_reg {
 		compatible = "regulator-fixed";
@@ -97,7 +81,7 @@
 	/* HS USB Host PHY on PORT 1 */
 	hsusb1_phy: hsusb1_phy {
 		compatible = "usb-nop-xceiv";
-		reset-supply = <&hsusb1_reset>;
+		reset-gpios = <&gpio2 30 GPIO_ACTIVE_LOW>;   /* gpio_62 */
 		vcc-supply = <&hsusb1_power>;
 	/**
 	 * FIXME:
-- 
1.7.4.1
