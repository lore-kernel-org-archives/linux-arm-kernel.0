From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:02 +0100
Subject: [PATCH v4 18/58] mtd: nand: fsl_elbc: use the mtd instance embedded
 in struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-19-git-send-email-boris.brezillon@free-electrons.com>
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
 drivers/mtd/nand/fsl_elbc_nand.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index ad6d5da..7bde76a 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -48,7 +48,6 @@
 /* mtd information per set */
 
 struct fsl_elbc_mtd {
-	struct mtd_info mtd;
 	struct nand_chip chip;
 	struct fsl_lbc_ctrl *ctrl;
 
@@ -742,12 +741,13 @@ static int fsl_elbc_chip_init(struct fsl_elbc_mtd *priv)
 	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
 	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = ctrl->nand;
 	struct nand_chip *chip = &priv->chip;
+	struct mtd_info *mtd = nand_to_mtd(chip);
 
 	dev_dbg(priv->dev, "eLBC Set Information for bank %d\n", priv->bank);
 
 	/* Fill in fsl_elbc_mtd structure */
-	priv->mtd.priv = chip;
-	priv->mtd.dev.parent = priv->dev;
+	mtd->priv = chip;
+	mtd->dev.parent = priv->dev;
 	nand_set_flash_node(chip, priv->dev->of_node);
 
 	/* set timeout to maximum */
@@ -798,9 +798,11 @@ static int fsl_elbc_chip_init(struct fsl_elbc_mtd *priv)
 static int fsl_elbc_chip_remove(struct fsl_elbc_mtd *priv)
 {
 	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = priv->ctrl->nand;
-	nand_release(&priv->mtd);
+	struct mtd_info *mtd = nand_to_mtd(&priv->chip);
 
-	kfree(priv->mtd.name);
+	nand_release(mtd);
+
+	kfree(mtd->name);
 
 	if (priv->vbase)
 		iounmap(priv->vbase);
@@ -824,6 +826,7 @@ static int fsl_elbc_nand_probe(struct platform_device *pdev)
 	int bank;
 	struct device *dev;
 	struct device_node *node = pdev->dev.of_node;
+	struct mtd_info *mtd;
 
 	if (!fsl_lbc_ctrl_dev || !fsl_lbc_ctrl_dev->regs)
 		return -ENODEV;
@@ -886,8 +889,9 @@ static int fsl_elbc_nand_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	priv->mtd.name = kasprintf(GFP_KERNEL, "%llx.flash", (u64)res.start);
-	if (!priv->mtd.name) {
+	mtd = nand_to_mtd(&priv->chip);
+	mtd->name = kasprintf(GFP_KERNEL, "%llx.flash", (u64)res.start);
+	if (!nand_to_mtd(&priv->chip)->name) {
 		ret = -ENOMEM;
 		goto err;
 	}
@@ -896,21 +900,21 @@ static int fsl_elbc_nand_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
-	ret = nand_scan_ident(&priv->mtd, 1, NULL);
+	ret = nand_scan_ident(mtd, 1, NULL);
 	if (ret)
 		goto err;
 
-	ret = fsl_elbc_chip_init_tail(&priv->mtd);
+	ret = fsl_elbc_chip_init_tail(mtd);
 	if (ret)
 		goto err;
 
-	ret = nand_scan_tail(&priv->mtd);
+	ret = nand_scan_tail(mtd);
 	if (ret)
 		goto err;
 
 	/* First look for RedBoot table or partitions on the command
 	 * line, these take precedence over device tree information */
-	mtd_device_parse_register(&priv->mtd, part_probe_types, NULL,
+	mtd_device_parse_register(mtd, part_probe_types, NULL,
 				  NULL, 0);
 
 	printk(KERN_INFO "eLBC NAND device at 0x%llx, bank %d\n",
-- 
2.1.4
