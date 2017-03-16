From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 16 Mar 2017 09:02:41 +0100
Subject: [PATCH v3 2/3] mtd: nand: atmel: Document the new DT bindings
In-Reply-To: <1489651362-17077-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1489651362-17077-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1489651362-17077-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The old NAND bindings were not exactly describing the hardware topology
and were preventing definitions of several NAND chips under the same
NAND controller.

New bindings address these limitations and should be preferred over the
old ones for new SoCs/boards.
Old bindings are still supported for backward compatibility but are
marked deprecated in the doc.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reviewed-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mtd/atmel-nand.txt         | 107 ++++++++++++++++++++-
 1 file changed, 106 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
index 3e7ee99d3949..f6bee57e453a 100644
--- a/Documentation/devicetree/bindings/mtd/atmel-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
@@ -1,4 +1,109 @@
-Atmel NAND flash
+Atmel NAND flash controller bindings
+
+The NAND flash controller node should be defined under the EBI bus (see
+Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt).
+One or several NAND devices can be defined under this NAND controller.
+The NAND controller might be connected to an ECC engine.
+
+* NAND controller bindings:
+
+Required properties:
+- compatible: should be one of the following
+	"atmel,at91rm9200-nand-controller"
+	"atmel,at91sam9260-nand-controller"
+	"atmel,at91sam9261-nand-controller"
+	"atmel,at91sam9g45-nand-controller"
+	"atmel,sama5d3-nand-controller"
+- ranges: empty ranges property to forward EBI ranges definitions.
+- #address-cells: should be set to 2.
+- #size-cells: should be set to 1.
+- atmel,nfc-io: phandle to the NFC IO block. Only required for sama5d3
+		controllers.
+- atmel,nfc-sram: phandle to the NFC SRAM block. Only required for sama5d3
+		  controllers.
+
+Optional properties:
+- ecc-engine: phandle to the PMECC block. Only meaningful if the SoC embeds
+	      a PMECC engine.
+
+* NAND device/chip bindings:
+
+Required properties:
+- reg: describes the CS lines assigned to the NAND device. If the NAND device
+       exposes multiple CS lines (multi-dies chips), your reg property will
+       contain X tuples of 3 entries.
+       1st entry: the CS line this NAND chip is connected to
+       2nd entry: the base offset of the memory region assigned to this
+		  device (always 0)
+       3rd entry: the memory region size (always 0x800000)
+
+Optional properties:
+- rb-gpios: the GPIO(s) used to check the Ready/Busy status of the NAND.
+- cs-gpios: the GPIO(s) used to control the CS line.
+- det-gpios: the GPIO used to detect if a Smartmedia Card is present.
+- atmel,rb: an integer identifying the native Ready/Busy pin. Only meaningful
+	    on sama5 SoCs.
+
+All generic properties described in
+Documentation/devicetree/bindings/mtd/{common,nand}.txt also apply to the NAND
+device node, and NAND partitions should be defined under the NAND node as
+described in Documentation/devicetree/bindings/mtd/partition.txt.
+
+* ECC engine (PMECC) bindings:
+
+Required properties:
+- compatible: should be one of the following
+	"atmel,at91sam9g45-pmecc"
+	"atmel,sama5d4-pmecc"
+	"atmel,sama5d2-pmecc"
+- reg: should contain 2 register ranges. The first one is pointing to the PMECC
+       block, and the second one to the PMECC_ERRLOC block.
+
+Example:
+
+	pmecc: ecc-engine at ffffc070 {
+		compatible = "atmel,at91sam9g45-pmecc";
+                reg = <0xffffc070 0x490>,
+                      <0xffffc500 0x100>;
+	};
+
+	ebi: ebi at 10000000 {
+		compatible = "atmel,sama5d3-ebi";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		atmel,smc = <&hsmc>;
+		reg = <0x10000000 0x10000000
+		       0x40000000 0x30000000>;
+		ranges = <0x0 0x0 0x10000000 0x10000000
+			  0x1 0x0 0x40000000 0x10000000
+			  0x2 0x0 0x50000000 0x10000000
+			  0x3 0x0 0x60000000 0x10000000>;
+		clocks = <&mck>;
+
+                nand_controller: nand-controller {
+			compatible = "atmel,sama5d3-nand-controller";
+			atmel,nfc-sram = <&nfc_sram>;
+			atmel,nfc-io = <&nfc_io>;
+			ecc-engine = <&pmecc>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			ranges;
+
+			nand at 3 {
+				reg = <0x3 0x0 0x800000>;
+				atmel,rb = <0>;
+
+				/*
+				 * Put generic NAND/MTD properties and
+				 * subnodes here.
+				 */
+			};
+		};
+	};
+
+-----------------------------------------------------------------------
+
+Deprecated bindings (should not be used in new device trees):
 
 Required properties:
 - compatible: The possible values are:
-- 
2.7.4
