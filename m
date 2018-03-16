From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:53:00 +0100
Subject: [PATCH 41/52] ARM: dts: gose: use demuxer for I2C4
In-Reply-To: <cover.1521208546.git.horms+renesas@verge.net.au>
References: <cover.1521208546.git.horms+renesas@verge.net.au>
Message-ID: <931bc7ec2d43f85c0b05aacb31bd1bd187ed7f65.1521208546.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Make it possible to fallback to GPIO for I2C4 on the EXIO-E connector.

This is based on reference work for the I2C0 core of the lager/r8a7790
by Wolfram Sang.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[wsa: rebased, corrected board name in subject, fixed aliases, switched
to named GPIOs, fixed pinmux for I2C4]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7793-gose.dts | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index 2b330ef71f4c..9ed6961f2d9a 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -49,7 +49,9 @@
 		serial0 = &scif0;
 		serial1 = &scif1;
 		i2c9 = &gpioi2c2;
+		i2c10 = &gpioi2c4;
 		i2c11 = &i2chdmi;
+		i2c12 = &i2cexio4;
 	};
 
 	chosen {
@@ -309,6 +311,16 @@
 		i2c-gpio,delay-us = <5>;
 	};
 
+	gpioi2c4: i2c-10 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "i2c-gpio";
+		status = "disabled";
+		scl-gpios = <&gpio7 13 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		sda-gpios = <&gpio7 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <5>;
+	};
+
 	/*
 	 * A fallback to GPIO is provided for I2C2.
 	 */
@@ -416,6 +428,18 @@
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
@@ -454,6 +478,11 @@
 		function = "i2c2";
 	};
 
+	i2c4_pins: i2c4 {
+		groups = "i2c4_c";
+		function = "i2c4";
+	};
+
 	du_pins: du {
 		groups = "du_rgb888", "du_sync", "du_disp", "du_clk_out_0";
 		function = "du";
@@ -692,6 +721,11 @@
 	};
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
2.11.0
