From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue,  5 Nov 2013 09:55:26 -0300
Subject: [PATCH v3 19/28] mtd: nand: pxa3xx: Move the data buffer clean to
 prepare_start_command()
In-Reply-To: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1383656135-8627-20-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To allow future support of multiple page reading/writing, move the data
buffer clean out of prepare_set_command().

This is done to prevent the data buffer from being cleaned on every command
preparation, when a multiple command sequence is implemented to read/write
pages larger than the FIFO size (2 KiB).

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 82aa1b9..2e6654c 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -614,6 +614,9 @@ static void set_command_address(struct pxa3xx_nand_info *info,
 
 static void prepare_start_command(struct pxa3xx_nand_info *info, int command)
 {
+	struct pxa3xx_nand_host *host = info->host[info->cs];
+	struct mtd_info *mtd = host->mtd;
+
 	/* reset data and oob column point to handle data */
 	info->buf_start		= 0;
 	info->buf_count		= 0;
@@ -638,6 +641,19 @@ static void prepare_start_command(struct pxa3xx_nand_info *info, int command)
 		info->ndcb2 = 0;
 		break;
 	}
+
+	/*
+	 * If we are about to isse a read command, or about to set
+	 * the write address, then clean the data buffer.
+	 */
+	if (command == NAND_CMD_READ0 ||
+	    command == NAND_CMD_READOOB ||
+	    command == NAND_CMD_SEQIN) {
+
+		info->buf_count = mtd->writesize + mtd->oobsize;
+		memset(info->data_buff, 0xFF, info->buf_count);
+	}
+
 }
 
 static int prepare_set_command(struct pxa3xx_nand_info *info, int command,
@@ -679,16 +695,11 @@ static int prepare_set_command(struct pxa3xx_nand_info *info, int command,
 			info->ndcb0 |= NDCB0_DBC | (NAND_CMD_READSTART << 8);
 
 		set_command_address(info, mtd->writesize, column, page_addr);
-		info->buf_count = mtd->writesize + mtd->oobsize;
-		memset(info->data_buff, 0xFF, info->buf_count);
 		break;
 
 	case NAND_CMD_SEQIN:
 
 		set_command_address(info, mtd->writesize, column, page_addr);
-		info->buf_count = mtd->writesize + mtd->oobsize;
-		memset(info->data_buff, 0xFF, info->buf_count);
-
 		break;
 
 	case NAND_CMD_PAGEPROG:
-- 
1.8.1.5
