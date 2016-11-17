From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Nov 2016 15:11:22 +0100
Subject: [PATCH 05/31] ARM: dts: lager: use demuxer for IIC1/I2C1
In-Reply-To: <cover.1479391750.git.horms+renesas@verge.net.au>
References: <cover.1479391750.git.horms+renesas@verge.net.au>
Message-ID: <88a9ab167e1d4143481aba43d71248d6f561f0a3.1479391750.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make it possible to select which I2C1 IP core you want to run on the
EXIO-A connector.

This is based on reference work for the I2C0 core of the lager board
by Wolfram Sang.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[wsa: rebased and fixed aliases]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 39 +++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 5645444cd21a..9b9748548702 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -50,7 +50,9 @@
 	aliases {
 		serial0 = &scif0;
 		serial1 = &scifa1;
+		i2c8 = &gpioi2c1;
 		i2c10 = &i2cexio0;
+		i2c11 = &i2cexio1;
 	};
 
 	chosen {
@@ -265,6 +267,17 @@
 		clock-frequency = <148500000>;
 	};
 
+	gpioi2c1: i2c-8 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "i2c-gpio";
+		status = "disabled";
+		gpios = <&gpio1 17 GPIO_ACTIVE_HIGH /* sda */
+			 &gpio1 16 GPIO_ACTIVE_HIGH /* scl */
+			>;
+		i2c-gpio,delay-us = <5>;
+	};
+
 	/*
 	 * IIC0/I2C0 is routed to EXIO connector A, pins 114 (SCL) + 116 (SDA) only.
 	 * We use the I2C demuxer, so the desired IP core can be selected at runtime
@@ -283,6 +296,19 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
+
+	/*
+	 * IIC1/I2C1 is routed to EXIO connector A, pins 78 (SCL) + 80 (SDA).
+	 * This is similar to the arangement described for i2cexio0 (above)
+	 * with a fallback to GPIO also provided.
+	 */
+	i2cexio1: i2c-11 {
+		compatible = "i2c-demux-pinctrl";
+		i2c-parent = <&iic1>, <&i2c1>, <&gpioi2c1>;
+		i2c-bus-name = "i2c-exio1";
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
 };
 
 &du {
@@ -405,6 +431,11 @@
 		function = "iic0";
 	};
 
+	i2c1_pins: i2c1 {
+		groups = "i2c1";
+		function = "i2c1";
+	};
+
 	iic1_pins: iic1 {
 		groups = "iic1";
 		function = "iic1";
@@ -606,10 +637,14 @@
 	pinctrl-names = "i2c-exio0";
 };
 
+&i2c1	{
+	pinctrl-0 = <&i2c1_pins>;
+	pinctrl-names = "i2c-exio1";
+};
+
 &iic1	{
-	status = "okay";
 	pinctrl-0 = <&iic1_pins>;
-	pinctrl-names = "default";
+	pinctrl-names = "i2c-exio1";
 };
 
 &iic2	{
-- 
2.7.0.rc3.207.g0ac5344
