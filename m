From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 18 Nov 2014 18:53:08 +0000
Subject: [PATCH v2 13/13] irqchip: GICv3: Binding updates for ITS
In-Reply-To: <1416336788-22634-1-git-send-email-marc.zyngier@arm.com>
References: <1416336788-22634-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1416336788-22634-14-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the documentation for the bindings describing the GICv3 ITS.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/devicetree/bindings/arm/gic-v3.txt | 39 ++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/gic-v3.txt b/Documentation/devicetree/bindings/arm/gic-v3.txt
index 33cd05e..ddfade4 100644
--- a/Documentation/devicetree/bindings/arm/gic-v3.txt
+++ b/Documentation/devicetree/bindings/arm/gic-v3.txt
@@ -49,11 +49,29 @@ Optional
   occupied by the redistributors. Required if more than one such
   region is present.
 
+Sub-nodes:
+
+GICv3 has one or more Interrupt Translation Services (ITS) that are
+used to route Message Signalled Interrupts (MSI) to the CPUs.
+
+These nodes must have the following properties:
+- compatible : Should at least contain  "arm,gic-v3-its".
+- msi-controller : Boolean property. Identifies the node as an MSI controller
+- reg: Specifies the base physical address and size of the ITS
+  registers.
+
+The main GIC node must contain the appropriate #address-cells,
+#size-cells and ranges properties for the reg property of all ITS
+nodes.
+
 Examples:
 
 	gic: interrupt-controller at 2cf00000 {
 		compatible = "arm,gic-v3";
 		#interrupt-cells = <3>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
 		interrupt-controller;
 		reg = <0x0 0x2f000000 0 0x10000>,	// GICD
 		      <0x0 0x2f100000 0 0x200000>,	// GICR
@@ -61,11 +79,20 @@ Examples:
 		      <0x0 0x2c010000 0 0x2000>,	// GICH
 		      <0x0 0x2c020000 0 0x2000>;	// GICV
 		interrupts = <1 9 4>;
+
+		gic-its at 2c200000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			reg = <0x0 0x2c200000 0 0x200000>;
+		};
 	};
 
 	gic: interrupt-controller at 2c010000 {
 		compatible = "arm,gic-v3";
 		#interrupt-cells = <3>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
 		interrupt-controller;
 		redistributor-stride = <0x0 0x40000>;	// 256kB stride
 		#redistributor-regions = <2>;
@@ -76,4 +103,16 @@ Examples:
 		      <0x0 0x2c060000 0 0x2000>,	// GICH
 		      <0x0 0x2c080000 0 0x2000>;	// GICV
 		interrupts = <1 9 4>;
+
+		gic-its at 2c200000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			reg = <0x0 0x2c200000 0 0x200000>;
+		};
+
+		gic-its at 2c400000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			reg = <0x0 0x2c400000 0 0x200000>;
+		};
 	};
-- 
2.1.3
