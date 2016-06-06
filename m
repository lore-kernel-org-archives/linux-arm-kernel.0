From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  6 Jun 2016 13:59:12 +0200
Subject: [PATCH 1/3] mtd: nand: sunxi: prefer 1k ECC blocks when applicable
In-Reply-To: <1465214354-31493-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1465214354-31493-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1465214354-31493-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switching to 1k ECC blocks when possible provides better resistance against
concentrated bitflips. Say you have those two configurations:

1/ 16bits/512bytes
2/ 32bits/1024bytes

Both of them require the same amount of ECC bytes (only true for this
specific engine), but the second config allows you to correct the case
where most of your bitflips are concentrated in a single 512bytes portion.

This fact makes the 1k ECC block size more advantageous than the 512bytes
one.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 5299ab0..4f5b4ad 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -1784,6 +1784,12 @@ static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
 	if (!data)
 		return -ENOMEM;
 
+	/* Prefer 1k ECC chunk over 512 ones */
+	if (ecc->size == 512 && mtd->writesize > 512) {
+		ecc->size = 1024;
+		ecc->strength *= 2;
+	}
+
 	/* Add ECC info retrieval from DT */
 	for (i = 0; i < ARRAY_SIZE(strengths); i++) {
 		if (ecc->strength <= strengths[i])
-- 
2.7.4
