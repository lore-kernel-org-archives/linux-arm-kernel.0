From: christopher.spinrath@rwth-aachen.de (christopher.spinrath at rwth-aachen.de)
Date: Fri, 11 Nov 2016 16:59:39 +0100
Subject: [PATCH 2/2] ARM: dts: imx6q-utilite-pro: i2c1 is muxed
In-Reply-To: <20161111155939.446-1-christopher.spinrath@rwth-aachen.de>
References: <20161111155939.446-1-christopher.spinrath@rwth-aachen.de>
Message-ID: <9380efa7a5b749ee8b9c6433f925b20b@rwthex-s1-b.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>

It turns out that the i2c1 adapter is connected to a multiplexer
controlled by a gpio line. The first (default) mux option connects
i2c1 to a bus connected to the already known peripherals. The other
one connects the adapter to the ddc pins of the DVI port.

Signed-off-by: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
---
 arch/arm/boot/dts/imx6q-utilite-pro.dts | 51 ++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-utilite-pro.dts b/arch/arm/boot/dts/imx6q-utilite-pro.dts
index 6199063..246979a 100644
--- a/arch/arm/boot/dts/imx6q-utilite-pro.dts
+++ b/arch/arm/boot/dts/imx6q-utilite-pro.dts
@@ -71,6 +71,40 @@
 			gpio-key,wakeup;
 		};
 	};
+
+	i2cmux {
+		compatible = "i2c-mux-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c1mux>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mux-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+		i2c-parent = <&i2c1>;
+
+		i2c at 0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			eeprom at 50 {
+				compatible = "at24,24c02";
+				reg = <0x50>;
+				pagesize = <16>;
+			};
+
+			em3027: rtc at 56 {
+				compatible = "emmicro,em3027";
+				reg = <0x56>;
+			};
+		};
+
+		i2c_dvi_ddc: i2c at 1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
 };
 
 &hdmi {
@@ -82,17 +116,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
-
-	eeprom at 50 {
-		compatible = "at24,24c02";
-		reg = <0x50>;
-		pagesize = <16>;
-	};
-
-	em3027: rtc at 56 {
-		compatible = "emmicro,em3027";
-		reg = <0x56>;
-	};
 };
 
 &i2c2 {
@@ -115,6 +138,12 @@
 		>;
 	};
 
+	pinctrl_i2c1mux: i2c1muxgrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_2__GPIO1_IO02 0x1b0b0
+		>;
+	};
+
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
 			MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b8b1
-- 
2.10.2
