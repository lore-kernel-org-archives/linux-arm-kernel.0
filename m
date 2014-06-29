From: a.heider@gmail.com (Andre Heider)
Date: Sun, 29 Jun 2014 18:21:35 +0200
Subject: [PATCH 01/13] uio: uio_pruss: use struct device
In-Reply-To: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
References: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
Message-ID: <1404058907-21112-2-git-send-email-a.heider@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Get rid of the repeating &dev->dev constructs and prevent introducing
new ones.

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 drivers/uio/uio_pruss.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/uio/uio_pruss.c b/drivers/uio/uio_pruss.c
index 96c4a19..c28d6e2 100644
--- a/drivers/uio/uio_pruss.c
+++ b/drivers/uio/uio_pruss.c
@@ -91,8 +91,7 @@ static irqreturn_t pruss_handler(int irq, struct uio_info *info)
 	return IRQ_HANDLED;
 }
 
-static void pruss_cleanup(struct platform_device *dev,
-			struct uio_pruss_dev *gdev)
+static void pruss_cleanup(struct device *dev, struct uio_pruss_dev *gdev)
 {
 	int cnt;
 	struct uio_info *p = gdev->info;
@@ -103,7 +102,7 @@ static void pruss_cleanup(struct platform_device *dev,
 	}
 	iounmap(gdev->prussio_vaddr);
 	if (gdev->ddr_vaddr) {
-		dma_free_coherent(&dev->dev, extram_pool_sz, gdev->ddr_vaddr,
+		dma_free_coherent(dev, extram_pool_sz, gdev->ddr_vaddr,
 			gdev->ddr_paddr);
 	}
 	if (gdev->sram_vaddr)
@@ -115,13 +114,14 @@ static void pruss_cleanup(struct platform_device *dev,
 	kfree(gdev);
 }
 
-static int pruss_probe(struct platform_device *dev)
+static int pruss_probe(struct platform_device *pdev)
 {
 	struct uio_info *p;
 	struct uio_pruss_dev *gdev;
 	struct resource *regs_prussio;
+	struct device *dev = &pdev->dev;
 	int ret = -ENODEV, cnt = 0, len;
-	struct uio_pruss_pdata *pdata = dev_get_platdata(&dev->dev);
+	struct uio_pruss_pdata *pdata = dev_get_platdata(dev);
 
 	gdev = kzalloc(sizeof(struct uio_pruss_dev), GFP_KERNEL);
 	if (!gdev)
@@ -132,10 +132,11 @@ static int pruss_probe(struct platform_device *dev)
 		kfree(gdev);
 		return -ENOMEM;
 	}
+
 	/* Power on PRU in case its not done as part of boot-loader */
-	gdev->pruss_clk = clk_get(&dev->dev, "pruss");
+	gdev->pruss_clk = clk_get(dev, "pruss");
 	if (IS_ERR(gdev->pruss_clk)) {
-		dev_err(&dev->dev, "Failed to get clock\n");
+		dev_err(dev, "Failed to get clock\n");
 		ret = PTR_ERR(gdev->pruss_clk);
 		kfree(gdev->info);
 		kfree(gdev);
@@ -144,14 +145,14 @@ static int pruss_probe(struct platform_device *dev)
 		clk_enable(gdev->pruss_clk);
 	}
 
-	regs_prussio = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	regs_prussio = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs_prussio) {
-		dev_err(&dev->dev, "No PRUSS I/O resource specified\n");
+		dev_err(dev, "No PRUSS I/O resource specified\n");
 		goto out_free;
 	}
 
 	if (!regs_prussio->start) {
-		dev_err(&dev->dev, "Invalid memory resource\n");
+		dev_err(dev, "Invalid memory resource\n");
 		goto out_free;
 	}
 
@@ -161,27 +162,27 @@ static int pruss_probe(struct platform_device *dev)
 			(unsigned long)gen_pool_dma_alloc(gdev->sram_pool,
 					sram_pool_sz, &gdev->sram_paddr);
 		if (!gdev->sram_vaddr) {
-			dev_err(&dev->dev, "Could not allocate SRAM pool\n");
+			dev_err(dev, "Could not allocate SRAM pool\n");
 			goto out_free;
 		}
 	}
 
-	gdev->ddr_vaddr = dma_alloc_coherent(&dev->dev, extram_pool_sz,
+	gdev->ddr_vaddr = dma_alloc_coherent(dev, extram_pool_sz,
 				&(gdev->ddr_paddr), GFP_KERNEL | GFP_DMA);
 	if (!gdev->ddr_vaddr) {
-		dev_err(&dev->dev, "Could not allocate external memory\n");
+		dev_err(dev, "Could not allocate external memory\n");
 		goto out_free;
 	}
 
 	len = resource_size(regs_prussio);
 	gdev->prussio_vaddr = ioremap(regs_prussio->start, len);
 	if (!gdev->prussio_vaddr) {
-		dev_err(&dev->dev, "Can't remap PRUSS I/O  address range\n");
+		dev_err(dev, "Can't remap PRUSS I/O  address range\n");
 		goto out_free;
 	}
 
 	gdev->pintc_base = pdata->pintc_base;
-	gdev->hostirq_start = platform_get_irq(dev, 0);
+	gdev->hostirq_start = platform_get_irq(pdev, 0);
 
 	for (cnt = 0, p = gdev->info; cnt < MAX_PRUSS_EVT; cnt++, p++) {
 		p->mem[0].addr = regs_prussio->start;
@@ -204,12 +205,12 @@ static int pruss_probe(struct platform_device *dev)
 		p->handler = pruss_handler;
 		p->priv = gdev;
 
-		ret = uio_register_device(&dev->dev, p);
+		ret = uio_register_device(dev, p);
 		if (ret < 0)
 			goto out_free;
 	}
 
-	platform_set_drvdata(dev, gdev);
+	platform_set_drvdata(pdev, gdev);
 	return 0;
 
 out_free:
@@ -221,7 +222,7 @@ static int pruss_remove(struct platform_device *dev)
 {
 	struct uio_pruss_dev *gdev = platform_get_drvdata(dev);
 
-	pruss_cleanup(dev, gdev);
+	pruss_cleanup(&dev->dev, gdev);
 	return 0;
 }
 
-- 
2.0.0
