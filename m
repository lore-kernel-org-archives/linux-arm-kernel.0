From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 20 Oct 2015 22:16:00 +0200
Subject: [PATCH 1/2] mtd: nand: sunxi: fix sunxi_nfc_hw_ecc_read/write_chunk()
Message-ID: <1445372161-6529-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sunxi_nfc_hw_ecc_read/write_chunk() functions try to avoid changing
the column address if unnecessary, but the logic to determine whether it's
necessary or not is currently wrong: it adds the ecc->bytes value to the
current offset where it should actually add ecc->size.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Fixes 913821bdd211 "mtd: nand: sunxi: introduce sunxi_nfc_hw_ecc_read/write_chunk()"
---
 drivers/mtd/nand/sunxi_nand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index ef46ac6..96f7370 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -588,7 +588,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 
 	sunxi_nfc_read_buf(mtd, data, ecc->size);
 
-	if (data_off + ecc->bytes != oob_off)
+	if (data_off + ecc->size != oob_off)
 		nand->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_off, -1);
 
 	ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
@@ -679,7 +679,7 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
 	writel(sunxi_nfc_buf_to_user_data(oob),
 	       nfc->regs + NFC_REG_USER_DATA(0));
 
-	if (data_off + ecc->bytes != oob_off)
+	if (data_off + ecc->size != oob_off)
 		nand->cmdfunc(mtd, NAND_CMD_RNDIN, oob_off, -1);
 
 	ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
-- 
2.1.4
