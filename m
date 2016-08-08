From: sricharan@codeaurora.org (Sricharan R)
Date: Tue,  9 Aug 2016 04:19:08 +0530
Subject: [PATCH 6/8] drivers: platform: Remove call to
 of_dma_(con/decon)figure_ops
In-Reply-To: <1470696550-3416-1-git-send-email-sricharan@codeaurora.org>
References: <1470696550-3416-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1470696550-3416-7-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dma_ops gets configured for the device generically during
the device_attach call. So remove it from the platform bus probe.
Similarly remove the deconfigure calls as well, since it is
now called form the device_detach path.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/of/platform.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index af3b291..b2872be 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -180,11 +180,9 @@ static struct platform_device *of_platform_device_create_pdata(
 	dev->dev.bus = &platform_bus_type;
 	dev->dev.platform_data = platform_data;
 	of_dma_configure_masks(&dev->dev, dev->dev.of_node);
-	of_dma_configure_ops(&dev->dev, dev->dev.of_node);
 	of_msi_configure(&dev->dev, dev->dev.of_node);
 
 	if (of_device_add(dev) != 0) {
-		of_dma_deconfigure(&dev->dev);
 		platform_device_put(dev);
 		goto err_clear_flag;
 	}
@@ -245,7 +243,6 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 	else
 		of_device_make_bus_id(&dev->dev);
 	of_dma_configure_masks(&dev->dev, dev->dev.of_node);
-	of_dma_configure_ops(&dev->dev, dev->dev.of_node);
 
 	/* Allow the HW Peripheral ID to be overridden */
 	prop = of_get_property(node, "arm,primecell-periphid", NULL);
@@ -503,7 +500,6 @@ static int of_platform_device_destroy(struct device *dev, void *data)
 		amba_device_unregister(to_amba_device(dev));
 #endif
 
-	of_dma_deconfigure(dev);
 	of_node_clear_flag(dev->of_node, OF_POPULATED);
 	of_node_clear_flag(dev->of_node, OF_POPULATED_BUS);
 	return 0;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
