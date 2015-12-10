From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:03 +0100
Subject: [PATCH v4 19/58] mtd: nand: fsl_ifc: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-20-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct nand_chip now embeds an mtd device. Make use of this mtd instance.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
Changes generated with the following coccinelle script

--->8---
virtual patch

@fix1@
identifier __chipfield, __mtdfield;
type __type;
@@
(
	__type {
		...
		struct nand_chip __chipfield;
		...
-		struct mtd_info __mtdfield;
		...
	};
|
	__type {
		...
-		struct mtd_info __mtdfield;
		...
		struct nand_chip __chipfield;
		...
	};
)

@fix2 depends on fix1@
identifier fix1.__chipfield, fix1.__mtdfield;
identifier __subfield;
type fix1.__type;
__type *__priv;
@@
(
-	__priv->__mtdfield.__subfield
+	nand_to_mtd(&__priv->__chipfield)->__subfield
|
-	&(__priv->__mtdfield)
+	nand_to_mtd(&__priv->__chipfield)
)
--->8---
---
 drivers/mtd/nand/fsl_ifc_nand.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
index 3136842..3f5654f 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -40,7 +40,6 @@ struct fsl_ifc_ctrl;
 
 /* mtd information per set */
 struct fsl_ifc_mtd {
-	struct mtd_info mtd;
 	struct nand_chip chip;
 	struct fsl_ifc_ctrl *ctrl;
 
@@ -877,12 +876,13 @@ static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
 	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
 	struct fsl_ifc_regs __iomem *ifc = ctrl->regs;
 	struct nand_chip *chip = &priv->chip;
+	struct mtd_info *mtd = nand_to_mtd(&priv->chip);
 	struct nand_ecclayout *layout;
 	u32 csor;
 
 	/* Fill in fsl_ifc_mtd structure */
-	priv->mtd.priv = chip;
-	priv->mtd.dev.parent = priv->dev;
+	mtd->priv = chip;
+	mtd->dev.parent = priv->dev;
 	nand_set_flash_node(chip, priv->dev->of_node);
 
 	/* fill in nand_chip structure */
@@ -994,9 +994,11 @@ static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
 
 static int fsl_ifc_chip_remove(struct fsl_ifc_mtd *priv)
 {
-	nand_release(&priv->mtd);
+	struct mtd_info *mtd = nand_to_mtd(&priv->chip);
 
-	kfree(priv->mtd.name);
+	nand_release(mtd);
+
+	kfree(mtd->name);
 
 	if (priv->vbase)
 		iounmap(priv->vbase);
@@ -1031,6 +1033,7 @@ static int fsl_ifc_nand_probe(struct platform_device *dev)
 	int ret;
 	int bank;
 	struct device_node *node = dev->dev.of_node;
+	struct mtd_info *mtd;
 
 	if (!fsl_ifc_ctrl_dev || !fsl_ifc_ctrl_dev->regs)
 		return -ENODEV;
@@ -1103,8 +1106,10 @@ static int fsl_ifc_nand_probe(struct platform_device *dev)
 		  IFC_NAND_EVTER_INTR_FTOERIR_EN |
 		  IFC_NAND_EVTER_INTR_WPERIR_EN,
 		  &ifc->ifc_nand.nand_evter_intr_en);
-	priv->mtd.name = kasprintf(GFP_KERNEL, "%llx.flash", (u64)res.start);
-	if (!priv->mtd.name) {
+
+	mtd = nand_to_mtd(&priv->chip);
+	mtd->name = kasprintf(GFP_KERNEL, "%llx.flash", (u64)res.start);
+	if (!mtd->name) {
 		ret = -ENOMEM;
 		goto err;
 	}
@@ -1113,22 +1118,21 @@ static int fsl_ifc_nand_probe(struct platform_device *dev)
 	if (ret)
 		goto err;
 
-	ret = nand_scan_ident(&priv->mtd, 1, NULL);
+	ret = nand_scan_ident(mtd, 1, NULL);
 	if (ret)
 		goto err;
 
-	ret = fsl_ifc_chip_init_tail(&priv->mtd);
+	ret = fsl_ifc_chip_init_tail(mtd);
 	if (ret)
 		goto err;
 
-	ret = nand_scan_tail(&priv->mtd);
+	ret = nand_scan_tail(mtd);
 	if (ret)
 		goto err;
 
 	/* First look for RedBoot table or partitions on the command
 	 * line, these take precedence over device tree information */
-	mtd_device_parse_register(&priv->mtd, part_probe_types, NULL,
-						NULL, 0);
+	mtd_device_parse_register(mtd, part_probe_types, NULL, NULL, 0);
 
 	dev_info(priv->dev, "IFC NAND device at 0x%llx, bank %d\n",
 		 (unsigned long long)res.start, priv->bank);
-- 
2.1.4
