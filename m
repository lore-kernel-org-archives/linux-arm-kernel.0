From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue,  6 Sep 2016 12:39:12 +0200
Subject: [PATCH 4/7] mtd: nand: automate NAND timings selection
In-Reply-To: <1473158355-22451-1-git-send-email-s.hauer@pengutronix.de>
References: <1473158355-22451-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1473158355-22451-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris Brezillon <boris.brezillon@free-electrons.com>

The NAND framework provides several helpers to query timing modes supported
by a NAND chip, but this implies that all NAND controller drivers have
to implement the same timings selection dance. Also currently NAND
devices can be resetted at arbitrary places which also resets the timing
for ONFI chips to timing mode 0.

Provide a common logic to select the best timings based on ONFI or
->onfi_timing_mode_default information. Hook this into nand_reset()
to make sure the new timing is applied each time during a reset.

NAND controller willing to support timings adjustment should just
implement the ->setup_data_interface() method.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mtd/nand/nand_base.c | 112 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/mtd/nand.h     |  14 ++++--
 2 files changed, 122 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 20151fc..37852e9 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -955,8 +955,63 @@ static int nand_wait(struct mtd_info *mtd, struct nand_chip *chip)
  */
 int nand_reset(struct mtd_info *mtd)
 {
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int ret;
+
+	if (chip->setup_data_interface) {
+		struct nand_data_interface conf = {
+			.type = NAND_SDR_IFACE,
+			.timings.sdr = *onfi_async_timing_mode_to_sdr_timings(0),
+		};
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
+		 * timings to timing mode 0.
+		 */
+
+		ret = chip->setup_data_interface(mtd, &conf, false);
+		if (ret) {
+			pr_err("Failed to configure data interface to SDR timing mode 0\n");
+			return ret;
+		}
+	}
+
 	chip->cmdfunc(mtd, NAND_CMD_RESET, -1, -1);
 
+	/*
+	 * Setup the NAND interface (interface type + timings).
+	 */
+	if (chip->data_iface) {
+		uint8_t tmode_param[ONFI_SUBFEATURE_PARAM_LEN] = {
+			chip->onfi_timing_mode_default,
+		};
+
+		/*
+		 * Ensure the timing mode has be changed on the chip side
+		 * before changing timings on the controller side.
+		 */
+		if (chip->onfi_version) {
+			ret = chip->onfi_set_features(mtd, chip,
+					ONFI_FEATURE_ADDR_TIMING_MODE,
+					tmode_param);
+			if (ret)
+				return ret;
+		}
+
+		ret = chip->setup_data_interface(mtd, chip->data_iface, false);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -3335,6 +3390,54 @@ static void nand_onfi_detect_micron(struct nand_chip *chip,
 	chip->setup_read_retry = nand_setup_read_retry_micron;
 }
 
+/**
+ * nand_find_data_interface - Find the best data interface and timings
+ * @mtd: MTD device structure
+ *
+ * Try to find the best data interface and NAND timings supported by the
+ * chip and the driver.
+ * First tries to retrieve supported timing modes from ONFI information,
+ * and if the NAND chip does not support ONFI, relies on the
+ * ->onfi_timing_mode_default specified in the nand_ids table.
+ *
+ * Returns 0 for success or negative error code otherwise.
+ */
+static int nand_find_data_interface(struct mtd_info *mtd)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int modes, mode, ret;
+	const struct nand_data_interface *conf;
+
+	/*
+	 * First try to identify the best timings from ONFI parameters and
+	 * if the NAND does not support ONFI, fallback to the default ONFI
+	 * timing mode.
+	 */
+	modes = onfi_get_async_timing_mode(chip);
+	if (modes == ONFI_TIMING_MODE_UNKNOWN)
+		modes = GENMASK(chip->onfi_timing_mode_default, 0);
+
+	ret = -EINVAL;
+	for (mode = fls(modes) - 1; mode >= 0; mode--) {
+		conf = onfi_async_timing_mode_to_data_interface(mode);
+
+		ret = chip->setup_data_interface(mtd, conf, true);
+		if (!ret) {
+			chip->onfi_timing_mode_default = mode;
+			break;
+		}
+	}
+
+	if (ret)
+		return ret;
+
+	chip->data_iface = kmemdup(conf, sizeof(*conf), GFP_KERNEL);
+	if (!chip->data_iface)
+		return -ENOMEM;
+
+	return 0;
+}
+
 /*
  * Check if the NAND chip is ONFI compliant, returns 1 if it is, 0 otherwise.
  */
@@ -4168,6 +4271,12 @@ int nand_scan_ident(struct mtd_info *mtd, int maxchips,
 		return PTR_ERR(type);
 	}
 
+	if (chip->setup_data_interface) {
+		ret = nand_find_data_interface(mtd);
+		if (ret)
+			return ret;
+	}
+
 	chip->select_chip(mtd, -1);
 
 	/* Check for a chip array */
@@ -4627,6 +4736,9 @@ void nand_release(struct mtd_info *mtd)
 
 	mtd_device_unregister(mtd);
 
+	/* Free interface config struct */
+	kfree(chip->data_iface);
+
 	/* Free bad block table memory */
 	kfree(chip->bbt);
 	if (!(chip->options & NAND_OWN_BUFFERS))
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index a8bdf6c..5269357 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -690,10 +690,9 @@ struct nand_data_interface {
  *                      also from the datasheet. It is the recommended ECC step
  *			size, if known; if unknown, set to zero.
  * @onfi_timing_mode_default: [INTERN] default ONFI timing mode. This field is
- *			      either deduced from the datasheet if the NAND
- *			      chip is not ONFI compliant or set to 0 if it is
- *			      (an ONFI chip is always configured in mode 0
- *			      after a NAND reset)
+ * 			      set to the actually used ONFI mode if the chip is
+ * 			      ONFI compliant or deduced from the datasheet if
+ * 			      the NAND chip is not ONFI compliant.
  * @numchips:		[INTERN] number of physical chips
  * @chipsize:		[INTERN] the size of one chip for multichip arrays
  * @pagemask:		[INTERN] page number mask = number of (pages / chip) - 1
@@ -713,6 +712,7 @@ struct nand_data_interface {
  * @read_retries:	[INTERN] the number of read retry modes supported
  * @onfi_set_features:	[REPLACEABLE] set the features for ONFI nand
  * @onfi_get_features:	[REPLACEABLE] get the features for ONFI nand
+ * @setup_data_interface: [OPTIONAL] setup the data interface and timing
  * @bbt:		[INTERN] bad block table pointer
  * @bbt_td:		[REPLACEABLE] bad block table descriptor for flash
  *			lookup.
@@ -759,6 +759,10 @@ struct nand_chip {
 	int (*onfi_get_features)(struct mtd_info *mtd, struct nand_chip *chip,
 			int feature_addr, uint8_t *subfeature_para);
 	int (*setup_read_retry)(struct mtd_info *mtd, int retry_mode);
+	int (*setup_data_interface)(struct mtd_info *mtd,
+				    const struct nand_data_interface *conf,
+				    bool check_only);
+
 
 	int chip_delay;
 	unsigned int options;
@@ -788,6 +792,8 @@ struct nand_chip {
 		struct nand_jedec_params jedec_params;
 	};
 
+	const struct nand_data_interface *data_iface;
+
 	int read_retries;
 
 	flstate_t state;
-- 
2.8.1
