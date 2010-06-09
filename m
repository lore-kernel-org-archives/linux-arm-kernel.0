From: leiwen@marvell.com (Lei Wen)
Date: Wed, 9 Jun 2010 09:53:18 +0800
Subject: [PATCH 23/25] pxa3xx_nand: fix reset timeout on mmp2
Message-ID: <mailman.46.1276839603.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For mmp2 board, reset command would always have timeout when enable
the IRQ processing. The command done would comes after exit the IRQ
processing whatever the timeout value is set.

Change reset command use polling mode fix the issue.

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index e76264c..99f4088 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -968,6 +968,10 @@ static int prepare_command_pool(struct
pxa3xx_nand *nand, int command,

 		break;
 	case NAND_CMD_RESET:
+		/* on some platform, it is stranger that when issue reset command,
+		 * cmd done would not come till timeout cause irq exit.
+		 * Force polling mode for reset command*/
+		use_polling = 1;
 		cmd = cmdset.reset;
 		nand->ndcb0[0] |= NDCB0_CMD_TYPE(5)
 				| cmd;
@@ -993,7 +997,7 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info
*mtd, unsigned command,
 {
 	struct pxa3xx_nand_info *info = mtd->priv;
 	struct pxa3xx_nand *nand = info->nand_data;
-	int ret, exec_cmd;
+	int ret, exec_cmd, polling_mode;

 	/* if this is a x16 device ,then convert the input
 	 * "byte" address into a "word" address appropriate
@@ -1009,6 +1013,7 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info
*mtd, unsigned command,
 		nand_writel(nand, NDTR1CS0, info->ndtr1cs0);
 	}

+	polling_mode = use_polling;
 	exec_cmd = prepare_command_pool(nand, command, column, page_addr);
 	if (exec_cmd) {
 		init_completion(&nand->cmd_complete);
@@ -1028,6 +1033,7 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info
*mtd, unsigned command,
 		}
 		nand->state &= ~STATE_CMD_PREPARED;
 	}
+	use_polling = polling_mode;
 }

 static uint8_t pxa3xx_nand_read_byte(struct mtd_info *mtd)
-- 
1.7.0.4
