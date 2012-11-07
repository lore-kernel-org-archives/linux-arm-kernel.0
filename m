From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed,  7 Nov 2012 23:19:38 +0800
Subject: [PATCH v4 5/9] document: devicetree: bind pinconf with pin-single
In-Reply-To: <1352301582-12244-1-git-send-email-haojian.zhuang@gmail.com>
References: <1352301582-12244-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1352301582-12244-6-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add comments with pinconf & gpio range in the document of
pinctrl-single.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 .../devicetree/bindings/pinctrl/pinctrl-single.txt |   67 +++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
index 2c81e45..0b8705f 100644
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
 
@@ -14,9 +16,33 @@ Optional properties:
 - pinctrl-single,function-off : function off mode for disabled state if
   available and same for all registers; if not specified, disabling of
   pin functions is ignored
+
 - pinctrl-single,bit-per-mux : boolean to indicate that one register controls
   more than one pin
 
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
@@ -42,6 +68,25 @@ Where 0xdc is the offset from the pinctrl register base address for the
 device pinctrl register, 0x18 is the desired value, and 0xff is the sub mask to
 be used when applying this change to the register.
 
+
+Optional sub-node: In case some pins could be configured as GPIO in the pinmux
+register. If both GPIO nubmer and pin base of those pins are in ascending order,
+those pins could be defined as a GPIO range. The sub-node should be defined in
+.dtsi files of those silicons.
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
@@ -76,6 +121,26 @@ control_devconf0: pinmux at 48002274 {
 	pinctrl-single,function-mask = <0x5F>;
 };
 
+/* third controller instance for pins in gpio domain */
+pmx_gpio: pinmux at d401e000 {
+	compatible = "pinctrl-single";
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
-- 
1.7.10.4
