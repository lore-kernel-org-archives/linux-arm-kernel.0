From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:10 +0100
Subject: [PATCH v4 26/58] mtd: nand: lpc32xx: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-27-git-send-email-boris.brezillon@free-electrons.com>
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
 drivers/mtd/nand/lpc32xx_mlc.c | 7 +++----
 drivers/mtd/nand/lpc32xx_slc.c | 7 +++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/lpc32xx_mlc.c b/drivers/mtd/nand/lpc32xx_mlc.c
index 3738856..3400b3f 100644
--- a/drivers/mtd/nand/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/lpc32xx_mlc.c
@@ -173,7 +173,6 @@ struct lpc32xx_nand_host {
 	struct nand_chip	nand_chip;
 	struct lpc32xx_mlc_platform_data *pdata;
 	struct clk		*clk;
-	struct mtd_info		mtd;
 	void __iomem		*io_base;
 	int			irq;
 	struct lpc32xx_nand_cfg_mlc	*ncfg;
@@ -566,7 +565,7 @@ static void lpc32xx_ecc_enable(struct mtd_info *mtd, int mode)
 
 static int lpc32xx_dma_setup(struct lpc32xx_nand_host *host)
 {
-	struct mtd_info *mtd = &host->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&host->nand_chip);
 	dma_cap_mask_t mask;
 
 	if (!host->pdata || !host->pdata->dma_filter) {
@@ -660,8 +659,8 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	
 	host->io_base_phy = rc->start;
 
-	mtd = &host->mtd;
 	nand_chip = &host->nand_chip;
+	mtd = nand_to_mtd(nand_chip);
 	if (pdev->dev.of_node)
 		host->ncfg = lpc32xx_parse_dt(&pdev->dev);
 	if (!host->ncfg) {
@@ -814,7 +813,7 @@ err_exit1:
 static int lpc32xx_nand_remove(struct platform_device *pdev)
 {
 	struct lpc32xx_nand_host *host = platform_get_drvdata(pdev);
-	struct mtd_info *mtd = &host->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&host->nand_chip);
 
 	nand_release(mtd);
 	free_irq(host->irq, host);
diff --git a/drivers/mtd/nand/lpc32xx_slc.c b/drivers/mtd/nand/lpc32xx_slc.c
index fcd9fac..61b2961 100644
--- a/drivers/mtd/nand/lpc32xx_slc.c
+++ b/drivers/mtd/nand/lpc32xx_slc.c
@@ -204,7 +204,6 @@ struct lpc32xx_nand_host {
 	struct nand_chip	nand_chip;
 	struct lpc32xx_slc_platform_data *pdata;
 	struct clk		*clk;
-	struct mtd_info		mtd;
 	void __iomem		*io_base;
 	struct lpc32xx_nand_cfg_slc *ncfg;
 
@@ -703,7 +702,7 @@ static int lpc32xx_nand_write_page_raw_syndrome(struct mtd_info *mtd,
 
 static int lpc32xx_nand_dma_setup(struct lpc32xx_nand_host *host)
 {
-	struct mtd_info *mtd = &host->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&host->nand_chip);
 	dma_cap_mask_t mask;
 
 	if (!host->pdata || !host->pdata->dma_filter) {
@@ -799,8 +798,8 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 
 	host->pdata = dev_get_platdata(&pdev->dev);
 
-	mtd = &host->mtd;
 	chip = &host->nand_chip;
+	mtd = nand_to_mtd(chip);
 	chip->priv = host;
 	nand_set_flash_node(chip, pdev->dev.of_node);
 	mtd->priv = chip;
@@ -932,7 +931,7 @@ static int lpc32xx_nand_remove(struct platform_device *pdev)
 {
 	uint32_t tmp;
 	struct lpc32xx_nand_host *host = platform_get_drvdata(pdev);
-	struct mtd_info *mtd = &host->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&host->nand_chip);
 
 	nand_release(mtd);
 	dma_release_channel(host->dma_chan);
-- 
2.1.4
