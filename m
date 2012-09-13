From: b32955@freescale.com (Huang Shijie)
Date: Thu, 13 Sep 2012 14:57:55 +0800
Subject: [PATCH v2 4/9] mtd: gpmi: do not get the clock frequency in
 gpmi_begin()
In-Reply-To: <1347519480-31106-1-git-send-email-b32955@freescale.com>
References: <1347519480-31106-1-git-send-email-b32955@freescale.com>
Message-ID: <1347519480-31106-5-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current code will gets the clock frequency which is used by
gpmi_nfc_compute_hardware_timing(). It makes the code a little mess.

So move the `get clock frequency` code to the
gpmi_nfc_compute_hardware_timing() itself. This makes the code tidy
and clean.

This patch also uses the macro NSE_PER_SEC to replace the `1000000000`.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
index c95dbe8..41e905d 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
@@ -293,6 +293,7 @@ static int gpmi_nfc_compute_hardware_timing(struct gpmi_nand_data *this,
 					struct gpmi_nfc_hardware_timing *hw)
 {
 	struct timing_threshod *nfc = &timing_default_threshold;
+	struct resources *r = &this->resources;
 	struct nand_chip *nand = &this->nand;
 	struct nand_timing target = this->timing;
 	bool improved_timing_is_available;
@@ -332,8 +333,9 @@ static int gpmi_nfc_compute_hardware_timing(struct gpmi_nand_data *this,
 		(target.tRHOH_in_ns >= 0) ;
 
 	/* Inspect the clock. */
+	nfc->clock_frequency_in_hz = clk_get_rate(r->clock[0]);
 	clock_frequency_in_hz = nfc->clock_frequency_in_hz;
-	clock_period_in_ns    = 1000000000 / clock_frequency_in_hz;
+	clock_period_in_ns    = NSEC_PER_SEC / clock_frequency_in_hz;
 
 	/*
 	 * The NFC quantizes setup and hold parameters in terms of clock cycles.
@@ -738,7 +740,6 @@ return_results:
 void gpmi_begin(struct gpmi_nand_data *this)
 {
 	struct resources *r = &this->resources;
-	struct timing_threshod *nfc = &timing_default_threshold;
 	void __iomem *gpmi_regs = r->gpmi_regs;
 	unsigned int   clock_period_in_ns;
 	uint32_t       reg;
@@ -753,10 +754,6 @@ void gpmi_begin(struct gpmi_nand_data *this)
 		goto err_out;
 	}
 
-	/* Get the timing information we need. */
-	nfc->clock_frequency_in_hz = clk_get_rate(r->clock[0]);
-	clock_period_in_ns = 1000000000 / nfc->clock_frequency_in_hz;
-
 	gpmi_nfc_compute_hardware_timing(this, &hw);
 
 	/* [1] Set HW_GPMI_TIMING0 */
@@ -801,6 +798,7 @@ void gpmi_begin(struct gpmi_nand_data *this)
 	 *
 	 * Calculate the amount of time we need to wait, in microseconds.
 	 */
+	clock_period_in_ns = NSEC_PER_SEC / clk_get_rate(r->clock[0]);
 	dll_wait_time_in_us = (clock_period_in_ns * 64) / 1000;
 
 	if (!dll_wait_time_in_us)
-- 
1.7.0.4
