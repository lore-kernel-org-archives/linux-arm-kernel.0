From: will.deacon@arm.com (Will Deacon)
Date: Fri, 16 Jan 2015 17:04:56 +0000
Subject: [PATCH] of/platform: teardown DMA mappings on device destruction
Message-ID: <1421427896-16928-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we can create and attach to IOMMU domains via of_dma_configure,
make sure we give the architecture a chance to tear them down when a
platform or amba device is destroyed.

Acked-by: Rob Herring <robh@kernel.org>
Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

Arnd, could you queue this along with the other of_dma_* bits that you
have please?

 drivers/of/platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 5b33c6a21807..3f61d668ded7 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -526,6 +526,7 @@ static int of_platform_device_destroy(struct device *dev, void *data)
 		amba_device_unregister(to_amba_device(dev));
 #endif
 
+	of_dma_deconfigure(dev);
 	of_node_clear_flag(dev->of_node, OF_POPULATED);
 	of_node_clear_flag(dev->of_node, OF_POPULATED_BUS);
 	return 0;
-- 
2.1.4
