From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 10 Aug 2013 10:49:58 +0400
Subject: [PATCH] ARM: dts: imx27-phytec-phycore-rdk: Add DT nodes for camera
 module
Message-ID: <1376117398-19080-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds PCA9536 device on first I2C bus (this device is
used on camera addon module to enable CSI bus muxing) and GPIO to
enable camera interface for Phytec PCM-970 RDK.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
index 0fc6551..e93c968 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
@@ -12,6 +12,25 @@
 / {
 	model = "Phytec pcm970";
 	compatible = "phytec,imx27-pcm970", "phytec,imx27-pcm038", "fsl,imx27";
+
+	cameramux: fixedregulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "CAM_MUX";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		gpio = <&camgpio 0 0>;
+		vin-supply = <&csi_en>;
+	};
+
+	csi_en: fixedregulator at 1 {
+		compatible = "regulator-fixed";
+		regulator-name = "CSI_EN";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 24 0>;
+		vin-supply = <&vcam_reg>;
+	};
 };
 
 &cspi1 {
@@ -19,6 +38,18 @@
 	cs-gpios = <&gpio4 28 0>, <&gpio4 27 0>;
 };
 
+&i2c1 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	camgpio: pca9536 at 41 {
+		compatible = "nxp,pca9536";
+		reg = <0x41>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
 &sdhci2 {
 	bus-width = <4>;
 	cd-gpios = <&gpio3 29 0>;
-- 
1.8.1.5
