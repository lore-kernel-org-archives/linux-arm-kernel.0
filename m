From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Wed, 22 Jun 2016 08:58:53 -0500
Subject: [PATCHv5 2/8] EDAC, altera: Add panic flag check to A10 IRQ
In-Reply-To: <1466603939-7526-1-git-send-email-tthayer@opensource.altera.com>
References: <1466603939-7526-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1466603939-7526-3-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

In preparation for additional memory module ECCs, the
IRQ function will check a panic flag before doing a
kernel panic on double bit errors.

OCRAM uncorrectable errors cause a panic because sleep/resume
functions and FPGA contents during sleep are stored in OCRAM.

ECCs on peripheral FIFO buffers will not cause a kernel panic
on DBERRs because the packet can be retried and therefore
recovered.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2  New patch. Add panic flag to IRQ function.
v3  No change
v4  Add reasons to panic on DBERR in OCRAM.
v5  No change
---
 drivers/edac/altera_edac.c |    9 ++++++++-
 drivers/edac/altera_edac.h |    1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 0101dd0..75451bc 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -897,7 +897,8 @@ static irqreturn_t altr_edac_a10_ecc_irq(int irq, void *dev_id)
 		writel(ALTR_A10_ECC_DERRPENA,
 		       base + ALTR_A10_ECC_INTSTAT_OFST);
 		edac_device_handle_ue(dci->edac_dev, 0, 0, dci->edac_dev_name);
-		panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
+		if (dci->data->panic)
+			panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
 
 		return IRQ_HANDLED;
 	}
@@ -936,6 +937,12 @@ const struct edac_device_prv_data a10_ocramecc_data = {
 	.set_err_ofst = ALTR_A10_ECC_INTTEST_OFST,
 	.ecc_irq_handler = altr_edac_a10_ecc_irq,
 	.inject_fops = &altr_edac_a10_device_inject_fops,
+	/*
+	 * OCRAM panic on uncorrectable error because sleep/resume
+	 * functions and FPGA contents are stored in OCRAM. Prefer
+	 * a kernel panic over executing/loading corrupted data.
+	 */
+	.panic = true,
 };
 
 #endif	/* CONFIG_EDAC_ALTERA_OCRAM */
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index 62b0fa0..cf4e8cb 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -298,6 +298,7 @@ struct edac_device_prv_data {
 	irqreturn_t (*ecc_irq_handler)(int irq, void *dev_id);
 	int trig_alloc_sz;
 	const struct file_operations *inject_fops;
+	bool panic;
 };
 
 struct altr_edac_device_dev {
-- 
1.7.9.5
