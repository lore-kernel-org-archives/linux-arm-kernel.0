From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 08:59:52 +0100
Subject: [PATCH v4 08/58] mtd: nand: bcm47xx: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-9-git-send-email-boris.brezillon@free-electrons.com>
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
 drivers/mtd/nand/bcm47xxnflash/bcm47xxnflash.h | 1 -
 drivers/mtd/nand/bcm47xxnflash/main.c          | 8 +++++---
 drivers/mtd/nand/bcm47xxnflash/ops_bcm4706.c   | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/bcm47xxnflash/bcm47xxnflash.h b/drivers/mtd/nand/bcm47xxnflash/bcm47xxnflash.h
index c005a62..8ea7571 100644
--- a/drivers/mtd/nand/bcm47xxnflash/bcm47xxnflash.h
+++ b/drivers/mtd/nand/bcm47xxnflash/bcm47xxnflash.h
@@ -12,7 +12,6 @@ struct bcm47xxnflash {
 	struct bcma_drv_cc *cc;
 
 	struct nand_chip nand_chip;
-	struct mtd_info mtd;
 
 	unsigned curr_command;
 	int curr_page_addr;
diff --git a/drivers/mtd/nand/bcm47xxnflash/main.c b/drivers/mtd/nand/bcm47xxnflash/main.c
index 9ba0c0f..4711ca2b 100644
--- a/drivers/mtd/nand/bcm47xxnflash/main.c
+++ b/drivers/mtd/nand/bcm47xxnflash/main.c
@@ -27,6 +27,7 @@ static int bcm47xxnflash_probe(struct platform_device *pdev)
 {
 	struct bcma_nflash *nflash = dev_get_platdata(&pdev->dev);
 	struct bcm47xxnflash *b47n;
+	struct mtd_info *mtd;
 	int err = 0;
 
 	b47n = devm_kzalloc(&pdev->dev, sizeof(*b47n), GFP_KERNEL);
@@ -34,8 +35,9 @@ static int bcm47xxnflash_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	b47n->nand_chip.priv = b47n;
-	b47n->mtd.dev.parent = &pdev->dev;
-	b47n->mtd.priv = &b47n->nand_chip; /* Required */
+	mtd = nand_to_mtd(&b47n->nand_chip);
+	mtd->dev.parent = &pdev->dev;
+	mtd->priv = &b47n->nand_chip; /* Required */
 	b47n->cc = container_of(nflash, struct bcma_drv_cc, nflash);
 
 	if (b47n->cc->core->bus->chipinfo.id == BCMA_CHIP_ID_BCM4706) {
@@ -49,7 +51,7 @@ static int bcm47xxnflash_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = mtd_device_parse_register(&b47n->mtd, probes, NULL, NULL, 0);
+	err = mtd_device_parse_register(mtd, probes, NULL, NULL, 0);
 	if (err) {
 		pr_err("Failed to register MTD device: %d\n", err);
 		return err;
diff --git a/drivers/mtd/nand/bcm47xxnflash/ops_bcm4706.c b/drivers/mtd/nand/bcm47xxnflash/ops_bcm4706.c
index e5b2e48..6524780 100644
--- a/drivers/mtd/nand/bcm47xxnflash/ops_bcm4706.c
+++ b/drivers/mtd/nand/bcm47xxnflash/ops_bcm4706.c
@@ -421,7 +421,7 @@ int bcm47xxnflash_ops_bcm4706_init(struct bcm47xxnflash *b47n)
 			(w4 << 24 | w3 << 18 | w2 << 12 | w1 << 6 | w0));
 
 	/* Scan NAND */
-	err = nand_scan(&b47n->mtd, 1);
+	err = nand_scan(nand_to_mtd(&b47n->nand_chip), 1);
 	if (err) {
 		pr_err("Could not scan NAND flash: %d\n", err);
 		goto exit;
-- 
2.1.4
