From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Nov 2016 21:14:14 +0100
Subject: [PATCH 07/31] ARM: dts: alt: use demuxer for I2C4
In-Reply-To: <cover.1479931686.git.horms+renesas@verge.net.au>
References: <cover.1479931686.git.horms+renesas@verge.net.au>
Message-ID: <e60a19f03cdb5a16fdad72d0776a1ede10fd2a57.1479931686.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make it possible to fallback to GPIO for I2C4 on the EXIO-B connector.

This is based on reference work for the I2C0 core of the lager/r8a7790
by Wolfram Sang.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[wsa: rebased and fixed aliases]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7794-alt.dts | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index a3e74684289b..7270d4224b1a 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -18,6 +18,8 @@
 
 	aliases {
 		serial0 = &scif2;
+		i2c10 = &gpioi2c4;
+		i2c12 = &i2cexio4;
 	};
 
 	chosen {
@@ -135,6 +137,29 @@
 		#clock-cells = <0>;
 		clock-frequency = <148500000>;
 	};
+
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
@@ -194,6 +219,11 @@
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
@@ -314,6 +344,11 @@
 	};
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
2.7.0.rc3.207.g0ac5344
