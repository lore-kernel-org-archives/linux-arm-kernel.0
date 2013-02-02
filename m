From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sun,  3 Feb 2013 01:25:53 +0800
Subject: [PATCH v8 12/12] document: devicetree: bind pinconf with pin single
In-Reply-To: <1359825953-15663-1-git-send-email-haojian.zhuang@linaro.org>
References: <1359825953-15663-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1359825953-15663-13-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Haojian Zhuang <haojian.zhuang@gmail.com>

Add comments with pinconf & gpio range in the document of
pinctrl-single.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 .../devicetree/bindings/pinctrl/pinctrl-single.txt |  108 +++++++++++++++++++-
 1 file changed, 107 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
index 2c81e45..eeb2e93 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
@@ -1,7 +1,9 @@
 One-register-per-pin type device tree based pinctrl driver
 
 Required properties:
-- compatible : "pinctrl-single"
+- compatible : "pinctrl-single" or "pinconf-single".
+  "pinctrl-single" means that pinconf isn't supported.
+  "pinconf-single" means that generic pinconf is supported.
 
 - reg : offset and length of the register set for the mux registers
 
@@ -14,9 +16,61 @@ Optional properties:
 - pinctrl-single,function-off : function off mode for disabled state if
   available and same for all registers; if not specified, disabling of
   pin functions is ignored
+
 - pinctrl-single,bit-per-mux : boolean to indicate that one register controls
   more than one pin
 
+- pinctrl-single,drive-strength : array of value that are used to configure
+  drive strength in the pinmux register. They're value of drive strength
+  current and drive strength mask.
+
+		/* drive strength current, mask */
+		pinctrl-single,power-source = <0x30 0xf0>;
+
+- pinctrl-single,bias-disable : array of value that are used to configure the
+  input bias disabled in the pinmux register. They're value of bias value,
+  match bias disabled value and bias disabled mask.
+
+		/* bias value, match bias disabled value, mask */
+		pinctrl-single,bias-disable = <2 0 3>;
+
+- pinctrl-single,bias-pullup : array of value that are used to configure the
+  input bias pullup in the pinmux register. They're value of bias value,
+  match bias pullup value and bias pullup mask.
+
+		/* bias value, match bias pullup value, mask */
+		pinctrl-single,bias-pullup = <0 1 1>;
+
+- pinctrl-single,bias-pulldown : array of value that are used to configure the
+  input bias pulldown in the pinmux register. They're value of bias value,
+  match bias pulldown value and bias pulldown mask.
+
+		/* bias value, match bias pulldown value, mask */
+		pinctrl-single,bias-pulldown = <2 2 2>;
+
+- pinctrl-single,input-schmitt : array of value that are used to configure
+  input schmitt in the pinmux register. In some silicons, there're two input
+  schmitt value (rising-edge & falling-edge) in the pinmux register.
+
+		/* input schmitt value, mask */
+		pinctrl-single,input-schmitt = <0x30 0x70>;
+
+- pinctrl-single,input-schmitt-disable : array of value that are used to
+  configure input schmitt disabled in the pinmux register. They're value of
+  input schmitt field, match disable value & mask.
+
+		/* input schmitt value, match disable value, mask */
+		pinctrl-single,input-schmitt-disable = <0x30 0x40 0x70>;
+
+- pinctrl-single,gpio-range : list of value that are used to configure a GPIO
+  range. They're value of subnode phandle, pin base in pinctrl device, pin
+  number in this range, GPIO function value of this GPIO range.
+  The number of parameters is depend on #pinctrl-single,gpio-range-cells
+  property.
+
+		/* pin base, nr pins & gpio function */
+		pinctrl-single,gpio-range = <&range 0 3 0 &range 3 9 1>;
+
 This driver assumes that there is only one register for each pin (unless the
 pinctrl-single,bit-per-mux is set), and uses the common pinctrl bindings as
 specified in the pinctrl-bindings.txt document in this directory.
@@ -42,6 +96,20 @@ Where 0xdc is the offset from the pinctrl register base address for the
 device pinctrl register, 0x18 is the desired value, and 0xff is the sub mask to
 be used when applying this change to the register.
 
+
+Optional sub-node: In case some pins could be configured as GPIO in the pinmux
+register, those pins could be defined as a GPIO range. This sub-node is required
+by pinctrl-single,gpio-range property.
+
+Required properties in sub-node:
+- #pinctrl-single,gpio-range-cells : the number of parameters after phandle in
+  pinctrl-single,gpio-range property.
+
+	range: gpio-range {
+		#pinctrl-single,gpio-range-cells = <3>;
+	};
+
+
 Example:
 
 /* SoC common file */
@@ -76,6 +144,29 @@ control_devconf0: pinmux at 48002274 {
 	pinctrl-single,function-mask = <0x5F>;
 };
 
+/* third controller instance for pins in gpio domain */
+pmx_gpio: pinmux at d401e000 {
+	compatible = "pinconf-single";
+	reg = <0xd401e000 0x0330>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges;
+
+	pinctrl-single,register-width = <32>;
+	pinctrl-single,function-mask = <7>;
+
+	/* sparse GPIO range could be supported */
+	pinctrl-single,gpio-range = <&range 0 3 0 &range 3 9 1
+				&range 12 1 0 &range 13 29 1
+				&range 43 1 0 &range 44 49 1
+				&range 94 1 1 &range 96 2 1>;
+
+	range: gpio-range {
+		#pinctrl-single,gpio-range-cells = <3>;
+	};
+};
+
+
 /* board specific .dts file */
 
 &pmx_core {
@@ -96,6 +187,16 @@ control_devconf0: pinmux at 48002274 {
 		>;
 	};
 
+	uart0_pins: pinmux_uart0_pins {
+		pinctrl-single,pins = <
+			0x208 0		/* UART0_RXD (IOCFG138) */
+			0x20c 0		/* UART0_TXD (IOCFG139) */
+		>;
+		pinctrl-single,bias-pulldown = <0 2 2>;
+		pinctrl-single,bias-pullup = <0 1 1>;
+		pinctrl-single,bias-disable = <0 0 3>;
+	};
+
 	/* map uart2 pins */
 	uart2_pins: pinmux_uart2_pins {
 		pinctrl-single,pins = <
@@ -122,6 +223,11 @@ control_devconf0: pinmux@48002274 {
 
 };
 
+&uart1 {
+       pinctrl-names = "default";
+       pinctrl-0 = <&uart0_pins>;
+};
+
 &uart2 {
        pinctrl-names = "default";
        pinctrl-0 = <&uart2_pins>;
-- 
1.7.10.4
