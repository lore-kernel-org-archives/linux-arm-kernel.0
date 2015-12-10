From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:26 +0100
Subject: [PATCH v4 42/58] mtd: nand: sunxi: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-43-git-send-email-boris.brezillon@free-electrons.com>
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
 drivers/mtd/nand/sunxi_nand.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 4ecd486..c29d659 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -234,7 +234,6 @@ struct sunxi_nand_hw_ecc {
 struct sunxi_nand_chip {
 	struct list_head node;
 	struct nand_chip nand;
-	struct mtd_info mtd;
 	unsigned long clk_rate;
 	u32 timing_cfg;
 	u32 timing_ctl;
@@ -991,6 +990,7 @@ static int sunxi_nand_chip_set_timings(struct sunxi_nand_chip *chip,
 static int sunxi_nand_chip_init_timings(struct sunxi_nand_chip *chip,
 					struct device_node *np)
 {
+	struct mtd_info *mtd = nand_to_mtd(&chip->nand);
 	const struct nand_sdr_timings *timings;
 	int ret;
 	int mode;
@@ -1008,12 +1008,11 @@ static int sunxi_nand_chip_init_timings(struct sunxi_nand_chip *chip,
 
 		feature[0] = mode;
 		for (i = 0; i < chip->nsels; i++) {
-			chip->nand.select_chip(&chip->mtd, i);
-			ret = chip->nand.onfi_set_features(&chip->mtd,
-						&chip->nand,
+			chip->nand.select_chip(mtd, i);
+			ret = chip->nand.onfi_set_features(mtd,	&chip->nand,
 						ONFI_FEATURE_ADDR_TIMING_MODE,
 						feature);
-			chip->nand.select_chip(&chip->mtd, -1);
+			chip->nand.select_chip(mtd, -1);
 			if (ret)
 				return ret;
 		}
@@ -1336,7 +1335,7 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
 	nand->write_buf = sunxi_nfc_write_buf;
 	nand->read_byte = sunxi_nfc_read_byte;
 
-	mtd = &chip->mtd;
+	mtd = nand_to_mtd(nand);
 	mtd->dev.parent = dev;
 	mtd->priv = nand;
 
@@ -1407,7 +1406,7 @@ static void sunxi_nand_chips_cleanup(struct sunxi_nfc *nfc)
 	while (!list_empty(&nfc->chips)) {
 		chip = list_first_entry(&nfc->chips, struct sunxi_nand_chip,
 					node);
-		nand_release(&chip->mtd);
+		nand_release(nand_to_mtd(&chip->nand));
 		sunxi_nand_ecc_cleanup(&chip->nand.ecc);
 		list_del(&chip->node);
 	}
-- 
2.1.4
