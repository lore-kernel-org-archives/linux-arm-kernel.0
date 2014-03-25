From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 25 Mar 2014 08:20:04 +0000
Subject: [RFC 47/47] mtd: nand: stm_nand_bch: catch unsupported calls
In-Reply-To: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
References: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1395735604-26706-48-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Display a BUG() message and return appropriate/expected value.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/stm_nand_bch.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/mtd/nand/stm_nand_bch.c b/drivers/mtd/nand/stm_nand_bch.c
index 4103d4f..e732bf3 100644
--- a/drivers/mtd/nand/stm_nand_bch.c
+++ b/drivers/mtd/nand/stm_nand_bch.c
@@ -852,6 +852,31 @@ static void flex_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 	}
 }
 
+/* Catch calls to non-supported functions */
+static uint16_t flex_read_word_bug(struct mtd_info *mtd)
+{
+	BUG();
+	return 0;
+}
+
+static int flex_block_bad_bug(struct mtd_info *mtd, loff_t ofs, int getchip)
+{
+	BUG();
+	return 1;
+}
+
+static int flex_block_markbad_bug(struct mtd_info *mtd, loff_t ofs)
+{
+	BUG();
+	return 1;
+}
+
+int flex_scan_bbt_bug(struct mtd_info *mtd)
+{
+	BUG();
+	return 1;
+}
+
 /*
  * Hamming-FLEX operations (optimised replacements for nand_base.c versions)
  */
@@ -1916,7 +1941,12 @@ static void nandi_set_mtd_defaults(struct nandi_controller *nandi,
 	chip->read_buf = flex_read_buf;
 	chip->write_buf = flex_write_buf;
 
+	chip->read_word = flex_read_word_bug;
+	chip->block_bad = flex_block_bad_bug;
+	chip->block_markbad = flex_block_markbad_bug;
+
 	chip->bbt_options |= NAND_BBT_USE_FLASH;
+	chip->scan_bbt = flex_scan_bbt_bug;
 
 	/* mtd_info */
 	mtd->owner = THIS_MODULE;
-- 
1.8.3.2
