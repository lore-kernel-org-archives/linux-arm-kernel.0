From: josh.wu@atmel.com (Josh Wu)
Date: Wed, 21 Nov 2012 13:14:23 +0800
Subject: [PATCH] MTD: at91: atmel_nand: return bit flips for the PMECC
 read_page()
Message-ID: <1353474863-28430-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 drivers/mtd/nand/atmel_nand.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 9144557..860dd36 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -723,6 +723,7 @@ static int pmecc_correction(struct mtd_info *mtd, u32 pmecc_stat, uint8_t *buf,
 	struct atmel_nand_host *host = nand_chip->priv;
 	int i, err_nbr, eccbytes;
 	uint8_t *buf_pos;
+	int total_err = 0;
 
 	eccbytes = nand_chip->ecc.bytes;
 	for (i = 0; i < eccbytes; i++)
@@ -750,12 +751,13 @@ normal_check:
 				pmecc_correct_data(mtd, buf_pos, ecc, i,
 					host->pmecc_bytes_per_sector, err_nbr);
 				mtd->ecc_stats.corrected += err_nbr;
+				total_err += err_nbr;
 			}
 		}
 		pmecc_stat >>= 1;
 	}
 
-	return 0;
+	return total_err;
 }
 
 static int atmel_nand_pmecc_read_page(struct mtd_info *mtd,
@@ -767,6 +769,7 @@ static int atmel_nand_pmecc_read_page(struct mtd_info *mtd,
 	uint32_t *eccpos = chip->ecc.layout->eccpos;
 	uint32_t stat;
 	unsigned long end_time;
+	int bitflips = 0;
 
 	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_RST);
 	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
@@ -789,11 +792,13 @@ static int atmel_nand_pmecc_read_page(struct mtd_info *mtd,
 	}
 
 	stat = pmecc_readl_relaxed(host->ecc, ISR);
-	if (stat != 0)
-		if (pmecc_correction(mtd, stat, buf, &oob[eccpos[0]]) != 0)
+	if (stat != 0) {
+		bitflips = pmecc_correction(mtd, stat, buf, &oob[eccpos[0]]);
+		if (bitflips < 0)
 			return -EIO;
+	}
 
-	return 0;
+	return bitflips;
 }
 
 static int atmel_nand_pmecc_write_page(struct mtd_info *mtd,
-- 
1.7.9.5
