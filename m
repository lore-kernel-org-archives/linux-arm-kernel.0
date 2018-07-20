From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 20 Jul 2018 17:15:18 +0200
Subject: [PATCH v4 26/35] mtd: rawnand: atmel: convert driver to nand_scan()
In-Reply-To: <20180720151527.16038-1-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
Message-ID: <20180720151527.16038-27-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two helpers have been added to the core to make ECC-related
configuration between the detection phase and the final NAND scan. Use
these hooks and convert the driver to just use nand_scan() instead of
both nand_scan_ident() and nand_scan_tail().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c | 83 ++++++++++++++--------------
 1 file changed, 40 insertions(+), 43 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index 855cc7729c43..0bc7e2abc885 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -202,7 +202,7 @@ struct atmel_nand_controller_ops {
 	int (*remove)(struct atmel_nand_controller *nc);
 	void (*nand_init)(struct atmel_nand_controller *nc,
 			  struct atmel_nand *nand);
-	int (*ecc_init)(struct atmel_nand *nand);
+	int (*ecc_init)(struct nand_chip *chip);
 	int (*setup_data_interface)(struct atmel_nand *nand, int csline,
 				    const struct nand_data_interface *conf);
 };
@@ -1133,9 +1133,8 @@ static int atmel_nand_pmecc_init(struct nand_chip *chip)
 	return 0;
 }
 
-static int atmel_nand_ecc_init(struct atmel_nand *nand)
+static int atmel_nand_ecc_init(struct nand_chip *chip)
 {
-	struct nand_chip *chip = &nand->base;
 	struct atmel_nand_controller *nc;
 	int ret;
 
@@ -1170,12 +1169,11 @@ static int atmel_nand_ecc_init(struct atmel_nand *nand)
 	return 0;
 }
 
-static int atmel_hsmc_nand_ecc_init(struct atmel_nand *nand)
+static int atmel_hsmc_nand_ecc_init(struct nand_chip *chip)
 {
-	struct nand_chip *chip = &nand->base;
 	int ret;
 
-	ret = atmel_nand_ecc_init(nand);
+	ret = atmel_nand_ecc_init(chip);
 	if (ret)
 		return ret;
 
@@ -1558,22 +1556,6 @@ static void atmel_hsmc_nand_init(struct atmel_nand_controller *nc,
 	chip->select_chip = atmel_hsmc_nand_select_chip;
 }
 
-static int atmel_nand_detect(struct atmel_nand *nand)
-{
-	struct nand_chip *chip = &nand->base;
-	struct mtd_info *mtd = nand_to_mtd(chip);
-	struct atmel_nand_controller *nc;
-	int ret;
-
-	nc = to_nand_controller(chip->controller);
-
-	ret = nand_scan_ident(mtd, nand->numcs, NULL);
-	if (ret)
-		dev_err(nc->dev, "nand_scan_ident() failed: %d\n", ret);
-
-	return ret;
-}
-
 static int atmel_nand_unregister(struct atmel_nand *nand)
 {
 	struct nand_chip *chip = &nand->base;
@@ -1595,7 +1577,6 @@ static int atmel_nand_register(struct atmel_nand *nand)
 	struct nand_chip *chip = &nand->base;
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct atmel_nand_controller *nc;
-	int ret;
 
 	nc = to_nand_controller(chip->controller);
 
@@ -1626,21 +1607,6 @@ static int atmel_nand_register(struct atmel_nand *nand)
 		}
 	}
 
-	ret = nand_scan_tail(mtd);
-	if (ret) {
-		dev_err(nc->dev, "nand_scan_tail() failed: %d\n", ret);
-		return ret;
-	}
-
-	ret = mtd_device_register(mtd, NULL, 0);
-	if (ret) {
-		dev_err(nc->dev, "Failed to register mtd device: %d\n", ret);
-		nand_cleanup(chip);
-		return ret;
-	}
-
-	list_add_tail(&nand->node, &nc->chips);
-
 	return 0;
 }
 
@@ -1755,6 +1721,8 @@ static int
 atmel_nand_controller_add_nand(struct atmel_nand_controller *nc,
 			       struct atmel_nand *nand)
 {
+	struct nand_chip *chip = &nand->base;
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	int ret;
 
 	/* No card inserted, skip this NAND. */
@@ -1765,15 +1733,30 @@ atmel_nand_controller_add_nand(struct atmel_nand_controller *nc,
 
 	nc->caps->ops->nand_init(nc, nand);
 
-	ret = atmel_nand_detect(nand);
-	if (ret)
+	ret = nand_scan(mtd, nand->numcs);
+	if (ret) {
+		dev_err(nc->dev, "NAND scan failed: %d\n", ret);
 		return ret;
+	}
 
-	ret = nc->caps->ops->ecc_init(nand);
+	ret = atmel_nand_register(nand);
 	if (ret)
-		return ret;
+		goto cleanup_nand;
+
+	ret = mtd_device_register(mtd, NULL, 0);
+	if (ret) {
+		dev_err(nc->dev, "Failed to register mtd device: %d\n", ret);
+		goto cleanup_nand;
+	}
+
+	list_add_tail(&nand->node, &nc->chips);
+
+	return 0;
+
+cleanup_nand:
+	nand_cleanup(chip);
 
-	return atmel_nand_register(nand);
+	return ret;
 }
 
 static int
@@ -1958,6 +1941,19 @@ static const struct of_device_id atmel_matrix_of_ids[] = {
 	{ /* sentinel */ },
 };
 
+static int atmel_nand_attach_chip(struct nand_chip *chip)
+{
+	struct atmel_nand_controller *nc;
+
+	nc = to_nand_controller(chip->controller);
+
+	return nc->caps->ops->ecc_init(chip);
+}
+
+static const struct nand_controller_ops atmel_nand_controller_ops = {
+	.attach_chip = atmel_nand_attach_chip,
+};
+
 static int atmel_nand_controller_init(struct atmel_nand_controller *nc,
 				struct platform_device *pdev,
 				const struct atmel_nand_controller_caps *caps)
@@ -1967,6 +1963,7 @@ static int atmel_nand_controller_init(struct atmel_nand_controller *nc,
 	int ret;
 
 	nand_controller_init(&nc->base);
+	nc->base.ops = &atmel_nand_controller_ops;
 	INIT_LIST_HEAD(&nc->chips);
 	nc->dev = dev;
 	nc->caps = caps;
-- 
2.14.1
