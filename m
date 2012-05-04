From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  4 May 2012 19:23:19 +0100
Subject: [PATCH 09/15] drivers/mfd: Enable Device Tree support for the
 db8500-prcmu
In-Reply-To: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1336155805-18554-10-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch will enable probing to occur during a Device Tree enabled
boot. The IRQ base is expected to be located in and will be fetched
from the DT itself. We also prevent any of the db8500 regulators
from being registered here, as they will be enabled via DT instead.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/db8500-prcmu.c |   29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 7a83bf0..9bc75a8 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2960,7 +2960,8 @@ static struct mfd_cell db8500_prcmu_devs[] = {
  */
 static int __devinit db8500_prcmu_probe(struct platform_device *pdev)
 {
-	int err = 0;
+	struct device_node *np = pdev->dev.of_node;
+	int irq = 0, err = 0;
 
 	if (ux500_is_svp())
 		return -ENODEV;
@@ -2970,8 +2971,14 @@ static int __devinit db8500_prcmu_probe(struct platform_device *pdev)
 	/* Clean up the mailbox interrupts after pre-kernel code. */
 	writel(ALL_MBOX_BITS, PRCM_ARM_IT1_CLR);
 
-	err = request_threaded_irq(IRQ_DB8500_PRCMU1, prcmu_irq_handler,
-		prcmu_irq_thread_fn, IRQF_NO_SUSPEND, "prcmu", NULL);
+	if (np)
+		irq = platform_get_irq(pdev, 0);
+
+	if (!np || irq <= 0)
+		irq = IRQ_DB8500_PRCMU1;
+
+	err = request_threaded_irq(irq, prcmu_irq_handler,
+	        prcmu_irq_thread_fn, IRQF_NO_SUSPEND, "prcmu", NULL);
 	if (err < 0) {
 		pr_err("prcmu: Failed to allocate IRQ_DB8500_PRCMU1.\n");
 		err = -EBUSY;
@@ -2981,14 +2988,16 @@ static int __devinit db8500_prcmu_probe(struct platform_device *pdev)
 	if (cpu_is_u8500v20_or_later())
 		prcmu_config_esram0_deep_sleep(ESRAM0_DEEP_SLEEP_STATE_RET);
 
-	err = mfd_add_devices(&pdev->dev, 0, db8500_prcmu_devs,
-			      ARRAY_SIZE(db8500_prcmu_devs), NULL,
-			      0);
+	if (!np) {
+		err = mfd_add_devices(&pdev->dev, 0, db8500_prcmu_devs,
+				ARRAY_SIZE(db8500_prcmu_devs), NULL, 0);
+		if (err) {
+			pr_err("prcmu: Failed to add subdevices\n");
+			return err;
+		}
+	}
 
-	if (err)
-		pr_err("prcmu: Failed to add subdevices\n");
-	else
-		pr_info("DB8500 PRCMU initialized\n");
+	pr_info("DB8500 PRCMU initialized\n");
 
 no_irq_return:
 	return err;
-- 
1.7.9.5
