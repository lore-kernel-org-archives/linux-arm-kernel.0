From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 20 Jul 2018 01:00:13 +0200
Subject: [PATCH v3 20/33] mtd: rawnand: sh_flctl: convert driver to nand_scan()
In-Reply-To: <20180719230026.8741-1-miquel.raynal@bootlin.com>
References: <20180719230026.8741-1-miquel.raynal@bootlin.com>
Message-ID: <20180719230026.8741-21-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two helpers have been added to the core to make ECC-related
configuration between the detection phase and the final NAND scan. Use
these hooks and convert the driver to just use nand_scan() instead of
both nand_scan_ident() and nand_scan_tail().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/sh_flctl.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
index d37d1d3ccbf9..aa9fd92818d9 100644
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
@@ -1073,6 +1073,10 @@ static int flctl_chip_init_tail(struct mtd_info *mtd)
 	return 0;
 }
 
+static struct nand_controller_ops flctl_nand_controller_ops = {
+	.attach_chip = flctl_chip_attach_chip,
+};
+
 static irqreturn_t flctl_handle_flste(int irq, void *dev_id)
 {
 	struct sh_flctl *flctl = dev_id;
@@ -1200,15 +1204,8 @@ static int flctl_probe(struct platform_device *pdev)
 
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
+	nand->dummy_controller.ops = &flctl_nand_controller_ops;
+	ret = nand_scan(flctl_mtd, 1);
 	if (ret)
 		goto err_chip;
 
-- 
2.14.1
