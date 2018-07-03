From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Wed,  4 Jul 2018 00:00:28 +0200
Subject: [PATCH v2 31/32] mtd: rawnand: do not export nand_scan_[ident|tail]()
 anymore
In-Reply-To: <20180703220029.19565-1-miquel.raynal@bootlin.com>
References: <20180703220029.19565-1-miquel.raynal@bootlin.com>
Message-ID: <20180703220029.19565-32-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both nand_scan_ident() and nand_scan_tail() helpers used to be called
directly from controller drivers that needed to tweak some ECC-related
parameters before nand_scan_tail(). This separation prevented dynamic
allocations during the phase of NAND identification, which was
inconvenient.

All controller drivers have been moved to use nand_scan(), in
conjunction with the chip->ecc.[attach|detach]_chip() hooks that
actually do the required tweaking sequence between both ident/tail
calls, allowing programmers to use dynamic allocation as they need all
across the scanning sequence.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/nand_base.c | 59 ++++++++++++++++++++++++++++++++--------
 include/linux/mtd/rawnand.h      | 11 ++------
 2 files changed, 50 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 97a74d48b0cf..9b8777e325da 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5120,6 +5120,7 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct nand_onfi_params *p;
+	char *model;
 	char id[4];
 	int i, ret, val;
 
@@ -5194,8 +5195,15 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
 
 	sanitize_string(p->manufacturer, sizeof(p->manufacturer));
 	sanitize_string(p->model, sizeof(p->model));
-	strncpy(chip->parameters.model, p->model,
-		sizeof(chip->parameters.model) - 1);
+	model = kmemdup(p->model, sizeof(p->model), GFP_KERNEL);
+	if (!model) {
+		ret = -ENOMEM;
+		goto free_onfi_param_page;
+	}
+
+	chip->parameters.model = model;
+	if (!mtd->name)
+		mtd->name = chip->parameters.model;
 
 	mtd->writesize = le32_to_cpu(p->byte_per_page);
 
@@ -5275,6 +5283,7 @@ static int nand_flash_detect_jedec(struct nand_chip *chip)
 	struct nand_jedec_params *p;
 	struct jedec_ecc_info *ecc;
 	int jedec_version = 0;
+	char *model;
 	char id[5];
 	int i, val, ret;
 
@@ -5325,8 +5334,16 @@ static int nand_flash_detect_jedec(struct nand_chip *chip)
 
 	sanitize_string(p->manufacturer, sizeof(p->manufacturer));
 	sanitize_string(p->model, sizeof(p->model));
-	strncpy(chip->parameters.model, p->model,
-		sizeof(chip->parameters.model) - 1);
+	model = kzalloc(sizeof(p->model), GFP_KERNEL);
+	if (!p) {
+		ret = -ENOMEM;
+		goto free_jedec_param_page;
+	}
+
+	strncpy(model, p->model, sizeof(model) - 1);
+	chip->parameters.model = model;
+	if (!mtd->name)
+		mtd->name = chip->parameters.model;
 
 	mtd->writesize = le32_to_cpu(p->byte_per_page);
 
@@ -5893,7 +5910,7 @@ static int nand_dt_init(struct nand_chip *chip)
 }
 
 /**
- * nand_scan_ident - [NAND Interface] Scan for the NAND device
+ * nand_scan_ident - Scan for the NAND device
  * @mtd: MTD device structure
  * @maxchips: number of chips to scan for
  * @table: alternative NAND ID table
@@ -5901,9 +5918,13 @@ static int nand_dt_init(struct nand_chip *chip)
  * This is the first phase of the normal nand_scan() function. It reads the
  * flash ID and sets up MTD fields accordingly.
  *
+ * This helper used to be called directly from controller drivers that needed
+ * to tweak some ECC-related parameters before nand_scan_tail(). This separation
+ * prevented dynamic allocations during this phase which was unconvenient and
+ * as been banned for the benefit of the ->init_ecc()/cleanup_ecc() hooks.
  */
-int nand_scan_ident(struct mtd_info *mtd, int maxchips,
-		    struct nand_flash_dev *table)
+static int nand_scan_ident(struct mtd_info *mtd, int maxchips,
+			   struct nand_flash_dev *table)
 {
 	int i, nand_maf_id, nand_dev_id;
 	struct nand_chip *chip = mtd_to_nand(mtd);
@@ -5977,7 +5998,11 @@ int nand_scan_ident(struct mtd_info *mtd, int maxchips,
 
 	return 0;
 }
-EXPORT_SYMBOL(nand_scan_ident);
+
+static void nand_scan_ident_cleanup(struct nand_chip *chip)
+{
+	kfree(chip->parameters.model);
+}
 
 static int nand_set_ecc_soft_ops(struct mtd_info *mtd)
 {
@@ -6354,14 +6379,14 @@ static bool nand_ecc_strength_good(struct mtd_info *mtd)
 }
 
 /**
- * nand_scan_tail - [NAND Interface] Scan for the NAND device
+ * nand_scan_tail - Scan for the NAND device
  * @mtd: MTD device structure
  *
  * This is the second phase of the normal nand_scan() function. It fills out
  * all the uninitialized function pointers with the defaults and scans for a
  * bad block table if appropriate.
  */
-int nand_scan_tail(struct mtd_info *mtd)
+static int nand_scan_tail(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
@@ -6685,7 +6710,6 @@ int nand_scan_tail(struct mtd_info *mtd)
 
 	return ret;
 }
-EXPORT_SYMBOL(nand_scan_tail);
 
 /*
  * is_module_text_address() isn't exported, and it's mostly a pointless
@@ -6722,12 +6746,20 @@ int nand_scan_with_ids(struct mtd_info *mtd, int maxchips,
 	if (chip->controller->attach_chip) {
 		ret = chip->controller->attach_chip(chip);
 		if (ret)
-			return ret;
+			goto cleanup_ident;
 	}
 
 	ret = nand_scan_tail(mtd);
+	if (ret)
+		goto detach_chip;
+
+	return 0;
+
+detach_chip:
 	if (ret && chip->controller->detach_chip)
 		chip->controller->detach_chip(chip);
+cleanup_ident:
+	nand_scan_ident_cleanup(chip);
 
 	return ret;
 }
@@ -6760,6 +6792,9 @@ void nand_cleanup(struct nand_chip *chip)
 	/* Free controller specific allocations after chip identification */
 	if (chip->controller->detach_chip)
 		chip->controller->detach_chip(chip);
+
+	/* Free identification phase allocations */
+	nand_scan_ident_cleanup(chip);
 }
 
 EXPORT_SYMBOL_GPL(nand_cleanup);
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 81654211e520..61b8e9a7e870 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -37,14 +37,9 @@ static inline int nand_scan(struct mtd_info *mtd, int max_chips)
 }
 
 /*
- * Separate phases of nand_scan(), allowing board driver to intervene
- * and override command or ECC setup according to flash type.
+ * Unregister the MTD device and free resources held by the NAND device, must be
+ * called on error after a successful nand_scan().
  */
-int nand_scan_ident(struct mtd_info *mtd, int max_chips,
-			   struct nand_flash_dev *table);
-int nand_scan_tail(struct mtd_info *mtd);
-
-/* Unregister the MTD device and free resources held by the NAND device */
 void nand_release(struct mtd_info *mtd);
 
 /* Internal helper for board drivers which need to override command function */
@@ -488,7 +483,7 @@ struct onfi_params {
  */
 struct nand_parameters {
 	/* Generic parameters */
-	char model[100];
+	const char *model;
 	bool supports_set_get_features;
 	DECLARE_BITMAP(set_feature_list, ONFI_FEATURE_NUMBER);
 	DECLARE_BITMAP(get_feature_list, ONFI_FEATURE_NUMBER);
-- 
2.14.1
