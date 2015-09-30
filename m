From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Sep 2015 23:45:28 +0200
Subject: [PATCH v2 6/7] mtd: nand: sunxi: replace the NFC_BUF_TO_USER_DATA()
 macro by an inline function
In-Reply-To: <1443649529-9852-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1443649529-9852-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1443649529-9852-7-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sunxi_nfc_user_data_to_buf() is exposed as an inline function, replace the
NFC_BUF_TO_USER_DATA() macro by an inline function to be consistent.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index a9061a0..a76eb51 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -156,10 +156,6 @@
 #define NFC_ECC_PAT_FOUND(x)	BIT(x + 16)
 #define NFC_ECC_ERR_CNT(b, x)	(((x) >> ((b) * 8)) & 0xff)
 
-/* NFC_USER_DATA helper macros */
-#define NFC_BUF_TO_USER_DATA(buf)	((buf)[0] | ((buf)[1] << 8) | \
-					((buf)[2] << 16) | ((buf)[3] << 24))
-
 #define NFC_DEFAULT_TIMEOUT_MS	1000
 
 #define NFC_SRAM_SIZE		1024
@@ -657,6 +653,11 @@ static void sunxi_nfc_hw_ecc_read_extra_oob(struct mtd_info *mtd,
 	*cur_off = mtd->oobsize + mtd->writesize;
 }
 
+static inline u32 sunxi_nfc_buf_to_user_data(const u8 *buf)
+{
+	return buf[0] | (buf[1] << 8) | (buf[2] << 16) | (buf[3] << 24);
+}
+
 static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
 					const u8 *data, int data_off,
 					const u8 *oob, int oob_off,
@@ -673,7 +674,8 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
 	sunxi_nfc_write_buf(mtd, data, ecc->size);
 
 	/* Fill OOB data in */
-	writel(NFC_BUF_TO_USER_DATA(oob), nfc->regs + NFC_REG_USER_DATA(0));
+	writel(sunxi_nfc_buf_to_user_data(oob),
+	       nfc->regs + NFC_REG_USER_DATA(0));
 
 	if (data_off + ecc->bytes != oob_off)
 		nand->cmdfunc(mtd, NAND_CMD_RNDIN, oob_off, -1);
-- 
2.1.4
