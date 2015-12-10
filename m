From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:08 +0100
Subject: [PATCH v4 24/58] mtd: nand: hisi504: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-25-git-send-email-boris.brezillon@free-electrons.com>
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
 drivers/mtd/nand/hisi504_nand.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/hisi504_nand.c b/drivers/mtd/nand/hisi504_nand.c
index 6358d4a..6e6e482 100644
--- a/drivers/mtd/nand/hisi504_nand.c
+++ b/drivers/mtd/nand/hisi504_nand.c
@@ -134,7 +134,6 @@
 
 struct hinfc_host {
 	struct nand_chip	chip;
-	struct mtd_info		mtd;
 	struct device		*dev;
 	void __iomem		*iobase;
 	void __iomem		*mmio;
@@ -189,8 +188,8 @@ static void wait_controller_finished(struct hinfc_host *host)
 
 static void hisi_nfc_dma_transfer(struct hinfc_host *host, int todev)
 {
-	struct mtd_info	*mtd = &host->mtd;
-	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct nand_chip *chip = &host->chip;
+	struct mtd_info	*mtd = nand_to_mtd(chip);
 	unsigned long val;
 	int ret;
 
@@ -262,7 +261,7 @@ static int hisi_nfc_send_cmd_pageprog(struct hinfc_host *host)
 
 static int hisi_nfc_send_cmd_readstart(struct hinfc_host *host)
 {
-	struct mtd_info	*mtd = &host->mtd;
+	struct mtd_info	*mtd = nand_to_mtd(&host->chip);
 
 	if ((host->addr_value[0] == host->cache_addr_value[0]) &&
 	    (host->addr_value[1] == host->cache_addr_value[1]))
@@ -643,7 +642,7 @@ static int hisi_nfc_ecc_probe(struct hinfc_host *host)
 	int size, strength, ecc_bits;
 	struct device *dev = host->dev;
 	struct nand_chip *chip = &host->chip;
-	struct mtd_info *mtd = &host->mtd;
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct device_node *np = host->dev->of_node;
 
 	size = of_get_nand_ecc_step_size(np);
@@ -712,7 +711,7 @@ static int hisi_nfc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, host);
 	chip = &host->chip;
-	mtd  = &host->mtd;
+	mtd  = nand_to_mtd(chip);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -822,7 +821,7 @@ err_res:
 static int hisi_nfc_remove(struct platform_device *pdev)
 {
 	struct hinfc_host *host = platform_get_drvdata(pdev);
-	struct mtd_info *mtd = &host->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&host->chip);
 
 	nand_release(mtd);
 
-- 
2.1.4
