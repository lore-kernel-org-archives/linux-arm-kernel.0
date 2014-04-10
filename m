From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 10 Apr 2014 14:20:45 +0200
Subject: [PATCH V3 02/19] mmc: mmci: Convert to devm functions
In-Reply-To: <1397132462-8005-1-git-send-email-ulf.hansson@linaro.org>
References: <1397132462-8005-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1397132462-8005-3-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Converting to devm functions to simplify error handling in ->probe() and
to cleanup ->remove().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	Convert to use devm_ioremap_resource(), suggested by Michal Simek.

---
 drivers/mmc/host/mmci.c |   52 ++++++++++++++++-------------------------------
 1 file changed, 17 insertions(+), 35 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index b0b81ac..93b1b10 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/device.h>
+#include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -1456,15 +1457,9 @@ static int mmci_probe(struct amba_device *dev,
 	if (np)
 		mmci_dt_populate_generic_pdata(np, plat);
 
-	ret = amba_request_regions(dev, DRIVER_NAME);
-	if (ret)
-		goto out;
-
 	mmc = mmc_alloc_host(sizeof(struct mmci_host), &dev->dev);
-	if (!mmc) {
-		ret = -ENOMEM;
-		goto rel_regions;
-	}
+	if (!mmc)
+		return -ENOMEM;
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
@@ -1500,10 +1495,11 @@ static int mmci_probe(struct amba_device *dev,
 		dev_dbg(mmc_dev(mmc), "eventual mclk rate: %u Hz\n",
 			host->mclk);
 	}
+
 	host->phybase = dev->res.start;
-	host->base = ioremap(dev->res.start, resource_size(&dev->res));
-	if (!host->base) {
-		ret = -ENOMEM;
+	host->base = devm_ioremap_resource(&dev->dev, &dev->res);
+	if (IS_ERR(host->base)) {
+		ret = PTR_ERR(host->base);
 		goto clk_disable;
 	}
 
@@ -1592,34 +1588,35 @@ static int mmci_probe(struct amba_device *dev,
 
 	if (plat->gpio_cd == -EPROBE_DEFER) {
 		ret = -EPROBE_DEFER;
-		goto err_gpio_cd;
+		goto clk_disable;
 	}
 	if (gpio_is_valid(plat->gpio_cd)) {
 		ret = mmc_gpio_request_cd(mmc, plat->gpio_cd, 0);
 		if (ret)
-			goto err_gpio_cd;
+			goto clk_disable;
 	}
 	if (plat->gpio_wp == -EPROBE_DEFER) {
 		ret = -EPROBE_DEFER;
-		goto err_gpio_cd;
+		goto clk_disable;
 	}
 	if (gpio_is_valid(plat->gpio_wp)) {
 		ret = mmc_gpio_request_ro(mmc, plat->gpio_wp);
 		if (ret)
-			goto err_gpio_cd;
+			goto clk_disable;
 	}
 
-	ret = request_irq(dev->irq[0], mmci_irq, IRQF_SHARED, DRIVER_NAME " (cmd)", host);
+	ret = devm_request_irq(&dev->dev, dev->irq[0], mmci_irq, IRQF_SHARED,
+			DRIVER_NAME " (cmd)", host);
 	if (ret)
-		goto err_gpio_cd;
+		goto clk_disable;
 
 	if (!dev->irq[1])
 		host->singleirq = true;
 	else {
-		ret = request_irq(dev->irq[1], mmci_pio_irq, IRQF_SHARED,
-				  DRIVER_NAME " (pio)", host);
+		ret = devm_request_irq(&dev->dev, dev->irq[1], mmci_pio_irq,
+				IRQF_SHARED, DRIVER_NAME " (pio)", host);
 		if (ret)
-			goto irq0_free;
+			goto clk_disable;
 	}
 
 	writel(MCI_IRQENABLE, host->base + MMCIMASK0);
@@ -1641,17 +1638,10 @@ static int mmci_probe(struct amba_device *dev,
 
 	return 0;
 
- irq0_free:
-	free_irq(dev->irq[0], host);
- err_gpio_cd:
-	iounmap(host->base);
  clk_disable:
 	clk_disable_unprepare(host->clk);
  host_free:
 	mmc_free_host(mmc);
- rel_regions:
-	amba_release_regions(dev);
- out:
 	return ret;
 }
 
@@ -1677,16 +1667,8 @@ static int mmci_remove(struct amba_device *dev)
 		writel(0, host->base + MMCIDATACTRL);
 
 		mmci_dma_release(host);
-		free_irq(dev->irq[0], host);
-		if (!host->singleirq)
-			free_irq(dev->irq[1], host);
-
-		iounmap(host->base);
 		clk_disable_unprepare(host->clk);
-
 		mmc_free_host(mmc);
-
-		amba_release_regions(dev);
 	}
 
 	return 0;
-- 
1.7.9.5
