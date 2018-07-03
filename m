From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Wed,  4 Jul 2018 00:00:29 +0200
Subject: [PATCH v2 32/32] mtd: rawnand: allocate dynamically ONFI parameters
 during detection
In-Reply-To: <20180703220029.19565-1-miquel.raynal@bootlin.com>
References: <20180703220029.19565-1-miquel.raynal@bootlin.com>
Message-ID: <20180703220029.19565-33-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that it is possible to do dynamic allocations during the
identification phase, convert the onfi_params structure (which is only
needed with ONFI compliant chips) into a pointer that will be allocated
only if needed.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/nand_base.c    | 54 +++++++++++++++++++++++--------------
 drivers/mtd/nand/raw/nand_micron.c  |  6 ++---
 drivers/mtd/nand/raw/nand_timings.c | 12 ++++-----
 include/linux/mtd/rawnand.h         |  6 ++---
 4 files changed, 46 insertions(+), 32 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 9b8777e325da..8fb1b74abb68 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5120,6 +5120,8 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct nand_onfi_params *p;
+	struct onfi_params *onfi;
+	int onfi_version = 0;
 	char *model;
 	char id[4];
 	int i, ret, val;
@@ -5176,21 +5178,19 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
 	/* Check version */
 	val = le16_to_cpu(p->revision);
 	if (val & ONFI_VERSION_2_3)
-		chip->parameters.onfi.version = 23;
+		onfi_version = 23;
 	else if (val & ONFI_VERSION_2_2)
-		chip->parameters.onfi.version = 22;
+		onfi_version = 22;
 	else if (val & ONFI_VERSION_2_1)
-		chip->parameters.onfi.version = 21;
+		onfi_version = 21;
 	else if (val & ONFI_VERSION_2_0)
-		chip->parameters.onfi.version = 20;
+		onfi_version = 20;
 	else if (val & ONFI_VERSION_1_0)
-		chip->parameters.onfi.version = 10;
+		onfi_version = 10;
 
-	if (!chip->parameters.onfi.version) {
+	if (!onfi_version) {
 		pr_info("unsupported ONFI version: %d\n", val);
 		goto free_onfi_param_page;
-	} else {
-		ret = 1;
 	}
 
 	sanitize_string(p->manufacturer, sizeof(p->manufacturer));
@@ -5231,7 +5231,7 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
 	if (p->ecc_bits != 0xff) {
 		chip->ecc_strength_ds = p->ecc_bits;
 		chip->ecc_step_ds = 512;
-	} else if (chip->parameters.onfi.version >= 21 &&
+	} else if (onfi_version >= 21 &&
 		(le16_to_cpu(p->features) & ONFI_FEATURE_EXT_PARAM_PAGE)) {
 
 		/*
@@ -5258,19 +5258,32 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
 		bitmap_set(chip->parameters.set_feature_list,
 			   ONFI_FEATURE_ADDR_TIMING_MODE, 1);
 	}
-	chip->parameters.onfi.tPROG = le16_to_cpu(p->t_prog);
-	chip->parameters.onfi.tBERS = le16_to_cpu(p->t_bers);
-	chip->parameters.onfi.tR = le16_to_cpu(p->t_r);
-	chip->parameters.onfi.tCCS = le16_to_cpu(p->t_ccs);
-	chip->parameters.onfi.async_timing_mode =
-		le16_to_cpu(p->async_timing_mode);
-	chip->parameters.onfi.vendor_revision =
-		le16_to_cpu(p->vendor_revision);
-	memcpy(chip->parameters.onfi.vendor, p->vendor,
-	       sizeof(p->vendor));
 
+	onfi = kzalloc(sizeof(*onfi), GFP_KERNEL);
+	if (!onfi) {
+		ret = -ENOMEM;
+		goto free_model;
+	}
+	onfi->version = onfi_version;
+	onfi->tPROG = le16_to_cpu(p->t_prog);
+	onfi->tBERS = le16_to_cpu(p->t_bers);
+	onfi->tR = le16_to_cpu(p->t_r);
+	onfi->tCCS = le16_to_cpu(p->t_ccs);
+	onfi->async_timing_mode = le16_to_cpu(p->async_timing_mode);
+	onfi->vendor_revision = le16_to_cpu(p->vendor_revision);
+	memcpy(onfi->vendor, p->vendor, sizeof(p->vendor));
+	chip->parameters.onfi = onfi;
+
+	/* Identification done, free the full ONFI parameter page and exit */
+	kfree(p);
+
+	return 1;
+
+free_model:
+	kfree(model);
 free_onfi_param_page:
 	kfree(p);
+
 	return ret;
 }
 
@@ -5672,7 +5685,6 @@ static int nand_detect(struct nand_chip *chip, struct nand_flash_dev *type)
 		}
 	}
 
-	chip->parameters.onfi.version = 0;
 	if (!type->name || !type->pagesize) {
 		/* Check if the chip is ONFI compliant */
 		ret = nand_flash_detect_onfi(chip);
@@ -6002,6 +6014,8 @@ static int nand_scan_ident(struct mtd_info *mtd, int maxchips,
 static void nand_scan_ident_cleanup(struct nand_chip *chip)
 {
 	kfree(chip->parameters.model);
+	kfree(chip->parameters.onfi);
+
 }
 
 static int nand_set_ecc_soft_ops(struct mtd_info *mtd)
diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
index 35fa6880a799..df92dd1f0427 100644
--- a/drivers/mtd/nand/raw/nand_micron.c
+++ b/drivers/mtd/nand/raw/nand_micron.c
@@ -77,9 +77,9 @@ static int micron_nand_setup_read_retry(struct mtd_info *mtd, int retry_mode)
 static int micron_nand_onfi_init(struct nand_chip *chip)
 {
 	struct nand_parameters *p = &chip->parameters;
-	struct nand_onfi_vendor_micron *micron = (void *)p->onfi.vendor;
+	struct nand_onfi_vendor_micron *micron = (void *)p->onfi->vendor;
 
-	if (chip->parameters.onfi.version && p->onfi.vendor_revision) {
+	if (p->onfi && p->onfi->vendor_revision) {
 		chip->read_retries = micron->read_retry_options;
 		chip->setup_read_retry = micron_nand_setup_read_retry;
 	}
@@ -283,7 +283,7 @@ static int micron_supports_on_die_ecc(struct nand_chip *chip)
 		if (chip->id.data[1] == micron_on_die_ecc[i])
 			return MICRON_ON_DIE_MANDATORY;
 
-	if (!chip->parameters.onfi.version)
+	if (!chip->parameters.onfi)
 		return MICRON_ON_DIE_UNSUPPORTED;
 
 	if (chip->bits_per_cell != 1)
diff --git a/drivers/mtd/nand/raw/nand_timings.c b/drivers/mtd/nand/raw/nand_timings.c
index 7c4e4a371bbc..d113c05c26f9 100644
--- a/drivers/mtd/nand/raw/nand_timings.c
+++ b/drivers/mtd/nand/raw/nand_timings.c
@@ -292,6 +292,7 @@ int onfi_fill_data_interface(struct nand_chip *chip,
 			     int timing_mode)
 {
 	struct nand_data_interface *iface = &chip->data_interface;
+	struct onfi_params *onfi = chip->parameters.onfi;
 
 	if (type != NAND_SDR_IFACE)
 		return -EINVAL;
@@ -306,17 +307,16 @@ int onfi_fill_data_interface(struct nand_chip *chip,
 	 * tR, tPROG, tCCS, ...
 	 * These information are part of the ONFI parameter page.
 	 */
-	if (chip->parameters.onfi.version) {
-		struct nand_parameters *params = &chip->parameters;
+	if (onfi) {
 		struct nand_sdr_timings *timings = &iface->timings.sdr;
 
 		/* microseconds -> picoseconds */
-		timings->tPROG_max = 1000000ULL * params->onfi.tPROG;
-		timings->tBERS_max = 1000000ULL * params->onfi.tBERS;
-		timings->tR_max = 1000000ULL * params->onfi.tR;
+		timings->tPROG_max = 1000000ULL * onfi->tPROG;
+		timings->tBERS_max = 1000000ULL * onfi->tBERS;
+		timings->tR_max = 1000000ULL * onfi->tR;
 
 		/* nanoseconds -> picoseconds */
-		timings->tCCS_min = 1000UL * params->onfi.tCCS;
+		timings->tCCS_min = 1000UL * onfi->tCCS;
 	}
 
 	return 0;
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 61b8e9a7e870..bbbe26be5fd2 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -489,7 +489,7 @@ struct nand_parameters {
 	DECLARE_BITMAP(get_feature_list, ONFI_FEATURE_NUMBER);
 
 	/* ONFI parameters */
-	struct onfi_params onfi;
+	struct onfi_params *onfi;
 };
 
 /* The maximum expected count of bytes in the NAND ID sequence */
@@ -1616,10 +1616,10 @@ struct platform_nand_data {
 /* return the supported asynchronous timing mode. */
 static inline int onfi_get_async_timing_mode(struct nand_chip *chip)
 {
-	if (!chip->parameters.onfi.version)
+	if (!chip->parameters.onfi)
 		return ONFI_TIMING_MODE_UNKNOWN;
 
-	return chip->parameters.onfi.async_timing_mode;
+	return chip->parameters.onfi->async_timing_mode;
 }
 
 int onfi_fill_data_interface(struct nand_chip *chip,
-- 
2.14.1
