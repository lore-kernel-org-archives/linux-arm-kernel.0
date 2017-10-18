From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Wed, 18 Oct 2017 16:36:20 +0200
Subject: [RFC 03/12] mtd: nand: use a static data_interface in the nand_chip
 structure
In-Reply-To: <20171018143629.29302-1-miquel.raynal@free-electrons.com>
References: <20171018143629.29302-1-miquel.raynal@free-electrons.com>
Message-ID: <20171018143629.29302-4-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the data_interface field from the nand_chip structure, convert
the pointer to a static structure.

Also remove the nand_get_default_data_interface() function that become
useless and rename the onfi_init_data_interface() by
nand_fill_data_interface(), which is a more appropriate name because
applied timings are ONFI, no matter if the NAND actually is one.

This is needed before passing to ->exec_op() to avoid any race that
could lead to a panic (null pointer dereference) on the initialization
of the timings structure that will be used from the first reset
operation if the pointer to data_interface was not referenced yet.

Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---
 drivers/mtd/nand/nand_base.c    | 35 ++++++++++-------------------------
 drivers/mtd/nand/nand_timings.c | 23 ++++++-----------------
 include/linux/mtd/rawnand.h     |  9 ++-------
 3 files changed, 18 insertions(+), 49 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 318595c29053..bef20e06f0db 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -814,8 +814,8 @@ static void nand_ccs_delay(struct nand_chip *chip)
 	 * Wait tCCS_min if it is correctly defined, otherwise wait 500ns
 	 * (which should be safe for all NANDs).
 	 */
-	if (chip->data_interface && chip->data_interface->timings.sdr.tCCS_min)
-		ndelay(chip->data_interface->timings.sdr.tCCS_min / 1000);
+	if (chip->data_interface.timings.sdr.tCCS_min)
+		ndelay(chip->data_interface.timings.sdr.tCCS_min / 1000);
 	else
 		ndelay(500);
 }
@@ -1107,7 +1107,6 @@ static int nand_wait(struct mtd_info *mtd, struct nand_chip *chip)
 static int nand_reset_data_interface(struct nand_chip *chip, int chipnr)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
-	const struct nand_data_interface *conf;
 	int ret;
 
 	if (!chip->setup_data_interface)
@@ -1127,8 +1126,8 @@ static int nand_reset_data_interface(struct nand_chip *chip, int chipnr)
 	 * timings to timing mode 0.
 	 */
 
-	conf = nand_get_default_data_interface();
-	ret = chip->setup_data_interface(mtd, chipnr, conf);
+	nand_fill_data_interface(chip, 0);
+	ret = chip->setup_data_interface(mtd, chipnr, &chip->data_interface);
 	if (ret)
 		pr_err("Failed to configure data interface to SDR timing mode 0\n");
 
@@ -1153,7 +1152,7 @@ static int nand_setup_data_interface(struct nand_chip *chip, int chipnr)
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	int ret;
 
-	if (!chip->setup_data_interface || !chip->data_interface)
+	if (!chip->setup_data_interface)
 		return 0;
 
 	/*
@@ -1174,7 +1173,7 @@ static int nand_setup_data_interface(struct nand_chip *chip, int chipnr)
 			goto err;
 	}
 
-	ret = chip->setup_data_interface(mtd, chipnr, chip->data_interface);
+	ret = chip->setup_data_interface(mtd, chipnr, &chip->data_interface);
 err:
 	return ret;
 }
@@ -1214,21 +1213,16 @@ static int nand_init_data_interface(struct nand_chip *chip)
 		modes = GENMASK(chip->onfi_timing_mode_default, 0);
 	}
 
-	chip->data_interface = kzalloc(sizeof(*chip->data_interface),
-				       GFP_KERNEL);
-	if (!chip->data_interface)
-		return -ENOMEM;
 
 	for (mode = fls(modes) - 1; mode >= 0; mode--) {
-		ret = onfi_init_data_interface(chip, chip->data_interface,
-					       NAND_SDR_IFACE, mode);
+		ret = nand_fill_data_interface(chip, mode);
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
@@ -1238,11 +1232,6 @@ static int nand_init_data_interface(struct nand_chip *chip)
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
@@ -5567,7 +5556,7 @@ int nand_scan_tail(struct mtd_info *mtd)
 		chip->select_chip(mtd, -1);
 
 		if (ret)
-			goto err_nand_data_iface_cleanup;
+			goto err_nand_manuf_cleanup;
 	}
 
 	/* Check, if we should skip the bad block table scan */
@@ -5577,12 +5566,10 @@ int nand_scan_tail(struct mtd_info *mtd)
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
@@ -5641,8 +5628,6 @@ void nand_cleanup(struct nand_chip *chip)
 	    chip->ecc.algo == NAND_ECC_BCH)
 		nand_bch_free((struct nand_bch_control *)chip->ecc.priv);
 
-	nand_release_data_interface(chip);
-
 	/* Free bad block table memory */
 	kfree(chip->bbt);
 	if (!(chip->options & NAND_OWN_BUFFERS) && chip->buffers) {
diff --git a/drivers/mtd/nand/nand_timings.c b/drivers/mtd/nand/nand_timings.c
index 5d1533bcc5bd..745b6404c901 100644
--- a/drivers/mtd/nand/nand_timings.c
+++ b/drivers/mtd/nand/nand_timings.c
@@ -283,17 +283,17 @@ const struct nand_sdr_timings *onfi_async_timing_mode_to_sdr_timings(int mode)
 EXPORT_SYMBOL(onfi_async_timing_mode_to_sdr_timings);
 
 /**
- * onfi_init_data_interface - [NAND Interface] Initialize a data interface from
+ * nand_fill_data_interface - [NAND Interface] Initialize a data interface from
  * given ONFI mode
  * @iface: The data interface to be initialized
  * @mode: The ONFI timing mode
  */
-int onfi_init_data_interface(struct nand_chip *chip,
-			     struct nand_data_interface *iface,
-			     enum nand_data_interface_type type,
+int nand_fill_data_interface(struct nand_chip *chip,
 			     int timing_mode)
 {
-	if (type != NAND_SDR_IFACE)
+	struct nand_data_interface *iface = &chip->data_interface;
+
+	if (iface->type != NAND_SDR_IFACE)
 		return -EINVAL;
 
 	if (timing_mode < 0 || timing_mode >= ARRAY_SIZE(onfi_sdr_timings))
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
+EXPORT_SYMBOL(nand_fill_data_interface);
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 04f4cfbe6c09..1acc26ed0e91 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -917,7 +917,7 @@ struct nand_chip {
 	u16 max_bb_per_die;
 	u32 blocks_per_die;
 
-	struct nand_data_interface *data_interface;
+	struct nand_data_interface data_interface;
 
 	int read_retries;
 
@@ -1214,10 +1214,7 @@ static inline int onfi_get_sync_timing_mode(struct nand_chip *chip)
 	return le16_to_cpu(chip->onfi_params.src_sync_timing_mode);
 }
 
-int onfi_init_data_interface(struct nand_chip *chip,
-			     struct nand_data_interface *iface,
-			     enum nand_data_interface_type type,
-			     int timing_mode);
+int nand_fill_data_interface(struct nand_chip *chip, int timing_mode);
 
 /*
  * Check if it is a SLC nand.
@@ -1258,8 +1255,6 @@ static inline int jedec_feature(struct nand_chip *chip)
 
 /* get timing characteristics from ONFI timing mode. */
 const struct nand_sdr_timings *onfi_async_timing_mode_to_sdr_timings(int mode);
-/* get data interface from ONFI timing mode 0, used after reset. */
-const struct nand_data_interface *nand_get_default_data_interface(void);
 
 int nand_check_erased_ecc_chunk(void *data, int datalen,
 				void *ecc, int ecclen,
-- 
2.11.0
