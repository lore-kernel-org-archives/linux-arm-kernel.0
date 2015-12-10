From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 08:59:58 +0100
Subject: [PATCH v4 14/58] mtd: nand: davinci: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-15-git-send-email-boris.brezillon@free-electrons.com>
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
 drivers/mtd/nand/davinci_nand.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
index b5978d5..b1f69f9 100644
--- a/drivers/mtd/nand/davinci_nand.c
+++ b/drivers/mtd/nand/davinci_nand.c
@@ -53,7 +53,6 @@
  * outputs in a "wire-AND" configuration, with no per-chip signals.
  */
 struct davinci_nand_info {
-	struct mtd_info		mtd;
 	struct nand_chip	chip;
 	struct nand_ecclayout	ecclayout;
 
@@ -80,8 +79,10 @@ struct davinci_nand_info {
 static DEFINE_SPINLOCK(davinci_nand_lock);
 static bool ecc4_busy;
 
-#define to_davinci_nand(m) container_of(m, struct davinci_nand_info, mtd)
-
+static inline struct davinci_nand_info *to_davinci_nand(struct mtd_info *mtd)
+{
+	return container_of(mtd_to_nand(mtd), struct davinci_nand_info, chip);
+}
 
 static inline unsigned int davinci_nand_readl(struct davinci_nand_info *info,
 		int offset)
@@ -636,6 +637,7 @@ static int nand_davinci_probe(struct platform_device *pdev)
 	int				ret;
 	uint32_t			val;
 	nand_ecc_modes_t		ecc_mode;
+	struct mtd_info			*mtd;
 
 	pdata = nand_davinci_get_pdata(pdev);
 	if (IS_ERR(pdata))
@@ -682,8 +684,9 @@ static int nand_davinci_probe(struct platform_device *pdev)
 	info->base		= base;
 	info->vaddr		= vaddr;
 
-	info->mtd.priv		= &info->chip;
-	info->mtd.dev.parent	= &pdev->dev;
+	mtd			= nand_to_mtd(&info->chip);
+	mtd->priv		= &info->chip;
+	mtd->dev.parent		= &pdev->dev;
 	nand_set_flash_node(&info->chip, pdev->dev.of_node);
 
 	info->chip.IO_ADDR_R	= vaddr;
@@ -785,7 +788,7 @@ static int nand_davinci_probe(struct platform_device *pdev)
 	spin_unlock_irq(&davinci_nand_lock);
 
 	/* Scan to find existence of the device(s) */
-	ret = nand_scan_ident(&info->mtd, pdata->mask_chipsel ? 2 : 1, NULL);
+	ret = nand_scan_ident(mtd, pdata->mask_chipsel ? 2 : 1, NULL);
 	if (ret < 0) {
 		dev_dbg(&pdev->dev, "no NAND chip(s) found\n");
 		goto err;
@@ -797,9 +800,9 @@ static int nand_davinci_probe(struct platform_device *pdev)
 	 * usable:  10 bytes are needed, not 6.
 	 */
 	if (pdata->ecc_bits == 4) {
-		int	chunks = info->mtd.writesize / 512;
+		int	chunks = mtd->writesize / 512;
 
-		if (!chunks || info->mtd.oobsize < 16) {
+		if (!chunks || mtd->oobsize < 16) {
 			dev_dbg(&pdev->dev, "too small\n");
 			ret = -EINVAL;
 			goto err;
@@ -811,8 +814,7 @@ static int nand_davinci_probe(struct platform_device *pdev)
 		 */
 		if (chunks == 1) {
 			info->ecclayout = hwecc4_small;
-			info->ecclayout.oobfree[1].length =
-				info->mtd.oobsize - 16;
+			info->ecclayout.oobfree[1].length = mtd->oobsize - 16;
 			goto syndrome_done;
 		}
 		if (chunks == 4) {
@@ -833,15 +835,15 @@ syndrome_done:
 		info->chip.ecc.layout = &info->ecclayout;
 	}
 
-	ret = nand_scan_tail(&info->mtd);
+	ret = nand_scan_tail(mtd);
 	if (ret < 0)
 		goto err;
 
 	if (pdata->parts)
-		ret = mtd_device_parse_register(&info->mtd, NULL, NULL,
+		ret = mtd_device_parse_register(mtd, NULL, NULL,
 					pdata->parts, pdata->nr_parts);
 	else
-		ret = mtd_device_register(&info->mtd, NULL, 0);
+		ret = mtd_device_register(mtd, NULL, 0);
 	if (ret < 0)
 		goto err;
 
@@ -871,7 +873,7 @@ static int nand_davinci_remove(struct platform_device *pdev)
 		ecc4_busy = false;
 	spin_unlock_irq(&davinci_nand_lock);
 
-	nand_release(&info->mtd);
+	nand_release(nand_to_mtd(&info->chip));
 
 	clk_disable_unprepare(info->clk);
 
-- 
2.1.4
