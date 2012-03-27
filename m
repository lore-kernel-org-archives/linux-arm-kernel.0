From: jm@lentin.co.uk (Jamie Lentin)
Date: Tue, 27 Mar 2012 22:54:12 +0100
Subject: [PATCH V3 2/5] mtd: Add orion_nand devicetree bindings
In-Reply-To: <1332885255-8304-1-git-send-email-jm@lentin.co.uk>
References: <1332885255-8304-1-git-send-email-jm@lentin.co.uk>
Message-ID: <1332885255-8304-3-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow a NAND chip using the orion_nand driver to be described using devicetree.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
 .../devicetree/bindings/mtd/orion-nand.txt         |   46 ++++++++++++++++++++
 drivers/mtd/nand/orion_nand.c                      |   35 ++++++++++++++-
 2 files changed, 79 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/orion-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/orion-nand.txt b/Documentation/devicetree/bindings/mtd/orion-nand.txt
new file mode 100644
index 0000000..22c7438
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/orion-nand.txt
@@ -0,0 +1,46 @@
+NAND support for Marvell Orion SoC platforms
+
+Required properties:
+- compatible : "mrvl,orion-nand".
+- reg : Base physical address of the NAND and length of memory mapped
+	region
+
+Optional properties:
+- cle :
+- ale :
+- bank-width :
+- chip-delay :
+
+Examples:
+
+nand at f4000000 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	cle = <0>;
+	ale = <1>;
+	bank-width = <8>;
+	chip-delay = <25>;
+	compatible = "mrvl,orion-nand";
+	reg = <0xf4000000 0x400>;
+
+	partition at 0 {
+		label = "u-boot";
+		reg = <0x0000000 0x100000>;
+		read-only;
+	};
+
+	partition at 100000 {
+		label = "uImage";
+		reg = <0x0100000 0x200000>;
+	};
+
+	partition at 300000 {
+		label = "dtb";
+		reg = <0x0300000 0x100000>;
+	};
+
+	partition at 400000 {
+		label = "root";
+		reg = <0x0400000 0x7d00000>;
+	};
+};
diff --git a/drivers/mtd/nand/orion_nand.c b/drivers/mtd/nand/orion_nand.c
index 29f505a..3b7c82f 100644
--- a/drivers/mtd/nand/orion_nand.c
+++ b/drivers/mtd/nand/orion_nand.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
@@ -74,11 +75,13 @@ static void orion_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 static int __init orion_nand_probe(struct platform_device *pdev)
 {
 	struct mtd_info *mtd;
+	struct mtd_part_parser_data ppdata = {};
 	struct nand_chip *nc;
 	struct orion_nand_data *board;
 	struct resource *res;
 	void __iomem *io_base;
 	int ret = 0;
+	u32 val = 0;
 
 	nc = kzalloc(sizeof(struct nand_chip) + sizeof(struct mtd_info), GFP_KERNEL);
 	if (!nc) {
@@ -101,7 +104,26 @@ static int __init orion_nand_probe(struct platform_device *pdev)
 		goto no_res;
 	}
 
-	board = pdev->dev.platform_data;
+	if (pdev->dev.of_node) {
+		board = devm_kzalloc(&pdev->dev, sizeof(struct orion_nand_data),
+					GFP_KERNEL);
+		if (!board) {
+			printk(KERN_ERR "orion_nand: failed to allocate board structure.\n");
+			ret = -ENOMEM;
+			goto no_res;
+		}
+		if (!of_property_read_u32(pdev->dev.of_node, "cle", &val))
+			board->cle = (u8)val;
+		if (!of_property_read_u32(pdev->dev.of_node, "ale", &val))
+			board->ale = (u8)val;
+		if (!of_property_read_u32(pdev->dev.of_node,
+						"bank-width", &val))
+			board->width = (u8)val;
+		if (!of_property_read_u32(pdev->dev.of_node,
+						"chip-delay", &val))
+			board->chip_delay = (u8)val;
+	} else
+		board = pdev->dev.platform_data;
 
 	mtd->priv = nc;
 	mtd->owner = THIS_MODULE;
@@ -129,7 +151,8 @@ static int __init orion_nand_probe(struct platform_device *pdev)
 	}
 
 	mtd->name = "orion_nand";
-	ret = mtd_device_parse_register(mtd, NULL, 0,
+	ppdata.of_node = pdev->dev.of_node;
+	ret = mtd_device_parse_register(mtd, NULL, &ppdata,
 			board->parts, board->nr_parts);
 	if (ret) {
 		nand_release(mtd);
@@ -161,11 +184,19 @@ static int __devexit orion_nand_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static struct of_device_id orion_nand_of_match_table[] = {
+	{ .compatible = "mrvl,orion-nand", },
+	{},
+};
+#endif
+
 static struct platform_driver orion_nand_driver = {
 	.remove		= __devexit_p(orion_nand_remove),
 	.driver		= {
 		.name	= "orion_nand",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(orion_nand_of_match_table),
 	},
 };
 
-- 
1.7.9.1
