From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 27 Nov 2017 16:52:50 +0000
Subject: [PATCH 09/13] ARM: dts: imx6qdl-hummingboard: add SD card regulator
In-Reply-To: <20171127165134.GH31757@n2100.armlinux.org.uk>
References: <20171127165134.GH31757@n2100.armlinux.org.uk>
Message-ID: <E1eJMeI-0002rP-Rt@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the SD card regulator, which allows the SD card power to be switched
on/off.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
index 84e6392fee1f..1b33cd6752f4 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
@@ -59,6 +59,19 @@
 		regulator-always-on;
 	};
 
+	v_sd: regulator-v-sd {
+		compatible = "regulator-fixed";
+		gpio = <&gpio4 30 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_hummingboard_vmmc>;
+		regulator-boot-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "v_sd";
+		startup-delay-us = <1000>;
+		vin-supply = <&reg_3p3v>;
+	};
+
 	reg_usbh1_vbus: usb-h1-vbus {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -241,6 +254,11 @@
 				MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x13059
 			>;
 		};
+		pinctrl_hummingboard_vmmc: hummingboard-vmmc {
+			fsl,pins = <
+				MX6QDL_PAD_DISP0_DAT9__GPIO4_IO30 0x1b0b0
+			>;
+		};
 	};
 };
 
@@ -292,7 +310,7 @@
 		&pinctrl_hummingboard_usdhc2_aux
 		&pinctrl_hummingboard_usdhc2
 	>;
-	vmmc-supply = <&reg_3p3v>;
+	vmmc-supply = <&v_sd>;
 	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
-- 
2.7.4
