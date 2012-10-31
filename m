From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu,  1 Nov 2012 07:04:17 +0800
Subject: [PATCH v3 5/9] document: devicetree: bind pinconf with pin-single
In-Reply-To: <1351724661-29050-1-git-send-email-haojian.zhuang@gmail.com>
References: <1351724661-29050-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1351724661-29050-6-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add comments with pinconf & gpio range in the document of
pinctrl-single.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 .../devicetree/bindings/pinctrl/pinctrl-single.txt |   66 ++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
index 2c81e45..15f4dae 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
@@ -17,6 +17,41 @@ Optional properties:
 - pinctrl-single,bit-per-mux : boolean to indicate that one register controls
   more than one pin
 
+- pinctrl-single,gpio-ranges : gpio range list of phandles.
+  Must be present if gpio range phandle is specified.
+  This property should be existing in .dtsi files for those silicons.
+
+- pinctrl-single,gpio : array with gpio range start, size & register
+  offset. Must be present if gpio range phandle is specified.
+  This property should be existing in .dts files for those boards.
+
+- pinctrl-single,gpio-func : gpio function value in the pinmux register.
+  Must be present if gpio range phandle is specified.
+  This property should be existing in .dts files for those boards.
+
+- pinctrl-single,power-source-mask : mask of setting power source in
+  the pinmux register
+
+- pinctrl-single,power-source : value of setting power source field
+  in the pinmux register
+
+- pinctrl-single,bias-mask : mask of setting bias value in the pinmux
+  register
+
+- pinctrl-single,bias-disable : value of disabling bias in the pinmux
+  register
+
+- pinctrl-single,bias-pull-down : value of setting bias pull down in
+  the pinmux register
+
+- pinctrl-single,bias-pull-up : value of setting bias pull up in the
+  pinmux register
+
+- pinctrl-single,bias : value of setting bias in the pinmux register
+
+- pinctrl-single,input-schmitt-mask : mask of setting input schmitt
+  in the pinmux register
+
 This driver assumes that there is only one register for each pin (unless the
 pinctrl-single,bit-per-mux is set), and uses the common pinctrl bindings as
 specified in the pinctrl-bindings.txt document in this directory.
@@ -42,6 +77,15 @@ Where 0xdc is the offset from the pinctrl register base address for the
 device pinctrl register, 0x18 is the desired value, and 0xff is the sub mask to
 be used when applying this change to the register.
 
+In case pinctrl device supports gpio function, it needs to define gpio range.
+All the phandles of gpio range list should be set in below:
+
+	pinctrl-single,gpio-ranges = <[phandle of gpio range]>;
+
+	[phandle of gpio range]: {
+		pinctrl-single,gpio = <0 55 0x0dc>;
+		pinctrl-single,gpio-func = <0>;
+	};
 Example:
 
 /* SoC common file */
@@ -76,6 +120,28 @@ control_devconf0: pinmux at 48002274 {
 	pinctrl-single,function-mask = <0x5F>;
 };
 
+/* third controller instance for pins in gpio domain */
+pmx_gpio: pinmux at d401e000 {
+	compatible = "pinctrl-single";
+	reg = <0xd401e000 0x0330>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-single,register-width = <32>;
+	pinctrl-single,function-mask = <7>;
+	pinctrl-single,gpio-ranges = <&gpiorange0 &gpiorange1>;
+};
+
+gpiorange0: gpiorange at d401e0dc {
+	pinctrl-single,gpio = <0 55 0x0dc>;
+	pinctrl-single,gpio-func = <0>;
+};
+
+gpiorange1: gpiorange at d401e2f0 {
+	pinctrl-single,gpio = <55 5 0x2f0>;
+	pinctrl-single,gpio-func = <1>;
+};
+
+
 /* board specific .dts file */
 
 &pmx_core {
-- 
1.7.10.4
