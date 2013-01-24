From: chao.xie@marvell.com (Chao Xie)
Date: Thu, 24 Jan 2013 01:38:26 -0500
Subject: [V5 PATCH 02/26] usb: gadget: mv_udc: use devm_xxx for probe
In-Reply-To: <1359009530-28182-1-git-send-email-chao.xie@marvell.com>
References: <1359009530-28182-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1359009530-28182-3-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

use devm_xxx for udc driver probe. So we do need care about
the resources release in driver remove or failure handling
in driver probe.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/usb/gadget/mv_udc_core.c |  156 ++++++++++++++------------------------
 1 files changed, 56 insertions(+), 100 deletions(-)

diff --git a/drivers/usb/gadget/mv_udc_core.c b/drivers/usb/gadget/mv_udc_core.c
index 32a9972..e2fdc8e 100644
--- a/drivers/usb/gadget/mv_udc_core.c
+++ b/drivers/usb/gadget/mv_udc_core.c
@@ -2115,12 +2115,11 @@ static void gadget_release(struct device *_dev)
 	complete(udc->done);
 }
 
-static int mv_udc_remove(struct platform_device *dev)
+static int mv_udc_remove(struct platform_device *pdev)
 {
 	struct mv_udc *udc;
-	int clk_i;
 
-	udc = platform_get_drvdata(dev);
+	udc = platform_get_drvdata(pdev);
 
 	usb_del_gadget_udc(&udc->gadget);
 
@@ -2129,55 +2128,27 @@ static int mv_udc_remove(struct platform_device *dev)
 		destroy_workqueue(udc->qwork);
 	}
 
-	/*
-	 * If we have transceiver inited,
-	 * then vbus irq will not be requested in udc driver.
-	 */
-	if (udc->pdata && udc->pdata->vbus
-		&& udc->clock_gating && IS_ERR_OR_NULL(udc->transceiver))
-		free_irq(udc->pdata->vbus->irq, &dev->dev);
-
 	/* free memory allocated in probe */
 	if (udc->dtd_pool)
 		dma_pool_destroy(udc->dtd_pool);
 
 	if (udc->ep_dqh)
-		dma_free_coherent(&dev->dev, udc->ep_dqh_size,
+		dma_free_coherent(&pdev->dev, udc->ep_dqh_size,
 			udc->ep_dqh, udc->ep_dqh_dma);
 
-	kfree(udc->eps);
-
-	if (udc->irq)
-		free_irq(udc->irq, &dev->dev);
-
 	mv_udc_disable(udc);
 
-	if (udc->cap_regs)
-		iounmap(udc->cap_regs);
-
-	if (udc->phy_regs)
-		iounmap(udc->phy_regs);
-
-	if (udc->status_req) {
-		kfree(udc->status_req->req.buf);
-		kfree(udc->status_req);
-	}
-
-	for (clk_i = 0; clk_i <= udc->clknum; clk_i++)
-		clk_put(udc->clk[clk_i]);
-
 	device_unregister(&udc->gadget.dev);
 
 	/* free dev, wait for the release() finished */
 	wait_for_completion(udc->done);
-	kfree(udc);
 
 	return 0;
 }
 
-static int mv_udc_probe(struct platform_device *dev)
+static int mv_udc_probe(struct platform_device *pdev)
 {
-	struct mv_usb_platform_data *pdata = dev->dev.platform_data;
+	struct mv_usb_platform_data *pdata = pdev->dev.platform_data;
 	struct mv_udc *udc;
 	int retval = 0;
 	int clk_i = 0;
@@ -2185,70 +2156,68 @@ static int mv_udc_probe(struct platform_device *dev)
 	size_t size;
 
 	if (pdata == NULL) {
-		dev_err(&dev->dev, "missing platform_data\n");
+		dev_err(&pdev->dev, "missing platform_data\n");
 		return -ENODEV;
 	}
 
 	size = sizeof(*udc) + sizeof(struct clk *) * pdata->clknum;
-	udc = kzalloc(size, GFP_KERNEL);
+	udc = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
 	if (udc == NULL) {
-		dev_err(&dev->dev, "failed to allocate memory for udc\n");
+		dev_err(&pdev->dev, "failed to allocate memory for udc\n");
 		return -ENOMEM;
 	}
 
 	udc->done = &release_done;
-	udc->pdata = dev->dev.platform_data;
+	udc->pdata = pdev->dev.platform_data;
 	spin_lock_init(&udc->lock);
 
-	udc->dev = dev;
+	udc->dev = pdev;
 
 #ifdef CONFIG_USB_OTG_UTILS
 	if (pdata->mode == MV_USB_MODE_OTG)
-		udc->transceiver = usb_get_phy(USB_PHY_TYPE_USB2);
+		udc->transceiver = devm_usb_get_phy(&pdev->dev,
+					USB_PHY_TYPE_USB2);
 #endif
 
 	udc->clknum = pdata->clknum;
 	for (clk_i = 0; clk_i < udc->clknum; clk_i++) {
-		udc->clk[clk_i] = clk_get(&dev->dev, pdata->clkname[clk_i]);
+		udc->clk[clk_i] = devm_clk_get(&pdev->dev,
+					pdata->clkname[clk_i]);
 		if (IS_ERR(udc->clk[clk_i])) {
 			retval = PTR_ERR(udc->clk[clk_i]);
-			goto err_put_clk;
+			return retval;
 		}
 	}
 
 	r = platform_get_resource_byname(udc->dev, IORESOURCE_MEM, "capregs");
 	if (r == NULL) {
-		dev_err(&dev->dev, "no I/O memory resource defined\n");
-		retval = -ENODEV;
-		goto err_put_clk;
+		dev_err(&pdev->dev, "no I/O memory resource defined\n");
+		return -ENODEV;
 	}
 
 	udc->cap_regs = (struct mv_cap_regs __iomem *)
-		ioremap(r->start, resource_size(r));
+		devm_ioremap(&pdev->dev, r->start, resource_size(r));
 	if (udc->cap_regs == NULL) {
-		dev_err(&dev->dev, "failed to map I/O memory\n");
-		retval = -EBUSY;
-		goto err_put_clk;
+		dev_err(&pdev->dev, "failed to map I/O memory\n");
+		return -EBUSY;
 	}
 
 	r = platform_get_resource_byname(udc->dev, IORESOURCE_MEM, "phyregs");
 	if (r == NULL) {
-		dev_err(&dev->dev, "no phy I/O memory resource defined\n");
-		retval = -ENODEV;
-		goto err_iounmap_capreg;
+		dev_err(&pdev->dev, "no phy I/O memory resource defined\n");
+		return -ENODEV;
 	}
 
 	udc->phy_regs = ioremap(r->start, resource_size(r));
 	if (udc->phy_regs == NULL) {
-		dev_err(&dev->dev, "failed to map phy I/O memory\n");
-		retval = -EBUSY;
-		goto err_iounmap_capreg;
+		dev_err(&pdev->dev, "failed to map phy I/O memory\n");
+		return -EBUSY;
 	}
 
 	/* we will acces controller register, so enable the clk */
 	retval = mv_udc_enable_internal(udc);
 	if (retval)
-		goto err_iounmap_phyreg;
+		return retval;
 
 	udc->op_regs =
 		(struct mv_op_regs __iomem *)((unsigned long)udc->cap_regs
@@ -2265,11 +2234,11 @@ static int mv_udc_probe(struct platform_device *dev)
 
 	size = udc->max_eps * sizeof(struct mv_dqh) *2;
 	size = (size + DQH_ALIGNMENT - 1) & ~(DQH_ALIGNMENT - 1);
-	udc->ep_dqh = dma_alloc_coherent(&dev->dev, size,
+	udc->ep_dqh = dma_alloc_coherent(&pdev->dev, size,
 					&udc->ep_dqh_dma, GFP_KERNEL);
 
 	if (udc->ep_dqh == NULL) {
-		dev_err(&dev->dev, "allocate dQH memory failed\n");
+		dev_err(&pdev->dev, "allocate dQH memory failed\n");
 		retval = -ENOMEM;
 		goto err_disable_clock;
 	}
@@ -2277,7 +2246,7 @@ static int mv_udc_probe(struct platform_device *dev)
 
 	/* create dTD dma_pool resource */
 	udc->dtd_pool = dma_pool_create("mv_dtd",
-			&dev->dev,
+			&pdev->dev,
 			sizeof(struct mv_dtd),
 			DTD_ALIGNMENT,
 			DMA_BOUNDARY);
@@ -2288,19 +2257,20 @@ static int mv_udc_probe(struct platform_device *dev)
 	}
 
 	size = udc->max_eps * sizeof(struct mv_ep) *2;
-	udc->eps = kzalloc(size, GFP_KERNEL);
+	udc->eps = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
 	if (udc->eps == NULL) {
-		dev_err(&dev->dev, "allocate ep memory failed\n");
+		dev_err(&pdev->dev, "allocate ep memory failed\n");
 		retval = -ENOMEM;
 		goto err_destroy_dma;
 	}
 
 	/* initialize ep0 status request structure */
-	udc->status_req = kzalloc(sizeof(struct mv_req), GFP_KERNEL);
+	udc->status_req = devm_kzalloc(&pdev->dev, sizeof(struct mv_req),
+					GFP_KERNEL);
 	if (!udc->status_req) {
-		dev_err(&dev->dev, "allocate status_req memory failed\n");
+		dev_err(&pdev->dev, "allocate status_req memory failed\n");
 		retval = -ENOMEM;
-		goto err_free_eps;
+		goto err_destroy_dma;
 	}
 	INIT_LIST_HEAD(&udc->status_req->queue);
 
@@ -2315,17 +2285,17 @@ static int mv_udc_probe(struct platform_device *dev)
 
 	r = platform_get_resource(udc->dev, IORESOURCE_IRQ, 0);
 	if (r == NULL) {
-		dev_err(&dev->dev, "no IRQ resource defined\n");
+		dev_err(&pdev->dev, "no IRQ resource defined\n");
 		retval = -ENODEV;
-		goto err_free_status_req;
+		goto err_destroy_dma;
 	}
 	udc->irq = r->start;
-	if (request_irq(udc->irq, mv_udc_irq,
+	if (devm_request_irq(&pdev->dev, udc->irq, mv_udc_irq,
 		IRQF_SHARED, driver_name, udc)) {
-		dev_err(&dev->dev, "Request irq %d for UDC failed\n",
+		dev_err(&pdev->dev, "Request irq %d for UDC failed\n",
 			udc->irq);
 		retval = -ENODEV;
-		goto err_free_status_req;
+		goto err_destroy_dma;
 	}
 
 	/* initialize gadget structure */
@@ -2337,14 +2307,14 @@ static int mv_udc_probe(struct platform_device *dev)
 
 	/* the "gadget" abstracts/virtualizes the controller */
 	dev_set_name(&udc->gadget.dev, "gadget");
-	udc->gadget.dev.parent = &dev->dev;
-	udc->gadget.dev.dma_mask = dev->dev.dma_mask;
+	udc->gadget.dev.parent = &pdev->dev;
+	udc->gadget.dev.dma_mask = pdev->dev.dma_mask;
 	udc->gadget.dev.release = gadget_release;
 	udc->gadget.name = driver_name;		/* gadget name */
 
 	retval = device_register(&udc->gadget.dev);
 	if (retval)
-		goto err_free_irq;
+		goto err_destroy_dma;
 
 	eps_init(udc);
 
@@ -2353,10 +2323,11 @@ static int mv_udc_probe(struct platform_device *dev)
 		udc->clock_gating = 1;
 	else if (pdata->vbus) {
 		udc->clock_gating = 1;
-		retval = request_threaded_irq(pdata->vbus->irq, NULL,
+		retval = devm_request_threaded_irq(&pdev->dev,
+				pdata->vbus->irq, NULL,
 				mv_udc_vbus_irq, IRQF_ONESHOT, "vbus", udc);
 		if (retval) {
-			dev_info(&dev->dev,
+			dev_info(&pdev->dev,
 				"Can not request irq for VBUS, "
 				"disable clock gating\n");
 			udc->clock_gating = 0;
@@ -2364,7 +2335,7 @@ static int mv_udc_probe(struct platform_device *dev)
 
 		udc->qwork = create_singlethread_workqueue("mv_udc_queue");
 		if (!udc->qwork) {
-			dev_err(&dev->dev, "cannot create workqueue\n");
+			dev_err(&pdev->dev, "cannot create workqueue\n");
 			retval = -ENOMEM;
 			goto err_unregister;
 		}
@@ -2382,43 +2353,28 @@ static int mv_udc_probe(struct platform_device *dev)
 	else
 		udc->vbus_active = 1;
 
-	retval = usb_add_gadget_udc(&dev->dev, &udc->gadget);
+	retval = usb_add_gadget_udc(&pdev->dev, &udc->gadget);
 	if (retval)
-		goto err_unregister;
+		goto err_create_workqueue;
 
-	platform_set_drvdata(dev, udc);
-	dev_info(&dev->dev, "successful probe UDC device %s clock gating.\n",
+	platform_set_drvdata(pdev, udc);
+	dev_info(&pdev->dev, "successful probe UDC device %s clock gating.\n",
 		udc->clock_gating ? "with" : "without");
 
 	return 0;
 
+err_create_workqueue:
+	destroy_workqueue(udc->qwork);
 err_unregister:
-	if (udc->pdata && udc->pdata->vbus
-		&& udc->clock_gating && IS_ERR_OR_NULL(udc->transceiver))
-		free_irq(pdata->vbus->irq, &dev->dev);
 	device_unregister(&udc->gadget.dev);
-err_free_irq:
-	free_irq(udc->irq, &dev->dev);
-err_free_status_req:
-	kfree(udc->status_req->req.buf);
-	kfree(udc->status_req);
-err_free_eps:
-	kfree(udc->eps);
 err_destroy_dma:
 	dma_pool_destroy(udc->dtd_pool);
 err_free_dma:
-	dma_free_coherent(&dev->dev, udc->ep_dqh_size,
+	dma_free_coherent(&pdev->dev, udc->ep_dqh_size,
 			udc->ep_dqh, udc->ep_dqh_dma);
 err_disable_clock:
 	mv_udc_disable_internal(udc);
-err_iounmap_phyreg:
-	iounmap(udc->phy_regs);
-err_iounmap_capreg:
-	iounmap(udc->cap_regs);
-err_put_clk:
-	for (clk_i--; clk_i >= 0; clk_i--)
-		clk_put(udc->clk[clk_i]);
-	kfree(udc);
+
 	return retval;
 }
 
@@ -2489,12 +2445,12 @@ static const struct dev_pm_ops mv_udc_pm_ops = {
 };
 #endif
 
-static void mv_udc_shutdown(struct platform_device *dev)
+static void mv_udc_shutdown(struct platform_device *pdev)
 {
 	struct mv_udc *udc;
 	u32 mode;
 
-	udc = platform_get_drvdata(dev);
+	udc = platform_get_drvdata(pdev);
 	/* reset controller mode to IDLE */
 	mv_udc_enable(udc);
 	mode = readl(&udc->op_regs->usbmode);
-- 
1.7.4.1
