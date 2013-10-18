From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 18 Oct 2013 20:02:44 -0300
Subject: [PATCH v2 17/27] mtd: nand: pxa3xx: Remove READ0 switch/case
 falltrough
In-Reply-To: <1382137374-21251-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1382137374-21251-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1382137374-21251-18-git-send-email-ezequiel.garcia@free-electrons.com>
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
index e9d0dde..cc5bcd1 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -674,6 +674,11 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
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
