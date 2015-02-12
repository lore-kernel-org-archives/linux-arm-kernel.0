From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 12 Feb 2015 13:10:18 +0200
Subject: [PATCH 1/2] mtd: nand: dt binding documentation for digicolor NFC
Message-ID: <e6a998f130c40cee0a72e23b4f7f65bece0d6b21.1423739332.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CX92755 SoC is one of Conexant Digicolor series of SoCs. This devicetree
binding document describes the NAND flash controller the is shared by some SoCs
in the Digicolor series.

Not all of the properties are currently actually used by the driver.
Specifically, the driver doesn't make use of interrupts. This may change in the
future.

Also worth noting that the only supported ECC mode is "hw_syndrome". In the
future the driver may add support for additional modes.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 .../devicetree/bindings/mtd/digicolor-nand.txt     | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/digicolor-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/digicolor-nand.txt b/Documentation/devicetree/bindings/mtd/digicolor-nand.txt
new file mode 100644
index 000000000000..60e2d9085b7a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/digicolor-nand.txt
@@ -0,0 +1,71 @@
+Conexant Digicolor NAND Flash Controller (NFC)
+
+Required properties:
+- compatible : "cnxt,cx92755-nfc".
+- reg : shall contain registers location and length for data and reg.
+- interrupts : shall define the nand controller interrupt.
+- #address-cells: shall be set to 1. Encode the nand CS.
+- #size-cells : shall be set to 0.
+- clocks : shall reference nand controller clocks.
+
+Optional children nodes:
+Children nodes represent the available nand chips.
+
+Required children properties:
+- nand-ecc-mode : must be "hw_syndrome".
+- nand-ecc-strength : must be one of 6, 7, 8, 24, 28, 30.
+- nand-ecc-step-size : must be either 512 or 1024.
+
+see Documentation/devicetree/bindings/mtd/nand.txt for generic bindings.
+
+Each nand chip child node may optionally have partition sub-nodes. See
+Documentation/devicetree/bindings/mtd/partition.txt for partitions binding.
+
+Example:
+nfc: nfc at f00a4000 {
+	compatible = "cnxt,cx92755-nfc";
+	reg = <0xf00a4000 0x200>;
+	interrupts = <26>;
+	clocks = <&main_clk>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	nand at 0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		nand-ecc-mode = "hw_syndrome";
+		nand-ecc-step-size = <1024>;
+		nand-ecc-strength = <28>;
+
+		partition at 0 {
+			label = "boot";
+			reg = <0x00000000 0x00700000>;
+		};
+
+		partition at 700000 {
+			label = "splash";
+			reg = <0x00700000 0x00500000>;
+		};
+
+		partition at c00000 {
+			label = "maint";
+			reg = <0x00c00000 0x00500000>;
+		};
+
+		partition at 1100000 {
+			label = "kernel";
+			reg = <0x01100000 0x00500000>;
+		};
+
+		partition at 1600000 {
+			label = "rootfs";
+			reg = <0x01600000 0x18000000>;
+		};
+
+		partition at 19600000 {
+			label = "data1";
+			reg = <0x19600000 0x66a00000>;
+		};
+	};
+};
-- 
2.1.4
