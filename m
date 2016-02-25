From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Feb 2016 08:53:07 +0900
Subject: [PATCH 18/19] ARM: dts: r8a7790: lager: use demuxer for IIC0/I2C0
In-Reply-To: <cover.1456443769.git.horms+renesas@verge.net.au>
References: <cover.1456443769.git.horms+renesas@verge.net.au>
Message-ID: <880cb5702471c4eb56b1af1c26e5273e48f50a32.1456443769.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Make it possible to select which I2C IP core you want to run on the
EXIO-A connector. This is the reference how to use this feature. Update
the copyright while we are here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index cdc0414f5f07..aa6ca92a9485 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2013-2014 Renesas Solutions Corp.
  * Copyright (C) 2014 Cogent Embedded, Inc.
+ * Copyright (C) 2015-2016 Renesas Electronics Corporation
  *
  * This file is licensed under the terms of the GNU General Public License
  * version 2.  This program is licensed "as is" without any warranty of any
@@ -49,6 +50,7 @@
 	aliases {
 		serial0 = &scif0;
 		serial1 = &scifa1;
+		i2c8 = "i2cexio";
 	};
 
 	chosen {
@@ -252,6 +254,23 @@
 		#clock-cells = <0>;
 		clock-frequency = <148500000>;
 	};
+
+	/*
+	 * IIC0/I2C0 is routed to EXIO connector A, pins 114 (SCL) + 116 (SDA) only.
+	 * We use the I2C demuxer, so the desired IP core can be selected at runtime
+	 * depending on the use case (e.g. DMA with IIC0 or slave support with I2C0).
+	 * Note: For testing the I2C slave feature, it is convenient to connect this
+	 * bus with IIC3 on pins 110 (SCL) + 112 (SDA), select I2C0 at runtime, and
+	 * instantiate the slave device at runtime according to the documentation.
+	 * You can then communicate with the slave via IIC3.
+	 */
+	i2cexio: i2c at 8 {
+		compatible = "i2c-demux-pinctrl";
+		i2c-parent = <&iic0>, <&i2c0>;
+		i2c-bus-name = "i2c-exio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
 };
 
 &du {
@@ -350,6 +369,11 @@
 		renesas,function = "msiof1";
 	};
 
+	i2c0_pins: i2c0 {
+		renesas,groups = "i2c0";
+		renesas,function = "i2c0";
+	};
+
 	iic0_pins: iic0 {
 		renesas,groups = "iic0";
 		renesas,function = "iic0";
@@ -537,10 +561,14 @@
 	cpu0-supply = <&vdd_dvfs>;
 };
 
+&i2c0	{
+	pinctrl-0 = <&i2c0_pins>;
+	pinctrl-names = "i2c-exio";
+};
+
 &iic0	{
-	status = "okay";
 	pinctrl-0 = <&iic0_pins>;
-	pinctrl-names = "default";
+	pinctrl-names = "i2c-exio";
 };
 
 &iic1	{
-- 
2.7.0.rc3.207.g0ac5344
