From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Mon, 16 Oct 2017 17:46:25 +0530
Subject: [PATCH 7/9] ARM: dts: rockchip: Add usb otg for rk3288-vyasa
In-Reply-To: <1508156187-27519-1-git-send-email-jagan@amarulasolutions.com>
References: <1508156187-27519-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <1508156187-27519-8-git-send-email-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add usb otg support for rk3288-vyasa, board support usb1 otg
power through otg_vbus_drv and naming conversion followed
as per schematic.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Note: g_ether/g_serial fired an issue with mainline tree 
https://paste.ubuntu.com/25752571/

 arch/arm/boot/dts/rk3288-vyasa.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-vyasa.dts b/arch/arm/boot/dts/rk3288-vyasa.dts
index c22d674..2f1389a 100644
--- a/arch/arm/boot/dts/rk3288-vyasa.dts
+++ b/arch/arm/boot/dts/rk3288-vyasa.dts
@@ -115,6 +115,20 @@
 		vin-supply = <&vcc_io>;
 	};
 
+	vusb1_5v: vusb1-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "vusb1_5v";
+		enable-active-high;
+		gpio = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>; /* OTG_VBUS_DRV */
+		pinctrl-names = "default";
+		pinctrl-0 = <&otg_vbus_drv>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vsus_5v>;
+	};
+
 	vusb2_5v: vusb2-5v {
 		compatible = "regulator-fixed";
 		regulator-name = "vusb2_5v";
@@ -401,6 +415,10 @@
 	status = "okay";
 };
 
+&usb_otg {
+	status = "okay";
+};
+
 &vopb {
 	status = "okay";
 };
@@ -455,4 +473,11 @@
 			rockchip,pins = <RK_GPIO8 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
+
+	usb_otg {
+		otg_vbus_drv: otg-vbus-drv {
+			rockchip,pins = <RK_GPIO0 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
+
+		};
+	};
 };
-- 
2.7.4
