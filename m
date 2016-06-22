From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 22 Jun 2016 12:43:48 +0900
Subject: [PATCH v3 10/13] ARM: dts: koelsch: use demuxer for I2C4
In-Reply-To: <1466567031-20381-1-git-send-email-horms+renesas@verge.net.au>
References: <1466567031-20381-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1466567031-20381-11-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make it possible to fallback to GPIO for I2C4 on the EXIO-E connector.

This is based on reference work for the I2C0 core of the lager/r8a7790
by Wolfram Sang.

Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v3
* New Patch
---
 arch/arm/boot/dts/r8a7793-gose.dts | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index 2c8c8a4852c8..0e418e7a6d5c 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -49,7 +49,9 @@
 		serial0 = &scif0;
 		serial1 = &scif1;
 		i2c9 = "gpioi2c2";
+		i2c10 = "gpioi2c4";
 		i2c11 = "i2chdmi";
+		i2c12 = "i2cexio4";
 	};
 
 	chosen {
@@ -289,6 +291,17 @@
 		i2c-gpio,delay-us = <5>;
 	};
 
+	gpioi2c4: i2c-10 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "i2c-gpio";
+		status = "disabled";
+		gpios = <&gpio7 14 GPIO_ACTIVE_HIGH /* sda */
+			 &gpio7 13 GPIO_ACTIVE_HIGH /* scl */
+			>;
+		i2c-gpio,delay-us = <5>;
+	};
+
 	/*
 	 * A fallback to GPIO is provided for I2C2.
 	 */
@@ -343,6 +356,18 @@
 			pagesize = <16>;
 		};
 	};
+
+	/*
+	 * I2C4 is routed to EXIO connector E, pins 37 (SCL) + 39 (SDA).
+	 * A fallback to GPIO is provided.
+	 */
+	i2cexio4: i2c-12 {
+		compatible = "i2c-demux-pinctrl";
+		i2c-parent = <&i2c4>, <&gpioi2c4>;
+		i2c-bus-name = "i2c-exio4";
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
 };
 
 &du {
@@ -383,6 +408,11 @@
 		function = "i2c2";
 	};
 
+	i2c4_pins: i2c4 {
+		groups = "i2c4";
+		function = "i2c4";
+	};
+
 	du_pins: du {
 		groups = "du_rgb888", "du_sync", "du_disp", "du_clk_out_0";
 		function = "du";
@@ -562,6 +592,11 @@
 	clock-frequency = <100000>;
 };
 
+&i2c4 {
+	pinctrl-0 = <&i2c4_pins>;
+	pinctrl-names = "i2c-exio4";
+};
+
 &rcar_sound {
 	pinctrl-0 = <&sound_pins &sound_clk_pins>;
 	pinctrl-names = "default";
-- 
2.1.4
