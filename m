From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:41 +0100
Subject: [PATCH 33/52] mtd: rawnand: s3c2410: enhance the probe function error
 path
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-34-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prepare the migration of the lpc32xx_slc driver to use nand_scan() by
cleaning the error path in the probe function.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/s3c2410.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/raw/s3c2410.c b/drivers/mtd/nand/raw/s3c2410.c
index b5bc5f106c09..1bc0458063d8 100644
--- a/drivers/mtd/nand/raw/s3c2410.c
+++ b/drivers/mtd/nand/raw/s3c2410.c
@@ -124,13 +124,11 @@ struct s3c2410_nand_info;
  * @chip: The NAND chip information.
  * @set: The platform information supplied for this set of NAND chips.
  * @info: Link back to the hardware information.
- * @scan_res: The result from calling nand_scan_ident().
 */
 struct s3c2410_nand_mtd {
 	struct nand_chip		chip;
 	struct s3c2410_nand_set		*set;
 	struct s3c2410_nand_info	*info;
-	int				scan_res;
 };
 
 enum s3c_cpu_type {
@@ -1163,17 +1161,19 @@ static int s3c24xx_nand_probe(struct platform_device *pdev)
 		mtd->dev.parent = &pdev->dev;
 		s3c2410_nand_init_chip(info, nmtd, sets);
 
-		nmtd->scan_res = nand_scan_ident(mtd,
-						 (sets) ? sets->nr_chips : 1,
-						 NULL);
+		err = nand_scan_ident(mtd, (sets) ? sets->nr_chips : 1, NULL);
+		if (err)
+			goto exit_error;
 
-		if (nmtd->scan_res == 0) {
-			err = s3c2410_nand_update_chip(info, nmtd);
-			if (err < 0)
-				goto exit_error;
-			nand_scan_tail(mtd);
-			s3c2410_nand_add_partition(info, nmtd, sets);
-		}
+		err = s3c2410_nand_update_chip(info, nmtd);
+		if (err < 0)
+			goto exit_error;
+
+		err = nand_scan_tail(mtd);
+		if (err)
+			goto exit_error;
+
+		s3c2410_nand_add_partition(info, nmtd, sets);
 
 		if (sets != NULL)
 			sets++;
-- 
2.14.1
