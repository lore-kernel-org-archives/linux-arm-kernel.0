From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 14 Nov 2013 18:25:32 -0300
Subject: [PATCH v5 07/14] mtd: nand: pxa3xx: Remove READ0 switch/case
 falltrough
In-Reply-To: <1384464339-6817-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1384464339-6817-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1384464339-6817-8-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

READ0 and READOOB command preparation has a falltrough to SEQIN
case, where the command address is specified.
This is certainly confusing and makes the code less readable with
no added value. Let's remove it.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 5e0d201..eea1ff8 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -669,6 +669,11 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 		if (mtd->writesize >= PAGE_CHUNK_SIZE)
 			info->ndcb0 |= NDCB0_DBC | (NAND_CMD_READSTART << 8);
 
+		set_command_address(info, mtd->writesize, column, page_addr);
+		info->buf_count = mtd->writesize + mtd->oobsize;
+		memset(info->data_buff, 0xFF, info->buf_count);
+		break;
+
 	case NAND_CMD_SEQIN:
 
 		set_command_address(info, mtd->writesize, column, page_addr);
-- 
1.8.1.5
