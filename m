From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:13 +0100
Subject: [PATCH 05/52] mtd: rawnand: brcmnand: convert driver to nand_scan()
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-6-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two helpers have been added to the core to make ECC-related
configuration between the detection phase and the final NAND scan. Use
these hooks and convert the driver to just use nand_scan() instead of
both nand_scan_ident() and nand_scan_tail().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 43 ++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 844c84987f49..4ba240f8662a 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2208,6 +2208,28 @@ static int brcmnand_setup_dev(struct brcmnand_host *host)
 	return 0;
 }
 
+static int brcmnand_attach_chip(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct brcmnand_host *host = nand_get_controller_data(chip);
+	int ret;
+
+	if (chip->bbt_options & NAND_BBT_USE_FLASH)
+		chip->bbt_options |= NAND_BBT_NO_OOB;
+
+	if (brcmnand_setup_dev(host))
+		return -ENXIO;
+
+	chip->ecc.size = host->hwcfg.sector_size_1k ? 1024 : 512;
+
+	/* only use our internal HW threshold */
+	mtd->bitflip_threshold = 1;
+
+	ret = brcmstb_choose_ecc_layout(host);
+
+	return ret;
+}
+
 static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
 {
 	struct brcmnand_controller *ctrl = host->ctrl;
@@ -2267,10 +2289,6 @@ static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
 	nand_writereg(ctrl, cfg_offs,
 		      nand_readreg(ctrl, cfg_offs) & ~CFG_BUS_WIDTH);
 
-	ret = nand_scan_ident(mtd, 1, NULL);
-	if (ret)
-		return ret;
-
 	chip->options |= NAND_NO_SUBPAGE_WRITE;
 	/*
 	 * Avoid (for instance) kmap()'d buffers from JFFS2, which we can't DMA
@@ -2279,21 +2297,8 @@ static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
 	 */
 	chip->options |= NAND_USE_BOUNCE_BUFFER;
 
-	if (chip->bbt_options & NAND_BBT_USE_FLASH)
-		chip->bbt_options |= NAND_BBT_NO_OOB;
-
-	if (brcmnand_setup_dev(host))
-		return -ENXIO;
-
-	chip->ecc.size = host->hwcfg.sector_size_1k ? 1024 : 512;
-	/* only use our internal HW threshold */
-	mtd->bitflip_threshold = 1;
-
-	ret = brcmstb_choose_ecc_layout(host);
-	if (ret)
-		return ret;
-
-	ret = nand_scan_tail(mtd);
+	chip->ecc.attach_chip = brcmnand_attach_chip;
+	ret = nand_scan(mtd, 1);
 	if (ret)
 		return ret;
 
-- 
2.14.1
