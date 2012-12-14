From: Barry.Song@csr.com (Barry Song)
Date: Fri, 14 Dec 2012 15:24:01 +0800
Subject: [PATCH] pinctrl: sirf: add missing DT-binding document
Message-ID: <1355469841-24457-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

While sending email to Linus for reviewing:
"pinctrl: sirf: add DT-binding pinmux mapping support"
https://patchwork.kernel.org/patch/1364361/

i have included the devicetree/bindings/pinctrl/pinctrl-sirf.txt

But while sending pull request with commit 056876f6c73406c,
i missed the document.

this patch takes the document back.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 .../devicetree/bindings/pinctrl/pinctrl-sirf.txt   |   44 ++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-sirf.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-sirf.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-sirf.txt
new file mode 100644
index 0000000..a2896df
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-sirf.txt
@@ -0,0 +1,44 @@
+CSR SiRFprimaII pinmux controller
+
+Required properties:
+- compatible	: "sirf,prima2-pinctrl"
+- reg		: Address range of the pinctrl registers
+- interrupts    : Interrupts used by every GPIO group
+- gpio-controller : Indicates this device is a GPIO controller
+- interrupt-controller  : Marks the device node as an interrupt controller
+
+Please refer to pinctrl-bindings.txt in this directory for details of the common
+pinctrl bindings used by client devices.
+
+SiRFprimaII's pinmux nodes act as a container for an abitrary number of subnodes.
+Each of these subnodes represents some desired configuration for a group of pins.
+
+Required subnode-properties:
+- sirf,pins : An array of strings. Each string contains the name of a group.
+- sirf,function: A string containing the name of the function to mux to the
+  group.
+
+  Valid values for group and function names can be found from looking at the
+  group and function arrays in driver files:
+  drivers/pinctrl/pinctrl-sirf.c
+
+For example, pinctrl might have subnodes like the following:
+ uart2_pins_a: uart2 at 0 {
+         uart {
+                 sirf,pins = "uart2grp";
+                 sirf,function = "uart2";
+         };
+ };
+ uart2_noflow_pins_a: uart2 at 1 {
+         uart {
+                 sirf,pins = "uart2_nostreamctrlgrp";
+                 sirf,function = "uart2_nostreamctrl";
+         };
+ };
+
+For a specific board, if it wants to use uart2 without hardware flow control,
+it can add the following to its board-specific .dts file.
+uart2: uart at 0xb0070000 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_noflow_pins_a>;
+}
-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
