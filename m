From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 15 May 2012 21:58:23 +0800
Subject: [PATCH v1 7/7] ARM: dts: imx6q-sabrelite: add usb devices
In-Reply-To: <1337090303-16046-1-git-send-email-richard.zhao@freescale.com>
References: <1337090303-16046-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1337090303-16046-8-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |   19 +++++++++++++-
 arch/arm/boot/dts/imx6q.dtsi          |   44 +++++++++++++++++++++++++++++++-
 2 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 2f631f2..ccc794e 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -41,10 +41,27 @@
 					status = "okay";
 				};
 			};
-
+			iomuxc at 020e0000 {
+				gpios {
+					pinctrl_gpio_hog: gpiohog {
+						fsl,pins = <1044 0x80000000
+							   144  0x80000000>;	/* MX6Q_PAD_GPIO_17__GPIO_7_12 */
+					};
+				};
+			};
 		};
 
 		aips-bus at 02100000 { /* AIPS2 */
+			usboh3 at 02184000 { /* USB OTG */
+				fsl,vbus-power = <&gpio3 22 0>;
+				status = "okay";
+			};
+
+			usboh3 at 02184200 { /* USB1 */
+				fsl,hub-reset = <&gpio7 12 0>;
+				status = "okay";
+			};
+
 			ethernet at 02188000 {
 				phy-mode = "rgmii";
 				phy-reset-gpios = <&gpio3 23 0>;
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index b5a15c4..863cb74 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -444,12 +444,14 @@
 				};
 			};
 
-			usbphy at 020c9000 { /* USBPHY1 */
+			usbphy1: usbphy at 020c9000 {
+				compatible = "fsl,imx6q-usbphy";
 				reg = <0x020c9000 0x1000>;
 				interrupts = <0 44 0x04>;
 			};
 
-			usbphy at 020ca000 { /* USBPHY2 */
+			usbphy2: usbphy at 020ca000 {
+				compatible = "fsl,imx6q-usbphy";
 				reg = <0x020ca000 0x1000>;
 				interrupts = <0 45 0x04>;
 			};
@@ -485,7 +487,15 @@
 				compatible = "fsl,imx6q-iomuxc";
 				reg = <0x020e0000 0x4000>;
 
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_gpio_hog>;
+
 				/* shared pinctrl settings */
+				gpios {
+					pinctrl_gpio_hog: gpiohog {
+					};
+				};
+
 				usdhc3 {
 					pinctrl_usdhc3_1: usdhc3grp-1 {
 						fsl,pins = <1273 0x17059	/* MX6Q_PAD_SD3_CMD__USDHC3_CMD */
@@ -550,6 +560,36 @@
 				reg = <0x0217c000 0x4000>;
 			};
 
+			usboh3 at 02184000 { /* USB OTG */
+				compatible = "fsl,imx6q-usboh3";
+				reg = <0x02184000 0x200>;
+				interrupts = <0 43 0x04>;
+				fsl,usbphy = <&usbphy1>;
+				status = "disabled";
+			};
+
+			usboh3 at 02184200 { /* USB1 */
+				compatible = "fsl,imx6q-usboh3";
+				reg = <0x02184200 0x200>;
+				interrupts = <0 40 0x04>;
+				fsl,usbphy = <&usbphy2>;
+				status = "disabled";
+			};
+
+			usboh3 at 02184400 { /* USB2 */
+				compatible = "fsl,imx6q-usboh3";
+				reg = <0x02184400 0x200>;
+				interrupts = <0 41 0x04>;
+				status = "disabled";
+			};
+
+			usboh3 at 02184600 { /* USB3 */
+				compatible = "fsl,imx6q-usboh3";
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
