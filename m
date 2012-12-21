From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 21 Dec 2012 17:45:15 +0800
Subject: [PATCH v6 5/8] document: devicetree: bind pinconf with pin single
In-Reply-To: <1356083118-18857-1-git-send-email-haojian.zhuang@linaro.org>
References: <1356083118-18857-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1356083118-18857-6-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Haojian Zhuang <haojian.zhuang@gmail.com>

Add comments with pinconf & gpio range in the document of
pinctrl-single.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 .../devicetree/bindings/pinctrl/pinctrl-single.txt |   82 +++++++++++++++++++-
 1 file changed, 81 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
index 2c81e45..7d1d4b2 100644
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
 
@@ -14,9 +16,31 @@ Optional properties:
 - pinctrl-single,function-off : function off mode for disabled state if
   available and same for all registers; if not specified, disabling of
   pin functions is ignored
+
 - pinctrl-single,bit-per-mux : boolean to indicate that one register controls
   more than one pin
 
+- pinctrl-single,power-source : array of value that are used to configure
+  power source in the pinmux register. They're value of power source field
+  and power source mask.
+
+		/* power source, mask */
+		pinctrl-single,power-source = <0x1000 0x1800>;
+
+- pinctrl-single,bias : array of value that are used to configure the input
+  bias in the pinmux register.  They're value of bias field, bias mask,
+  bias disable value, bias pull down value & bias pull up value.
+
+		/* bias, mask, disable, pull down, pull up */
+		pinctrl-single,bias = <0xc000 0xe000 0 0xa000 0xc000>;
+
+- pinctrl-single,input-schmitt : array of value that are used to configure
+  input schmitt in the pinmux register. They're value of input schmitt field,
+  mask, & disable value.
+
+		/* input schmitt value, mask, disable */
+		pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+
 This driver assumes that there is only one register for each pin (unless the
 pinctrl-single,bit-per-mux is set), and uses the common pinctrl bindings as
 specified in the pinctrl-bindings.txt document in this directory.
@@ -42,6 +66,24 @@ Where 0xdc is the offset from the pinctrl register base address for the
 device pinctrl register, 0x18 is the desired value, and 0xff is the sub mask to
 be used when applying this change to the register.
 
+
+Optional sub-node: In case some pins could be configured as GPIO in the pinmux
+register, those pins could be defined as a GPIO range. The sub-node should
+be defined in .dtsi files of those silicons.
+
+Required properties in sub-node:
+- reg : offset and length of the GPIO range sub-node.
+
+- pinctrl-single,gpio : array of GPIO base number in the range and the GPIO
+  function in the pinmux register.
+
+	range0: {
+		/* GPIO0 ~ GPIO54 */
+		reg = <0xd401e0dc 55>;
+		pinctrl-single,gpio = <0 0>;
+	};
+
+
 Example:
 
 /* SoC common file */
@@ -76,6 +118,26 @@ control_devconf0: pinmux at 48002274 {
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
+	range0: range at d401e0dc {
+		/* GPIO0 ~ GPIO54 */
+		reg = <0xd401e0dc 0xdc>;
+		/* gpio base & gpio func */
+		pinctrl-single,gpio = <0 0>;
+	};
+};
+
+
 /* board specific .dts file */
 
 &pmx_core {
@@ -96,6 +158,19 @@ control_devconf0: pinmux at 48002274 {
 		>;
 	};
 
+	uart1_pins: pinmux_uart1_pins {
+		pinctrl-single,pins = <
+			0x198 0x6	/* GPIO47_UART1_RXD */
+			0x19c 0x6	/* GPIO48_UART1_TXD */
+		>;
+		/* power source, mask */
+		pinctrl-single,power-source = <0x1000 0x1800>;
+		/* bias, mask, disable, pull down, pull up */
+		pinctrl-single,bias = <0xc000 0xe000 0 0xa000 0xc000>;
+		/* input schmitt, mask, disable */
+		pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+	};
+
 	/* map uart2 pins */
 	uart2_pins: pinmux_uart2_pins {
 		pinctrl-single,pins = <
@@ -122,6 +197,11 @@ control_devconf0: pinmux@48002274 {
 
 };
 
+&uart1 {
+       pinctrl-names = "default";
+       pinctrl-0 = <&uart1_pins>;
+};
+
 &uart2 {
        pinctrl-names = "default";
        pinctrl-0 = <&uart2_pins>;
-- 
1.7.10.4
