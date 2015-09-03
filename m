From: stefan@agner.ch (Stefan Agner)
Date: Wed,  2 Sep 2015 18:06:35 -0700
Subject: [PATCH v12 3/5] mtd: nand: vf610_nfc: add device tree bindings
In-Reply-To: <1441242397-870-1-git-send-email-stefan@agner.ch>
References: <1441242397-870-1-git-send-email-stefan@agner.ch>
Message-ID: <1441242397-870-4-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bill Pringlemeir <bpringlemeir@nbsps.com>
Acked-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 .../devicetree/bindings/mtd/vf610-nfc.txt          | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/vf610-nfc.txt

diff --git a/Documentation/devicetree/bindings/mtd/vf610-nfc.txt b/Documentation/devicetree/bindings/mtd/vf610-nfc.txt
new file mode 100644
index 0000000..6be4871
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/vf610-nfc.txt
@@ -0,0 +1,59 @@
+Freescale's NAND flash controller (NFC)
+
+This variant of the Freescale NAND flash controller (NFC) can be found on
+Vybrid (vf610), MPC5125, MCF54418 and Kinetis K70.
+
+Required properties:
+- compatible: Should be set to "fsl,vf610-nfc".
+- reg: address range of the NFC.
+- interrupts: interrupt of the NFC.
+- #address-cells: shall be set to 1. Encode the nand CS.
+- #size-cells : shall be set to 0.
+- assigned-clocks: main clock from the SoC, for Vybrid <&clks VF610_CLK_NFC>;
+- assigned-clock-rates: The NAND bus timing is derived from this clock
+    rate and should not exceed maximum timing for any NAND memory chip
+    in a board stuffing. Typical NAND memory timings derived from this
+    clock are found in the SoC hardware reference manual. Furthermore,
+    there might be restrictions on maximum rates when using hardware ECC.
+
+- #address-cells, #size-cells : Must be present if the device has sub-nodes
+  representing partitions.
+
+Required children nodes:
+Children nodes represent the available nand chips. Currently the driver can
+only handle one NAND chip.
+
+Required properties:
+- compatible: Should be set to "fsl,vf610-nfc-cs".
+- nand-bus-width: see nand.txt
+- nand-ecc-mode: see nand.txt
+
+Required properties for hardware ECC:
+- nand-ecc-strength: supported strengths are 24 and 32 bit (see nand.txt)
+- nand-ecc-step-size: step size equals page size, currently only 2k pages are
+    supported
+- nand-on-flash-bbt: see nand.txt
+
+Example:
+
+	nfc: nand at 400e0000 {
+		compatible = "fsl,vf610-nfc";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x400e0000 0x4000>;
+		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clks VF610_CLK_NFC>;
+		clock-names = "nfc";
+		assigned-clocks = <&clks VF610_CLK_NFC>;
+		assigned-clock-rates = <33000000>;
+
+		nand at 0 {
+			compatible = "fsl,vf610-nfc-nandcs";
+			reg = <0>;
+			nand-bus-width = <8>;
+			nand-ecc-mode = "hw";
+			nand-ecc-strength = <32>;
+			nand-ecc-step-size = <2048>;
+			nand-on-flash-bbt;
+		};
+	};
-- 
2.5.1
