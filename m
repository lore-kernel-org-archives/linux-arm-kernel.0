From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Wed, 24 Jan 2018 23:49:31 +0100
Subject: [PATCH] mtd: nand: sunxi: Fix ECC strength choice
Message-ID: <20180124224931.14392-1-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the requested ECC strength does not exactly match the strengths
supported by the ECC engine, the driver is selecting the closest
strength meeting the 'selected_strength > requested_strength'
constraint. Fix the fact that, in this particular case, ecc->strength
value was not updated to match the 'selected_strength'.

For instance, one can encounter this issue when no ECC requirement is
filled in the device tree while the NAND chip minimum requirement is not
a strength/step_size combo natively supported by the ECC engine.

Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 82244be3e766..958974821582 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -1853,8 +1853,14 @@ static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
 
 	/* Add ECC info retrieval from DT */
 	for (i = 0; i < ARRAY_SIZE(strengths); i++) {
-		if (ecc->strength <= strengths[i])
+		if (ecc->strength <= strengths[i]) {
+			/*
+			 * Update ecc->strength value with the actual strength
+			 * that will be used by the ECC engine.
+			 */
+			ecc->strength = strengths[i];
 			break;
+		}
 	}
 
 	if (i >= ARRAY_SIZE(strengths)) {
-- 
2.11.0
