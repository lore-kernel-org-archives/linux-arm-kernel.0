From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 12 Sep 2017 11:37:30 +0900
Subject: [PATCH 1/2] mtd: nand: introduce NAND_ROW_ADDR_3 flag
In-Reply-To: <1505183851-29355-1-git-send-email-yamada.masahiro@socionext.com>
References: <1505183851-29355-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1505183851-29355-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Several drivers check ->chipsize to see if the third row address cycle
is needed.  Instead of embedding magic sizes such as 32MB, 128MB in
drivers, introduce a new flag NAND_ROW_ADDR_3 for clean-up.  Since
nand_scan_ident() knows well about the device, it can handle this
properly.  The flag is set if the row address bit width is greater
than 16.

Delete comments such as "One more address cycle for ..." because
intention is now clear enough from the code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mtd/nand/atmel/nand-controller.c | 3 +--
 drivers/mtd/nand/au1550nd.c              | 3 +--
 drivers/mtd/nand/diskonchip.c            | 3 +--
 drivers/mtd/nand/hisi504_nand.c          | 3 +--
 drivers/mtd/nand/mxc_nand.c              | 3 +--
 drivers/mtd/nand/nand_base.c             | 9 +++++----
 drivers/mtd/nand/nuc900_nand.c           | 2 +-
 include/linux/mtd/rawnand.h              | 3 +++
 8 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/atmel/nand-controller.c b/drivers/mtd/nand/atmel/nand-controller.c
index f25eca7..7bc8d20 100644
--- a/drivers/mtd/nand/atmel/nand-controller.c
+++ b/drivers/mtd/nand/atmel/nand-controller.c
@@ -718,8 +718,7 @@ static void atmel_nfc_set_op_addr(struct nand_chip *chip, int page, int column)
 		nc->op.addrs[nc->op.naddrs++] = page;
 		nc->op.addrs[nc->op.naddrs++] = page >> 8;
 
-		if ((mtd->writesize > 512 && chip->chipsize > SZ_128M) ||
-		    (mtd->writesize <= 512 && chip->chipsize > SZ_32M))
+		if (chip->options & NAND_ROW_ADDR_3)
 			nc->op.addrs[nc->op.naddrs++] = page >> 16;
 	}
 }
diff --git a/drivers/mtd/nand/au1550nd.c b/drivers/mtd/nand/au1550nd.c
index 9d4a28f..8ab827e 100644
--- a/drivers/mtd/nand/au1550nd.c
+++ b/drivers/mtd/nand/au1550nd.c
@@ -331,8 +331,7 @@ static void au1550_command(struct mtd_info *mtd, unsigned command, int column, i
 
 			ctx->write_byte(mtd, (u8)(page_addr >> 8));
 
-			/* One more address cycle for devices > 32MiB */
-			if (this->chipsize > (32 << 20))
+			if (this->options & NAND_ROW_ADDR_3)
 				ctx->write_byte(mtd,
 						((page_addr >> 16) & 0x0f));
 		}
diff --git a/drivers/mtd/nand/diskonchip.c b/drivers/mtd/nand/diskonchip.c
index c3aa53c..72671dc 100644
--- a/drivers/mtd/nand/diskonchip.c
+++ b/drivers/mtd/nand/diskonchip.c
@@ -705,8 +705,7 @@ static void doc2001plus_command(struct mtd_info *mtd, unsigned command, int colu
 		if (page_addr != -1) {
 			WriteDOC((unsigned char)(page_addr & 0xff), docptr, Mplus_FlashAddress);
 			WriteDOC((unsigned char)((page_addr >> 8) & 0xff), docptr, Mplus_FlashAddress);
-			/* One more address cycle for higher density devices */
-			if (this->chipsize & 0x0c000000) {
+			if (this->options & NAND_ROW_ADDR_3) {
 				WriteDOC((unsigned char)((page_addr >> 16) & 0x0f), docptr, Mplus_FlashAddress);
 				printk("high density\n");
 			}
diff --git a/drivers/mtd/nand/hisi504_nand.c b/drivers/mtd/nand/hisi504_nand.c
index d9ee1a7..0ded7f4 100644
--- a/drivers/mtd/nand/hisi504_nand.c
+++ b/drivers/mtd/nand/hisi504_nand.c
@@ -432,8 +432,7 @@ static void set_addr(struct mtd_info *mtd, int column, int page_addr)
 		host->addr_value[0] |= (page_addr & 0xffff)
 			<< (host->addr_cycle * 8);
 		host->addr_cycle    += 2;
-		/* One more address cycle for devices > 128MiB */
-		if (chip->chipsize > (128 << 20)) {
+		if (chip->->options & NAND_ROW_ADDR_3) {
 			host->addr_cycle += 1;
 			if (host->command == NAND_CMD_ERASE1)
 				host->addr_value[0] |= ((page_addr >> 16) & 0xff) << 16;
diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 53e5e03..bacdd04 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -859,8 +859,7 @@ static void mxc_do_addr_cycle(struct mtd_info *mtd, int column, int page_addr)
 				host->devtype_data->send_addr(host,
 						(page_addr >> 8) & 0xff, true);
 		} else {
-			/* One more address cycle for higher density devices */
-			if (mtd->size >= 0x4000000) {
+			if (nand_chip->options & NAND_ROW_ADDR_3) {
 				/* paddr_8 - paddr_15 */
 				host->devtype_data->send_addr(host,
 						(page_addr >> 8) & 0xff,
diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index bcc8cef1..3bc4404 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -727,8 +727,7 @@ static void nand_command(struct mtd_info *mtd, unsigned int command,
 		chip->cmd_ctrl(mtd, page_addr, ctrl);
 		ctrl &= ~NAND_CTRL_CHANGE;
 		chip->cmd_ctrl(mtd, page_addr >> 8, ctrl);
-		/* One more address cycle for devices > 32MiB */
-		if (chip->chipsize > (32 << 20))
+		if (chip->options & NAND_ROW_ADDR_3)
 			chip->cmd_ctrl(mtd, page_addr >> 16, ctrl);
 	}
 	chip->cmd_ctrl(mtd, NAND_CMD_NONE, NAND_NCE | NAND_CTRL_CHANGE);
@@ -854,8 +853,7 @@ static void nand_command_lp(struct mtd_info *mtd, unsigned int command,
 			chip->cmd_ctrl(mtd, page_addr, ctrl);
 			chip->cmd_ctrl(mtd, page_addr >> 8,
 				       NAND_NCE | NAND_ALE);
-			/* One more address cycle for devices > 128MiB */
-			if (chip->chipsize > (128 << 20))
+			if (chip->options & NAND_ROW_ADDR_3)
 				chip->cmd_ctrl(mtd, page_addr >> 16,
 					       NAND_NCE | NAND_ALE);
 		}
@@ -4000,6 +3998,9 @@ static int nand_detect(struct nand_chip *chip, struct nand_flash_dev *type)
 		chip->chip_shift += 32 - 1;
 	}
 
+	if (chip->chip_shift - chip->page_shift > 16)
+		chip->options |= NAND_ROW_ADDR_3;
+
 	chip->badblockbits = 8;
 	chip->erase = single_erase;
 
diff --git a/drivers/mtd/nand/nuc900_nand.c b/drivers/mtd/nand/nuc900_nand.c
index 7bb4d2e..af5b32c9 100644
--- a/drivers/mtd/nand/nuc900_nand.c
+++ b/drivers/mtd/nand/nuc900_nand.c
@@ -154,7 +154,7 @@ static void nuc900_nand_command_lp(struct mtd_info *mtd, unsigned int command,
 		if (page_addr != -1) {
 			write_addr_reg(nand, page_addr);
 
-			if (chip->chipsize > (128 << 20)) {
+			if (chip->options & NAND_ROW_ADDR_3) {
 				write_addr_reg(nand, page_addr >> 8);
 				write_addr_reg(nand, page_addr >> 16 | ENDADDR);
 			} else {
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 2b05f42..749bb08 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -177,6 +177,9 @@ enum nand_ecc_algo {
  */
 #define NAND_NEED_SCRAMBLING	0x00002000
 
+/* Device needs 3rd row address cycle */
+#define NAND_ROW_ADDR_3		0x00004000
+
 /* Options valid for Samsung large page devices */
 #define NAND_SAMSUNG_LP_OPTIONS NAND_CACHEPRG
 
-- 
2.7.4
