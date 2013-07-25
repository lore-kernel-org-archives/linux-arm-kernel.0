From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 25 Jul 2013 18:18:33 -0300
Subject: [PATCH] ARM: dts: imx53-qsb: Make USBH1 functional
Message-ID: <1374787113-6628-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mx53qsb uses GPIO7_8 to turn on VBUS, so add support for it.

Also specify the PHY type in the device tree.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
In order to test USBH1 the following patch is also needed:
"[PATCH] chipidea: core: Move hw_phymode_configure() into probe"

Just sent it to the linux-usb list.

 arch/arm/boot/dts/imx53-qsb.dts | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
index eedd27e..e97ddae 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -93,6 +93,15 @@
 			regulator-max-microvolt = <3200000>;
 			regulator-always-on;
 		};
+
+		reg_usb_vbus: usb_vbus {
+			compatible = "regulator-fixed";
+			regulator-name = "usb_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio7 8 0>;
+			enable-active-high;
+		};
 	};
 
 	sound {
@@ -145,6 +154,7 @@
 				MX53_PAD_EIM_DA12__GPIO3_12       0x80000000
 				MX53_PAD_EIM_DA13__GPIO3_13       0x80000000
 				MX53_PAD_PATA_DA_0__GPIO7_6       0x80000000
+				MX53_PAD_PATA_DA_2__GPIO7_8	  0x80000000
 				MX53_PAD_GPIO_16__GPIO7_11        0x80000000
 			>;
 		};
@@ -302,7 +312,9 @@
 };
 
 &usbh1 {
-       status = "okay";
+	vbus-supply = <&reg_usb_vbus>;
+	phy_type = "utmi";
+	status = "okay";
 };
 
 &usbotg {
-- 
1.8.1.2
