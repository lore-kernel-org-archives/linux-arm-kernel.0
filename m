From: tyler@opensourcefoundries.com (tyler at opensourcefoundries.com)
Date: Thu, 30 Nov 2017 12:14:29 -0800
Subject: [PATCH 3/8] ARM: dts: imx7d-cl-som: add nodes for usbh, and usbotg2
In-Reply-To: <20171130201434.14122-1-tyler@opensourcefoundries.com>
References: <20171130201434.14122-1-tyler@opensourcefoundries.com>
Message-ID: <20171130201434.14122-4-tyler@opensourcefoundries.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tyler Baker <tyler@opensourcefoundries.com>

Add device tree nodes for the USB hub, and USB OTG. i2c2 on this
platform supports low state retention power state so lets use it.

Signed-off-by: Tyler Baker <tyler@opensourcefoundries.com>
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 36 +++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index ae45af1..a9f690b 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -30,6 +30,16 @@
 		gpio = <&gpio1 5 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	reg_usbh_nreset: regulator at 4 {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_host_nreset";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pca9555 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
 };
 
 &cpu0 {
@@ -199,6 +209,16 @@
 	status = "okay";
 };
 
+&usbotg2 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbh {
+	vbus-supply = <&reg_usbh_nreset>;
+	status = "okay";
+};
+
 &usdhc3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc3>;
@@ -247,13 +267,6 @@
 		>;
 	};
 
-	pinctrl_i2c2: i2c2grp {
-		fsl,pins = <
-			MX7D_PAD_I2C2_SDA__I2C2_SDA		0x4000007f
-			MX7D_PAD_I2C2_SCL__I2C2_SCL		0x4000007f
-		>;
-	};
-
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
@@ -284,4 +297,11 @@
 			MX7D_PAD_LPSR_GPIO1_IO05__GPIO1_IO5	0x14 /* OTG PWREN */
 		>;
 	};
-};
\ No newline at end of file
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX7D_PAD_LPSR_GPIO1_IO07__I2C2_SDA		0x4000000f
+			MX7D_PAD_LPSR_GPIO1_IO06__I2C2_SCL		0x4000000f
+		>;
+	};
+};
-- 
2.9.3
