From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 26 Feb 2014 23:02:52 +0100
Subject: [PATCH v8.1 1/6] dt-bindings: sram: describe option to reserve parts
 of the memory
In-Reply-To: <201402251419.31151.arnd@arndb.de>
References: <21117503.1c6iOkvYSr@phil> <126672712.tufE5adZWC@phil>
 <201402251419.31151.arnd@arndb.de>
Message-ID: <2574291.evU61mFTUd@phil>
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
Hi Arnd,

I've changed the range definition as suggested. I've also changed my
rockchip dt-files accordingly, but will wait with respinning the whole
series until the direction with this binding is a bit safer.

I've also amended the "compatible"-property for the subnodes. It now
mimics the text from the generic reserved memory nodes [0],
which got no complaints from the DT maintainers.

Heiko


[0] https://lkml.org/lkml/2014/2/4/172

 Documentation/devicetree/bindings/misc/sram.txt | 35 +++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/sram.txt b/Documentation/devicetree/bindings/misc/sram.txt
index 4d0a00e..36cbe5a 100644
--- a/Documentation/devicetree/bindings/misc/sram.txt
+++ b/Documentation/devicetree/bindings/misc/sram.txt
@@ -8,9 +8,44 @@ Required properties:
 
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
+- ranges : standard definition, should translate from local addresses
+           within the sram to bus addresses
+
+Required properties in the area nodes:
+
+- reg : iomem address range, relative to the SRAM range
+
+Optional properties in the area nodes:
+
+- compatible : standard definition, should contain a vendor specific string
+               in the form <vendor>,[<device>-]<usage>
+
 Example:
 
 sram: sram at 5c000000 {
 	compatible = "mmio-sram";
 	reg = <0x5c000000 0x40000>; /* 256 KiB SRAM at address 0x5c000000 */
+
+	#adress-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0 0x5c000000 0x40000>;
+
+	smp-sram at 100 {
+		compatible = "socvendor,smp-sram";
+		reg = <0x100 0x50>;
+	};
 };
-- 
1.8.5.3
