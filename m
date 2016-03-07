From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Mar 2016 17:18:23 +0100
Subject: [PATCH 06/16] mtd: nand: sunxi: implement ->read_oob()/->write_oob()
In-Reply-To: <1457367513-26069-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457367513-26069-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1457367513-26069-7-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner's ECC engine is capable of protecting a few bytes of the OOB
area. Implement specific OOB functions to benefit from this capability.

Also, when in raw mode, the randomizer is disabled, which means you'll
only be able to retrieve randomized data, which is not really useful
for most applications.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 2914785..8977a5f 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -1074,6 +1074,40 @@ static int sunxi_nfc_hw_syndrome_ecc_write_page(struct mtd_info *mtd,
 	return 0;
 }
 
+static int sunxi_nfc_hw_common_ecc_read_oob(struct mtd_info *mtd,
+					    struct nand_chip *chip,
+					    int page)
+{
+	chip->cmdfunc(mtd, NAND_CMD_READ0, 0, page);
+
+	chip->pagebuf = -1;
+
+	return chip->ecc.read_page(mtd, chip, chip->buffers->databuf, 1, page);
+}
+
+static int sunxi_nfc_hw_common_ecc_write_oob(struct mtd_info *mtd,
+					     struct nand_chip *chip,
+					     int page)
+{
+	int ret, status;
+
+	chip->cmdfunc(mtd, NAND_CMD_SEQIN, 0, page);
+
+	chip->pagebuf = -1;
+
+	memset(chip->buffers->databuf, 0xff, mtd->writesize);
+	ret = chip->ecc.write_page(mtd, chip, chip->buffers->databuf, 1, page);
+	if (ret)
+		return ret;
+
+	/* Send command to program the OOB data */
+	chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
+
+	status = chip->waitfunc(mtd, chip);
+
+	return status & NAND_STATUS_FAIL ? -EIO : 0;
+}
+
 static const s32 tWB_lut[] = {6, 12, 16, 20};
 static const s32 tRHW_lut[] = {4, 8, 12, 20};
 
@@ -1315,6 +1349,8 @@ static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
 
 	layout->eccbytes = (ecc->bytes * nsectors);
 
+	ecc->read_oob = sunxi_nfc_hw_common_ecc_read_oob;
+	ecc->write_oob = sunxi_nfc_hw_common_ecc_write_oob;
 	ecc->layout = layout;
 	ecc->priv = data;
 
@@ -1346,6 +1382,8 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct mtd_info *mtd,
 
 	ecc->read_page = sunxi_nfc_hw_ecc_read_page;
 	ecc->write_page = sunxi_nfc_hw_ecc_write_page;
+	ecc->read_oob_raw = nand_read_oob_std;
+	ecc->write_oob_raw = nand_write_oob_std;
 	layout = ecc->layout;
 	nsectors = mtd->writesize / ecc->size;
 
@@ -1400,6 +1438,8 @@ static int sunxi_nand_hw_syndrome_ecc_ctrl_init(struct mtd_info *mtd,
 	ecc->prepad = 4;
 	ecc->read_page = sunxi_nfc_hw_syndrome_ecc_read_page;
 	ecc->write_page = sunxi_nfc_hw_syndrome_ecc_write_page;
+	ecc->read_oob_raw = nand_read_oob_syndrome;
+	ecc->write_oob_raw = nand_write_oob_syndrome;
 
 	layout = ecc->layout;
 	nsectors = mtd->writesize / ecc->size;
-- 
2.1.4
