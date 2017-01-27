From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 27 Jan 2017 22:38:43 +0100
Subject: [PATCH v5 11/13] arm64: allwinner: pine64: add MMC support
In-Reply-To: <cover.6f3d82744628848e2182720c35f13e87e8b62258.1485553113.git-series.maxime.ripard@free-electrons.com>
References: <cover.6f3d82744628848e2182720c35f13e87e8b62258.1485553113.git-series.maxime.ripard@free-electrons.com>
Message-ID: <f5f71a373a789314c64baf7b6d7bbce9fb2d68c8.1485553113.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

All Pine64 boards connect an micro-SD card slot to the first MMC
controller.
Enable the respective DT node and specify the (always-on) regulator
and card-detect pin.
As a micro-SD slot does not feature a write-protect switch, we disable
this feature.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 20 ++++++++++++++-
 1 file changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index cf9105179bcb..c680ed385da3 100644
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
git-series 0.8.11
