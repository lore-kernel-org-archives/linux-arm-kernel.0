From: stefan@agner.ch (Stefan Agner)
Date: Mon, 22 Sep 2014 19:09:25 +0200
Subject: [PATCH 4/9] ARM: dts: vf610-colibri: GPIO power key
In-Reply-To: <cover.1411404079.git.stefan@agner.ch>
References: <cover.1411404079.git.stefan@agner.ch>
Message-ID: <2c2c603ecaae889c93cea081fd6b1f015fa6cf3a.1411404079.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable GPIO power key on pad 41 which is routed to our default
wakeup pin SO-DIMM 45.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf610-colibri-eval-v3.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-colibri-eval-v3.dts b/arch/arm/boot/dts/vf610-colibri-eval-v3.dts
index 7fb3066..e707243 100644
--- a/arch/arm/boot/dts/vf610-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/vf610-colibri-eval-v3.dts
@@ -8,6 +8,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/input/input.h>
 #include "vf610-colibri.dtsi"
 
 / {
@@ -17,6 +18,20 @@
 	chosen {
 		bootargs = "console=ttyLP0,115200";
 	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpiokeys>;
+
+		power {
+			label = "Power";
+			gpios = <&gpio2 9 GPIO_ACTIVE_HIGH>;
+			linux,code = <KEY_POWER>;
+			debounce-interval = <10>;
+			gpio-key,wakeup;
+		};
+	};
 };
 
 &esdhc1 {
@@ -44,3 +59,14 @@
 &uart2 {
 	status = "okay";
 };
+
+
+&iomuxc {
+	vf610-colibri {
+		pinctrl_gpiokeys: gpiokeys {
+			fsl,pins = <
+				VF610_PAD_PTB19__GPIO_41	0x219d
+			>;
+		};
+	};
+};
-- 
2.1.0
