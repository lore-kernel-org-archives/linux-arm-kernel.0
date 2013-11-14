From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 14 Nov 2013 18:25:38 -0300
Subject: [PATCH v5 13/14] mtd: nand: pxa3xx: Add multiple chunk write support
In-Reply-To: <1384464339-6817-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1384464339-6817-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1384464339-6817-14-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds write support for large pages (4 KiB, 8 KiB).
Such support is implemented by issuing a multiple command sequence,
transfering a set of 2 KiB chunks per transaction.

The splitted command sequence requires to send the SEQIN command
independently of the PAGEPROG command and therefore it's set as
an execution command.

Since PAGEPROG enables ECC, each 2 KiB chunk of data is written
together with ECC code at a controller-fixed location within
the flash page.

Currently, only devices with a 4 KiB page size has been tested.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 81 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 73 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 838068f..be28b81 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -760,6 +760,20 @@ static int prepare_set_command(struct pxa3xx_nand_info *info, int command,
 
 		info->buf_start = column;
 		set_command_address(info, mtd->writesize, 0, page_addr);
+
+		/*
+		 * Multiple page programming needs to execute the initial
+		 * SEQIN command that sets the page address.
+		 */
+		if (mtd->writesize > PAGE_CHUNK_SIZE) {
+			info->ndcb0 |= NDCB0_CMD_TYPE(0x1)
+				| NDCB0_EXT_CMD_TYPE(ext_cmd_type)
+				| addr_cycle
+				| command;
+			/* No data transfer in this case */
+			info->data_size = 0;
+			exec_cmd = 1;
+		}
 		break;
 
 	case NAND_CMD_PAGEPROG:
@@ -769,13 +783,40 @@ static int prepare_set_command(struct pxa3xx_nand_info *info, int command,
 			break;
 		}
 
-		info->ndcb0 |= NDCB0_CMD_TYPE(0x1)
-				| NDCB0_AUTO_RS
-				| NDCB0_ST_ROW_EN
-				| NDCB0_DBC
-				| (NAND_CMD_PAGEPROG << 8)
-				| NAND_CMD_SEQIN
-				| addr_cycle;
+		/* Second command setting for large pages */
+		if (mtd->writesize > PAGE_CHUNK_SIZE) {
+			/*
+			 * Multiple page write uses the 'extended command'
+			 * field. This can be used to issue a command dispatch
+			 * or a naked-write depending on the current stage.
+			 */
+			info->ndcb0 |= NDCB0_CMD_TYPE(0x1)
+					| NDCB0_LEN_OVRD
+					| NDCB0_EXT_CMD_TYPE(ext_cmd_type);
+			info->ndcb3 = info->chunk_size +
+				      info->oob_size;
+
+			/*
+			 * This is the command dispatch that completes a chunked
+			 * page program operation.
+			 */
+			if (info->data_size == 0) {
+				info->ndcb0 = NDCB0_CMD_TYPE(0x1)
+					| NDCB0_EXT_CMD_TYPE(ext_cmd_type)
+					| command;
+				info->ndcb1 = 0;
+				info->ndcb2 = 0;
+				info->ndcb3 = 0;
+			}
+		} else {
+			info->ndcb0 |= NDCB0_CMD_TYPE(0x1)
+					| NDCB0_AUTO_RS
+					| NDCB0_ST_ROW_EN
+					| NDCB0_DBC
+					| (NAND_CMD_PAGEPROG << 8)
+					| NAND_CMD_SEQIN
+					| addr_cycle;
+		}
 		break;
 
 	case NAND_CMD_PARAM:
@@ -919,8 +960,15 @@ static void armada370_nand_cmdfunc(struct mtd_info *mtd,
 	case NAND_CMD_READOOB:
 		ext_cmd_type = EXT_CMD_TYPE_MONO;
 		break;
+	case NAND_CMD_SEQIN:
+		ext_cmd_type = EXT_CMD_TYPE_DISPATCH;
+		break;
+	case NAND_CMD_PAGEPROG:
+		ext_cmd_type = EXT_CMD_TYPE_NAKED_RW;
+		break;
 	default:
 		ext_cmd_type = 0;
+		break;
 	}
 
 	prepare_start_command(info, command);
@@ -958,7 +1006,16 @@ static void armada370_nand_cmdfunc(struct mtd_info *mtd,
 		}
 
 		/* Check if the sequence is complete */
-		if (info->data_size == 0)
+		if (info->data_size == 0 && command != NAND_CMD_PAGEPROG)
+			break;
+
+		/*
+		 * After a splitted program command sequence has issued
+		 * the command dispatch, the command sequence is complete.
+		 */
+		if (info->data_size == 0 &&
+		    command == NAND_CMD_PAGEPROG &&
+		    ext_cmd_type == EXT_CMD_TYPE_DISPATCH)
 			break;
 
 		if (command == NAND_CMD_READ0 || command == NAND_CMD_READOOB) {
@@ -967,6 +1024,14 @@ static void armada370_nand_cmdfunc(struct mtd_info *mtd,
 				ext_cmd_type = EXT_CMD_TYPE_LAST_RW;
 			else
 				ext_cmd_type = EXT_CMD_TYPE_NAKED_RW;
+
+		/*
+		 * If a splitted program command has no more data to transfer,
+		 * the command dispatch must be issued to complete.
+		 */
+		} else if (command == NAND_CMD_PAGEPROG &&
+			   info->data_size == 0) {
+				ext_cmd_type = EXT_CMD_TYPE_DISPATCH;
 		}
 	} while (1);
 
-- 
1.8.1.5
