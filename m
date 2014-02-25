From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 25 Feb 2014 12:45:49 +0100
Subject: [PATCH v8 1/6] dt-bindings: sram: describe option to reserve parts of
 the memory
In-Reply-To: <21117503.1c6iOkvYSr@phil>
References: <21117503.1c6iOkvYSr@phil>
Message-ID: <126672712.tufE5adZWC@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some SoCs need parts of their sram for special purposes. So while being part
of the peripheral, it should not be part of the genpool controlling the sram.

Therefore add the option to define reserved regions as subnodes of the
sram-node similar to defining reserved global memory regions.

Originally
Suggested-by: Rob Herring <robherring2@gmail.com>

Using subnodes for reserved regions
Suggested-by: Grant Likely <grant.likely@linaro.org>

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Ulrich Prinz <ulrich.prinz@googlemail.com>
---
 Documentation/devicetree/bindings/misc/sram.txt | 33 +++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/sram.txt b/Documentation/devicetree/bindings/misc/sram.txt
index 4d0a00e..2d83758 100644
--- a/Documentation/devicetree/bindings/misc/sram.txt
+++ b/Documentation/devicetree/bindings/misc/sram.txt
@@ -8,9 +8,42 @@ Required properties:
 
 - reg : SRAM iomem address range
 
+Reserving sram areas:
+---------------------
+
+Each child of the sram node specifies a region of reserved memory. Each
+child node should use a 'reg' property to specify a specific range of
+reserved memory.
+
+Following the generic-names recommended practice, node names should
+reflect the purpose of the node. Unit address (@<address>) should be
+appended to the name.
+
+Required properties in the sram node:
+
+- #address-cells, #size-cells : should use the same values as the root node
+- ranges : standard definition, should be empty
+
+Required properties in the area nodes:
+
+- reg : iomem address range
+
+Optional properties in the area nodes:
+
+- compatible : standard definition
+
 Example:
 
 sram: sram at 5c000000 {
 	compatible = "mmio-sram";
 	reg = <0x5c000000 0x40000>; /* 256 KiB SRAM at address 0x5c000000 */
+
+	#adress-cells = <1>;
+	#size-cells = <1>;
+	ranges;
+
+	smp-sram at 5c000100 {
+		compatible = "socvendor,smp-sram";
+		reg = <0x5c000100 0x50>;
+	};
 };
-- 
1.8.5.3
