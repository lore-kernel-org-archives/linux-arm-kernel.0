From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 23 Jan 2017 15:56:13 +0000
Subject: [PATCH v2 1/2] dt-bindings: arm,
 gic: Fix binding example for a virt-capable GIC
In-Reply-To: <1485186974-13678-1-git-send-email-marc.zyngier@arm.com>
References: <1485186974-13678-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1485186974-13678-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The joys of copy/paste: the example of a virtualization capable GIC
in the DT binding was wrong, and propagated to dozens of platforms.
By having a GICC region that is only 4kB (instead of 8kB), we
end-up not being able to access the GICC_DIR register which is on
the second page.

Oh well. Let's fix the source of the crap before tackling individual
offenders. While we're at it, also fix the compatibility string to
mention "arm,gic-400", which is the name of the actual implementation
of the GICv2 spec.

Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
index 5393e2a..a3d51ed 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
@@ -107,11 +107,11 @@ Required properties:
 Example:
 
 	interrupt-controller at 2c001000 {
-		compatible = "arm,cortex-a15-gic";
+		compatible = "arm,gic-400";
 		#interrupt-cells = <3>;
 		interrupt-controller;
 		reg = <0x2c001000 0x1000>,
-		      <0x2c002000 0x1000>,
+		      <0x2c002000 0x2000>,
 		      <0x2c004000 0x2000>,
 		      <0x2c006000 0x2000>;
 		interrupts = <1 9 0xf04>;
-- 
2.1.4
