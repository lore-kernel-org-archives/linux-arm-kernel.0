From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Sep 2015 23:45:27 +0200
Subject: [PATCH v2 5/7] mtd: nand: sunxi: retrieve corrected OOB bytes
In-Reply-To: <1443649529-9852-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1443649529-9852-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1443649529-9852-6-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ECC engine is protecting a few OOB bytes. Retrieve them from the
USER_DATA register instead of reading them in raw mode (ie without the ECC
protection).

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 45b74fc..a9061a0 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -567,6 +567,14 @@ static void sunxi_nfc_hw_ecc_disable(struct mtd_info *mtd)
 	       nfc->regs + NFC_REG_ECC_CTL);
 }
 
+static inline void sunxi_nfc_user_data_to_buf(u32 user_data, u8 *buf)
+{
+	buf[0] = user_data;
+	buf[1] = user_data >> 8;
+	buf[2] = user_data >> 16;
+	buf[3] = user_data >> 24;
+}
+
 static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 				       u8 *data, int data_off,
 				       u8 *oob, int oob_off,
@@ -606,8 +614,16 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 	nand->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_off, -1);
 	sunxi_nfc_read_buf(mtd, oob, ecc->bytes + 4);
 
-	if (status & NFC_ECC_ERR(0))
+	if (status & NFC_ECC_ERR(0)) {
 		ret = -EIO;
+	} else {
+		/*
+		 * The engine protects 4 bytes of OOB data per chunk.
+		 * Retrieve the corrected OOB bytes.
+		 */
+		sunxi_nfc_user_data_to_buf(readl(nfc->regs + NFC_REG_USER_DATA(0)),
+					   oob);
+	}
 
 	if (ret < 0) {
 		mtd->ecc_stats.failed++;
-- 
2.1.4
