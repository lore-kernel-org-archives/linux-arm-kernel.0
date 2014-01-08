From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Wed,  8 Jan 2014 15:21:56 +0100
Subject: [RFC PATCH 1/9] mtd: nand: retrieve ECC requirements from Hynix READ
 ID byte 4
In-Reply-To: <1389190924-26226-1-git-send-email-b.brezillon@overkiz.com>
References: <1389190924-26226-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1389190924-26226-2-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Hynix nand flashes store their ECC requirements in byte 4 of its id
(returned on READ ID command).

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 drivers/mtd/nand/nand_base.c |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index bd39f7b..15069ec 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -3202,6 +3202,43 @@ static void nand_decode_ext_id(struct mtd_info *mtd, struct nand_chip *chip,
 		else
 			mtd->erasesize = (64 * 1024) << tmp;
 		*busw = 0;
+
+		/* Retrieve ECC infos */
+		switch ((id_data[4] >> 4) & 0x7) {
+		case 1:
+			chip->ecc_step_ds = 512;
+			chip->ecc_strength_ds = 1;
+			break;
+		case 2:
+			chip->ecc_step_ds = 512;
+			chip->ecc_strength_ds = 2;
+			break;
+		case 3:
+			chip->ecc_step_ds = 512;
+			chip->ecc_strength_ds = 4;
+			break;
+		case 4:
+			chip->ecc_step_ds = 512;
+			chip->ecc_strength_ds = 8;
+			break;
+		case 5:
+			chip->ecc_step_ds = 1024;
+			chip->ecc_strength_ds = 24;
+			break;
+		case 6:
+			chip->ecc_step_ds = 1024;
+			chip->ecc_strength_ds = 32;
+			break;
+		case 7:
+			chip->ecc_step_ds = 1024;
+			chip->ecc_strength_ds = 40;
+			break;
+		case 0:
+		default:
+			chip->ecc_step_ds = 0;
+			chip->ecc_strength_ds = 0;
+			break;
+		}
 	} else {
 		/* Calc pagesize */
 		mtd->writesize = 1024 << (extid & 0x03);
-- 
1.7.9.5
