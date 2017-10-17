From: hayashibara.keiji@socionext.com (Keiji Hayashibara)
Date: Tue, 17 Oct 2017 13:41:02 +0900
Subject: [PATCH v3 1/3] dt-bindings: nvmem: add description for UniPhier eFuse
In-Reply-To: <1508215264-3745-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1508215264-3745-1-git-send-email-hayashibara.keiji@socionext.com>
Message-ID: <1508215264-3745-2-git-send-email-hayashibara.keiji@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add uniphier-efuse dt-bindings documentation.

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
---
 .../devicetree/bindings/nvmem/uniphier-efuse.txt   | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/uniphier-efuse.txt

diff --git a/Documentation/devicetree/bindings/nvmem/uniphier-efuse.txt b/Documentation/devicetree/bindings/nvmem/uniphier-efuse.txt
new file mode 100644
index 0000000..dd78bc5
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/uniphier-efuse.txt
@@ -0,0 +1,49 @@
+= UniPhier eFuse device tree bindings =
+
+This UniPhier eFuse must be under soc-glue.
+
+Required properties:
+- compatible: should be "socionext,uniphier-efuse"
+- reg: should contain the register location and length
+
+= Data cells =
+Are child nodes of efuse, bindings of which as described in
+bindings/nvmem/nvmem.txt
+
+Example:
+
+	soc-glue at 5f900000 {
+		compatible = "socionext,uniphier-ld20-soc-glue-debug",
+			     "simple-mfd";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x5f900000 0x2000>;
+
+		efuse at 100 {
+			compatible = "socionext,uniphier-efuse";
+			reg = <0x100 0x28>;
+		};
+
+		efuse at 200 {
+			compatible = "socionext,uniphier-efuse";
+			reg = <0x200 0x68>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			/* Data cells */
+			usb-mon: usb-mon at 54 {
+				reg = <0x54 0xc>;
+			};
+		};
+	};
+
+= Data consumers =
+Are device nodes which consume nvmem data cells.
+
+Example:
+
+	usb {
+		...
+		nvmem-cells = <&usb-mon>;
+		nvmem-cell-names = "usb-mon";
+	}
-- 
2.7.4
