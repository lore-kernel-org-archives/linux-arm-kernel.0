From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 25 May 2012 10:24:23 +0800
Subject: [PATCH v3 10/12] ARM: dts: imx6q-sabrelite: add usb devices
In-Reply-To: <1337912665-16615-1-git-send-email-richard.zhao@freescale.com>
References: <1337912665-16615-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1337912665-16615-11-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- add usbphy devices
- add usb host controller and otg devices
- add on-board hub reset gpio pinctrl
- add usb h1 vbus regulator

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |   28 +++++++++++++++++++++++++
 arch/arm/boot/dts/imx6q.dtsi          |   36 +++++++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 1dd2261..06a5d00 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -48,10 +48,29 @@
 					status = "okay";
 				};
 			};
+			iomuxc at 020e0000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_gpio_hog>;
 
+				gpios {
+					pinctrl_gpio_hog: gpiohog {
+						fsl,pins = <1044 0x80000000	/* MX6Q_PAD_GPIO_17__GPIO_7_12 */
+							   144  0x80000000>;	/* MX6Q_PAD_EIM_D22__GPIO_3_22 */
+					};
+				};
+			};
 		};
 
 		aips-bus at 02100000 { /* AIPS2 */
+			usb at 02184000 { /* USB OTG */
+				vbus-supply = <&reg_usb_otg_vbus>;
+				status = "okay";
+			};
+
+			usb at 02184200 { /* USB1 */
+				status = "okay";
+			};
+
 			ethernet at 02188000 {
 				phy-mode = "rgmii";
 				phy-reset-gpios = <&gpio3 23 0>;
@@ -118,6 +137,15 @@
 			regulator-max-microvolt = <3300000>;
 			regulator-always-on;
 		};
+
+		reg_usb_otg_vbus: usb_otg_vbus {
+			compatible = "regulator-fixed";
+			regulator-name = "usb_otg_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio3 22 0>;
+			enable-active-high;
+		};
 	};
 
 	sound {
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 8c90cba..ccc8a5f 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -444,12 +444,14 @@
 				};
 			};
 
-			usbphy at 020c9000 { /* USBPHY1 */
+			usbphy1: usbphy at 020c9000 {
+				compatible = "fsl,imx6q-usbphy", "fsl,imx23-usbphy";
 				reg = <0x020c9000 0x1000>;
 				interrupts = <0 44 0x04>;
 			};
 
-			usbphy at 020ca000 { /* USBPHY2 */
+			usbphy2: usbphy at 020ca000 {
+				compatible = "fsl,imx6q-usbphy", "fsl,imx23-usbphy";
 				reg = <0x020ca000 0x1000>;
 				interrupts = <0 45 0x04>;
 			};
@@ -573,6 +575,36 @@
 				reg = <0x0217c000 0x4000>;
 			};
 
+			usb at 02184000 { /* USB OTG */
+				compatible = "fsl,imx6q-usb", "fsl,imx31-usb";
+				reg = <0x02184000 0x200>;
+				interrupts = <0 43 0x04>;
+				fsl,usbphy = <&usbphy1>;
+				status = "disabled";
+			};
+
+			usb at 02184200 { /* USB1 */
+				compatible = "fsl,imx6q-usb", "fsl,imx31-usb";
+				reg = <0x02184200 0x200>;
+				interrupts = <0 40 0x04>;
+				fsl,usbphy = <&usbphy2>;
+				status = "disabled";
+			};
+
+			usb at 02184400 { /* USB2 */
+				compatible = "fsl,imx6q-usb", "fsl,imx31-usb";
+				reg = <0x02184400 0x200>;
+				interrupts = <0 41 0x04>;
+				status = "disabled";
+			};
+
+			usb at 02184600 { /* USB3 */
+				compatible = "fsl,imx6q-usb", "fsl,imx31-usb";
+				reg = <0x02184600 0x200>;
+				interrupts = <0 42 0x04>;
+				status = "disabled";
+			};
+
 			ethernet at 02188000 {
 				compatible = "fsl,imx6q-fec";
 				reg = <0x02188000 0x4000>;
-- 
1.7.5.4
