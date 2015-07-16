From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Fri, 17 Jul 2015 04:03:16 +0800
Subject: [PATCH 1/1] ARM: dts: imx6ul: add usb host and function support
Message-ID: <1437076996-1194-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

Enable usb host and function driver

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/boot/dts/imx6ul-14x14-evk.dts | 11 +++++++++++
 arch/arm/boot/dts/imx6ul.dtsi          | 27 +++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
index 61b41ee..3d676ef 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
@@ -57,6 +57,17 @@
 	status = "okay";
 };
 
+&usbotg1 {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	disable-over-current;
+	status = "okay";
+};
+
 &usdhc1 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1>;
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index f0cfc64..61507ef 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -511,6 +511,33 @@
 			reg = <0x02100000 0x100000>;
 			ranges;
 
+			usbotg1: usb at 02184000 {
+				compatible = "fsl,imx6ul-usb", "fsl,imx27-usb";
+				reg = <0x02184000 0x200>;
+				interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_USBOH3>;
+				fsl,usbphy = <&usbphy1>;
+				fsl,usbmisc = <&usbmisc 0>;
+				fsl,anatop = <&anatop>;
+				status = "disabled";
+			};
+
+			usbotg2: usb at 02184200 {
+				compatible = "fsl,imx6ul-usb", "fsl,imx27-usb";
+				reg = <0x02184200 0x200>;
+				interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_USBOH3>;
+				fsl,usbphy = <&usbphy2>;
+				fsl,usbmisc = <&usbmisc 1>;
+				status = "disabled";
+			};
+
+			usbmisc: usbmisc at 02184800 {
+				#index-cells = <1>;
+				compatible = "fsl,imx6ul-usbmisc", "fsl,imx6q-usbmisc";
+				reg = <0x02184800 0x200>;
+			};
+
 			usdhc1: usdhc at 02190000 {
 				compatible = "fsl,imx6ul-usdhc", "fsl,imx6sx-usdhc";
 				reg = <0x02190000 0x4000>;
-- 
1.9.1
