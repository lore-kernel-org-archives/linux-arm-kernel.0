From: b32955@freescale.com (Huang Shijie)
Date: Fri, 3 Jan 2014 11:01:40 +0800
Subject: [PATCH 1/3] mtd: nand: add "page" argument for read_subpage hook
In-Reply-To: <a>
References: <a>
Message-ID: <1388718102-26097-2-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the "page" argument for the read_subpage hook. With this argument,
the implementation of this hook could prints out more accurate information
for debugging.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/nand_base.c |    7 +++++--
 include/linux/mtd/nand.h     |    2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 9b3bb3c..b2556f8 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -1115,9 +1115,11 @@ static int nand_read_page_swecc(struct mtd_info *mtd, struct nand_chip *chip,
  * @data_offs: offset of requested data within the page
  * @readlen: data length
  * @bufpoi: buffer to store read data
+ * @page: page number to read
  */
 static int nand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
-			uint32_t data_offs, uint32_t readlen, uint8_t *bufpoi)
+			uint32_t data_offs, uint32_t readlen, uint8_t *bufpoi,
+			int page)
 {
 	int start_step, end_step, num_steps;
 	uint32_t *eccpos = chip->ecc.layout->eccpos;
@@ -1467,7 +1469,8 @@ static int nand_do_read_ops(struct mtd_info *mtd, loff_t from,
 			else if (!aligned && NAND_HAS_SUBPAGE_READ(chip) &&
 				 !oob)
 				ret = chip->ecc.read_subpage(mtd, chip,
-							col, bytes, bufpoi);
+							col, bytes, bufpoi,
+							page);
 			else
 				ret = chip->ecc.read_page(mtd, chip, bufpoi,
 							  oob_required, page);
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 9e6c8f9..b7a344c 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -394,7 +394,7 @@ struct nand_ecc_ctrl {
 	int (*read_page)(struct mtd_info *mtd, struct nand_chip *chip,
 			uint8_t *buf, int oob_required, int page);
 	int (*read_subpage)(struct mtd_info *mtd, struct nand_chip *chip,
-			uint32_t offs, uint32_t len, uint8_t *buf);
+			uint32_t offs, uint32_t len, uint8_t *buf, int page);
 	int (*write_subpage)(struct mtd_info *mtd, struct nand_chip *chip,
 			uint32_t offset, uint32_t data_len,
 			const uint8_t *data_buf, int oob_required);
-- 
1.7.2.rc3
