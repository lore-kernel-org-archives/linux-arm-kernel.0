From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:04:00 +0100
Subject: [PATCH 52/52] mtd: rawnand: allocate dynamically ONFI parameters
 during detection
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-53-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that it is possible to do dynamic allocations during the
identification phase, convert the onfi_params structure (which is only
needed with ONFI compliant chips) into a pointer that will be allocated
only if needed.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/nand_base.c    | 37 +++++++++++++++++++++++++------------
 drivers/mtd/nand/raw/nand_micron.c  |  4 ++--
 drivers/mtd/nand/raw/nand_timings.c | 12 ++++++------
 include/linux/mtd/rawnand.h         |  6 +++---
 4 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 82d52112907f..1b9fdf51ed8e 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5100,6 +5100,7 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct nand_onfi_params *p;
+	struct onfi_params *op;
 	char *model;
 	char id[4];
 	int i, ret, val;
@@ -5154,8 +5155,6 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
 	if (!chip->onfi_version) {
 		pr_info("unsupported ONFI version: %d\n", val);
 		goto free_onfi_param_page;
-	} else {
-		ret = 1;
 	}
 
 	sanitize_string(p->manufacturer, sizeof(p->manufacturer));
@@ -5224,19 +5223,31 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
 		bitmap_set(chip->parameters.set_feature_list,
 			   ONFI_FEATURE_ADDR_TIMING_MODE, 1);
 	}
-	chip->parameters.onfi_params.t_prog = le16_to_cpu(p->t_prog);
-	chip->parameters.onfi_params.t_bers = le16_to_cpu(p->t_bers);
-	chip->parameters.onfi_params.t_r = le16_to_cpu(p->t_r);
-	chip->parameters.onfi_params.t_ccs = le16_to_cpu(p->t_ccs);
-	chip->parameters.onfi_params.async_timing_mode =
-		le16_to_cpu(p->async_timing_mode);
-	chip->parameters.onfi_params.vendor_revision =
-		le16_to_cpu(p->vendor_revision);
-	memcpy(chip->parameters.onfi_params.vendor, p->vendor,
-	       sizeof(p->vendor));
 
+	op = kzalloc(sizeof(*op), GFP_KERNEL);
+	if (!op) {
+		ret = -ENOMEM;
+		goto free_model;
+	}
+	op->t_prog = le16_to_cpu(p->t_prog);
+	op->t_bers = le16_to_cpu(p->t_bers);
+	op->t_r = le16_to_cpu(p->t_r);
+	op->t_ccs = le16_to_cpu(p->t_ccs);
+	op->async_timing_mode = le16_to_cpu(p->async_timing_mode);
+	op->vendor_revision = le16_to_cpu(p->vendor_revision);
+	memcpy(op->vendor, p->vendor, sizeof(p->vendor));
+	chip->parameters.onfi_params = op;
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
 
@@ -5966,6 +5977,8 @@ static int nand_scan_ident(struct mtd_info *mtd, int maxchips,
 static void nand_scan_ident_cleanup(struct nand_chip *chip)
 {
 	kfree(chip->parameters.model);
+	kfree(chip->parameters.onfi_params);
+
 }
 
 static int nand_set_ecc_soft_ops(struct mtd_info *mtd)
diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
index 651129023257..0674721acad8 100644
--- a/drivers/mtd/nand/raw/nand_micron.c
+++ b/drivers/mtd/nand/raw/nand_micron.c
@@ -57,9 +57,9 @@ static int micron_nand_setup_read_retry(struct mtd_info *mtd, int retry_mode)
 static int micron_nand_onfi_init(struct nand_chip *chip)
 {
 	struct nand_parameters *p = &chip->parameters;
-	struct nand_onfi_vendor_micron *micron = (void *)p->onfi_params.vendor;
+	struct nand_onfi_vendor_micron *micron = (void *)p->onfi_params->vendor;
 
-	if (chip->onfi_version && p->onfi_params.vendor_revision) {
+	if (p->onfi_params && p->onfi_params->vendor_revision) {
 		chip->read_retries = micron->read_retry_options;
 		chip->setup_read_retry = micron_nand_setup_read_retry;
 	}
diff --git a/drivers/mtd/nand/raw/nand_timings.c b/drivers/mtd/nand/raw/nand_timings.c
index b97bcf29f75a..58dc524471fa 100644
--- a/drivers/mtd/nand/raw/nand_timings.c
+++ b/drivers/mtd/nand/raw/nand_timings.c
@@ -292,6 +292,7 @@ int onfi_fill_data_interface(struct nand_chip *chip,
 			     int timing_mode)
 {
 	struct nand_data_interface *iface = &chip->data_interface;
+	struct onfi_params *onfi_params = chip->parameters.onfi_params;
 
 	if (type != NAND_SDR_IFACE)
 		return -EINVAL;
@@ -306,17 +307,16 @@ int onfi_fill_data_interface(struct nand_chip *chip,
 	 * tR, tPROG, tCCS, ...
 	 * These information are part of the ONFI parameter page.
 	 */
-	if (chip->onfi_version) {
-		struct nand_parameters *params = &chip->parameters;
+	if (onfi_params) {
 		struct nand_sdr_timings *timings = &iface->timings.sdr;
 
 		/* microseconds -> picoseconds */
-		timings->tPROG_max = 1000000ULL * params->onfi_params.t_prog;
-		timings->tBERS_max = 1000000ULL * params->onfi_params.t_bers;
-		timings->tR_max = 1000000ULL * params->onfi_params.t_r;
+		timings->tPROG_max = 1000000ULL * onfi_params->t_prog;
+		timings->tBERS_max = 1000000ULL * onfi_params->t_bers;
+		timings->tR_max = 1000000ULL * onfi_params->t_r;
 
 		/* nanoseconds -> picoseconds */
-		timings->tCCS_min = 1000UL * params->onfi_params.t_ccs;
+		timings->tCCS_min = 1000UL * onfi_params->t_ccs;
 	}
 
 	return 0;
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 9e15256bef2b..7d43fc05d009 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -445,7 +445,7 @@ struct nand_parameters {
 	DECLARE_BITMAP(get_feature_list, ONFI_FEATURE_NUMBER);
 
 	/* ONFI parameters */
-	struct onfi_params onfi_params;
+	struct onfi_params *onfi_params;
 };
 
 /* The maximum expected count of bytes in the NAND ID sequence */
@@ -1559,10 +1559,10 @@ struct platform_nand_data {
 /* return the supported asynchronous timing mode. */
 static inline int onfi_get_async_timing_mode(struct nand_chip *chip)
 {
-	if (!chip->onfi_version)
+	if (!chip->parameters.onfi_params)
 		return ONFI_TIMING_MODE_UNKNOWN;
 
-	return chip->parameters.onfi_params.async_timing_mode;
+	return chip->parameters.onfi_params->async_timing_mode;
 }
 
 int onfi_fill_data_interface(struct nand_chip *chip,
-- 
2.14.1
