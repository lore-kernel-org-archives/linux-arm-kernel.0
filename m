From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 27 Jul 2018 15:14:15 +0100
Subject: [PATCH] of/platform: Initialise default DMA masks
Message-ID: <9ffa7f2676c25adf39e85ec8114b26500b5680f6.1532699305.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When of_dma_configure() was first born in 591c1ee465ce ("of: configure
the platform device dma parameters"), everything DMA-related was
factored out of of_platform_device_create_pdata() as seemed appropriate
at the time. However, now that of_dma_configure() has grown into the
generic handler for processing DMA-related properties from DT for all
kinds of devices, it is no longer an appropriate place to be doing
OF-platform-specific business. Since there are still plenty of platform
drivers not setting their own masks and depending on the bus default,
let's reinstate that inialisation in the OF-platform code itself, and
restore the long-standing status quo from 0589342c2794 ("of: set
dma_mask to point to coherent_dma_mask")

CC: Rob Herring <robh+dt@kernel.org>
CC: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

This shouldn't strictly depend on the changes currently queued in the
dma-mapping tree, so should be OK to go through the DT tree in parallel.
Ideally we'd fix all DMA-capable drivers to set their masks correctly,
but in the short term everyone's going to get cross about -rc1 not
booting...

Robin.

 drivers/of/platform.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 6925d993e1f0..7ba90c290a42 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -185,6 +185,9 @@ static struct platform_device *of_platform_device_create_pdata(
 	if (!dev)
 		goto err_clear_flag;
 
+	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	if (!dev->dev.dma_mask)
+		dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
 	dev->dev.bus = &platform_bus_type;
 	dev->dev.platform_data = platform_data;
 	of_msi_configure(&dev->dev, dev->dev.of_node);
-- 
2.17.1.dirty
