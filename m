From: romain.izard.pro@gmail.com (Romain Izard)
Date: Fri, 15 Sep 2017 16:04:07 +0200
Subject: [PATCH v2 5/9] mtd: nand: atmel: Report PMECC failures as errors
In-Reply-To: <20170915140411.31716-1-romain.izard.pro@gmail.com>
References: <20170915140411.31716-1-romain.izard.pro@gmail.com>
Message-ID: <20170915140411.31716-6-romain.izard.pro@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is not normal for the PMECC to fail when trying to fix ECC errors.
Report these cases as errors.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 drivers/mtd/nand/atmel/pmecc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/atmel/pmecc.c b/drivers/mtd/nand/atmel/pmecc.c
index 8d1208f38025..2a23f1ff945f 100644
--- a/drivers/mtd/nand/atmel/pmecc.c
+++ b/drivers/mtd/nand/atmel/pmecc.c
@@ -687,6 +687,8 @@ static int atmel_pmecc_err_location(struct atmel_pmecc_user *user)
 	 * Number of roots does not match the degree of smu
 	 * unable to correct error.
 	 */
+	dev_err(pmecc->dev,
+		"PMECC: Impossible to calculate error location.\n");
 	return -EBADMSG;
 }
 
@@ -729,7 +731,7 @@ int atmel_pmecc_correct_sector(struct atmel_pmecc_user *user, int sector,
 			ptr = ecc + byte - sectorsize;
 			area = "ECC";
 		} else {
-			dev_dbg(pmecc->dev,
+			dev_err(pmecc->dev,
 				"Invalid errpos value (%d, max is %d)\n",
 				errpos, (sectorsize + eccbytes) * 8);
 			return -EINVAL;
-- 
2.11.0
