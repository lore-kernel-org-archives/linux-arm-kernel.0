From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Thu,  2 Aug 2012 16:06:47 +0300
Subject: [PATCH] mtd: use %*ph[CN] to dump small buffers
Message-ID: <1343912807-29355-1-git-send-email-andriy.shevchenko@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is new format specified that helps to dump small buffers. It makes the
code simplier and nicer.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Jiandong Zheng <jdzheng@broadcom.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
---
 drivers/mtd/devices/doc2001plus.c |   14 +++-----------
 drivers/mtd/devices/docg3.c       |   12 +++---------
 drivers/mtd/nand/bcm_umi_bch.c    |   17 ++++-------------
 drivers/mtd/nand/s3c2410.c        |   11 ++++-------
 4 files changed, 14 insertions(+), 40 deletions(-)

diff --git a/drivers/mtd/devices/doc2001plus.c b/drivers/mtd/devices/doc2001plus.c
index 04eb2e4..753e50b 100644
--- a/drivers/mtd/devices/doc2001plus.c
+++ b/drivers/mtd/devices/doc2001plus.c
@@ -659,23 +659,15 @@ static int doc_read(struct mtd_info *mtd, loff_t from, size_t len,
 #ifdef ECC_DEBUG
 			printk("%s(%d): Millennium Plus ECC error (from=0x%x:\n",
 				__FILE__, __LINE__, (int)from);
-			printk("        syndrome= %02x:%02x:%02x:%02x:%02x:"
-				"%02x\n",
-				syndrome[0], syndrome[1], syndrome[2],
-				syndrome[3], syndrome[4], syndrome[5]);
-			printk("          eccbuf= %02x:%02x:%02x:%02x:%02x:"
-				"%02x\n",
-				eccbuf[0], eccbuf[1], eccbuf[2],
-				eccbuf[3], eccbuf[4], eccbuf[5]);
+			printk("        syndrome= %*phC\n", 6, syndrome);
+			printk("          eccbuf= %*phC\n", 6, eccbuf);
 #endif
 				ret = -EIO;
 		}
 	}
 
 #ifdef PSYCHO_DEBUG
-	printk("ECC DATA at %lx: %2.2X %2.2X %2.2X %2.2X %2.2X %2.2X\n",
-	       (long)from, eccbuf[0], eccbuf[1], eccbuf[2], eccbuf[3],
-	       eccbuf[4], eccbuf[5]);
+	printk("ECC DATA at %lx: %*ph\n", (long)from, 6, eccbuf);
 #endif
 	/* disable the ECC engine */
 	WriteDOC(DOC_ECC_DIS, docptr , Mplus_ECCConf);
diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
index f70854d..d34d83b 100644
--- a/drivers/mtd/devices/docg3.c
+++ b/drivers/mtd/devices/docg3.c
@@ -919,19 +919,13 @@ static int doc_read_oob(struct mtd_info *mtd, loff_t from,
 		eccconf1 = doc_register_readb(docg3, DOC_ECCCONF1);
 
 		if (nboob >= DOC_LAYOUT_OOB_SIZE) {
-			doc_dbg("OOB - INFO: %02x:%02x:%02x:%02x:%02x:%02x:%02x\n",
-				oobbuf[0], oobbuf[1], oobbuf[2], oobbuf[3],
-				oobbuf[4], oobbuf[5], oobbuf[6]);
+			doc_dbg("OOB - INFO: %*phC\n", 7, oobbuf);
 			doc_dbg("OOB - HAMMING: %02x\n", oobbuf[7]);
-			doc_dbg("OOB - BCH_ECC: %02x:%02x:%02x:%02x:%02x:%02x:%02x\n",
-				oobbuf[8], oobbuf[9], oobbuf[10], oobbuf[11],
-				oobbuf[12], oobbuf[13], oobbuf[14]);
+			doc_dbg("OOB - BCH_ECC: %*phC\n", 7, oobbuf + 8);
 			doc_dbg("OOB - UNUSED: %02x\n", oobbuf[15]);
 		}
 		doc_dbg("ECC checks: ECCConf1=%x\n", eccconf1);
-		doc_dbg("ECC HW_ECC: %02x:%02x:%02x:%02x:%02x:%02x:%02x\n",
-			hwecc[0], hwecc[1], hwecc[2], hwecc[3], hwecc[4],
-			hwecc[5], hwecc[6]);
+		doc_dbg("ECC HW_ECC: %*phC\n", 7, hwecc);
 
 		ret = -EIO;
 		if (is_prot_seq_error(docg3))
diff --git a/drivers/mtd/nand/bcm_umi_bch.c b/drivers/mtd/nand/bcm_umi_bch.c
index c8799a0..ce39c87 100644
--- a/drivers/mtd/nand/bcm_umi_bch.c
+++ b/drivers/mtd/nand/bcm_umi_bch.c
@@ -154,19 +154,10 @@ static int bcm_umi_bch_read_page_hwecc(struct mtd_info *mtd,
 #if defined(NAND_BCM_UMI_DEBUG)
 			printk(KERN_WARNING "%s uncorr_err sectorIdx=%d\n",
 			       __func__, sectorIdx);
-			printk(KERN_WARNING
-			       "%s data %02x %02x %02x %02x "
-					 "%02x %02x %02x %02x\n",
-			       __func__, datap[0], datap[1], datap[2], datap[3],
-			       datap[4], datap[5], datap[6], datap[7]);
-			printk(KERN_WARNING
-			       "%s ecc  %02x %02x %02x %02x "
-					 "%02x %02x %02x %02x %02x %02x "
-					 "%02x %02x %02x\n",
-			       __func__, eccCalc[0], eccCalc[1], eccCalc[2],
-			       eccCalc[3], eccCalc[4], eccCalc[5], eccCalc[6],
-			       eccCalc[7], eccCalc[8], eccCalc[9], eccCalc[10],
-			       eccCalc[11], eccCalc[12]);
+			printk(KERN_WARNING "%s data %*ph\n",
+			       __func__, 8, datap);
+			printk(KERN_WARNING "%s ecc  %*ph\n",
+			       __func__, 13, eccCalc);
 			BUG();
 #endif
 			mtd->ecc_stats.failed++;
diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
index 91121f3..7bc6f7d 100644
--- a/drivers/mtd/nand/s3c2410.c
+++ b/drivers/mtd/nand/s3c2410.c
@@ -463,10 +463,8 @@ static int s3c2410_nand_correct_data(struct mtd_info *mtd, u_char *dat,
 	diff1 = read_ecc[1] ^ calc_ecc[1];
 	diff2 = read_ecc[2] ^ calc_ecc[2];
 
-	pr_debug("%s: rd %02x%02x%02x calc %02x%02x%02x diff %02x%02x%02x\n",
-		 __func__,
-		 read_ecc[0], read_ecc[1], read_ecc[2],
-		 calc_ecc[0], calc_ecc[1], calc_ecc[2],
+	pr_debug("%s: rd %*phN calc %*phN diff %02x%02x%02x\n",
+		 __func__, 3, read_ecc, 3, calc_ecc,
 		 diff0, diff1, diff2);
 
 	if (diff0 == 0 && diff1 == 0 && diff2 == 0)
@@ -566,8 +564,7 @@ static int s3c2410_nand_calculate_ecc(struct mtd_info *mtd, const u_char *dat, u
 	ecc_code[1] = readb(info->regs + S3C2410_NFECC + 1);
 	ecc_code[2] = readb(info->regs + S3C2410_NFECC + 2);
 
-	pr_debug("%s: returning ecc %02x%02x%02x\n", __func__,
-		 ecc_code[0], ecc_code[1], ecc_code[2]);
+	pr_debug("%s: returning ecc %*phN\n", __func__, 3, ecc_code);
 
 	return 0;
 }
@@ -581,7 +578,7 @@ static int s3c2412_nand_calculate_ecc(struct mtd_info *mtd, const u_char *dat, u
 	ecc_code[1] = ecc >> 8;
 	ecc_code[2] = ecc >> 16;
 
-	pr_debug("calculate_ecc: returning ecc %02x,%02x,%02x\n", ecc_code[0], ecc_code[1], ecc_code[2]);
+	pr_debug("%s: returning ecc %*phN\n", __func__, 3, ecc_code);
 
 	return 0;
 }
-- 
1.7.10.4
