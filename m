From: chao.xie@marvell.com (Chao Xie)
Date: Mon, 21 Jan 2013 05:07:22 -0500
Subject: [V4 PATCH 04/26] usb: otg: mv_otg: use devm_xxx for probe
In-Reply-To: <1358762864-9249-1-git-send-email-chao.xie@marvell.com>
References: <xiechao.mail@gmail.com>
 <1358762864-9249-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1358762864-9249-5-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

use devm_xxx for otg driver probe. So we do need care about
the resources release in driver remove or failure handling
in driver probe.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/usb/otg/mv_otg.c |   82 ++++++++++++---------------------------------
 1 files changed, 22 insertions(+), 60 deletions(-)

diff --git a/drivers/usb/otg/mv_otg.c b/drivers/usb/otg/mv_otg.c
index eace975..da2d60c 100644
--- a/drivers/usb/otg/mv_otg.c
+++ b/drivers/usb/otg/mv_otg.c
@@ -662,18 +662,9 @@ static struct attribute_group inputs_attr_group = {
 int mv_otg_remove(struct platform_device *pdev)
 {
 	struct mv_otg *mvotg = platform_get_drvdata(pdev);
-	int clk_i;
 
 	sysfs_remove_group(&mvotg->pdev->dev.kobj, &inputs_attr_group);
 
-	if (mvotg->irq)
-		free_irq(mvotg->irq, mvotg);
-
-	if (mvotg->pdata->vbus)
-		free_irq(mvotg->pdata->vbus->irq, mvotg);
-	if (mvotg->pdata->id)
-		free_irq(mvotg->pdata->id->irq, mvotg);
-
 	if (mvotg->qwork) {
 		flush_workqueue(mvotg->qwork);
 		destroy_workqueue(mvotg->qwork);
@@ -681,21 +672,9 @@ int mv_otg_remove(struct platform_device *pdev)
 
 	mv_otg_disable(mvotg);
 
-	if (mvotg->cap_regs)
-		iounmap(mvotg->cap_regs);
-
-	if (mvotg->phy_regs)
-		iounmap(mvotg->phy_regs);
-
-	for (clk_i = 0; clk_i <= mvotg->clknum; clk_i++)
-		clk_put(mvotg->clk[clk_i]);
-
 	usb_remove_phy(&mvotg->phy);
 	platform_set_drvdata(pdev, NULL);
 
-	kfree(mvotg->phy.otg);
-	kfree(mvotg);
-
 	return 0;
 }
 
@@ -714,17 +693,15 @@ static int mv_otg_probe(struct platform_device *pdev)
 	}
 
 	size = sizeof(*mvotg) + sizeof(struct clk *) * pdata->clknum;
-	mvotg = kzalloc(size, GFP_KERNEL);
+	mvotg = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
 	if (!mvotg) {
 		dev_err(&pdev->dev, "failed to allocate memory!\n");
 		return -ENOMEM;
 	}
 
-	otg = kzalloc(sizeof *otg, GFP_KERNEL);
-	if (!otg) {
-		kfree(mvotg);
+	otg = devm_kzalloc(&pdev->dev, sizeof(*otg), GFP_KERNEL);
+	if (!otg)
 		return -ENOMEM;
-	}
 
 	platform_set_drvdata(pdev, mvotg);
 
@@ -733,18 +710,18 @@ static int mv_otg_probe(struct platform_device *pdev)
 
 	mvotg->clknum = pdata->clknum;
 	for (clk_i = 0; clk_i < mvotg->clknum; clk_i++) {
-		mvotg->clk[clk_i] = clk_get(&pdev->dev, pdata->clkname[clk_i]);
+		mvotg->clk[clk_i] = devm_clk_get(&pdev->dev,
+						pdata->clkname[clk_i]);
 		if (IS_ERR(mvotg->clk[clk_i])) {
 			retval = PTR_ERR(mvotg->clk[clk_i]);
-			goto err_put_clk;
+			return retval;
 		}
 	}
 
 	mvotg->qwork = create_singlethread_workqueue("mv_otg_queue");
 	if (!mvotg->qwork) {
 		dev_dbg(&pdev->dev, "cannot create workqueue for OTG\n");
-		retval = -ENOMEM;
-		goto err_put_clk;
+		return -ENOMEM;
 	}
 
 	INIT_DELAYED_WORK(&mvotg->work, mv_otg_work);
@@ -772,7 +749,7 @@ static int mv_otg_probe(struct platform_device *pdev)
 		goto err_destroy_workqueue;
 	}
 
-	mvotg->phy_regs = ioremap(r->start, resource_size(r));
+	mvotg->phy_regs = devm_ioremap(&pdev->dev, r->start, resource_size(r));
 	if (mvotg->phy_regs == NULL) {
 		dev_err(&pdev->dev, "failed to map phy I/O memory\n");
 		retval = -EFAULT;
@@ -784,21 +761,21 @@ static int mv_otg_probe(struct platform_device *pdev)
 	if (r == NULL) {
 		dev_err(&pdev->dev, "no I/O memory resource defined\n");
 		retval = -ENODEV;
-		goto err_unmap_phyreg;
+		goto err_destroy_workqueue;
 	}
 
-	mvotg->cap_regs = ioremap(r->start, resource_size(r));
+	mvotg->cap_regs = devm_ioremap(&pdev->dev, r->start, resource_size(r));
 	if (mvotg->cap_regs == NULL) {
 		dev_err(&pdev->dev, "failed to map I/O memory\n");
 		retval = -EFAULT;
-		goto err_unmap_phyreg;
+		goto err_destroy_workqueue;
 	}
 
 	/* we will acces controller register, so enable the udc controller */
 	retval = mv_otg_enable_internal(mvotg);
 	if (retval) {
 		dev_err(&pdev->dev, "mv otg enable error %d\n", retval);
-		goto err_unmap_capreg;
+		goto err_destroy_workqueue;
 	}
 
 	mvotg->op_regs =
@@ -806,9 +783,9 @@ static int mv_otg_probe(struct platform_device *pdev)
 			+ (readl(mvotg->cap_regs) & CAPLENGTH_MASK));
 
 	if (pdata->id) {
-		retval = request_threaded_irq(pdata->id->irq, NULL,
-					      mv_otg_inputs_irq,
-					      IRQF_ONESHOT, "id", mvotg);
+		retval = devm_request_threaded_irq(&pdev->dev, pdata->id->irq,
+						NULL, mv_otg_inputs_irq,
+						IRQF_ONESHOT, "id", mvotg);
 		if (retval) {
 			dev_info(&pdev->dev,
 				 "Failed to request irq for ID\n");
@@ -818,9 +795,9 @@ static int mv_otg_probe(struct platform_device *pdev)
 
 	if (pdata->vbus) {
 		mvotg->clock_gating = 1;
-		retval = request_threaded_irq(pdata->vbus->irq, NULL,
-					      mv_otg_inputs_irq,
-					      IRQF_ONESHOT, "vbus", mvotg);
+		retval = devm_request_threaded_irq(&pdev->dev, pdata->vbus->irq,
+						NULL, mv_otg_inputs_irq,
+						IRQF_ONESHOT, "vbus", mvotg);
 		if (retval) {
 			dev_info(&pdev->dev,
 				 "Failed to request irq for VBUS, "
@@ -844,7 +821,7 @@ static int mv_otg_probe(struct platform_device *pdev)
 	}
 
 	mvotg->irq = r->start;
-	if (request_irq(mvotg->irq, mv_otg_irq, IRQF_SHARED,
+	if (devm_request_irq(&pdev->dev, mvotg->irq, mv_otg_irq, IRQF_SHARED,
 			driver_name, mvotg)) {
 		dev_err(&pdev->dev, "Request irq %d for OTG failed\n",
 			mvotg->irq);
@@ -857,14 +834,14 @@ static int mv_otg_probe(struct platform_device *pdev)
 	if (retval < 0) {
 		dev_err(&pdev->dev, "can't register transceiver, %d\n",
 			retval);
-		goto err_free_irq;
+		goto err_disable_clk;
 	}
 
 	retval = sysfs_create_group(&pdev->dev.kobj, &inputs_attr_group);
 	if (retval < 0) {
 		dev_dbg(&pdev->dev,
 			"Can't register sysfs attr group: %d\n", retval);
-		goto err_set_transceiver;
+		goto err_remove_phy;
 	}
 
 	spin_lock_init(&mvotg->wq_lock);
@@ -879,30 +856,15 @@ static int mv_otg_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_set_transceiver:
+err_remove_phy:
 	usb_remove_phy(&mvotg->phy);
-err_free_irq:
-	free_irq(mvotg->irq, mvotg);
 err_disable_clk:
-	if (pdata->vbus)
-		free_irq(pdata->vbus->irq, mvotg);
-	if (pdata->id)
-		free_irq(pdata->id->irq, mvotg);
 	mv_otg_disable_internal(mvotg);
-err_unmap_capreg:
-	iounmap(mvotg->cap_regs);
-err_unmap_phyreg:
-	iounmap(mvotg->phy_regs);
 err_destroy_workqueue:
 	flush_workqueue(mvotg->qwork);
 	destroy_workqueue(mvotg->qwork);
-err_put_clk:
-	for (clk_i--; clk_i >= 0; clk_i--)
-		clk_put(mvotg->clk[clk_i]);
 
 	platform_set_drvdata(pdev, NULL);
-	kfree(otg);
-	kfree(mvotg);
 
 	return retval;
 }
-- 
1.7.4.1
