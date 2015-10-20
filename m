From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 20 Oct 2015 22:16:01 +0200
Subject: [PATCH 2/2] mtd: nand: sunxi: avoid retrieving data before ECC pass
In-Reply-To: <1445372161-6529-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1445372161-6529-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1445372161-6529-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The in-band data are copied twice: before ECC correction and after the
ECC engine has fixed all the fixable bitflips.
Drop the useless memcpy_fromio operation by passing a NULL pointer when
calling sunxi_nfc_read_buf().

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 96f7370..8247118 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -586,7 +586,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 	if (*cur_off != data_off)
 		nand->cmdfunc(mtd, NAND_CMD_RNDOUT, data_off, -1);
 
-	sunxi_nfc_read_buf(mtd, data, ecc->size);
+	sunxi_nfc_read_buf(mtd, NULL, ecc->size);
 
 	if (data_off + ecc->size != oob_off)
 		nand->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_off, -1);
-- 
2.1.4
