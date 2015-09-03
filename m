From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu,  3 Sep 2015 09:06:48 +0200
Subject: [PATCH v3] mtd: nand: sunxi: fix OOB handling in ->write_xxx()
 functions
Message-ID: <1441264008-24569-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USER_DATA register cannot be accessed using byte accessors on A13
SoCs, thus triggering a bug when using memcpy_toio on this register.
Declare two helper macros to convert an OOB buffer into a suitable
USER_DATA value and vice-versa.

This patch also fixes an error in the oob_required logic (some OOB data
are not written even if the user required it) by removing the
oob_required condition, which is perfectly valid since the core already
fill ->oob_poi with FFs when oob_required is false.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: <stable@vger.kernel.org> # 3.19+
Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller support")

---
Changes since v2:
- add the NFC_USER_DATA_TO_BUF() macro and rename NFC_USER_DATA() into
  NFC_BUF_TO_USER_DATA()
- rework the commit message

Changes since v1:
- drop the !oob_required conditional path
- replace endianness conversions by a macro relying on byte shifting
  operations
---
 drivers/mtd/nand/sunxi_nand.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index f97a58d..f9b5a4c 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -147,6 +147,17 @@
 #define NFC_ECC_MODE		GENMASK(15, 12)
 #define NFC_RANDOM_SEED		GENMASK(30, 16)
 
+/* NFC_USER_DATA helper macros */
+#define NFC_BUF_TO_USER_DATA(buf)	((buf)[0] | ((buf)[1] << 8) | \
+					((buf)[2] << 16) | ((buf)[3] << 24))
+#define NFC_USER_DATA_TO_BUF(buf, val)	\
+	{				\
+		(buf)[0] = val;		\
+		(buf)[1] = val >> 8;	\
+		(buf)[2] = val >> 16;	\
+		(buf)[3] = val >> 24;	\
+	}
+
 #define NFC_DEFAULT_TIMEOUT_MS	1000
 
 #define NFC_SRAM_SIZE		1024
@@ -646,15 +657,9 @@ static int sunxi_nfc_hw_ecc_write_page(struct mtd_info *mtd,
 		offset = layout->eccpos[i * ecc->bytes] - 4 + mtd->writesize;
 
 		/* Fill OOB data in */
-		if (oob_required) {
-			tmp = 0xffffffff;
-			memcpy_toio(nfc->regs + NFC_REG_USER_DATA_BASE, &tmp,
-				    4);
-		} else {
-			memcpy_toio(nfc->regs + NFC_REG_USER_DATA_BASE,
-				    chip->oob_poi + offset - mtd->writesize,
-				    4);
-		}
+		writel(NFC_BUF_TO_USER_DATA(chip->oob_poi +
+					    layout->oobfree[i].offset),
+		       nfc->regs + NFC_REG_USER_DATA_BASE);
 
 		chip->cmdfunc(mtd, NAND_CMD_RNDIN, offset, -1);
 
@@ -784,14 +789,8 @@ static int sunxi_nfc_hw_syndrome_ecc_write_page(struct mtd_info *mtd,
 		offset += ecc->size;
 
 		/* Fill OOB data in */
-		if (oob_required) {
-			tmp = 0xffffffff;
-			memcpy_toio(nfc->regs + NFC_REG_USER_DATA_BASE, &tmp,
-				    4);
-		} else {
-			memcpy_toio(nfc->regs + NFC_REG_USER_DATA_BASE, oob,
-				    4);
-		}
+		writel(NFC_BUF_TO_USER_DATA(oob),
+		       nfc->regs + NFC_REG_USER_DATA_BASE);
 
 		tmp = NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ACCESS_DIR |
 		      (1 << 30);
-- 
1.9.1
