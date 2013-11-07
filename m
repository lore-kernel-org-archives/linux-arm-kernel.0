From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu,  7 Nov 2013 12:17:13 -0300
Subject: [PATCH v4 09/31] mtd: nand: pxa3xx: read_page() returns max_bitflips
In-Reply-To: <1383837455-30721-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383837455-30721-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1383837455-30721-10-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per the ecc.read_page() prototype, we must return the maximum number
of bitflips that were corrected on any one region covering an ecc step.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index c578ca7..521d43e 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -751,6 +751,7 @@ static int pxa3xx_nand_read_page_hwecc(struct mtd_info *mtd,
 {
 	struct pxa3xx_nand_host *host = mtd->priv;
 	struct pxa3xx_nand_info *info = host->info_data;
+	int max_bitflips = 0;
 
 	chip->read_buf(mtd, buf, mtd->writesize);
 	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
@@ -758,6 +759,7 @@ static int pxa3xx_nand_read_page_hwecc(struct mtd_info *mtd,
 	if (info->retcode == ERR_SBERR) {
 		switch (info->use_ecc) {
 		case 1:
+			max_bitflips = 1;
 			mtd->ecc_stats.corrected++;
 			break;
 		case 0:
@@ -776,7 +778,7 @@ static int pxa3xx_nand_read_page_hwecc(struct mtd_info *mtd,
 			mtd->ecc_stats.failed++;
 	}
 
-	return 0;
+	return max_bitflips;
 }
 
 static uint8_t pxa3xx_nand_read_byte(struct mtd_info *mtd)
-- 
1.8.1.5
