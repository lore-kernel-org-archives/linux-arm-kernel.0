From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 22 Jun 2016 12:43:50 +0900
Subject: [PATCH v3 12/13] ARM: dts: alt: use demuxer for I2C4
In-Reply-To: <1466567031-20381-1-git-send-email-horms+renesas@verge.net.au>
References: <1466567031-20381-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1466567031-20381-13-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make it possible to fallback to GPIO for I2C4 on the EXIO-B connector.

This is based on reference work for the I2C0 core of the lager/r8a7790
by Wolfram Sang.

Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v3
* New Patch
---
 arch/arm/boot/dts/r8a7794-alt.dts | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index d00b1b33f6ed..10f72e700685 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -19,7 +19,9 @@
 	aliases {
 		serial0 = &scif2;
 		i2c9 = "gpioi2c1";
+		i2c10 = "gpioi2c4";
 		i2c11 = "i2chdmi";
+		i2c12 = "i2cexio4";
 	};
 
 	chosen {
@@ -92,6 +94,17 @@
 		i2c-gpio,delay-us = <5>;
 	};
 
+	gpioi2c4: i2c-10 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "i2c-gpio";
+		status = "disabled";
+		gpios = <&gpio4 9 GPIO_ACTIVE_HIGH /* sda */
+			 &gpio4 8 GPIO_ACTIVE_HIGH /* scl */
+			>;
+		i2c-gpio,delay-us = <5>;
+	};
+
 	/*
 	 * A fallback to GPIO is provided for I2C1.
 	 */
@@ -115,6 +128,18 @@
 			};
 		};
 	};
+
+	/*
+	 * I2C4 is routed to EXIO connector B, pins 73 (SCL) + 74 (SDA).
+	 * A fallback to GPIO is provided.
+	 */
+	i2cexio4: i2c-14 {
+		compatible = "i2c-demux-pinctrl";
+		i2c-parent = <&i2c4>, <&gpioi2c4>;
+		i2c-bus-name = "i2c-exio4";
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
 };
 
 &du {
@@ -174,6 +199,11 @@
 		function = "i2c1";
 	};
 
+	i2c4_pins: i2c4 {
+		groups = "i2c4";
+		function = "i2c4";
+	};
+
 	vin0_pins: vin0 {
 		groups = "vin0_data8", "vin0_clk";
 		function = "vin0";
@@ -214,6 +244,11 @@
 	clock-frequency = <400000>;
 };
 
+&i2c4 {
+	pinctrl-0 = <&i2c4_pins>;
+	pinctrl-names = "i2c-exio4";
+};
+
 &vin0 {
 	status = "okay";
 	pinctrl-0 = <&vin0_pins>;
-- 
2.1.4
