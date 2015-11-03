From: eric.auger@linaro.org (Eric Auger)
Date: Tue,  3 Nov 2015 18:12:19 +0000
Subject: [PATCH v6 8/8] vfio: platform: reset: calxedaxgmac: fix ioaddr leak
In-Reply-To: <1446574339-1843-1-git-send-email-eric.auger@linaro.org>
References: <1446574339-1843-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1446574339-1843-9-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the current code the vfio_platform_region is copied on the stack.
As a consequence the ioaddr address is not iounmapped in the vfio
platform driver (vfio_platform_regions_cleanup). The patch uses the
pointer to the region instead.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c b/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
index 640f5d8..e3d3d94 100644
--- a/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
+++ b/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
@@ -59,20 +59,20 @@ static inline void xgmac_mac_disable(void __iomem *ioaddr)
 
 int vfio_platform_calxedaxgmac_reset(struct vfio_platform_device *vdev)
 {
-	struct vfio_platform_region reg = vdev->regions[0];
+	struct vfio_platform_region *reg = &vdev->regions[0];
 
-	if (!reg.ioaddr) {
-		reg.ioaddr =
-			ioremap_nocache(reg.addr, reg.size);
-		if (!reg.ioaddr)
+	if (!reg->ioaddr) {
+		reg->ioaddr =
+			ioremap_nocache(reg->addr, reg->size);
+		if (!reg->ioaddr)
 			return -ENOMEM;
 	}
 
 	/* disable IRQ */
-	writel(0, reg.ioaddr + XGMAC_DMA_INTR_ENA);
+	writel(0, reg->ioaddr + XGMAC_DMA_INTR_ENA);
 
 	/* Disable the MAC core */
-	xgmac_mac_disable(reg.ioaddr);
+	xgmac_mac_disable(reg->ioaddr);
 
 	return 0;
 }
-- 
1.9.1
