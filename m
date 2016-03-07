From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Mon, 7 Mar 2016 13:43:02 -0600
Subject: [PATCHv2 06/11] EDAC, altera: Add IRQ flags to private data struct
In-Reply-To: <1457379787-8327-1-git-send-email-tthayer@opensource.altera.com>
References: <1457379787-8327-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1457379787-8327-7-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

In preparation for the Arria10 peripheral ECCs, irq_flags
was added to the private data structure because Arria10
uses shared IRQs while Cyclone5/Arria5 have exclusive IRQs.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2: Split large patch into smaller patches. Add irq_flags
    to the private data structure.
---
 drivers/edac/altera_edac.c |    8 ++++++--
 drivers/edac/altera_edac.h |    1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index c28cd78..fd73a77 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -759,14 +759,16 @@ static int altr_edac_device_probe(struct platform_device *pdev)
 	drvdata->sb_irq = platform_get_irq(pdev, 0);
 	res = devm_request_irq(&pdev->dev, drvdata->sb_irq,
 			       altr_edac_device_handler,
-			       0, dev_name(&pdev->dev), dci);
+			       drvdata->data->irq_flags,
+			       dev_name(&pdev->dev), dci);
 	if (res)
 		goto fail1;
 
 	drvdata->db_irq = platform_get_irq(pdev, 1);
 	res = devm_request_irq(&pdev->dev, drvdata->db_irq,
 			       altr_edac_device_handler,
-			       0, dev_name(&pdev->dev), dci);
+			       drvdata->data->irq_flags,
+			       dev_name(&pdev->dev), dci);
 	if (res)
 		goto fail1;
 
@@ -889,6 +891,7 @@ const struct edac_device_prv_data ocramecc_data = {
 	.ue_set_mask = (ALTR_OCR_ECC_EN | ALTR_OCR_ECC_INJD),
 	.set_err_ofst = ALTR_OCR_ECC_REG_OFFSET,
 	.trig_alloc_sz = ALTR_TRIG_OCRAM_BYTE_SIZE,
+	.irq_flags = 0,
 };
 
 #endif	/* CONFIG_EDAC_ALTERA_OCRAM */
@@ -964,6 +967,7 @@ const struct edac_device_prv_data l2ecc_data = {
 	.ue_set_mask = (ALTR_L2_ECC_EN | ALTR_L2_ECC_INJD),
 	.set_err_ofst = ALTR_L2_ECC_REG_OFFSET,
 	.trig_alloc_sz = ALTR_TRIG_L2C_BYTE_SIZE,
+	.irq_flags = 0,
 };
 
 #endif	/* CONFIG_EDAC_ALTERA_L2C */
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index f15b4ad..b262f74 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -235,6 +235,7 @@ struct edac_device_prv_data {
 	int ue_set_mask;
 	int set_err_ofst;
 	int trig_alloc_sz;
+	int irq_flags;
 };
 
 struct altr_edac_device_dev {
-- 
1.7.9.5
