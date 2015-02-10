From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 10 Feb 2015 19:59:58 +0100
Subject: [PATCH 4/6] mtd: mxc-nand: Allow to use column addresses different
 from 0
In-Reply-To: <1423594800-24214-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1423594800-24214-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1423594800-24214-5-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mxc-nand controller works pagewise and so usually only sends
commands to the flash chip with column == 0. A request with column != 0
from the upper layer is then fulfilled by indexing appropriately into the
device's RAM buffer.

To be able to access the ONFI marker at offset 0x20 in reply to the
READID command however it's invalid to read 32 bytes starting from
column 0.

So let the function used to send the address cycles send the column
address actually passed instead of 0 and fix all callers to pass 0
instead appropriately. Also add some warnings in case this patch changes
the drivers semantics.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/mtd/nand/mxc_nand.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index aa98a0dddcfb..0afe5904a337 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -836,6 +836,12 @@ static void copy_spare(struct mtd_info *mtd, bool bfrom)
 	}
 }
 
+/*
+ * MXC NANDFC can only perform full page+spare or spare-only read/write.  When
+ * the upper layers perform a read/write buf operation, the saved column address
+ * is used to index into the full page. So usually this function is called with
+ * column == 0 (unless no column cycle is needed indicated by column == -1)
+ */
 static void mxc_do_addr_cycle(struct mtd_info *mtd, int column, int page_addr)
 {
 	struct nand_chip *nand_chip = mtd->priv;
@@ -843,16 +849,13 @@ static void mxc_do_addr_cycle(struct mtd_info *mtd, int column, int page_addr)
 
 	/* Write out column address, if necessary */
 	if (column != -1) {
-		/*
-		 * MXC NANDFC can only perform full page+spare or
-		 * spare-only read/write.  When the upper layers
-		 * perform a read/write buf operation, the saved column
-		  * address is used to index into the full page.
-		 */
-		host->devtype_data->send_addr(host, 0, page_addr == -1);
+		host->devtype_data->send_addr(host, column & 0xff,
+					      page_addr == -1);
 		if (mtd->writesize > 512)
 			/* another col addr cycle for 2k page */
-			host->devtype_data->send_addr(host, 0, false);
+			host->devtype_data->send_addr(host,
+						      (column >> 8) & 0xff,
+						      false);
 	}
 
 	/* Write out page address, if necessary */
@@ -1077,6 +1080,9 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
 		host->status_request = true;
 
 		host->devtype_data->send_cmd(host, command, true);
+		WARN_ONCE(column != -1 || page_addr != -1,
+			  "Unexpected column/row value (cmd=%u, col=%d, row=%d)\n",
+			  command, column, page_addr);
 		mxc_do_addr_cycle(mtd, column, page_addr);
 		break;
 
@@ -1090,7 +1096,10 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
 		command = NAND_CMD_READ0; /* only READ0 is valid */
 
 		host->devtype_data->send_cmd(host, command, false);
-		mxc_do_addr_cycle(mtd, column, page_addr);
+		WARN_ONCE(column < 0,
+			  "Unexpected column/row value (cmd=%u, col=%d, row=%d)\n",
+			  command, column, page_addr);
+		mxc_do_addr_cycle(mtd, 0, page_addr);
 
 		if (mtd->writesize > 512)
 			host->devtype_data->send_cmd(host,
@@ -1111,7 +1120,10 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
 		host->buf_start = column;
 
 		host->devtype_data->send_cmd(host, command, false);
-		mxc_do_addr_cycle(mtd, column, page_addr);
+		WARN_ONCE(column < -1,
+			  "Unexpected column/row value (cmd=%u, col=%d, row=%d)\n",
+			  command, column, page_addr);
+		mxc_do_addr_cycle(mtd, 0, page_addr);
 		break;
 
 	case NAND_CMD_PAGEPROG:
@@ -1119,6 +1131,9 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
 		copy_spare(mtd, false);
 		host->devtype_data->send_page(mtd, NFC_INPUT);
 		host->devtype_data->send_cmd(host, command, true);
+		WARN_ONCE(column != -1 || page_addr != -1,
+			  "Unexpected column/row value (cmd=%u, col=%d, row=%d)\n",
+			  command, column, page_addr);
 		mxc_do_addr_cycle(mtd, column, page_addr);
 		break;
 
@@ -1126,12 +1141,15 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
 		host->devtype_data->send_cmd(host, command, true);
 		mxc_do_addr_cycle(mtd, column, page_addr);
 		host->devtype_data->send_read_id(host);
-		host->buf_start = column;
+		host->buf_start = 0;
 		break;
 
 	case NAND_CMD_ERASE1:
 	case NAND_CMD_ERASE2:
 		host->devtype_data->send_cmd(host, command, false);
+		WARN_ONCE(column != -1,
+			  "Unexpected column value (cmd=%u, col=%d)\n",
+			  command, column);
 		mxc_do_addr_cycle(mtd, column, page_addr);
 
 		break;
-- 
2.1.4
