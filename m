From: b.brezillon.dev@gmail.com (Boris BREZILLON)
Date: Wed, 12 Mar 2014 19:07:41 +0100
Subject: [PATCH v3 6/9] mtd: nand: add sunxi NFC dt bindings doc
In-Reply-To: <1394647664-8258-1-git-send-email-b.brezillon.dev@gmail.com>
References: <1394647664-8258-1-git-send-email-b.brezillon.dev@gmail.com>
Message-ID: <1394647664-8258-7-git-send-email-b.brezillon.dev@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the sunxi NAND Flash Controller dt bindings documentation.

Signed-off-by: Boris BREZILLON <b.brezillon.dev@gmail.com>
---
 .../devicetree/bindings/mtd/sunxi-nand.txt         |   48 ++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/sunxi-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/sunxi-nand.txt b/Documentation/devicetree/bindings/mtd/sunxi-nand.txt
new file mode 100644
index 0000000..4bf5b07
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/sunxi-nand.txt
@@ -0,0 +1,48 @@
+Allwinner NAND Flash Controller (NFC)
+
+Required properties:
+- compatible : "allwinner,sun4i-nand".
+- reg : shall contain registers location and length for data and reg.
+- interrupts : shall define the nand controller interrupt.
+- #address-cells: shall be set to 1. Encode the nand CS.
+- #size-cells : shall be set to 0.
+- clocks : shall reference nand controller clocks.
+- clock-names : nand controller internal clock names. Shall contain :
+    * "ahb_clk" : AHB gating clock
+    * "sclk" : nand controller clock
+
+Optional children nodes:
+Children nodes represent the available nand chips.
+
+Optional properties:
+- onfi,nand-timing-mode : mandatory if the chip does not support the ONFI
+  standard.
+- allwinner,rb : shall contain the native Ready/Busy ids.
+ or
+- rb-gpios : shall contain the gpios used as R/B pins.
+- nand-ecc-mode : one of the supported ECC modes ("hw", "hw_syndrome", "soft",
+  "soft_bch" or "none")
+
+see Documentation/devicetree/mtd/nand.txt for generic bindings.
+
+
+Examples:
+nfc: nand at 01c03000 {
+	compatible = "allwinner,sun4i-nand";
+	reg = <0x01c03000 0x1000>;
+	interrupts = <0 37 1>;
+	clocks = <&ahb_gates 13>, <&nand_clk>;
+	clock-names = "ahb_clk", "sclk";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&nand_pins_a &nand_cs0_pins_a &nand_rb0_pins_a>;
+	status = "okay";
+
+	nand at 0 {
+		reg = <0>;
+		allwinner,rb = <0>;
+		nand-ecc-mode = "soft_bch";
+		onfi,nand-timing-mode = <4>;
+	};
+};
-- 
1.7.9.5
