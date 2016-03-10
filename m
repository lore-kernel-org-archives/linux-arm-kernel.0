From: stefan@agner.ch (Stefan Agner)
Date: Wed,  9 Mar 2016 18:16:44 -0800
Subject: [PATCH 03/18] ARM: dts: vf610-colibri: GPIO wakeup key
In-Reply-To: <1457576219-7971-1-git-send-email-stefan@agner.ch>
References: <1457576219-7971-1-git-send-email-stefan@agner.ch>
Message-ID: <1457576219-7971-4-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable GPIO wakeup key on Vybrid PAD 41 which is routed to the
Colibri default wakeup pin SO-DIMM 45.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
index 4d8b7f6..936ece6 100644
--- a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
@@ -39,6 +39,8 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <dt-bindings/input/input.h>
+
 / {
 	chosen {
 		stdout-path = "serial0:115200n8";
@@ -74,6 +76,20 @@
 		gpio = <&gpio2 19 GPIO_ACTIVE_LOW>; /* USBH_PEN resp. USBH_P_EN */
 		vin-supply = <&reg_5v0>;
 	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpiokeys>;
+
+		power {
+			label = "Wake-Up";
+			gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
+			linux,code = <KEY_WAKEUP>;
+			debounce-interval = <10>;
+			gpio-key,wakeup;
+		};
+	};
 };
 
 &bl {
@@ -157,5 +173,11 @@
 				VF610_PAD_PTB21__GPIO_43	0x22ed
 			>;
 		};
+
+		pinctrl_gpiokeys: gpiokeys {
+			fsl,pins = <
+				VF610_PAD_PTB19__GPIO_41	0x218d
+			>;
+		};
 	};
 };
-- 
2.7.2
