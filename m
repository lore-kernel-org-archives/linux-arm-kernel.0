From: stuart.yoder@nxp.com (Stuart Yoder)
Date: Fri, 1 Apr 2016 15:54:29 -0500
Subject: [PATCH 1/2] Documentation: fsl-mc: binding updates for MSIs, ranges,
 PHYs
Message-ID: <1459544069-12852-1-git-send-email-stuart.yoder@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stuart Yoder <stuart.yoder@freescale.com>

-The Freescale Management Complex and all associated objects
 use message interrupts, and thus an msi-parent is required.

-Define a ranges property to specify the mapping between
 the MC address space and the system address space.

-The fsl-mc node may optionally have dpmac sub-nodes that describe
 the relationship between the Ethernet MACs which belong to the MC
 and the Ethernet PHYs on the system board.

Signed-off-by: Stuart Yoder <stuart.yoder@nxp.com>
Acked-by: J. German Rivera <German.Rivera@nxp.com>
---
 .../devicetree/bindings/misc/fsl,qoriq-mc.txt      |   81 +++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
index c7a26ca..6611a7c 100644
--- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
+++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
@@ -30,11 +30,90 @@ Required properties:
                         region may not be present in some scenarios, such
                         as in the device tree presented to a virtual machine.
 
+    - msi-parent
+        Value type: <phandle>
+        Definition: Must be present and point to the MSI controller node
+                    handling message interrupts for the MC.
+
+    - ranges
+        Value type: <prop-encoded-array>
+        Definition: A standard property.  Defines the mapping between the child
+                    MC address space and the parent system address space.
+
+                    The MC address space is defined by 3 components:
+                       <region type> <offset hi> <offset lo>
+
+                    Valid values for region type are
+                       0x0 - MC portals
+                       0x1 - QBMAN portals
+
+    - #address-cells
+        Value type: <u32>
+        Definition: Must be 3.  (see definition in 'ranges' property)
+
+    - #size-cells
+        Value type: <u32>
+        Definition: Must be 1.
+
+Sub-nodes:
+
+        The fsl-mc node may optionally have dpmac sub-nodes that describe
+        the relationship between the Ethernet MACs which belong to the MC
+        and the Ethernet PHYs on the system board.
+
+        The dpmac nodes must be under a node named "dpmacs" which contains
+        the following properties:
+
+            - #address-cells
+              Value type: <u32>
+              Definition: Must be present if dpmac sub-nodes are defined and must
+                          have a value of 1.
+
+            - #size-cells
+              Value type: <u32>
+              Definition: Must be present if dpmac sub-nodes are defined and must
+                          have a value of 0.
+
+        These nodes must have the following properties:
+
+            - compatible
+              Value type: <string>
+              Definition: Must be "fsl,qoriq-mc-dpmac".
+
+            - reg
+              Value type: <prop-encoded-array>
+              Definition: Specifies the id of the dpmac.
+
+            - phy-handle
+              Value type: <phandle>
+              Definition: Specifies the phandle to the PHY device node associated
+                          with the this dpmac.
+
 Example:
 
         fsl_mc: fsl-mc at 80c000000 {
                 compatible = "fsl,qoriq-mc";
                 reg = <0x00000008 0x0c000000 0 0x40>,    /* MC portal base */
                       <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
-        };
+                msi-parent = <&its>;
+                #address-cells = <3>;
+                #size-cells = <1>;
+
+                /*
+                 * Region type 0x0 - MC portals
+                 * Region type 0x1 - QBMAN portals
+                 */
+                ranges = <0x0 0x0 0x0 0x8 0x0c000000 0x4000000
+                          0x1 0x0 0x0 0x8 0x18000000 0x8000000>;
 
+                dpmacs {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    dpmac at 1 {
+                        compatible = "fsl,qoriq-mc-dpmac";
+                        reg = <1>;
+                        phy-handle = <&mdio0_phy0>;
+                    }
+                }
+        };
-- 
1.7.9.5
