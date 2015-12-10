From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:05 +0100
Subject: [PATCH v4 21/58] mtd: nand: fsmc: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-22-git-send-email-boris.brezillon@free-electrons.com>
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
 drivers/mtd/nand/fsmc_nand.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
index 499fc59..4c68e7a 100644
--- a/drivers/mtd/nand/fsmc_nand.c
+++ b/drivers/mtd/nand/fsmc_nand.c
@@ -299,7 +299,6 @@ static struct fsmc_eccplace fsmc_ecc4_sp_place = {
  */
 struct fsmc_nand_data {
 	u32			pid;
-	struct mtd_info		mtd;
 	struct nand_chip	nand;
 	struct mtd_partition	*partitions;
 	unsigned int		nr_partitions;
@@ -328,7 +327,7 @@ struct fsmc_nand_data {
 
 static inline struct fsmc_nand_data *mtd_to_fsmc(struct mtd_info *mtd)
 {
-	return container_of(mtd, struct fsmc_nand_data, mtd);
+	return container_of(mtd_to_nand(mtd), struct fsmc_nand_data, nand);
 }
 
 /* Assert CS signal based on chipnr */
@@ -1008,13 +1007,13 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 		init_completion(&host->dma_access_complete);
 
 	/* Link all private pointers */
-	mtd = &host->mtd;
+	mtd = nand_to_mtd(&host->nand);
 	nand = &host->nand;
 	mtd->priv = nand;
 	nand->priv = host;
 	nand_set_flash_node(nand, np);
 
-	host->mtd.dev.parent = &pdev->dev;
+	mtd->dev.parent = &pdev->dev;
 	nand->IO_ADDR_R = host->data_va;
 	nand->IO_ADDR_W = host->data_va;
 	nand->cmd_ctrl = fsmc_cmd_ctrl;
@@ -1077,14 +1076,14 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 	/*
 	 * Scan to find existence of the device
 	 */
-	if (nand_scan_ident(&host->mtd, 1, NULL)) {
+	if (nand_scan_ident(mtd, 1, NULL)) {
 		ret = -ENXIO;
 		dev_err(&pdev->dev, "No NAND Device found!\n");
 		goto err_scan_ident;
 	}
 
 	if (AMBA_REV_BITS(host->pid) >= 8) {
-		switch (host->mtd.oobsize) {
+		switch (mtd->oobsize) {
 		case 16:
 			nand->ecc.layout = &fsmc_ecc4_16_layout;
 			host->ecc_place = &fsmc_ecc4_sp_place;
@@ -1135,7 +1134,7 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 		 * generated later in nand_bch_init() later.
 		 */
 		if (nand->ecc.mode != NAND_ECC_SOFT_BCH) {
-			switch (host->mtd.oobsize) {
+			switch (mtd->oobsize) {
 			case 16:
 				nand->ecc.layout = &fsmc_ecc1_16_layout;
 				break;
@@ -1156,7 +1155,7 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 	}
 
 	/* Second stage of scan to fill MTD data-structures */
-	if (nand_scan_tail(&host->mtd)) {
+	if (nand_scan_tail(mtd)) {
 		ret = -ENXIO;
 		goto err_probe;
 	}
@@ -1171,9 +1170,8 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 	/*
 	 * Check for partition info passed
 	 */
-	host->mtd.name = "nand";
-	ret = mtd_device_register(&host->mtd, host->partitions,
-				  host->nr_partitions);
+	mtd->name = "nand";
+	ret = mtd_device_register(mtd, host->partitions, host->nr_partitions);
 	if (ret)
 		goto err_probe;
 
@@ -1203,7 +1201,7 @@ static int fsmc_nand_remove(struct platform_device *pdev)
 	struct fsmc_nand_data *host = platform_get_drvdata(pdev);
 
 	if (host) {
-		nand_release(&host->mtd);
+		nand_release(nand_to_mtd(&host->nand));
 
 		if (host->mode == USE_DMA_ACCESS) {
 			dma_release_channel(host->write_dma_chan);
-- 
2.1.4
