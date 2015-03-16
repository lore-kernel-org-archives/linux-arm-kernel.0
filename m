From: george.joseph@fairview5.com (George Joseph)
Date: Mon, 16 Mar 2015 14:36:41 -0600
Subject: [PATCH] dts: cubox: Map gpio-keys and pps-gpio to gpio3 8
Message-ID: <1426538201-7571-1-git-send-email-george.joseph@fairview5.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cubox has a recessed button between the HDMI and RJ-45 connectors
that wasn't mapped in the device tree.  Since the button is normally
open and there's no external pull up/down, that pad (EIM_DA8) can be
used for almost anything so I've mapped it to gpio-keys BTN_0 and
pps-gpio.  Whichever driver claims it first wins.  If both drivers
are build as modules, you can even switch between them at run time
and the pinmux will adjust the pin configuration as required.
If neither driver claims the gpio, it's still available in the normal
gpio sysfs.

Signed-off-by: George Joseph <george.joseph@fairview5.com>
Tested-by: George Joseph <george.joseph@fairview5.com>
---
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
index 6a524ca..7479fb6 100644
--- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -3,6 +3,8 @@
  */
 #include "imx6qdl-microsom.dtsi"
 #include "imx6qdl-microsom-ar8035.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	ir_recv: ir-receiver {
@@ -66,6 +68,26 @@
 		spdif-controller = <&spdif>;
 		spdif-out;
 	};
+
+	pps {
+		compatible = "pps-gpio";
+		pinctrl-0 = <&pinctrl_gpio_pps>;
+		pinctrl-names = "default";
+		gpios = <&gpio3 8 0>;
+		interrupt-parent = <&intc>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&pinctrl_gpio_key>;
+		pinctrl-names = "default";
+
+		button_0 {
+			label = "Button 0";
+			gpios = <&gpio3 8 GPIO_ACTIVE_LOW>;
+			linux,code = <BTN_0>;
+		};
+	};
 };
 
 &hdmi {
@@ -170,6 +192,18 @@
 				MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x13059
 			>;
 		};
+
+		pinctrl_gpio_pps: gpio-pps {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_DA8__GPIO3_IO08	0x130c1
+			>;
+		};
+
+		pinctrl_gpio_key: gpio-key {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_DA8__GPIO3_IO08	0x17059
+			>;
+		};
 	};
 };
 
-- 
2.1.0
