From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 14 Nov 2013 18:25:33 -0300
Subject: [PATCH v5 08/14] mtd: nand: pxa3xx: Split prepare_command_pool() in
 two stages
In-Reply-To: <1384464339-6817-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1384464339-6817-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1384464339-6817-9-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit splits the prepare_command_pool() function into two
stages: prepare_start_command() / prepare_set_command().

This is a preparation patch without any functionality changes,
and is meant to allow support for multiple page reading/writing
operations.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 44 ++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index eea1ff8..b66f32b 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -607,18 +607,8 @@ static void set_command_address(struct pxa3xx_nand_info *info,
 	}
 }
 
-static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
-		uint16_t column, int page_addr)
+static void prepare_start_command(struct pxa3xx_nand_info *info, int command)
 {
-	int addr_cycle, exec_cmd;
-	struct pxa3xx_nand_host *host;
-	struct mtd_info *mtd;
-
-	host = info->host[info->cs];
-	mtd = host->mtd;
-	addr_cycle = 0;
-	exec_cmd = 1;
-
 	/* reset data and oob column point to handle data */
 	info->buf_start		= 0;
 	info->buf_count		= 0;
@@ -627,10 +617,6 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 	info->use_spare		= 1;
 	info->retcode		= ERR_NONE;
 	info->ndcb3		= 0;
-	if (info->cs != 0)
-		info->ndcb0 = NDCB0_CSEL;
-	else
-		info->ndcb0 = 0;
 
 	switch (command) {
 	case NAND_CMD_READ0:
@@ -642,14 +628,32 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 	case NAND_CMD_PARAM:
 		info->use_spare = 0;
 		break;
-	case NAND_CMD_SEQIN:
-		exec_cmd = 0;
-		break;
 	default:
 		info->ndcb1 = 0;
 		info->ndcb2 = 0;
 		break;
 	}
+}
+
+static int prepare_set_command(struct pxa3xx_nand_info *info, int command,
+		uint16_t column, int page_addr)
+{
+	int addr_cycle, exec_cmd;
+	struct pxa3xx_nand_host *host;
+	struct mtd_info *mtd;
+
+	host = info->host[info->cs];
+	mtd = host->mtd;
+	addr_cycle = 0;
+	exec_cmd = 1;
+
+	if (info->cs != 0)
+		info->ndcb0 = NDCB0_CSEL;
+	else
+		info->ndcb0 = 0;
+
+	if (command == NAND_CMD_SEQIN)
+		exec_cmd = 0;
 
 	addr_cycle = NDCB0_ADDR_CYC(host->row_addr_cycles
 				    + host->col_addr_cycles);
@@ -784,8 +788,10 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
 		nand_writel(info, NDTR1CS0, info->ndtr1cs0);
 	}
 
+	prepare_start_command(info, command);
+
 	info->state = STATE_PREPARED;
-	exec_cmd = prepare_command_pool(info, command, column, page_addr);
+	exec_cmd = prepare_set_command(info, command, column, page_addr);
 	if (exec_cmd) {
 		init_completion(&info->cmd_complete);
 		init_completion(&info->dev_ready);
-- 
1.8.1.5
