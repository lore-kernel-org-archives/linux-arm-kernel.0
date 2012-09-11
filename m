From: b32955@freescale.com (Huang Shijie)
Date: Tue, 11 Sep 2012 14:17:10 +0800
Subject: [PATCH 8/9] mtd: gpmi: add EDO feature for imx6q
In-Reply-To: <1347344231-10295-1-git-send-email-b32955@freescale.com>
References: <1347344231-10295-1-git-send-email-b32955@freescale.com>
Message-ID: <1347344231-10295-9-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the frequency on the nand chip pins is above 33MHz,
the nand EDO(extended Data Out) timing could be applied.
The GPMI implements a Feedback read strobe to sample the read data in
the EDO timing mode.

This patch adds the EDO feature for the gpmi-nand driver.

For some onfi nand chips, the mode 4 is the fastest;
while for other onfi nand chips, the mode 5 is the fastest.
This patch only adds the support for the fastest asynchronous timing mode.
So this patch only supports the mode 4 and mode 5.

I tested several Micron's ONFI nand chips with EDO enabled,
take Micron MT29F32G08MAA for example (in mode 5, 100MHz):

1) The test result BEFORE we add the EDO feature:
=================================================
mtd_speedtest: MTD device: 2
mtd_speedtest: MTD device size 209715200, eraseblock size 524288,
			page size 4096, count of eraseblocks 400,
			pages per eraseblock 128, OOB size 218
.......................................
mtd_speedtest: testing eraseblock read speed
mtd_speedtest: eraseblock read speed is 3632 KiB/s
.......................................
mtd_speedtest: testing page read speed
mtd_speedtest: page read speed is 3554 KiB/s
.......................................
mtd_speedtest: testing 2 page read speed
mtd_speedtest: 2 page read speed is 3592 KiB/s
.......................................
=================================================

2) The test result AFTER we add the EDO feature:
=================================================
mtd_speedtest: MTD device: 2
mtd_speedtest: MTD device size 209715200, eraseblock size 524288,
			page size 4096, count of eraseblocks 400,
			pages per eraseblock 128, OOB size 218
.......................................
mtd_speedtest: testing eraseblock read speed
mtd_speedtest: eraseblock read speed is 19555 KiB/s
.......................................
mtd_speedtest: testing page read speed
mtd_speedtest: page read speed is 17319 KiB/s
.......................................
mtd_speedtest: testing 2 page read speed
mtd_speedtest: 2 page read speed is 18339 KiB/s
.......................................
=================================================

The read data performance is much improved by more then 5 times.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c  |  214 +++++++++++++++++++++++++++++++-
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |    8 ++
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h |    6 +
 3 files changed, 227 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
index 83c5573..7efd326 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
@@ -737,6 +737,215 @@ return_results:
 	return 0;
 }
 
+/*
+ * [1] Firstly, we should know what's the GPMI-clock means.
+ *     The GPMI-clock is the internal clock in the gpmi nand controller.
+ *     If you set 100MHz to gpmi nand controller, the GPMI-clock's period
+ *     is 10ns. Mark the GPMI-clock's period as GPMI-clock-period.
+ *
+ * [2] Secondly, we should know what's the frequency on the nand chip pins.
+ *     The frequency on the nand chip pins is derived from the GPMI-clock.
+ *     We can get it from the following equation:
+ *
+ *         F = G / (DS + DH)
+ *
+ *         F  : the frequency on the nand chip pins.
+ *         G  : the GPMI clock, such as 100MHz.
+ *         DS : GPMI_HW_GPMI_TIMING0:DATA_SETUP
+ *         DH : GPMI_HW_GPMI_TIMING0:DATA_HOLD
+ *
+ * [3] Thirdly, when the frequency on the nand chip pins is above 33MHz,
+ *     the nand EDO(extended Data Out) timing could be applied.
+ *     The GPMI implements a feedback read strobe to sample the read data.
+ *     The feedback read strobe can be delayed to support the nand EDO timing
+ *     where the read strobe may deasserts before the read data is valid, and
+ *     read data is valid for some time after read strobe.
+ *
+ *     The following figure illustrates some aspects of a NAND Flash read:
+ *
+ *                   |<---tREA---->|
+ *                   |             |
+ *                   |         |   |
+ *                   |<--tRP-->|   |
+ *                   |         |   |
+ *                  __          ___|__________________________________
+ *     RDN            \________/   |
+ *                                 |
+ *                                 /---------\
+ *     Read Data    --------------<           >---------
+ *                                 \---------/
+ *                                |     |
+ *                                |<-D->|
+ *     FeedbackRDN  ________             ____________
+ *                          \___________/
+ *
+ *          D stands for delay, set in the HW_GPMI_CTRL1:RDN_DELAY.
+ *
+ *
+ * [4] Now, we begin to describe how to compute the right RDN_DELAY.
+ *
+ *  4.1) From the aspect of the nand chip pins:
+ *        Delay = (tREA + C - tRP)               [1]
+ *
+ *        tREA : the maximum read access time. From the ONFI nand standards,
+ *               we know that tREA is 16ns in mode 5, tREA is 20ns is mode 4.
+ *               Please check it in : www.onfi.org
+ *        C    : a constant for adjust the delay. default is 4.
+ *        tRP  : the read pulse width.
+ *               Specified by the HW_GPMI_TIMING0:DATA_SETUP:
+ *                    tRP = (GPMI-clock-period) * DATA_SETUP
+ *
+ *  4.2) From the aspect of the GPMI nand controller:
+ *         Delay = RDN_DELAY * 0.125 * RP        [2]
+ *
+ *         RP   : the DLL reference period.
+ *            if (GPMI-clock-period > DLL_THRETHOLD)
+ *                   RP = GPMI-clock-period / 2;
+ *            else
+ *                   RP = GPMI-clock-period;
+ *
+ *            Set the HW_GPMI_CTRL1:HALF_PERIOD if GPMI-clock-period
+ *            is greater DLL_THRETHOLD. In other Soc, the thethold is 16ns,
+ *            but in mx6q, we use 12ns.
+ *
+ *  4.3) since [1] equals [2], we get:
+ *
+ *                    (tREA + 4 - tRP) * 8
+ *         RDN_DELAY = ---------------------     [3]
+ *                           RP
+ *
+ *  4.4) We only support the fastest asynchronous mode of ONFI nand.
+ *       For some ONFI nand, the mode 4 is the fastest mode;
+ *       while for some ONFI nand, the mode 5 is the fastest mode.
+ *       So we only support the mode 4 and mode 5. It is no need to
+ *       support other modes.
+ */
+static void gpmi_compute_edo_timing(struct gpmi_nand_data *this,
+			struct gpmi_nfc_hardware_timing *hw)
+{
+	struct resources *r = &this->resources;
+	unsigned long rate = clk_get_rate(r->clock[0]);
+	int mode = this->timing_mode;
+	int dll_threshold = 16; /* in ns */
+	unsigned long delay;
+	unsigned long clk_period;
+	int t_rea;
+	int c = 4;
+	int t_rp;
+	int rp;
+
+	/*
+	 * 1) for GPMI_HW_GPMI_TIMING0:
+	 *    The async mode requires 40MHz for mode 4, 50MHz for mode 5.
+	 *    The GPMI can support 100MHz at most. But the if we want to
+	 *    get the 40MHz or 50MHz, we have to set DS=1, DH=1.
+	 *    It is okay to set ADDRESS_SETUP to 1.
+	 */
+	hw->data_setup_in_cycles = 1;
+	hw->data_hold_in_cycles = 1;
+	hw->address_setup_in_cycles = 1;
+
+	/* 2) for GPMI_HW_GPMI_TIMING1 */
+	hw->device_busy_timeout = 0x9000;
+
+	/* 3) for GPMI_HW_GPMI_CTRL1 */
+	hw->wrn_dly_sel = 3; /* no delay for write strobe. */
+
+	if (GPMI_IS_MX6Q(this))
+		dll_threshold = 12;
+
+	/*
+	 * Enlarge 10 times for the numerator and denominator in [3].
+	 * This make us to get more accurate result.
+	 */
+	clk_period = 1000000000 / (rate / 10);
+	dll_threshold *= 10;
+	t_rea = ((mode == 5) ? 16 : 20) * 10;
+	c *= 10;
+
+	t_rp = clk_period * 1; /* DATA_SETUP is 1 */
+
+	if (clk_period > dll_threshold) {
+		hw->use_half_periods = 1;
+		rp = clk_period / 2;
+	} else {
+		hw->use_half_periods = 0;
+		rp = clk_period;
+	}
+
+	/*
+	 * Multiply the numerator with 10, we could do a round off:
+	 *      7.8 round up to 8; 7.4 round down to 7.
+	 */
+	delay  = (((t_rea + c - t_rp) * 8) * 10) / rp;
+	delay = (delay + 5) / 10;
+
+	hw->sample_delay_factor = delay;
+}
+
+static int enable_edo_mode(struct gpmi_nand_data *this, int mode)
+{
+	struct resources  *r = &this->resources;
+	struct nand_chip *nand = &this->nand;
+	struct mtd_info	 *mtd = &this->mtd;
+	uint8_t feature[ONFI_SUBFEATURE_PARAM_LEN] = {};
+	unsigned long rate;
+	int ret;
+
+	nand->select_chip(mtd, 0);
+
+	/* [1] send SET FEATURE commond to NAND */
+	feature[0] = mode;
+	ret = nand->onfi_set_features(mtd, nand,
+				ONFI_FEATURE_ADDR_TIMING_MODE, feature);
+	if (ret)
+		goto err_out;
+
+	/* [2] send GET FEATURE command to double-check the timing mode */
+	memset(feature, 0, ONFI_SUBFEATURE_PARAM_LEN);
+	ret = nand->onfi_get_features(mtd, nand,
+				ONFI_FEATURE_ADDR_TIMING_MODE, feature);
+	if (ret)
+		goto err_out;
+
+	nand->select_chip(mtd, -1);
+
+	/* [3] set the main IO clock, 100MHz for mode 5, 80MHz for mode 4. */
+	rate = (mode == 5) ? 100000000 : 80000000;
+	clk_set_rate(r->clock[0], rate);
+
+	this->flags |= GPMI_ASYNC_EDO_ENABLED;
+	this->timing_mode = mode;
+	pr_info("gpmi-nand enters asynchronous EDO mode %d\n", mode);
+	return 0;
+
+err_out:
+	nand->select_chip(mtd, -1);
+	dev_err(this->dev, "mode:%d ,failed in set feature.\n", mode);
+	return -EINVAL;
+}
+
+int gpmi_extra_init(struct gpmi_nand_data *this)
+{
+	struct nand_chip *chip = &this->nand;
+
+	/* Enable the asynchronous EDO feature. */
+	if (GPMI_IS_MX6Q(this) && chip->onfi_version) {
+		int mode = onfi_get_async_timing_mode(chip);
+
+		/* We only support the timing mode 4 and mode 5. */
+		if (mode & ONFI_TIMING_MODE_5)
+			mode = 5;
+		else if (mode & ONFI_TIMING_MODE_4)
+			mode = 4;
+		else
+			return 0;
+
+		return enable_edo_mode(this, mode);
+	}
+	return 0;
+}
+
 /* Begin the I/O */
 void gpmi_begin(struct gpmi_nand_data *this)
 {
@@ -755,7 +964,10 @@ void gpmi_begin(struct gpmi_nand_data *this)
 		goto err_out;
 	}
 
-	gpmi_nfc_compute_hardware_timing(this, &hw);
+	if (this->flags & GPMI_ASYNC_EDO_ENABLED)
+		gpmi_compute_edo_timing(this, &hw);
+	else
+		gpmi_nfc_compute_hardware_timing(this, &hw);
 
 	/* [1] Set HW_GPMI_TIMING0 */
 	reg = BF_GPMI_TIMING0_ADDRESS_SETUP(hw.address_setup_in_cycles) |
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index cc74ebf..684c456 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1514,6 +1514,14 @@ static int gpmi_scan_bbt(struct mtd_info *mtd)
 	if (ret)
 		return ret;
 
+	/*
+	 * Can we enable the extra features? such as EDO or Sync mode.
+	 *
+	 * We do not check the return value now. That's means if we fail in
+	 * enable the extra features, we still can run in the normal way.
+	 */
+	gpmi_extra_init(this);
+
 	/* use the default BBT implementation */
 	return nand_default_bbt(mtd);
 }
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
index 39f1f76..fe52a3b 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
@@ -122,6 +122,10 @@ struct nand_timing {
 };
 
 struct gpmi_nand_data {
+	/* flags */
+#define GPMI_ASYNC_EDO_ENABLED	(1 << 0)
+	int			flags;
+
 	/* System Interface */
 	struct device		*dev;
 	struct platform_device	*pdev;
@@ -132,6 +136,7 @@ struct gpmi_nand_data {
 
 	/* Flash Hardware */
 	struct nand_timing	timing;
+	int			timing_mode;
 
 	/* BCH */
 	struct bch_geometry	bch_geometry;
@@ -258,6 +263,7 @@ extern int start_dma_with_bch_irq(struct gpmi_nand_data *,
 
 /* GPMI-NAND helper function library */
 extern int gpmi_init(struct gpmi_nand_data *);
+extern int gpmi_extra_init(struct gpmi_nand_data *);
 extern void gpmi_clear_bch(struct gpmi_nand_data *);
 extern void gpmi_dump_info(struct gpmi_nand_data *);
 extern int bch_set_geometry(struct gpmi_nand_data *);
-- 
1.7.0.4
