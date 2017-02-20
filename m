From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 20 Feb 2017 18:16:14 +0100
Subject: [PATCH 1/3] mtd: nand: Pass the CS line to ->setup_data_interface()
In-Reply-To: <1487610978-12423-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1487610978-12423-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1487610978-12423-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some NAND controllers can assign different NAND timings to different
CS lines. Pass the CS line information to ->setup_data_interface() so
that the NAND controller driver knows which CS line is concerned by
the setup_data_interface() request.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/mxc_nand.c   | 12 +++++-------
 drivers/mtd/nand/nand_base.c  | 22 +++++++++++++---------
 drivers/mtd/nand/s3c2410.c    |  5 ++---
 drivers/mtd/nand/sunxi_nand.c |  7 +++----
 drivers/mtd/nand/tango_nand.c |  7 +++----
 include/linux/mtd/nand.h      | 12 ++++++++----
 6 files changed, 34 insertions(+), 31 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 61ca020c5272..a764d5ca7536 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -152,9 +152,8 @@ struct mxc_nand_devtype_data {
 	void (*select_chip)(struct mtd_info *mtd, int chip);
 	int (*correct_data)(struct mtd_info *mtd, u_char *dat,
 			u_char *read_ecc, u_char *calc_ecc);
-	int (*setup_data_interface)(struct mtd_info *mtd,
-				    const struct nand_data_interface *conf,
-				    bool check_only);
+	int (*setup_data_interface)(struct mtd_info *mtd, int csline,
+				    const struct nand_data_interface *conf);
 
 	/*
 	 * On i.MX21 the CONFIG2:INT bit cannot be read if interrupts are masked
@@ -1015,9 +1014,8 @@ static void preset_v1(struct mtd_info *mtd)
 	writew(0x4, NFC_V1_V2_WRPROT);
 }
 
-static int mxc_nand_v2_setup_data_interface(struct mtd_info *mtd,
-					const struct nand_data_interface *conf,
-					bool check_only)
+static int mxc_nand_v2_setup_data_interface(struct mtd_info *mtd, int csline,
+					const struct nand_data_interface *conf)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
 	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
@@ -1075,7 +1073,7 @@ static int mxc_nand_v2_setup_data_interface(struct mtd_info *mtd,
 		return -EINVAL;
 	}
 
-	if (check_only)
+	if (csline == NAND_DATA_IFACE_CHECK_ONLY)
 		return 0;
 
 	ret = clk_set_rate(host->clk, rate);
diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index c8894f31392e..d62a1c7c5c5c 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -977,12 +977,13 @@ static int nand_wait(struct mtd_info *mtd, struct nand_chip *chip)
 /**
  * nand_reset_data_interface - Reset data interface and timings
  * @chip: The NAND chip
+ * @chipnr: Internal die id
  *
  * Reset the Data interface and timings to ONFI mode 0.
  *
  * Returns 0 for success or negative error code otherwise.
  */
-static int nand_reset_data_interface(struct nand_chip *chip)
+static int nand_reset_data_interface(struct nand_chip *chip, int chipnr)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	const struct nand_data_interface *conf;
@@ -1006,7 +1007,7 @@ static int nand_reset_data_interface(struct nand_chip *chip)
 	 */
 
 	conf = nand_get_default_data_interface();
-	ret = chip->setup_data_interface(mtd, conf, false);
+	ret = chip->setup_data_interface(mtd, chipnr, conf);
 	if (ret)
 		pr_err("Failed to configure data interface to SDR timing mode 0\n");
 
@@ -1016,6 +1017,7 @@ static int nand_reset_data_interface(struct nand_chip *chip)
 /**
  * nand_setup_data_interface - Setup the best data interface and timings
  * @chip: The NAND chip
+ * @chipnr: Internal die id
  *
  * Find and configure the best data interface and NAND timings supported by
  * the chip and the driver.
@@ -1025,7 +1027,7 @@ static int nand_reset_data_interface(struct nand_chip *chip)
  *
  * Returns 0 for success or negative error code otherwise.
  */
-static int nand_setup_data_interface(struct nand_chip *chip)
+static int nand_setup_data_interface(struct nand_chip *chip, int chipnr)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	int ret;
@@ -1049,7 +1051,7 @@ static int nand_setup_data_interface(struct nand_chip *chip)
 			goto err;
 	}
 
-	ret = chip->setup_data_interface(mtd, chip->data_interface, false);
+	ret = chip->setup_data_interface(mtd, chipnr, chip->data_interface);
 err:
 	return ret;
 }
@@ -1100,8 +1102,10 @@ static int nand_init_data_interface(struct nand_chip *chip)
 		if (ret)
 			continue;
 
-		ret = chip->setup_data_interface(mtd, chip->data_interface,
-						 true);
+		/* Pass -1 to only */
+		ret = chip->setup_data_interface(mtd,
+						 NAND_DATA_IFACE_CHECK_ONLY,
+						 chip->data_interface);
 		if (!ret) {
 			chip->onfi_timing_mode_default = mode;
 			break;
@@ -1128,7 +1132,7 @@ int nand_reset(struct nand_chip *chip, int chipnr)
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	int ret;
 
-	ret = nand_reset_data_interface(chip);
+	ret = nand_reset_data_interface(chip, chipnr);
 	if (ret)
 		return ret;
 
@@ -1141,7 +1145,7 @@ int nand_reset(struct nand_chip *chip, int chipnr)
 	chip->select_chip(mtd, -1);
 
 	chip->select_chip(mtd, chipnr);
-	ret = nand_setup_data_interface(chip);
+	ret = nand_setup_data_interface(chip, chipnr);
 	chip->select_chip(mtd, -1);
 	if (ret)
 		return ret;
@@ -4376,7 +4380,7 @@ int nand_scan_ident(struct mtd_info *mtd, int maxchips,
 	 * For the other dies, nand_reset() will automatically switch to the
 	 * best mode for us.
 	 */
-	ret = nand_setup_data_interface(chip);
+	ret = nand_setup_data_interface(chip, 0);
 	if (ret)
 		return ret;
 
diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
index f0b030d44f71..9e0c849607b9 100644
--- a/drivers/mtd/nand/s3c2410.c
+++ b/drivers/mtd/nand/s3c2410.c
@@ -812,9 +812,8 @@ static int s3c2410_nand_add_partition(struct s3c2410_nand_info *info,
 	return -ENODEV;
 }
 
-static int s3c2410_nand_setup_data_interface(struct mtd_info *mtd,
-					const struct nand_data_interface *conf,
-					bool check_only)
+static int s3c2410_nand_setup_data_interface(struct mtd_info *mtd, int csline,
+					const struct nand_data_interface *conf)
 {
 	struct s3c2410_nand_info *info = s3c2410_nand_mtd_toinfo(mtd);
 	struct s3c2410_platform_nand *pdata = info->platform;
diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index e40482a65de6..4495c6111e32 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -1576,9 +1576,8 @@ static int _sunxi_nand_lookup_timing(const s32 *lut, int lut_size, u32 duration,
 #define sunxi_nand_lookup_timing(l, p, c) \
 			_sunxi_nand_lookup_timing(l, ARRAY_SIZE(l), p, c)
 
-static int sunxi_nfc_setup_data_interface(struct mtd_info *mtd,
-					const struct nand_data_interface *conf,
-					bool check_only)
+static int sunxi_nfc_setup_data_interface(struct mtd_info *mtd, int csline,
+					const struct nand_data_interface *conf)
 {
 	struct nand_chip *nand = mtd_to_nand(mtd);
 	struct sunxi_nand_chip *chip = to_sunxi_nand(nand);
@@ -1691,7 +1690,7 @@ static int sunxi_nfc_setup_data_interface(struct mtd_info *mtd,
 		return tRHW;
 	}
 
-	if (check_only)
+	if (csline == NAND_DATA_IFACE_CHECK_ONLY)
 		return 0;
 
 	/*
diff --git a/drivers/mtd/nand/tango_nand.c b/drivers/mtd/nand/tango_nand.c
index 4a5e948c62df..4f37b5e80ac6 100644
--- a/drivers/mtd/nand/tango_nand.c
+++ b/drivers/mtd/nand/tango_nand.c
@@ -474,9 +474,8 @@ static u32 to_ticks(int kHz, int ps)
 	return DIV_ROUND_UP_ULL((u64)kHz * ps, NSEC_PER_SEC);
 }
 
-static int tango_set_timings(struct mtd_info *mtd,
-			     const struct nand_data_interface *conf,
-			     bool check_only)
+static int tango_set_timings(struct mtd_info *mtd, int csline,
+			     const struct nand_data_interface *conf)
 {
 	const struct nand_sdr_timings *sdr = nand_get_sdr_timings(conf);
 	struct nand_chip *chip = mtd_to_nand(mtd);
@@ -488,7 +487,7 @@ static int tango_set_timings(struct mtd_info *mtd,
 	if (IS_ERR(sdr))
 		return PTR_ERR(sdr);
 
-	if (check_only)
+	if (csline == NAND_DATA_IFACE_CHECK_ONLY)
 		return 0;
 
 	Trdy = to_ticks(kHz, sdr->tCEA_max - sdr->tREA_max);
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 9d51dee53be4..3ea1c176e591 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -107,6 +107,8 @@ int nand_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len);
 #define NAND_STATUS_READY	0x40
 #define NAND_STATUS_WP		0x80
 
+#define NAND_DATA_IFACE_CHECK_ONLY	-1
+
 /*
  * Constants for ECC_MODES
  */
@@ -804,7 +806,10 @@ nand_get_sdr_timings(const struct nand_data_interface *conf)
  * @read_retries:	[INTERN] the number of read retry modes supported
  * @onfi_set_features:	[REPLACEABLE] set the features for ONFI nand
  * @onfi_get_features:	[REPLACEABLE] get the features for ONFI nand
- * @setup_data_interface: [OPTIONAL] setup the data interface and timing
+ * @setup_data_interface: [OPTIONAL] setup the data interface and timing. If
+ * 			  chipnr is set to %NAND_DATA_IFACE_CHECK_ONLY this
+ * 			  means the configuration should not be applied but
+ * 			  only checked.
  * @bbt:		[INTERN] bad block table pointer
  * @bbt_td:		[REPLACEABLE] bad block table descriptor for flash
  *			lookup.
@@ -847,9 +852,8 @@ struct nand_chip {
 	int (*onfi_get_features)(struct mtd_info *mtd, struct nand_chip *chip,
 			int feature_addr, uint8_t *subfeature_para);
 	int (*setup_read_retry)(struct mtd_info *mtd, int retry_mode);
-	int (*setup_data_interface)(struct mtd_info *mtd,
-				    const struct nand_data_interface *conf,
-				    bool check_only);
+	int (*setup_data_interface)(struct mtd_info *mtd, int chipnr,
+				    const struct nand_data_interface *conf);
 
 
 	int chip_delay;
-- 
2.7.4
