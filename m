From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:45 +0100
Subject: [PATCH 37/52] mtd: rawnand: sh_flctl: convert driver to nand_scan()
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-38-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two helpers have been added to the core to make ECC-related
configuration between the detection phase and the final NAND scan. Use
these hooks and convert the driver to just use nand_scan() instead of
both nand_scan_ident() and nand_scan_tail().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/sh_flctl.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
index 67f125d56771..0f1b7db4fe7f 100644
--- a/drivers/mtd/nand/raw/sh_flctl.c
+++ b/drivers/mtd/nand/raw/sh_flctl.c
@@ -1002,10 +1002,10 @@ static void flctl_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 	flctl->index += len;
 }
 
-static int flctl_chip_init_tail(struct mtd_info *mtd)
+static int flctl_chip_attach_chip(struct nand_chip *chip)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct sh_flctl *flctl = mtd_to_flctl(mtd);
-	struct nand_chip *chip = &flctl->chip;
 
 	if (chip->options & NAND_BUSWIDTH_16) {
 		/*
@@ -1200,15 +1200,8 @@ static int flctl_probe(struct platform_device *pdev)
 
 	flctl_setup_dma(flctl);
 
-	ret = nand_scan_ident(flctl_mtd, 1, NULL);
-	if (ret)
-		goto err_chip;
-
-	ret = flctl_chip_init_tail(flctl_mtd);
-	if (ret)
-		goto err_chip;
-
-	ret = nand_scan_tail(flctl_mtd);
+	nand->ecc.attach_chip = flctl_chip_attach_chip;
+	ret = nand_scan(flctl_mtd, 1);
 	if (ret)
 		goto err_chip;
 
-- 
2.14.1
