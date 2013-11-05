From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue,  5 Nov 2013 09:55:23 -0300
Subject: [PATCH v3 16/28] mtd: nand: pxa3xx: Add helper function to set page
 address
In-Reply-To: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1383656135-8627-17-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's simplify the code by first introducing a helper function
to set the page address, as done by the READ0, READOOB and SEQIN
commands.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 6544300..7cc67b0 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -592,6 +592,26 @@ static inline int is_buf_blank(uint8_t *buf, size_t len)
 	return 1;
 }
 
+static void set_command_address(struct pxa3xx_nand_info *info,
+		unsigned int page_size, uint16_t column, int page_addr)
+{
+	/* small page addr setting */
+	if (page_size < PAGE_CHUNK_SIZE) {
+		info->ndcb1 = ((page_addr & 0xFFFFFF) << 8)
+				| (column & 0xFF);
+
+		info->ndcb2 = 0;
+	} else {
+		info->ndcb1 = ((page_addr & 0xFFFF) << 16)
+				| (column & 0xFFFF);
+
+		if (page_addr & 0xFF0000)
+			info->ndcb2 = (page_addr & 0xFF0000) >> 16;
+		else
+			info->ndcb2 = 0;
+	}
+}
+
 static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 		uint16_t column, int page_addr)
 {
@@ -655,22 +675,8 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 			info->ndcb0 |= NDCB0_DBC | (NAND_CMD_READSTART << 8);
 
 	case NAND_CMD_SEQIN:
-		/* small page addr setting */
-		if (unlikely(mtd->writesize < PAGE_CHUNK_SIZE)) {
-			info->ndcb1 = ((page_addr & 0xFFFFFF) << 8)
-					| (column & 0xFF);
-
-			info->ndcb2 = 0;
-		} else {
-			info->ndcb1 = ((page_addr & 0xFFFF) << 16)
-					| (column & 0xFFFF);
-
-			if (page_addr & 0xFF0000)
-				info->ndcb2 = (page_addr & 0xFF0000) >> 16;
-			else
-				info->ndcb2 = 0;
-		}
 
+		set_command_address(info, mtd->writesize, column, page_addr);
 		info->buf_count = mtd->writesize + mtd->oobsize;
 		memset(info->data_buff, 0xFF, info->buf_count);
 
-- 
1.8.1.5
