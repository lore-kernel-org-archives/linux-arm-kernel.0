From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 08:59:54 +0100
Subject: [PATCH v4 10/58] mtd: nand: brcm: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-11-git-send-email-boris.brezillon@free-electrons.com>
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
 drivers/mtd/nand/brcmnand/brcmnand.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c b/drivers/mtd/nand/brcmnand/brcmnand.c
index 190a99a..26b64bc 100644
--- a/drivers/mtd/nand/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/brcmnand/brcmnand.c
@@ -178,7 +178,6 @@ struct brcmnand_host {
 	struct list_head	node;
 
 	struct nand_chip	chip;
-	struct mtd_info		mtd;
 	struct platform_device	*pdev;
 	int			cs;
 
@@ -1074,7 +1073,7 @@ static int brcmnand_low_level_op(struct brcmnand_host *host,
 				 enum brcmnand_llop_type type, u32 data,
 				 bool last_op)
 {
-	struct mtd_info *mtd = &host->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&host->chip);
 	struct nand_chip *chip = &host->chip;
 	struct brcmnand_controller *ctrl = host->ctrl;
 	u32 tmp;
@@ -1802,7 +1801,7 @@ static inline int get_blk_adr_bytes(u64 size, u32 writesize)
 
 static int brcmnand_setup_dev(struct brcmnand_host *host)
 {
-	struct mtd_info *mtd = &host->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&host->chip);
 	struct nand_chip *chip = &host->chip;
 	struct brcmnand_controller *ctrl = host->ctrl;
 	struct brcmnand_cfg *cfg = &host->hwcfg;
@@ -1916,7 +1915,7 @@ static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
 		return -ENXIO;
 	}
 
-	mtd = &host->mtd;
+	mtd = nand_to_mtd(&host->chip);
 	chip = &host->chip;
 
 	nand_set_flash_node(chip, dn);
@@ -2060,8 +2059,8 @@ static int brcmnand_resume(struct device *dev)
 	}
 
 	list_for_each_entry(host, &ctrl->host_list, node) {
-		struct mtd_info *mtd = &host->mtd;
-		struct nand_chip *chip = mtd_to_nand(mtd);
+		struct nand_chip *chip = &host->chip;
+		struct mtd_info *mtd = nand_to_mtd(chip);
 
 		brcmnand_save_restore_cs_config(host, 1);
 
@@ -2262,7 +2261,7 @@ int brcmnand_remove(struct platform_device *pdev)
 	struct brcmnand_host *host;
 
 	list_for_each_entry(host, &ctrl->host_list, node)
-		nand_release(&host->mtd);
+		nand_release(nand_to_mtd(&host->chip));
 
 	dev_set_drvdata(&pdev->dev, NULL);
 
-- 
2.1.4
