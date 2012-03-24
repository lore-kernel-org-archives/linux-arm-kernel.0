From: jm@lentin.co.uk (Jamie Lentin)
Date: Sat, 24 Mar 2012 13:14:35 +0000
Subject: [PATCH V2 2/3] ARM: kirkwood: Convert orion-nand to fdt
In-Reply-To: <1332594876-8673-1-git-send-email-jm@lentin.co.uk>
References: <1332594876-8673-1-git-send-email-jm@lentin.co.uk>
Message-ID: <1332594876-8673-3-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert orion-nand to use fdt and add common setup to kirkwood.dtsi, including
a default value for chip-delay (all current boards seem to use 25 anyway).

Add placeholder documentation for the bindings, for someone more knowledgable
than me to fill in the details of the properties.

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
 .../devicetree/bindings/mtd/orion-nand.txt         |   46 ++++++++++++++++++++
 arch/arm/boot/dts/kirkwood.dtsi                    |   15 ++++++-
 arch/arm/mach-kirkwood/common.c                    |   12 +++++
 drivers/mtd/nand/orion_nand.c                      |   34 ++++++++++++++-
 4 files changed, 104 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/orion-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/orion-nand.txt b/Documentation/devicetree/bindings/mtd/orion-nand.txt
new file mode 100644
index 0000000..d347999
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
+- width :
+- chip-delay :
+
+Examples:
+
+nand at f4000000 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	cle = <0>;
+	ale = <1>;
+	width = <8>;
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
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 3474ef8..82ffc3e 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -5,7 +5,7 @@
 
 	ocp at f1000000 {
 		compatible = "simple-bus";
-		ranges = <0 0xf1000000 0x1000000>;
+		ranges = <0 0xf1000000 0x4000000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 
@@ -32,5 +32,18 @@
 			reg = <0x10300 0x20>;
 			interrupts = <53>;
 		};
+
+		nand at 3000000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cle = <0>;
+			ale = <1>;
+			width = <8>;
+			compatible = "mrvl,orion-nand";
+			reg = <0x3000000 0x400>;
+			chip-delay = <25>;
+			/* set partition map and/or chip-delay in board dts */
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index a02cae8..3ad0373 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -15,6 +15,7 @@
 #include <linux/ata_platform.h>
 #include <linux/mtd/nand.h>
 #include <linux/dma-mapping.h>
+#include <linux/of.h>
 #include <net/dsa.h>
 #include <asm/page.h>
 #include <asm/timex.h>
@@ -482,6 +483,9 @@ static int __init kirkwood_clock_gate(void)
 	unsigned int curr = readl(CLOCK_GATING_CTRL);
 	u32 dev, rev;
 
+#ifdef CONFIG_OF
+	struct device_node *np;
+#endif
 	kirkwood_pcie_id(&dev, &rev);
 	printk(KERN_DEBUG "Gating clock of unused units\n");
 	printk(KERN_DEBUG "before: 0x%08x\n", curr);
@@ -489,6 +493,14 @@ static int __init kirkwood_clock_gate(void)
 	/* Make sure those units are accessible */
 	writel(curr | CGC_SATA0 | CGC_SATA1 | CGC_PEX0 | CGC_PEX1, CLOCK_GATING_CTRL);
 
+#ifdef CONFIG_OF
+	np = of_find_compatible_node(NULL, NULL, "mrvl,orion-nand");
+	if (np && of_device_is_available(np)) {
+		kirkwood_clk_ctrl |= CGC_RUNIT;
+		of_node_put(np);
+	}
+#endif
+
 	/* For SATA: first shutdown the phy */
 	if (!(kirkwood_clk_ctrl & CGC_SATA0)) {
 		/* Disable PLL and IVREF */
diff --git a/drivers/mtd/nand/orion_nand.c b/drivers/mtd/nand/orion_nand.c
index 29f505a..4cb0244 100644
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
@@ -101,7 +104,25 @@ static int __init orion_nand_probe(struct platform_device *pdev)
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
+		if (!of_property_read_u32(pdev->dev.of_node, "width", &val))
+			board->width = (u8)val;
+		if (!of_property_read_u32(pdev->dev.of_node,
+						"chip-delay", &val))
+			board->chip_delay = (u8)val;
+	} else
+		board = pdev->dev.platform_data;
 
 	mtd->priv = nc;
 	mtd->owner = THIS_MODULE;
@@ -129,7 +150,8 @@ static int __init orion_nand_probe(struct platform_device *pdev)
 	}
 
 	mtd->name = "orion_nand";
-	ret = mtd_device_parse_register(mtd, NULL, 0,
+	ppdata.of_node = pdev->dev.of_node;
+	ret = mtd_device_parse_register(mtd, NULL, &ppdata,
 			board->parts, board->nr_parts);
 	if (ret) {
 		nand_release(mtd);
@@ -161,11 +183,19 @@ static int __devexit orion_nand_remove(struct platform_device *pdev)
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
