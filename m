From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Mon, 25 Apr 2016 12:52:43 -0500
Subject: [PATCHv2 2/7] EDAC, altera: Add panic flag check to A10 IRQ
In-Reply-To: <1461606768-14404-1-git-send-email-tthayer@opensource.altera.com>
References: <1461606768-14404-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1461606768-14404-3-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

In preparation for additional memory module ECCs, the
IRQ function will check a panic flag before doing a
kernel panic on double bit errors. ECCs on buffers
will not cause a kernel panic on DBERRs.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2  New patch. Add panic flag to IRQ function.
---
 drivers/edac/altera_edac.c |    4 +++-
 drivers/edac/altera_edac.h |    1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index b127e77..d4afecc 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -895,7 +895,8 @@ static irqreturn_t altr_edac_a10_ecc_irq(struct altr_edac_device_dev *dci,
 		writel(ALTR_A10_ECC_DERRPENA,
 		       base + ALTR_A10_ECC_INTSTAT_OFST);
 		edac_device_handle_ue(dci->edac_dev, 0, 0, dci->edac_dev_name);
-		panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
+		if (dci->data->panic)
+			panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
 	}
 	return IRQ_HANDLED;
 }
@@ -929,6 +930,7 @@ const struct edac_device_prv_data a10_ocramecc_data = {
 	.set_err_ofst = ALTR_A10_ECC_INTTEST_OFST,
 	.ecc_irq_handler = altr_edac_a10_ecc_irq,
 	.inject_fops = &altr_edac_a10_device_inject_fops,
+	.panic = true,
 };
 
 #endif	/* CONFIG_EDAC_ALTERA_OCRAM */
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index 42090f3..83e621e 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -299,6 +299,7 @@ struct edac_device_prv_data {
 				       bool sb);
 	int trig_alloc_sz;
 	const struct file_operations *inject_fops;
+	bool panic;
 };
 
 struct altr_edac_device_dev {
-- 
1.7.9.5
