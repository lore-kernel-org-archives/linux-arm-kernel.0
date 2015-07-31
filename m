From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 31 Jul 2015 17:41:52 +0200
Subject: [PATCH] ARM: dts: sun7i: Change cubietruck wifi enable pin to use
 mmc-pwrseq
Message-ID: <1438357312-17378-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The wifi-enable pin of the ap6210 module is not really a regulator,
switch to the mmc-pwrseq framework for controlling it. This more
accurately reflects how the hardware actually works.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index de3e195..0b2f914 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -88,15 +88,11 @@
 		};
 	};
 
-	reg_vmmc3: vmmc3 {
-		compatible = "regulator-fixed";
+	mmc3_pwrseq: mmc3_pwrseq {
+		compatible = "mmc-pwrseq-simple";
 		pinctrl-names = "default";
 		pinctrl-0 = <&vmmc3_pin_cubietruck>;
-		regulator-name = "vmmc3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		enable-active-high;
-		gpio = <&pio 7 9 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&pio 7 9 GPIO_ACTIVE_LOW>; /* PH9 WIFI_EN */
 	};
 };
 
@@ -179,7 +175,8 @@
 &mmc3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc3_pins_a>;
-	vmmc-supply = <&reg_vmmc3>;
+	vmmc-supply = <&reg_vcc3v3>;
+	mmc-pwrseq = <&mmc3_pwrseq>;
 	bus-width = <4>;
 	non-removable;
 	status = "okay";
-- 
2.4.3
