From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue, 17 Jul 2018 14:55:26 +0530
Subject: [PATCH v3 3/3] ARM: dts: i.MX6: imx6dl-mamoj: Add usb host and device
 support
In-Reply-To: <20180717092526.32215-1-jagan@amarulasolutions.com>
References: <20180717092526.32215-1-jagan@amarulasolutions.com>
Message-ID: <20180717092526.32215-3-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michael Trimarchi <michael@amarulasolutions.com>

Add USB host and device support for BTicino i.MX6DL Mamoj board.

Signed-off-by: Simone CIANNI <simone.cianni@bticino.it>
Signed-off-by: Raffaele RECALCATI <raffaele.recalcati@bticino.it>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes for v3:
- usbhost is replace with usbhostgrp on iomux node
Changes for v2:
- collect Fabio r-w-b tag

 arch/arm/boot/dts/imx6dl-mamoj.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-mamoj.dts b/arch/arm/boot/dts/imx6dl-mamoj.dts
index 530cb20ccc86..df8607fe4142 100644
--- a/arch/arm/boot/dts/imx6dl-mamoj.dts
+++ b/arch/arm/boot/dts/imx6dl-mamoj.dts
@@ -134,6 +134,17 @@
 		vin-supply = <&reg_lcd_vgl>;
 	};
 
+	reg_usb_host: regulator-usb-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usbhost-vbus";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbhost>;
+		regulator-min-microvolt = <50000000>;
+		regulator-max-microvolt = <50000000>;
+		gpio = <&gpio6 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_wl18xx_vmmc:  regulator-wl18xx-vmcc {
 		compatible = "regulator-fixed";
 		regulator-name = "vwl1807";
@@ -297,6 +308,16 @@
 	status = "okay";
 };
 
+&usbh1 {
+	vbus-supply = <&reg_usb_host>;
+	status = "okay";
+};
+
+&usbotg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
 &usdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1>;
@@ -428,6 +449,12 @@
 		>;
 	};
 
+	pinctrl_usbhost: usbhostgrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_A23__GPIO6_IO06		0x4001b0b0
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17069
-- 
2.17.1
