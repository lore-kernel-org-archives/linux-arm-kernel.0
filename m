From: josh.wu@atmel.com (Josh Wu)
Date: Wed, 14 Jan 2015 11:50:46 +0800
Subject: [PATCH] mtd: atmel_nand: return max bitflips in all sectors in
 pmecc_correction()
Message-ID: <1421207446-16973-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

atmel_nand_pmecc_read_page() will return the total bitflips in this
page. This is incorrect.

As one nand page includes multiple ecc sectors, that will cause the
returned total bitflips exceed ecc capablity.

So this patch will make pmecc_correct() return the max bitflips of all
sectors in the page. That also makes atmel_nand_pmecc_read_page() return
the max bitflips.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 drivers/mtd/nand/atmel_nand.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index a345e7b..7346d16 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -847,7 +847,7 @@ static int pmecc_correction(struct mtd_info *mtd, u32 pmecc_stat, uint8_t *buf,
 	struct atmel_nand_host *host = nand_chip->priv;
 	int i, err_nbr;
 	uint8_t *buf_pos;
-	int total_err = 0;
+	int max_bitflips = 0;
 
 	for (i = 0; i < nand_chip->ecc.total; i++)
 		if (ecc[i] != 0xff)
@@ -874,13 +874,13 @@ normal_check:
 				pmecc_correct_data(mtd, buf_pos, ecc, i,
 					nand_chip->ecc.bytes, err_nbr);
 				mtd->ecc_stats.corrected += err_nbr;
-				total_err += err_nbr;
+				max_bitflips = max_t(int, max_bitflips, err_nbr);
 			}
 		}
 		pmecc_stat >>= 1;
 	}
 
-	return total_err;
+	return max_bitflips;
 }
 
 static void pmecc_enable(struct atmel_nand_host *host, int ecc_op)
-- 
1.9.1
