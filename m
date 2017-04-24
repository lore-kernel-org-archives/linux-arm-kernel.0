From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 24 Apr 2017 21:01:12 +0800
Subject: [PATCH 1/2] dt-bindings: add bindings doc for ZTE pinctrl
In-Reply-To: <1493038873-18354-1-git-send-email-shawnguo@kernel.org>
References: <1493038873-18354-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1493038873-18354-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

It adds device tree bindings for ZTE pin controller found on ZX2967xx
family SoCs.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../devicetree/bindings/pinctrl/pinctrl-zx.txt     | 85 ++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-zx.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-zx.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-zx.txt
new file mode 100644
index 000000000000..e219849b21ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-zx.txt
@@ -0,0 +1,85 @@
+* ZTE ZX Pin Controller
+
+The pin controller on ZTE ZX platforms is kinda of hybrid.  It consists of
+a main controller and an auxiliary one.  For example, on ZX296718 SoC, the
+main controller is TOP_PMM and the auxiliary one is AON_IOCFG.  Both
+controllers work together to control pin multiplexing and configuration in
+the way illustrated as below.
+
+
+           GMII_RXD3 ---+
+                        |
+             DVI1_HS ---+----------------------------- GMII_RXD3 (TOP pin)
+                        |
+             BGPIO16 ---+                               ^
+                                                        | pinconf
+                        ^                               |
+                        | pinmux                        |
+                        |                               |
+
+                   TOP_PMM (main)           AON_IOCFG (aux)
+
+                        |                       |       |
+                        |                pinmux |       |
+                        | pinmux                v       |
+                        v                               | pinconf
+                                    KEY_ROW2 ---+       v
+        PORT1_LCD_TE ---+                       |
+                        |            AGPIO10 ---+------ KEY_ROW2 (AON pin)
+          I2S0_DOUT3 ---+                       |
+                        |-----------------------+
+            PWM_OUT3 ---+
+                        |
+             VGA_VS1 ---+
+
+
+For most of pins like GMII_RXD3 in the figure, the pinmux function is
+controlled by TOP_PMM block only, and this type of pins are meant by term
+'TOP pins'.  For pins like KEY_ROW2, the pinmux is controlled by both
+TOP_PMM and AON_IOCFG blocks, as the available multiplexing functions for
+the pin spread in both controllers.  This type of pins are called 'AON pins'.
+Though pinmux implementation is quite different, pinconf is same for both
+types of pins.  Both are controlled by auxiliary controller, i.e. AON_IOCFG
+on ZX296718.
+
+Required properties:
+- compatible: should be "zte,zx296718-pmm".
+- reg: the register physical address and length.
+- zte,auxiliary-controller: phandle to the auxiliary pin controller which
+  implements pinmux for AON pins and pinconf for all pins.
+
+The following pin configuration are supported. Please refer to
+pinctrl-bindings.txt in this directory for more details of the common
+pinctrl bindings used by client devices.
+
+- bias-pull-up
+- bias-pull-down
+- drive-strength
+- input-enable
+- slew-rate
+
+Examples:
+
+iocfg: pin-controller at 119000 {
+	compatible = "zte,zx296718-iocfg";
+	reg = <0x119000 0x1000>;
+};
+
+pmm: pin-controller at 1462000 {
+	compatible = "zte,zx296718-pmm";
+	reg = <0x1462000 0x1000>;
+	zte,auxiliary-controller = <&iocfg>;
+};
+
+&pmm {
+	vga_pins: vga {
+		pins = "KEY_COL1", "KEY_COL2", "KEY_ROW1", "KEY_ROW2";
+		function = "VGA";
+	};
+};
+
+&vga {
+	pinctrl-names = "default";
+	pinctrl-0 = <&vga_pins>;
+	status = "okay";
+};
-- 
1.9.1
