From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 21 May 2014 10:23:20 +0200
Subject: [PATCH v2] ARM: sun6i: Add MMC0 controller to the Colombus board
Message-ID: <1400660600-29015-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Colombus has a full size SD slot wired to the MMC0 controller. In order to
work, the MMC lines have to have the pull-ups enabled though.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
Changes from v1:
  - Deduplicated MMC pins

 arch/arm/boot/dts/sun6i-a31-colombus.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-colombus.dts b/arch/arm/boot/dts/sun6i-a31-colombus.dts
index 3898a7bce831..229e7922e4ec 100644
--- a/arch/arm/boot/dts/sun6i-a31-colombus.dts
+++ b/arch/arm/boot/dts/sun6i-a31-colombus.dts
@@ -13,6 +13,7 @@
 
 /dts-v1/;
 /include/ "sun6i-a31.dtsi"
+/include/ "sunxi-common-regulators.dtsi"
 
 / {
 	model = "WITS A31 Colombus Evaluation Board";
@@ -23,6 +24,29 @@
 	};
 
 	soc at 01c00000 {
+		mmc0: mmc at 01c0f000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_colombus>;
+			vmmc-supply = <&reg_vcc3v0>;
+			bus-width = <4>;
+			cd-gpios = <&pio 0 8 0>; /* PA8 */
+			cd-inverted;
+			status = "okay";
+		};
+
+		pio: pinctrl at 01c20800 {
+			mmc0_pins_a: mmc0 at 0 {
+				allwinner,pull = <1>;
+			};
+
+			mmc0_cd_pin_colombus: mmc0_cd_pin at 0 {
+				allwinner,pins = "PA8";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <0>;
+				allwinner,pull = <1>;
+			};
+		};
+
 		uart0: serial at 01c28000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart0_pins_a>;
-- 
1.9.3
