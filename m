From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue,  5 Nov 2013 09:55:27 -0300
Subject: [PATCH v3 20/28] mtd: nand: pxa3xx: Fix SEQIN column address set
In-Reply-To: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1383656135-8627-21-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds support page programming with a non-zero "column"
address setting. This is important to support OOB writing, through
command sequences such as:

  cmdfunc(mtd, NAND_CMD_SEQIN, mtd->writesize, ofs);
  write_buf(mtd, oob_buf, 6);
  cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 2e6654c..4999c3d 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -699,7 +699,8 @@ static int prepare_set_command(struct pxa3xx_nand_info *info, int command,
 
 	case NAND_CMD_SEQIN:
 
-		set_command_address(info, mtd->writesize, column, page_addr);
+		info->buf_start = column;
+		set_command_address(info, mtd->writesize, 0, page_addr);
 		break;
 
 	case NAND_CMD_PAGEPROG:
-- 
1.8.1.5
