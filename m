From: d-gerlach@ti.com (Dave Gerlach)
Date: Tue, 26 Sep 2017 19:03:54 -0500
Subject: [PATCH v4 1/2] Documentation: dt: Update ti,emif bindings
In-Reply-To: <20170927000355.30597-1-d-gerlach@ti.com>
References: <20170927000355.30597-1-d-gerlach@ti.com>
Message-ID: <20170927000355.30597-2-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the Texas Instruments EMIF binding document to include the device
tree bindings for ti,emif-am3352 and ti,emif-am4372 which are used by
the ti-emif-sram driver to provide low-level PM functionality.

Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 .../devicetree/bindings/memory-controllers/ti/emif.txt | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt b/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
index 0db60470ebb6..8c0214b17c2b 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
@@ -8,6 +8,7 @@ of the EMIF IP and memory parts attached to it.
 Required properties:
 - compatible	: Should be of the form "ti,emif-<ip-rev>" where <ip-rev>
   is the IP revision of the specific EMIF instance.
+		  For am335x should be ti,emif-am3352.
 		  For am437x should be ti,emif-am4372.
 
 - phy-type	: <u32> indicating the DDR phy type. Following are the
@@ -21,6 +22,13 @@ Required properties:
   the value shall be "emif<n>" where <n> is the number of the EMIF
   instance with base 1.
 
+Required only for "ti,emif-am3352" and "ti,emif-am4372":
+- sram			: Phandles for generic sram driver nodes,
+  first should be type 'protect-exec' for the driver to use to copy
+  and run PM functions, second should be regular pool to be used for
+  data region for code. See Documentation/devicetree/bindings/sram/sram.txt
+  for more details.
+
 Optional properties:
 - cs1-used		: Have this property if CS1 of this EMIF
   instance has a memory part attached to it. If there is a memory
@@ -42,7 +50,7 @@ Optional properties:
 - hw-caps-temp-alert	: Have this property if the controller
   has capability for generating SDRAM temperature alerts
 
-Example:
+-Examples:
 
 emif1: emif at 0x4c000000 {
 	compatible	= "ti,emif-4d";
@@ -54,3 +62,11 @@ emif1: emif at 0x4c000000 {
 	hw-caps-ll-interface;
 	hw-caps-temp-alert;
 };
+
+/* From am33xx.dtsi */
+emif: emif at 4c000000 {
+        compatible = "ti,emif-am3352";
+        reg =   <0x4C000000 0x1000>;
+        sram = <&pm_sram_code
+                &pm_sram_data>;
+};
-- 
2.13.4
