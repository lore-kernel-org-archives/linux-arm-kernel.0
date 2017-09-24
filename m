From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Sun, 24 Sep 2017 12:04:53 +0300
Subject: [PATCH 1/2] gpu: host1x: Call of_dma_configure after setting bus
Message-ID: <20170924090454.28116-1-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_dma_configure now checks the device's bus before configuring it, so
we need to set the device's bus before calling.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index f9cde03030fd..66ea5acee820 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -403,12 +403,13 @@ static int host1x_device_add(struct host1x *host1x,
 	device->dev.coherent_dma_mask = host1x->dev->coherent_dma_mask;
 	device->dev.dma_mask = &device->dev.coherent_dma_mask;
 	dev_set_name(&device->dev, "%s", driver->driver.name);
-	of_dma_configure(&device->dev, host1x->dev->of_node);
 	device->dev.release = host1x_device_release;
 	device->dev.of_node = host1x->dev->of_node;
 	device->dev.bus = &host1x_bus_type;
 	device->dev.parent = host1x->dev;
 
+	of_dma_configure(&device->dev, host1x->dev->of_node);
+
 	err = host1x_device_parse_dt(device, driver);
 	if (err < 0) {
 		kfree(device);
-- 
2.14.1
