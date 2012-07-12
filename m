From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 12 Jul 2012 14:21:41 +0800
Subject: [PATCH v8] ARM: dts: imx6q-sabrelite: add usb devices
In-Reply-To: <1342059927-25661-5-git-send-email-richard.zhao@freescale.com>
References: <1342059927-25661-5-git-send-email-richard.zhao@freescale.com>
Message-ID: <1342074101-31493-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- add usbphy devices
- add usb host controller and otg devices
- add usb h1 vbus regulator

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
changes since last version:
 - add gpio pinctrl

 arch/arm/boot/dts/imx6q-sabrelite.dts |   30 +++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6q.dtsi          |   36 +++++++++++++++++++++++++++++++--
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index e0ec929..46fdfd1 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -42,9 +42,30 @@
 				};
 			};
 
+			iomuxc at 020e0000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_gpio_hog>;
+
+				gpios {
+					pinctrl_gpio_hog: gpiohog {
+						fsl,pins = <
+							   144  0x80000000	/* MX6Q_PAD_EIM_D22__GPIO_3_22 */
+							   >;
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
@@ -111,6 +132,15 @@
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
index 16a3884..5e4f100 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -461,12 +461,14 @@
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
@@ -614,6 +616,36 @@
 				reg = <0x0217c000 0x4000>;
 			};
 
+			usb at 02184000 { /* USB OTG */
+				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
+				reg = <0x02184000 0x200>;
+				interrupts = <0 43 0x04>;
+				fsl,usbphy = <&usbphy1>;
+				status = "disabled";
+			};
+
+			usb at 02184200 { /* USB1 */
+				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
+				reg = <0x02184200 0x200>;
+				interrupts = <0 40 0x04>;
+				fsl,usbphy = <&usbphy2>;
+				status = "disabled";
+			};
+
+			usb at 02184400 { /* USB2 */
+				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
+				reg = <0x02184400 0x200>;
+				interrupts = <0 41 0x04>;
+				status = "disabled";
+			};
+
+			usb at 02184600 { /* USB3 */
+				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
+				reg = <0x02184600 0x200>;
+				interrupts = <0 42 0x04>;
+				status = "disabled";
+			};
+
 			ethernet at 02188000 {
 				compatible = "fsl,imx6q-fec";
 				reg = <0x02188000 0x4000>;
-- 
1.7.9.5
