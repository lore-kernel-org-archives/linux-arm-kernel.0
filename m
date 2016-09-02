From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  2 Sep 2016 14:42:28 +0200
Subject: [PATCH 1/2] mtd: nand: automate NAND timings selection
In-Reply-To: <1472820149-24241-1-git-send-email-s.hauer@pengutronix.de>
References: <1472820149-24241-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1472820149-24241-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris Brezillon <boris.brezillon@free-electrons.com>

The NAND framework provides several helpers to query timing modes supported
by a NAND chip, but this implies that all NAND controller drivers have
to implement the same timings selection dance.

Provide a common logic to select the best timings based on ONFI or
->onfi_timing_mode_default information.
NAND controller willing to support timings adjustment should just
implement the ->setup_data_interface() method.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mtd/nand/nand_base.c | 196 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/mtd/nand.h     | 115 ++++++++++++++-----------
 2 files changed, 261 insertions(+), 50 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 77533f7..018fd56 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -3322,6 +3322,148 @@ static void nand_onfi_detect_micron(struct nand_chip *chip,
 	chip->setup_read_retry = nand_setup_read_retry_micron;
 }
 
+/**
+ * nand_setup_data_interface - Setup the data interface and timings on the
+ *			       controller side
+ * @mtd: MTD device structure
+ * @conf: new configuration to apply
+ *
+ * Try to configure the NAND controller to support the provided data
+ * interface configuration.
+ *
+ * Returns 0 in case of success or -ERROR_CODE.
+ */
+static int nand_setup_data_interface(struct mtd_info *mtd,
+				     const struct nand_data_interface *conf)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int ret;
+
+	if (!chip->setup_data_interface)
+		return -ENOTSUPP;
+
+	ret = chip->setup_data_interface(mtd, conf, false);
+	if (ret)
+		return ret;
+
+	*chip->data_iface = *conf;
+
+	return 0;
+}
+
+/**
+ * nand_check_data_interface - Check if a data interface config is supported
+ *			       by the NAND controller
+ * @mtd: MTD device structure
+ * @conf: new configuration to apply
+ *
+ * Check if the provided data interface configuration is supported by the
+ * NAND controller.
+ *
+ * Returns 0 if it is supported or -ERROR_CODE.
+ */
+static int nand_check_data_interface(struct mtd_info *mtd,
+				     const struct nand_data_interface *conf)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (!chip->setup_data_interface)
+		return -ENOTSUPP;
+
+	return chip->setup_data_interface(mtd, conf, true);
+}
+
+/**
+ * nand_configure_data_interface - Configure the data interface and timings
+ * @mtd: MTD device structure
+ *
+ * Try to configure the data interface and NAND timings appropriately.
+ * First tries to retrieve supported timing modes from ONFI information,
+ * and if the NAND chip does not support ONFI, relies on the
+ * ->onfi_timing_mode_default specified in the nand_ids table.
+ *
+ * Returns 0 in case of success or -ERROR_CODE.
+ */
+static int nand_configure_data_interface(struct mtd_info *mtd)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct nand_data_interface *conf;
+	int modes, mode, ret = -EINVAL;
+	uint8_t tmode_param[ONFI_SUBFEATURE_PARAM_LEN] = { };
+	int i;
+
+	conf = kzalloc(sizeof(*conf), GFP_KERNEL);
+	if (!conf)
+		return -ENOMEM;
+
+	/* TODO: support DDR interfaces */
+	conf->type = NAND_SDR_IFACE;
+
+	/*
+	 * First try to identify the best timings from ONFI parameters and
+	 * if the NAND does not support ONFI, fallback to the default ONFI
+	 * timing mode.
+	 */
+	modes = onfi_get_async_timing_mode(chip);
+	if (modes == ONFI_TIMING_MODE_UNKNOWN) {
+		mode = chip->onfi_timing_mode_default;
+		conf->timings.sdr =
+				*onfi_async_timing_mode_to_sdr_timings(mode);
+
+		ret = nand_check_data_interface(mtd, conf);
+	} else {
+		for (mode = fls(modes) - 1; mode >= 0; mode--) {
+			conf->timings.sdr =
+				*onfi_async_timing_mode_to_sdr_timings(mode);
+
+			ret = nand_check_data_interface(mtd, conf);
+			if (!ret)
+				break;
+		}
+	}
+
+	if (ret)
+		goto out;
+
+	tmode_param[0] = mode;
+
+	/*
+	 * Ensure the timing mode has be changed on the chip side
+	 * before changing timings on the controller side.
+	 */
+	if (modes != ONFI_TIMING_MODE_UNKNOWN) {
+		/*
+		 * FIXME: should we really set the timing mode on all
+		 * dies?
+		 */
+		for (i = 0; i < chip->numchips; i++) {
+			chip->select_chip(mtd, i);
+			ret = chip->onfi_set_features(mtd, chip,
+					ONFI_FEATURE_ADDR_TIMING_MODE,
+					tmode_param);
+			if (ret)
+				goto out_reset;
+		}
+		chip->select_chip(mtd, -1);
+	}
+
+	ret = nand_setup_data_interface(mtd, conf);
+
+out_reset:
+	/*
+	 * Reset the NAND chip if the data interface setup
+	 * failed so that the chip goes back to a known state
+	 * (timing mode 0).
+	 */
+	if (ret)
+		chip->cmdfunc(mtd, NAND_CMD_RESET, -1, -1);
+
+out:
+	kfree(conf);
+
+	return ret;
+}
+
 /*
  * Check if the NAND chip is ONFI compliant, returns 1 if it is, 0 otherwise.
  */
@@ -4144,6 +4286,41 @@ int nand_scan_ident(struct mtd_info *mtd, int maxchips,
 	/* Set the default functions */
 	nand_set_defaults(chip, chip->options & NAND_BUSWIDTH_16);
 
+	/*
+	 * Allocate an interface config struct if the controller implements the
+	 * ->apply_interface_conf() method.
+	 */
+	if (chip->setup_data_interface) {
+		chip->data_iface = kzalloc(sizeof(*chip->data_iface),
+					   GFP_KERNEL);
+		if (!chip->data_iface)
+			return -ENOMEM;
+
+		/*
+		 * The ONFI specification says:
+		 * "
+		 * To transition from NV-DDR or NV-DDR2 to the SDR data
+		 * interface, the host shall use the Reset (FFh) command
+		 * using SDR timing mode 0. A device in any timing mode is
+		 * required to recognize Reset (FFh) command issued in SDR
+		 * timing mode 0.
+		 * "
+		 *
+		 * Configure the data interface in SDR mode and set the
+		 * timings to timing mode 0. The Reset command is issued
+		 * in nand_get_flash_type().
+		 */
+
+		chip->data_iface->type = NAND_SDR_IFACE;
+		chip->data_iface->timings.sdr =
+				*onfi_async_timing_mode_to_sdr_timings(0);
+		ret = chip->setup_data_interface(mtd, chip->data_iface, false);
+		if (ret) {
+			pr_err("Failed to configure data interface to SDR timing mode 0\n");
+			goto err;
+		}
+	}
+
 	/* Read the flash type */
 	type = nand_get_flash_type(mtd, chip, &nand_maf_id,
 				   &nand_dev_id, table);
@@ -4152,7 +4329,17 @@ int nand_scan_ident(struct mtd_info *mtd, int maxchips,
 		if (!(chip->options & NAND_SCAN_SILENT_NODEV))
 			pr_warn("No NAND device found\n");
 		chip->select_chip(mtd, -1);
-		return PTR_ERR(type);
+		ret = PTR_ERR(type);
+		goto err;
+	}
+
+	/*
+	 * Setup the NAND interface (interface type + timings).
+	 */
+	if (chip->setup_data_interface) {
+		ret = nand_configure_data_interface(mtd);
+		if (ret)
+			goto err;
 	}
 
 	chip->select_chip(mtd, -1);
@@ -4180,6 +4367,10 @@ int nand_scan_ident(struct mtd_info *mtd, int maxchips,
 	mtd->size = i * chip->chipsize;
 
 	return 0;
+
+err:
+	kfree(chip->data_iface);
+	return ret;
 }
 EXPORT_SYMBOL(nand_scan_ident);
 
@@ -4614,6 +4805,9 @@ void nand_release(struct mtd_info *mtd)
 
 	mtd_device_unregister(mtd);
 
+	/* Free interface config struct */
+	kfree(chip->data_iface);
+
 	/* Free bad block table memory */
 	kfree(chip->bbt);
 	if (!(chip->options & NAND_OWN_BUFFERS))
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 8dd6e01..7493215 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -565,6 +565,66 @@ struct nand_buffers {
 	uint8_t *databuf;
 };
 
+/*
+ * struct nand_sdr_timings - SDR NAND chip timings
+ *
+ * This struct defines the timing requirements of a SDR NAND chip.
+ * These information can be found in every NAND datasheets and the timings
+ * meaning are described in the ONFI specifications:
+ * www.onfi.org/~/media/ONFI/specs/onfi_3_1_spec.pdf (chapter 4.15 Timing
+ * Parameters)
+ *
+ * All these timings are expressed in picoseconds.
+ */
+
+struct nand_sdr_timings {
+	u32 tALH_min;
+	u32 tADL_min;
+	u32 tALS_min;
+	u32 tAR_min;
+	u32 tCEA_max;
+	u32 tCEH_min;
+	u32 tCH_min;
+	u32 tCHZ_max;
+	u32 tCLH_min;
+	u32 tCLR_min;
+	u32 tCLS_min;
+	u32 tCOH_min;
+	u32 tCS_min;
+	u32 tDH_min;
+	u32 tDS_min;
+	u32 tFEAT_max;
+	u32 tIR_min;
+	u32 tITC_max;
+	u32 tRC_min;
+	u32 tREA_max;
+	u32 tREH_min;
+	u32 tRHOH_min;
+	u32 tRHW_min;
+	u32 tRHZ_max;
+	u32 tRLOH_min;
+	u32 tRP_min;
+	u32 tRR_min;
+	u64 tRST_max;
+	u32 tWB_max;
+	u32 tWC_min;
+	u32 tWH_min;
+	u32 tWHR_min;
+	u32 tWP_min;
+	u32 tWW_min;
+};
+
+enum nand_data_interface_type {
+	NAND_SDR_IFACE,
+};
+
+struct nand_data_interface {
+	enum nand_data_interface_type type;
+	union {
+		struct nand_sdr_timings sdr;
+	} timings;
+};
+
 /**
  * struct nand_chip - NAND Private Flash Chip Data
  * @mtd:		MTD device registered to the MTD framework
@@ -696,6 +756,10 @@ struct nand_chip {
 	int (*onfi_get_features)(struct mtd_info *mtd, struct nand_chip *chip,
 			int feature_addr, uint8_t *subfeature_para);
 	int (*setup_read_retry)(struct mtd_info *mtd, int retry_mode);
+	int (*setup_data_interface)(struct mtd_info *mtd,
+				    const struct nand_data_interface *conf,
+				    bool check_only);
+
 
 	int chip_delay;
 	unsigned int options;
@@ -725,6 +789,8 @@ struct nand_chip {
 		struct nand_jedec_params jedec_params;
 	};
 
+	struct nand_data_interface *data_iface;
+
 	int read_retries;
 
 	flstate_t state;
@@ -1023,55 +1089,6 @@ static inline int jedec_feature(struct nand_chip *chip)
 		: 0;
 }
 
-/*
- * struct nand_sdr_timings - SDR NAND chip timings
- *
- * This struct defines the timing requirements of a SDR NAND chip.
- * These informations can be found in every NAND datasheets and the timings
- * meaning are described in the ONFI specifications:
- * www.onfi.org/~/media/ONFI/specs/onfi_3_1_spec.pdf (chapter 4.15 Timing
- * Parameters)
- *
- * All these timings are expressed in picoseconds.
- */
-
-struct nand_sdr_timings {
-	u32 tALH_min;
-	u32 tADL_min;
-	u32 tALS_min;
-	u32 tAR_min;
-	u32 tCEA_max;
-	u32 tCEH_min;
-	u32 tCH_min;
-	u32 tCHZ_max;
-	u32 tCLH_min;
-	u32 tCLR_min;
-	u32 tCLS_min;
-	u32 tCOH_min;
-	u32 tCS_min;
-	u32 tDH_min;
-	u32 tDS_min;
-	u32 tFEAT_max;
-	u32 tIR_min;
-	u32 tITC_max;
-	u32 tRC_min;
-	u32 tREA_max;
-	u32 tREH_min;
-	u32 tRHOH_min;
-	u32 tRHW_min;
-	u32 tRHZ_max;
-	u32 tRLOH_min;
-	u32 tRP_min;
-	u32 tRR_min;
-	u64 tRST_max;
-	u32 tWB_max;
-	u32 tWC_min;
-	u32 tWH_min;
-	u32 tWHR_min;
-	u32 tWP_min;
-	u32 tWW_min;
-};
-
 /* get timing characteristics from ONFI timing mode. */
 const struct nand_sdr_timings *onfi_async_timing_mode_to_sdr_timings(int mode);
 
-- 
2.8.1
