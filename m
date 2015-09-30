From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Sep 2015 23:45:29 +0200
Subject: [PATCH v2 7/7] mtd: nand: sunxi: fix bitflips in erased pages
In-Reply-To: <1443649529-9852-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1443649529-9852-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1443649529-9852-8-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the nand_check_erased_ecc_chunk() function to test if the ECC error
was triggered by an erased page containing a few bitflips.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index a76eb51..92245a3 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -611,7 +611,9 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 	sunxi_nfc_read_buf(mtd, oob, ecc->bytes + 4);
 
 	if (status & NFC_ECC_ERR(0)) {
-		ret = -EIO;
+		ret = nand_check_erased_ecc_chunk(data,	ecc->size,
+						  oob, ecc->bytes + 4,
+						  NULL, 0, ecc->strength);
 	} else {
 		/*
 		 * The engine protects 4 bytes of OOB data per chunk.
-- 
2.1.4
