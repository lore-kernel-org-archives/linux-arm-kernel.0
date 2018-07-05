From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Thu,  5 Jul 2018 12:27:31 +0200
Subject: [PATCH 6/8] mtd: rawnand: Kill the chip->scan_bbt() hook
In-Reply-To: <20180705102733.29673-1-boris.brezillon@bootlin.com>
References: <20180705102733.29673-1-boris.brezillon@bootlin.com>
Message-ID: <20180705102733.29673-7-boris.brezillon@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

None of the existing drivers are overloading the ->scan_bbt() method,
let's get rid of it and replace calls to ->scan_bbt() by
nand_create_bbt() ones.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/diskonchip.c          | 4 ++--
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 2 +-
 drivers/mtd/nand/raw/nand_base.c           | 9 +--------
 drivers/mtd/nand/raw/nandsim.c             | 2 +-
 include/linux/mtd/rawnand.h                | 1 -
 5 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
index 8d10061abb4b..3c46188dd6d2 100644
--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -1291,7 +1291,7 @@ static int __init nftl_scan_bbt(struct mtd_info *mtd)
 		this->bbt_md = NULL;
 	}
 
-	ret = this->scan_bbt(mtd);
+	ret = nand_create_bbt(this);
 	if (ret)
 		return ret;
 
@@ -1338,7 +1338,7 @@ static int __init inftl_scan_bbt(struct mtd_info *mtd)
 		this->bbt_md->pattern = "TBB_SYSM";
 	}
 
-	ret = this->scan_bbt(mtd);
+	ret = nand_create_bbt(this);
 	if (ret)
 		return ret;
 
diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index f6aa358a3452..fd2da2eaa225 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -1947,7 +1947,7 @@ static int gpmi_nand_init(struct gpmi_nand_data *this)
 	ret = nand_boot_init(this);
 	if (ret)
 		goto err_nand_cleanup;
-	ret = chip->scan_bbt(mtd);
+	ret = nand_create_bbt(chip);
 	if (ret)
 		goto err_nand_cleanup;
 
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 0476e13d47b1..4fa5e20d9690 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4924,11 +4924,6 @@ static void nand_shutdown(struct mtd_info *mtd)
 	nand_get_device(mtd, FL_PM_SUSPENDED);
 }
 
-static int nand_default_bbt(struct mtd_info *mtd)
-{
-	return nand_create_bbt(mtd_to_nand(mtd));
-}
-
 /* Set default functions */
 static void nand_set_defaults(struct nand_chip *chip)
 {
@@ -4970,8 +4965,6 @@ static void nand_set_defaults(struct nand_chip *chip)
 		chip->write_byte = busw ? nand_write_byte16 : nand_write_byte;
 	if (!chip->read_buf || chip->read_buf == nand_read_buf)
 		chip->read_buf = busw ? nand_read_buf16 : nand_read_buf;
-	if (!chip->scan_bbt)
-		chip->scan_bbt = nand_default_bbt;
 
 	if (!chip->controller) {
 		chip->controller = &chip->hwcontrol;
@@ -6673,7 +6666,7 @@ int nand_scan_tail(struct mtd_info *mtd)
 		return 0;
 
 	/* Build bad block table */
-	ret = chip->scan_bbt(mtd);
+	ret = nand_create_bbt(chip);
 	if (ret)
 		goto err_nand_manuf_cleanup;
 
diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
index f8edacde49ab..8a3b36cfe5ea 100644
--- a/drivers/mtd/nand/raw/nandsim.c
+++ b/drivers/mtd/nand/raw/nandsim.c
@@ -2337,7 +2337,7 @@ static int __init ns_init_module(void)
 	if ((retval = init_nandsim(nsmtd)) != 0)
 		goto err_exit;
 
-	if ((retval = chip->scan_bbt(nsmtd)) != 0)
+	if ((retval = nand_create_bbt(chip)) != 0)
 		goto err_exit;
 
 	if ((retval = parse_badblocks(nand, nsmtd)) != 0)
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 186f9fb1e7eb..5848e01459b0 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1292,7 +1292,6 @@ struct nand_chip {
 		       const struct nand_operation *op,
 		       bool check_only);
 	int (*erase)(struct mtd_info *mtd, int page);
-	int (*scan_bbt)(struct mtd_info *mtd);
 	int (*set_features)(struct mtd_info *mtd, struct nand_chip *chip,
 			    int feature_addr, uint8_t *subfeature_para);
 	int (*get_features)(struct mtd_info *mtd, struct nand_chip *chip,
-- 
2.14.1
