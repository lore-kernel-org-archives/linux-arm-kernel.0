From: leiwen@marvell.com (Lei Wen)
Date: Tue, 13 Jul 2010 21:10:32 +0800
Subject: [PATCH 29/29] pxa3xx_nand: new read oob logic only works with
Message-ID: <mailman.150.1280297160.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

new silicon


Signed-off-by: Lei Wen <leiwen@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index bc2f56d..068232c 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -360,6 +360,8 @@ static void pxa3xx_nand_set_timing(struct
pxa3xx_nand_info *info,
 static void pxa3xx_set_datasize(struct pxa3xx_nand_info *info)
 {
 	struct pxa3xx_nand *nand = info->nand_data;
+	struct platform_device *pdev = nand->pdev;
+	struct pxa3xx_nand_platform_data *pdata = pdev->dev.platform_data;
 	int oob_enable = info->reg_ndcr & NDCR_SPARE_EN;

 	if (info->page_size < PAGE_CHUNK_SIZE) {
@@ -388,7 +390,10 @@ static void pxa3xx_set_datasize(struct
pxa3xx_nand_info *info)
 		return;
 	}

-	if (nand->command == NAND_CMD_READOOB) {
+	if (nand->command == NAND_CMD_READOOB
+		&& pdata->controller_attrs & PXA3XX_NAKED_CMD_EN) {
+		/* This special handle read oob method can only be used
+		 * with silicon support naked command*/
 		switch (info->ecc_strength) {
 		case HAMMING_STRENGTH:
 			nand->ndcb1[3] = 2 * PAGE_CHUNK_SIZE + OOB_CHUNK_SIZE;
-- 
1.7.0.4
