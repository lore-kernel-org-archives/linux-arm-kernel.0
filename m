From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Nov 2013 13:54:08 -0700
Subject: [PATCH 13/31] dma: tegra: register as an OF DMA controller
In-Reply-To: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1384548866-13141-14-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Call of_dma_controller_register() so that DMA clients can look up the
Tegra DMA controller using standard APIs. This requires the OF filter
function to save off the DMA slave ID, and for tegra_dma_slave_config()
not to over-write this information; once DMA client drivers are converted
to dma_request_slave_channel() and DT-based lookups, they won't set this
field of struct dma_slave_config anymore.

Cc: treding at nvidia.com
Cc: pdeschrijver at nvidia.com
Cc: linux-tegra at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This patch is part of a series with strong internal depdendencies. I'm
looking for an ack so that I can take the entire series through the Tegra
and arm-soc trees. The series will be part of a stable branch that can be
merged into other subsystems if needed to avoid/resolve dependencies.
---
 drivers/dma/tegra20-apb-dma.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index afa5844c9346..72b76c755947 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1,7 +1,7 @@
 /*
  * DMA driver for Nvidia's Tegra20 APB DMA controller.
  *
- * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2012-2013, NVIDIA CORPORATION.  All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -29,6 +29,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_dma.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
@@ -199,6 +200,7 @@ struct tegra_dma_channel {
 	void			*callback_param;
 
 	/* Channel-slave specific configuration */
+	unsigned int slave_id;
 	struct dma_slave_config dma_sconfig;
 	struct tegra_dma_channel_regs	channel_reg;
 };
@@ -340,6 +342,8 @@ static int tegra_dma_slave_config(struct dma_chan *dc,
 	}
 
 	memcpy(&tdc->dma_sconfig, sconfig, sizeof(*sconfig));
+	if (!tdc->slave_id)
+		tdc->slave_id = sconfig->slave_id;
 	tdc->config_init = true;
 	return 0;
 }
@@ -942,7 +946,7 @@ static struct dma_async_tx_descriptor *tegra_dma_prep_slave_sg(
 	ahb_seq |= TEGRA_APBDMA_AHBSEQ_BUS_WIDTH_32;
 
 	csr |= TEGRA_APBDMA_CSR_ONCE | TEGRA_APBDMA_CSR_FLOW;
-	csr |= tdc->dma_sconfig.slave_id << TEGRA_APBDMA_CSR_REQ_SEL_SHIFT;
+	csr |= tdc->slave_id << TEGRA_APBDMA_CSR_REQ_SEL_SHIFT;
 	if (flags & DMA_PREP_INTERRUPT)
 		csr |= TEGRA_APBDMA_CSR_IE_EOC;
 
@@ -1086,7 +1090,7 @@ static struct dma_async_tx_descriptor *tegra_dma_prep_dma_cyclic(
 	csr |= TEGRA_APBDMA_CSR_FLOW;
 	if (flags & DMA_PREP_INTERRUPT)
 		csr |= TEGRA_APBDMA_CSR_IE_EOC;
-	csr |= tdc->dma_sconfig.slave_id << TEGRA_APBDMA_CSR_REQ_SEL_SHIFT;
+	csr |= tdc->slave_id << TEGRA_APBDMA_CSR_REQ_SEL_SHIFT;
 
 	apb_seq |= TEGRA_APBDMA_APBSEQ_WRAP_WORD_1;
 
@@ -1206,6 +1210,8 @@ static void tegra_dma_free_chan_resources(struct dma_chan *dc)
 		kfree(sg_req);
 	}
 	clk_disable_unprepare(tdma->dma_clk);
+
+	tdc->slave_id = 0;
 }
 
 /* Tegra20 specific DMA controller information */
@@ -1245,6 +1251,26 @@ static const struct of_device_id tegra_dma_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, tegra_dma_of_match);
 
+static struct platform_driver tegra_dmac_driver;
+
+bool tegra_dma_filter_fn(struct dma_chan *dc, void *param)
+{
+	u32 slave_id = *(u32 *)param;
+	struct tegra_dma_channel *tdc;
+
+	if (dc->device->dev->driver != &tegra_dmac_driver.driver)
+		return false;
+
+	tdc = to_tegra_dma_chan(dc);
+	tdc->slave_id = slave_id;
+
+	return true;
+}
+
+static struct of_dma_filter_info tegra_dma_info = {
+	.filter_fn = tegra_dma_filter_fn,
+};
+
 static int tegra_dma_probe(struct platform_device *pdev)
 {
 	struct resource	*res;
@@ -1383,6 +1409,10 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		goto err_irq;
 	}
 
+	tegra_dma_info.dma_cap = tdma->dma_dev.cap_mask;
+	ret = of_dma_controller_register(pdev->dev.of_node,
+					 of_dma_simple_xlate, &tegra_dma_info);
+
 	dev_info(&pdev->dev, "Tegra20 APB DMA driver register %d channels\n",
 			cdata->nr_channels);
 	return 0;
-- 
1.8.1.5
