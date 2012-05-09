From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  9 May 2012 18:57:57 +0100
Subject: [PATCH v2] ARM: DT: Add binding for GIC virtualization extentions
 (VGIC)
Message-ID: <1336586277-28454-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GICv2 can have virtualization extension support, consisting
of an additional set of registers and interrupts. Add the necessary
binding to the GIC DT documentation.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/devicetree/bindings/arm/gic.txt |   35 +++++++++++++++++++++++-
 1 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
index 9b4b82a..62eb8df 100644
--- a/Documentation/devicetree/bindings/arm/gic.txt
+++ b/Documentation/devicetree/bindings/arm/gic.txt
@@ -11,7 +11,9 @@ have PPIs or SGIs.
 Main node required properties:
 
 - compatible : should be one of:
+	"arm,cortex-a15-gic"
 	"arm,cortex-a9-gic"
+	"arm,cortex-a7-gic"
 	"arm,arm11mp-gic"
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Specifies the number of cells needed to encode an
@@ -39,8 +41,9 @@ Main node required properties:
   the GIC cpu interface register base and size.
 
 Optional
-- interrupts	: Interrupt source of the parent interrupt controller. Only
-  present on secondary GICs.
+- interrupts	: Interrupt source of the parent interrupt controller on
+  secondary GICs, or VGIC maintainance interrupt on primary GIC (see
+  below).
 
 - cpu-offset	: per-cpu offset within the distributor and cpu interface
   regions, used when the GIC doesn't have banked registers. The offset is
@@ -57,3 +60,31 @@ Example:
 		      <0xfff10100 0x100>;
 	};
 
+
+* GIC virtualization extensions (VGIC)
+
+For ARM cores that support the virtualization extensions, additional
+properties must be described (they only exist if the GIC is the
+primary interrupt controller).
+
+Required properties:
+
+- reg : Additional regions specifying the base physical address and
+  size of the VGIC registers. The first additional region is the GIC
+  virtual interface control register base and size. The 2nd additional
+  region is the GIC virtual cpu interface register base and size.
+
+- interrupts : VGIC maintainance interrupt.
+
+Example:
+
+	interrupt-controller at 2c001000 {
+		compatible = "arm,cortex-a15-gic";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x2c001000 0x1000>,
+		      <0x2c002000 0x1000>,
+		      <0x2c004000 0x2000>,
+		      <0x2c006000 0x2000>;
+		interrupts = <1 9 0xf04>;
+	};
-- 
1.7.7.1
