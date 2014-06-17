From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 17 Jun 2014 14:41:01 +0100
Subject: [PATCH 2/2] ARM: dts: hummingboard/cubox-i: move usb otg
 configuration to platform level
In-Reply-To: <20140617134016.GK23430@n2100.arm.linux.org.uk>
References: <20140617134016.GK23430@n2100.arm.linux.org.uk>
Message-ID: <E1WwtdF-00004v-6t@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The configuration of the USB OTG is a platform configuration decision,
not a microsom decision.  Move this configuration out to the platform
level files.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/imx6dl-hummingboard.dts | 10 ++++++++++
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi    | 10 ++++++++++
 arch/arm/boot/dts/imx6qdl-microsom.dtsi   | 13 -------------
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-hummingboard.dts b/arch/arm/boot/dts/imx6dl-hummingboard.dts
index 5373a5f2782b..c8e51dd41b8f 100644
--- a/arch/arm/boot/dts/imx6dl-hummingboard.dts
+++ b/arch/arm/boot/dts/imx6dl-hummingboard.dts
@@ -143,6 +143,14 @@
 			fsl,pins = <MX6QDL_PAD_GPIO_0__GPIO1_IO00 0x1b0b0>;
 		};
 
+		pinctrl_hummingboard_usbotg_id: hummingboard-usbotg-id {
+			/*
+			 * Similar to pinctrl_usbotg_2, but we want it
+			 * pulled down for a fixed host connection.
+			 */
+			fsl,pins = <MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x13059>;
+		};
+
 		pinctrl_hummingboard_usbotg_vbus: hummingboard-usbotg-vbus {
 			fsl,pins = <MX6QDL_PAD_EIM_D22__GPIO3_IO22 0x1b0b0>;
 		};
@@ -178,6 +186,8 @@
 };
 
 &usbotg {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hummingboard_usbotg_id>;
 	vbus-supply = <&reg_usbotg_vbus>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
index 9202c8d18a30..e8e781656b3f 100644
--- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -134,6 +134,14 @@
 			fsl,pins = <MX6QDL_PAD_GPIO_0__GPIO1_IO00 0x4001b0b0>;
 		};
 
+		pinctrl_cubox_i_usbotg_id: cubox-i-usbotg-id {
+			/*
+			 * The Cubox-i pulls this low, but as it's pointless
+			 * leaving it as a pull-up, even if it is just 10uA.
+			 */
+			fsl,pins = <MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x13059>;
+		};
+
 		pinctrl_cubox_i_usbotg_vbus: cubox-i-usbotg-vbus {
 			fsl,pins = <MX6QDL_PAD_EIM_D22__GPIO3_IO22 0x4001b0b0>;
 		};
@@ -170,6 +178,8 @@
 };
 
 &usbotg {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_cubox_i_usbotg_id>;
 	vbus-supply = <&reg_usbotg_vbus>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6qdl-microsom.dtsi b/arch/arm/boot/dts/imx6qdl-microsom.dtsi
index d729d0b15f25..79eac6849d4c 100644
--- a/arch/arm/boot/dts/imx6qdl-microsom.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-microsom.dtsi
@@ -10,14 +10,6 @@
 				MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA	0x1b0b1
 			>;
 		};
-
-		pinctrl_microsom_usbotg: microsom-usbotg {
-			/*
-			 * Similar to pinctrl_usbotg_2, but we want it
-			 * pulled down for a fixed host connection.
-			 */
-			fsl,pins = <MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x13059>;
-		};
 	};
 };
 
@@ -26,8 +18,3 @@
 	pinctrl-0 = <&pinctrl_microsom_uart1>;
 	status = "okay";
 };
-
-&usbotg {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_microsom_usbotg>;
-};
-- 
1.8.3.1
