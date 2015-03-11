From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 11 Mar 2015 15:43:45 +0000
Subject: [PATCH v6 3/7] DT: update ti,irq-crossbar binding
In-Reply-To: <1426088629-15377-1-git-send-email-marc.zyngier@arm.com>
References: <1426088629-15377-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1426088629-15377-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make it look like a real interrupt controller.

Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 .../devicetree/bindings/arm/omap/crossbar.txt          | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/crossbar.txt b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
index 4139db3..a9b28d7 100644
--- a/Documentation/devicetree/bindings/arm/omap/crossbar.txt
+++ b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
@@ -9,7 +9,9 @@ inputs.
 Required properties:
 - compatible : Should be "ti,irq-crossbar"
 - reg: Base address and the size of the crossbar registers.
-- ti,max-irqs: Total number of irqs available at the interrupt controller.
+- interrupt-controller: indicates that this block is an interrupt controller.
+- interrupt-parent: the interrupt controller this block is connected to.
+- ti,max-irqs: Total number of irqs available at the parent interrupt controller.
 - ti,max-crossbar-sources: Maximum number of crossbar sources that can be routed.
 - ti,reg-size: Size of a individual register in bytes. Every individual
 	    register is assumed to be of same size. Valid sizes are 1, 2, 4.
@@ -27,13 +29,13 @@ Optional properties:
   when the interrupt controller irq is unused (when not provided, default is 0)
 
 Examples:
-		crossbar_mpu: @4a020000 {
+		crossbar_mpu: crossbar at 4a002a48 {
 			compatible = "ti,irq-crossbar";
 			reg = <0x4a002a48 0x130>;
 			ti,max-irqs = <160>;
 			ti,max-crossbar-sources = <400>;
 			ti,reg-size = <2>;
-			ti,irqs-reserved = <0 1 2 3 5 6 131 132 139 140>;
+			ti,irqs-reserved = <0 1 2 3 5 6 131 132>;
 			ti,irqs-skip = <10 133 139 140>;
 		};
 
@@ -44,10 +46,6 @@ Documentation/devicetree/bindings/arm/gic.txt for further details.
 
 An interrupt consumer on an SoC using crossbar will use:
 	interrupts = <GIC_SPI request_number interrupt_level>
-When the request number is between 0 to that described by
-"ti,max-crossbar-sources", it is assumed to be a crossbar mapping. If the
-request_number is greater than "ti,max-crossbar-sources", then it is mapped as a
-quirky hardware mapping direct to GIC.
 
 Example:
 	device_x at 0x4a023000 {
@@ -55,9 +53,3 @@ Example:
 		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 		...
 	};
-
-	device_y at 0x4a033000 {
-		/* Direct mapped GIC SPI 1 used */
-		interrupts = <GIC_SPI DIRECT_IRQ(1) IRQ_TYPE_LEVEL_HIGH>;
-		...
-	};
-- 
2.1.4
