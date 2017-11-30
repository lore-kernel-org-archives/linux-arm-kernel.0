From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Thu, 30 Nov 2017 18:01:31 +0100
Subject: [PATCH 4/5] mtd: nand: use a static data_interface in the nand_chip
 structure
In-Reply-To: <20171130170132.27522-1-miquel.raynal@free-electrons.com>
References: <20171130170132.27522-1-miquel.raynal@free-electrons.com>
Message-ID: <20171130170132.27522-5-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the nand_chip structure, to embed the nand_data_interface object.

Also remove the nand_get_default_data_interface() function that become
useless but add the initialization of the data_interface at the very
beginning of nand_scan_ident() to be sure core functions using timings
may be used safely.

Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---
 drivers/mtd/nand/nand_base.c    | 44 ++++++++++++++++++-----------------------
 drivers/mtd/nand/nand_timings.c | 21 +++++---------------
 include/linux/mtd/rawnand.h     |  7 ++-----
 3 files changed, 26 insertions(+), 46 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index ee9825780a6c..52965a8aeb2c 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -816,8 +816,8 @@ static void nand_ccs_delay(struct nand_chip *chip)
 	 * Wait tCCS_min if it is correctly defined, otherwise wait 500ns
 	 * (which should be safe for all NANDs).
 	 */
-	if (chip->data_interface && chip->data_interface->timings.sdr.tCCS_min)
-		ndelay(chip->data_interface->timings.sdr.tCCS_min / 1000);
+	if (chip->setup_data_interface)
+		ndelay(chip->data_interface.timings.sdr.tCCS_min / 1000);
 	else
 		ndelay(500);
 }
@@ -1112,7 +1112,6 @@ static int nand_wait(struct mtd_info *mtd, struct nand_chip *chip)
 static int nand_reset_data_interface(struct nand_chip *chip, int chipnr)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
-	const struct nand_data_interface *conf;
 	int ret;
 
 	if (!chip->setup_data_interface)
@@ -1132,8 +1131,8 @@ static int nand_reset_data_interface(struct nand_chip *chip, int chipnr)
 	 * timings to timing mode 0.
 	 */
 
-	conf = nand_get_default_data_interface();
-	ret = chip->setup_data_interface(mtd, chipnr, conf);
+	onfi_fill_data_interface(chip, NAND_SDR_IFACE, 0);
+	ret = chip->setup_data_interface(mtd, chipnr, &chip->data_interface);
 	if (ret)
 		pr_err("Failed to configure data interface to SDR timing mode 0\n");
 
@@ -1158,7 +1157,7 @@ static int nand_setup_data_interface(struct nand_chip *chip, int chipnr)
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	int ret;
 
-	if (!chip->setup_data_interface || !chip->data_interface)
+	if (!chip->setup_data_interface)
 		return 0;
 
 	/*
@@ -1179,7 +1178,7 @@ static int nand_setup_data_interface(struct nand_chip *chip, int chipnr)
 			goto err;
 	}
 
-	ret = chip->setup_data_interface(mtd, chipnr, chip->data_interface);
+	ret = chip->setup_data_interface(mtd, chipnr, &chip->data_interface);
 err:
 	return ret;
 }
@@ -1219,21 +1218,16 @@ static int nand_init_data_interface(struct nand_chip *chip)
 		modes = GENMASK(chip->onfi_timing_mode_default, 0);
 	}
 
-	chip->data_interface = kzalloc(sizeof(*chip->data_interface),
-				       GFP_KERNEL);
-	if (!chip->data_interface)
-		return -ENOMEM;
 
 	for (mode = fls(modes) - 1; mode >= 0; mode--) {
-		ret = onfi_init_data_interface(chip, chip->data_interface,
-					       NAND_SDR_IFACE, mode);
+		ret = onfi_fill_data_interface(chip, NAND_SDR_IFACE, mode);
 		if (ret)
 			continue;
 
 		/* Pass -1 to only */
 		ret = chip->setup_data_interface(mtd,
 						 NAND_DATA_IFACE_CHECK_ONLY,
-						 chip->data_interface);
+						 &chip->data_interface);
 		if (!ret) {
 			chip->onfi_timing_mode_default = mode;
 			break;
@@ -1243,11 +1237,6 @@ static int nand_init_data_interface(struct nand_chip *chip)
 	return 0;
 }
 
-static void nand_release_data_interface(struct nand_chip *chip)
-{
-	kfree(chip->data_interface);
-}
-
 /**
  * nand_read_page_op - Do a READ PAGE operation
  * @chip: The NAND chip
@@ -1763,11 +1752,16 @@ EXPORT_SYMBOL_GPL(nand_write_data_op);
  * @chip: The NAND chip
  * @chipnr: Internal die id
  *
+ * Save the timings data structure, then apply SDR timings mode 0 (see
+ * nand_reset_data_interface for details), do the reset operation, and
+ * apply back the previous timings.
+ *
  * Returns 0 for success or negative error code otherwise
  */
 int nand_reset(struct nand_chip *chip, int chipnr)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct nand_data_interface saved_data_intf = chip->data_interface;
 	int ret;
 
 	ret = nand_reset_data_interface(chip, chipnr);
@@ -1785,6 +1779,7 @@ int nand_reset(struct nand_chip *chip, int chipnr)
 		return ret;
 
 	chip->select_chip(mtd, chipnr);
+	chip->data_interface = saved_data_intf;
 	ret = nand_setup_data_interface(chip, chipnr);
 	chip->select_chip(mtd, -1);
 	if (ret)
@@ -4889,6 +4884,9 @@ int nand_scan_ident(struct mtd_info *mtd, int maxchips,
 	struct nand_chip *chip = mtd_to_nand(mtd);
 	int ret;
 
+	/* Enforce the right timings for reset/detection */
+	onfi_fill_data_interface(chip, NAND_SDR_IFACE, 0);
+
 	ret = nand_dt_init(chip);
 	if (ret)
 		return ret;
@@ -5629,7 +5627,7 @@ int nand_scan_tail(struct mtd_info *mtd)
 		chip->select_chip(mtd, -1);
 
 		if (ret)
-			goto err_nand_data_iface_cleanup;
+			goto err_nand_manuf_cleanup;
 	}
 
 	/* Check, if we should skip the bad block table scan */
@@ -5639,12 +5637,10 @@ int nand_scan_tail(struct mtd_info *mtd)
 	/* Build bad block table */
 	ret = chip->scan_bbt(mtd);
 	if (ret)
-		goto err_nand_data_iface_cleanup;
+		goto err_nand_manuf_cleanup;
 
 	return 0;
 
-err_nand_data_iface_cleanup:
-	nand_release_data_interface(chip);
 
 err_nand_manuf_cleanup:
 	nand_manufacturer_cleanup(chip);
@@ -5703,8 +5699,6 @@ void nand_cleanup(struct nand_chip *chip)
 	    chip->ecc.algo == NAND_ECC_BCH)
 		nand_bch_free((struct nand_bch_control *)chip->ecc.priv);
 
-	nand_release_data_interface(chip);
-
 	/* Free bad block table memory */
 	kfree(chip->bbt);
 	if (!(chip->options & NAND_OWN_BUFFERS) && chip->buffers) {
diff --git a/drivers/mtd/nand/nand_timings.c b/drivers/mtd/nand/nand_timings.c
index 5d1533bcc5bd..9400d039ddbd 100644
--- a/drivers/mtd/nand/nand_timings.c
+++ b/drivers/mtd/nand/nand_timings.c
@@ -283,16 +283,16 @@ const struct nand_sdr_timings *onfi_async_timing_mode_to_sdr_timings(int mode)
 EXPORT_SYMBOL(onfi_async_timing_mode_to_sdr_timings);
 
 /**
- * onfi_init_data_interface - [NAND Interface] Initialize a data interface from
+ * onfi_fill_data_interface - [NAND Interface] Initialize a data interface from
  * given ONFI mode
- * @iface: The data interface to be initialized
  * @mode: The ONFI timing mode
  */
-int onfi_init_data_interface(struct nand_chip *chip,
-			     struct nand_data_interface *iface,
+int onfi_fill_data_interface(struct nand_chip *chip,
 			     enum nand_data_interface_type type,
 			     int timing_mode)
 {
+	struct nand_data_interface *iface = &chip->data_interface;
+
 	if (type != NAND_SDR_IFACE)
 		return -EINVAL;
 
@@ -321,15 +321,4 @@ int onfi_init_data_interface(struct nand_chip *chip,
 
 	return 0;
 }
-EXPORT_SYMBOL(onfi_init_data_interface);
-
-/**
- * nand_get_default_data_interface - [NAND Interface] Retrieve NAND
- * data interface for mode 0. This is used as default timing after
- * reset.
- */
-const struct nand_data_interface *nand_get_default_data_interface(void)
-{
-	return &onfi_sdr_timings[0];
-}
-EXPORT_SYMBOL(nand_get_default_data_interface);
+EXPORT_SYMBOL(onfi_fill_data_interface);
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 831bf91e0c34..0be959a478db 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -917,7 +917,7 @@ struct nand_chip {
 	u16 max_bb_per_die;
 	u32 blocks_per_die;
 
-	struct nand_data_interface *data_interface;
+	struct nand_data_interface data_interface;
 
 	int read_retries;
 
@@ -1214,8 +1214,7 @@ static inline int onfi_get_sync_timing_mode(struct nand_chip *chip)
 	return le16_to_cpu(chip->onfi_params.src_sync_timing_mode);
 }
 
-int onfi_init_data_interface(struct nand_chip *chip,
-			     struct nand_data_interface *iface,
+int onfi_fill_data_interface(struct nand_chip *chip,
 			     enum nand_data_interface_type type,
 			     int timing_mode);
 
@@ -1258,8 +1257,6 @@ static inline int jedec_feature(struct nand_chip *chip)
 
 /* get timing characteristics from ONFI timing mode. */
 const struct nand_sdr_timings *onfi_async_timing_mode_to_sdr_timings(int mode);
-/* get data interface from ONFI timing mode 0, used after reset. */
-const struct nand_data_interface *nand_get_default_data_interface(void);
 
 int nand_check_erased_ecc_chunk(void *data, int datalen,
 				void *ecc, int ecclen,
-- 
2.11.0
