From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Wed, 13 Dec 2017 11:32:16 +0100
Subject: [PATCH v2 2/5] arm64: dts: rockchip: add extcon nodes and enable
 tcphy.
In-Reply-To: <20171213103219.1464-1-enric.balletbo@collabora.com>
References: <20171213103219.1464-1-enric.balletbo@collabora.com>
Message-ID: <20171213103219.1464-2-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable tcphy and create the cros-ec's extcon node for the USB Type-C port.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
---
Changes since v1:
 - Add the Reviewed-by: Brian Norris

 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 470105d..03f1950 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -855,6 +855,20 @@ ap_i2c_audio: &i2c8 {
 			compatible = "google,cros-ec-pwm";
 			#pwm-cells = <1>;
 		};
+
+		usbc_extcon0: extcon at 0 {
+			compatible = "google,extcon-usbc-cros-ec";
+			google,usb-port-id = <0>;
+
+			#extcon-cells = <0>;
+		};
+
+		usbc_extcon1: extcon at 1 {
+			compatible = "google,extcon-usbc-cros-ec";
+			google,usb-port-id = <1>;
+
+			#extcon-cells = <0>;
+		};
 	};
 };
 
@@ -865,6 +879,16 @@ ap_i2c_audio: &i2c8 {
 	rockchip,hw-tshut-polarity = <1>; /* tshut polarity 0:LOW 1:HIGH */
 };
 
+&tcphy0 {
+	status = "okay";
+	extcon = <&usbc_extcon0>;
+};
+
+&tcphy1 {
+	status = "okay";
+	extcon = <&usbc_extcon1>;
+};
+
 &u2phy0 {
 	status = "okay";
 };
@@ -911,6 +935,7 @@ ap_i2c_audio: &i2c8 {
 
 &usbdrd3_0 {
 	status = "okay";
+	extcon = <&usbc_extcon0>;
 };
 
 &usbdrd_dwc3_0 {
@@ -920,6 +945,7 @@ ap_i2c_audio: &i2c8 {
 
 &usbdrd3_1 {
 	status = "okay";
+	extcon = <&usbc_extcon1>;
 };
 
 &usbdrd_dwc3_1 {
-- 
2.9.3
