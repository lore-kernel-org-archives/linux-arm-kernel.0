From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Oct 2013 18:27:40 +0200
Subject: [PATCH] ARM: integrator: core module registers from compatible strings
Message-ID: <1381422460-20218-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This augments the core machine code for the Integrator platforms
to get their references to the core module device nodes by
using compatible strings instead of predefined node names
and rename the CP syscon node to be simply "syscon".

Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/arm/arm-boards | 30 ++++++++++++++----------
 arch/arm/boot/dts/integratorap.dts               |  2 +-
 arch/arm/boot/dts/integratorcp.dts               |  4 ++--
 arch/arm/mach-integrator/integrator_ap.c         |  8 ++++++-
 arch/arm/mach-integrator/integrator_cp.c         |  8 ++++++-
 5 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/arm-boards b/Documentation/devicetree/bindings/arm/arm-boards
index 0ebf3d9..5fac246 100644
--- a/Documentation/devicetree/bindings/arm/arm-boards
+++ b/Documentation/devicetree/bindings/arm/arm-boards
@@ -19,18 +19,22 @@ Required nodes:
   - regs: the location and size of the core module registers, one
     range of 0x200 bytes.
 
-- cpcon/syscon: the root node the Integrator/CP must have a /cpcon
-  node pointing to the CP control registers, and the Integrator/AP
-  must have a /syscon node pointing to the Integrator/AP system
-  controller. The AP syscon node must include the logical module
-  interrupts.
-
-In the root node the Integrator/CP must have a /cpcon node pointing
-to the CP control registers, and the Integrator/AP must have a
-/syscon node pointing to the Integrator/AP system controller.
-The AP syscon node must include the logic module interrupts, stated
-in order of module instance <module 0, module 1, module 2 ...>
-example:
+- syscon: the root node of the Integrator platforms must have a
+  system controller node pointong to the control registers,
+  with the compatible string
+  "arm,integrator-ap-syscon"
+  "arm,integrator-cp-syscon"
+  respectively.
+
+  Required properties for the system controller:
+  - regs: the location and size of the system controller registers,
+    one range of 0x100 bytes.
+
+  Required properties for the AP system controller:
+  - interrupts: the AP syscon node must include the logical module
+    interrupts, stated in order of module instance <module 0>,
+    <module 1>, <module 2> ... for the CP system controller this
+    is not required not of any use.
 
 /dts-v1/;
 /include/ "integrator.dtsi"
@@ -45,7 +49,7 @@ example:
 	};
 
 	syscon {
-		/* AP system controller registers */
+		compatible = "arm,integrator-ap-syscon";
 		reg = <0x11000000 0x100>;
 		interrupt-parent = <&pic>;
 		/* These are the logic module IRQs */
diff --git a/arch/arm/boot/dts/integratorap.dts b/arch/arm/boot/dts/integratorap.dts
index 453ab0e..e6be931 100644
--- a/arch/arm/boot/dts/integratorap.dts
+++ b/arch/arm/boot/dts/integratorap.dts
@@ -19,7 +19,7 @@
 	};
 
 	syscon {
-		/* AP system controller registers */
+		compatible = "arm,integrator-ap-syscon";
 		reg = <0x11000000 0x100>;
 		interrupt-parent = <&pic>;
 		/* These are the logical module IRQs */
diff --git a/arch/arm/boot/dts/integratorcp.dts b/arch/arm/boot/dts/integratorcp.dts
index ff1aea0..a3a06b8 100644
--- a/arch/arm/boot/dts/integratorcp.dts
+++ b/arch/arm/boot/dts/integratorcp.dts
@@ -18,8 +18,8 @@
 		bootargs = "root=/dev/ram0 console=ttyAMA0,38400n8 earlyprintk";
 	};
 
-	cpcon {
-		/* CP controller registers */
+	syscon {
+		compatible = "arm,integrator-cp-syscon";
 		reg = <0xcb000000 0x100>;
 	};
 
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index ece4755..d50dc2d 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -470,6 +470,11 @@ static struct of_dev_auxdata ap_auxdata_lookup[] __initdata = {
 	{ /* sentinel */ },
 };
 
+static const struct of_device_id ap_syscon_match[] = {
+	{ .compatible = "arm,integrator-ap-syscon"},
+	{ },
+};
+
 static void __init ap_init_of(void)
 {
 	unsigned long sc_dec;
@@ -486,7 +491,8 @@ static void __init ap_init_of(void)
 	root = of_find_node_by_path("/");
 	if (!root)
 		return;
-	syscon = of_find_node_by_path("/syscon");
+
+	syscon = of_find_matching_node(root, ap_syscon_match);
 	if (!syscon)
 		return;
 
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 422c3f9..1df6e76 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -286,6 +286,11 @@ static struct of_dev_auxdata intcp_auxdata_lookup[] __initdata = {
 	{ /* sentinel */ },
 };
 
+static const struct of_device_id intcp_syscon_match[] = {
+	{ .compatible = "arm,integrator-cp-syscon"},
+	{ },
+};
+
 static void __init intcp_init_of(void)
 {
 	struct device_node *root;
@@ -300,7 +305,8 @@ static void __init intcp_init_of(void)
 	root = of_find_node_by_path("/");
 	if (!root)
 		return;
-	cpcon = of_find_node_by_path("/cpcon");
+
+	cpcon = of_find_matching_node(root, intcp_syscon_match);
 	if (!cpcon)
 		return;
 
-- 
1.8.3.1
