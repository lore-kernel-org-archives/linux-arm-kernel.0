From: leiwen@marvell.com (Lei Wen)
Date: Tue, 28 Jun 2011 20:51:26 -0700
Subject: [PATCH 1/9] MTD: pxa3xx_nand: convert all printk into dev_*
In-Reply-To: <1309246361.23597.30.camel@sauron>
References: <1309246361.23597.30.camel@sauron>
Message-ID: <1309319494-17951-2-git-send-email-leiwen@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lei Wen <leiwen@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index b7db1b2..44fb210 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -359,7 +359,7 @@ static void handle_data_pio(struct pxa3xx_nand_info *info)
 					DIV_ROUND_UP(info->oob_size, 4));
 		break;
 	default:
-		printk(KERN_ERR "%s: invalid state %d\n", __func__,
+		dev_err(&info->pdev->dev, "%s: invalid state %d\n", __func__,
 				info->state);
 		BUG();
 	}
@@ -385,7 +385,7 @@ static void start_data_dma(struct pxa3xx_nand_info *info)
 		desc->dcmd |= DCMD_INCTRGADDR | DCMD_FLOWSRC;
 		break;
 	default:
-		printk(KERN_ERR "%s: invalid state %d\n", __func__,
+		dev_err(&info->pdev->dev, "%s: invalid state %d\n", __func__,
 				info->state);
 		BUG();
 	}
@@ -616,8 +616,8 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 
 	default:
 		exec_cmd = 0;
-		printk(KERN_ERR "pxa3xx-nand: non-supported"
-			" command %x\n", command);
+		dev_err(&info->pdev->dev, "non-supported command %x\n",
+				command);
 		break;
 	}
 
@@ -646,7 +646,7 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
 		ret = wait_for_completion_timeout(&info->cmd_complete,
 				CHIP_DELAY_TIMEOUT);
 		if (!ret) {
-			printk(KERN_ERR "Wait time out!!!\n");
+			dev_err(&info->pdev->dev, "Wait time out!!!\n");
 			/* Stop State Machine for next command cycle */
 			pxa3xx_nand_stop(info);
 		}
@@ -898,7 +898,7 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 	if (!ret) {
 		kfree(mtd);
 		info->mtd = NULL;
-		printk(KERN_INFO "There is no nand chip on cs 0!\n");
+		dev_info(&info->pdev->dev, "There is no nand chip on cs 0!\n");
 
 		return -EINVAL;
 	}
@@ -906,11 +906,12 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 	chip->cmdfunc(mtd, NAND_CMD_READID, 0, 0);
 	id = *((uint16_t *)(info->data_buff));
 	if (id != 0)
-		printk(KERN_INFO "Detect a flash id %x\n", id);
+		dev_info(&info->pdev->dev, "Detect a flash id %x\n", id);
 	else {
 		kfree(mtd);
 		info->mtd = NULL;
-		printk(KERN_WARNING "Read out ID 0, potential timing set wrong!!\n");
+		dev_warn(&info->pdev->dev, "Read out ID 0, "
+				"potential timing set wrong!!\n");
 
 		return -EINVAL;
 	}
@@ -930,7 +931,7 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 	if (i >= (ARRAY_SIZE(builtin_flash_types) + pdata->num_flash - 1)) {
 		kfree(mtd);
 		info->mtd = NULL;
-		printk(KERN_ERR "ERROR!! flash not defined!!!\n");
+		dev_err(&info->pdev->dev, "ERROR!! flash not defined!!!\n");
 
 		return -EINVAL;
 	}
-- 
1.7.0.4
