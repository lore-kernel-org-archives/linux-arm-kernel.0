From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 10 Jan 2017 01:22:31 +0000
Subject: [PATCH 1/3] arm64: dts: Pine64: add MMC support
In-Reply-To: <1484011353-21480-1-git-send-email-andre.przywara@arm.com>
References: <1484011353-21480-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1484011353-21480-2-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All Pine64 boards connect an micro-SD card slot to the first MMC
controller.
Enable the respective DT node and specify the (always-on) regulator
and card-detect pin.
As a micro-SD slot does not feature a write-protect switch, we disable
this feature.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index cf91051..c680ed3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -44,6 +44,8 @@
 
 #include "sun50i-a64.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "Pine64";
 	compatible = "pine64,pine64", "allwinner,sun50i-a64";
@@ -55,6 +57,13 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	reg_vcc3v3: vcc3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 };
 
 &ehci1 {
@@ -71,6 +80,17 @@
 	bias-pull-up;
 };
 
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins>;
+	vmmc-supply = <&reg_vcc3v3>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
+	cd-inverted;
+	disable-wp;
+	bus-width = <4>;
+	status = "okay";
+};
+
 &ohci1 {
 	status = "okay";
 };
-- 
2.8.2
