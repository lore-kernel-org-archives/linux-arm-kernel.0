From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  3 Oct 2013 18:02:57 +0200
Subject: [PATCH 1/6] ARM: integrator: get the LM interrupts from DT
Message-ID: <1380816177-3046-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OF/DT boot path needs to get the LM (Logical Module)
IRQs from the device tree for coherency. This augments the
DT syscon node to contain these IRQs and alter the DT LM
code to get them from there.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/arm/arm-boards | 20 ++++++++++++++++++++
 arch/arm/boot/dts/integratorap.dts               |  3 +++
 arch/arm/mach-integrator/integrator_ap.c         |  2 +-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/arm-boards b/Documentation/devicetree/bindings/arm/arm-boards
index db5858e..06e5370 100644
--- a/Documentation/devicetree/bindings/arm/arm-boards
+++ b/Documentation/devicetree/bindings/arm/arm-boards
@@ -9,9 +9,29 @@ Required properties (in root node):
 
 FPGA type interrupt controllers, see the versatile-fpga-irq binding doc.
 
+Required nodes:
+
 In the root node the Integrator/CP must have a /cpcon node pointing
 to the CP control registers, and the Integrator/AP must have a
 /syscon node pointing to the Integrator/AP system controller.
+The AP syscon node must include the logical module interrupts,
+example:
+
+/dts-v1/;
+/include/ "integrator.dtsi"
+
+/ {
+	model = "ARM Integrator/AP";
+	compatible = "arm,integrator-ap";
+
+	syscon {
+		/* AP system controller registers */
+		reg = <0x11000000 0x100>;
+		interrupt-parent = <&pic>;
+		/* These are the logical module IRQs */
+		interrupts = <9 10 11 12>;
+	};
+};
 
 
 ARM Versatile Application and Platform Baseboards
diff --git a/arch/arm/boot/dts/integratorap.dts b/arch/arm/boot/dts/integratorap.dts
index b6b82ec..7c8925f 100644
--- a/arch/arm/boot/dts/integratorap.dts
+++ b/arch/arm/boot/dts/integratorap.dts
@@ -21,6 +21,9 @@
 	syscon {
 		/* AP system controller registers */
 		reg = <0x11000000 0x100>;
+		interrupt-parent = <&pic>;
+		/* These are the logical module IRQs */
+		interrupts = <9 10 11 12>;
 	};
 
 	timer0: timer at 13000000 {
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index d9e95e6..f5fbd8a 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -541,7 +541,7 @@ static void __init ap_init_of(void)
 		lmdev->resource.start = 0xc0000000 + 0x10000000 * i;
 		lmdev->resource.end = lmdev->resource.start + 0x0fffffff;
 		lmdev->resource.flags = IORESOURCE_MEM;
-		lmdev->irq = IRQ_AP_EXPINT0 + i;
+		lmdev->irq = irq_of_parse_and_map(syscon, i);
 		lmdev->id = i;
 
 		lm_device_register(lmdev);
-- 
1.8.3.1
