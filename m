From: robin.murphy@arm.com (Robin Murphy)
Date: Thu,  7 Apr 2016 18:42:03 +0100
Subject: [PATCH 0/5] Introduce per-domain page sizes
Message-ID: <cover.1460048991.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Since this area seems to be in vogue at the moment, here's what I was
working on when the related patches[1][2] popped up, which happens to
be more or less the intersection of both. As I recycled some of Will's
old series as a starting point, I've retained the cleanup patches from
that with their original acks - hope that's OK.

Fortunately, this already looks rather like parts of Joerg's plan[3],
so I hope it's a suitable first step. Below is a quick hacked-up example
of the kind of caller-controlled special use-case alluded to, using the
SMMU/HDLCD combo on Juno - for a 'real' implementation of this we'd want
the group-based domain allocation call so the driver could throw the
device at that and get its own non-default DMA ops domain to play with.

Robin.

[1]:http://thread.gmane.org/gmane.linux.kernel.iommu/12774
[2]:http://thread.gmane.org/gmane.linux.kernel.iommu/12901
[3]:http://article.gmane.org/gmane.linux.kernel.iommu/12937

Robin Murphy (4):
  iommu: of: enforce const-ness of struct iommu_ops
  iommu: Allow selecting page sizes per domain
  iommu/dma: Finish optimising higher-order allocations
  iommu/arm-smmu: Use per-domain page sizes.

Will Deacon (1):
  iommu: remove unused priv field from struct iommu_ops

 arch/arm/include/asm/dma-mapping.h   |  2 +-
 arch/arm/mm/dma-mapping.c            |  6 +++---
 arch/arm64/include/asm/dma-mapping.h |  2 +-
 arch/arm64/mm/dma-mapping.c          |  8 ++++----
 drivers/iommu/arm-smmu-v3.c          | 19 +++++++++---------
 drivers/iommu/arm-smmu.c             | 26 +++++++++++++-----------
 drivers/iommu/dma-iommu.c            | 39 +++++++++++++++++++++++++++---------
 drivers/iommu/iommu.c                | 22 +++++++++++---------
 drivers/iommu/mtk_iommu.c            |  2 +-
 drivers/iommu/of_iommu.c             | 14 ++++++-------
 drivers/of/device.c                  |  2 +-
 drivers/vfio/vfio_iommu_type1.c      |  2 +-
 include/linux/dma-iommu.h            |  4 ++--
 include/linux/dma-mapping.h          |  2 +-
 include/linux/iommu.h                |  5 ++---
 include/linux/of_iommu.h             |  8 ++++----
 16 files changed, 93 insertions(+), 70 deletions(-)

--->8---
diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index 56b829f..0da0f4b 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -13,6 +13,7 @@
 #include <linux/spinlock.h>
 #include <linux/clk.h>
 #include <linux/component.h>
+#include <linux/iommu.h>
 #include <linux/list.h>
 #include <linux/of_graph.h>
 #include <linux/of_reserved_mem.h>
@@ -34,6 +35,7 @@ static int hdlcd_load(struct drm_device *drm, unsigned long flags)
 {
 	struct hdlcd_drm_private *hdlcd = drm->dev_private;
 	struct platform_device *pdev = to_platform_device(drm->dev);
+	struct iommu_domain *dom;
 	struct resource *res;
 	u32 version;
 	int ret;
@@ -79,6 +81,21 @@ static int hdlcd_load(struct drm_device *drm, unsigned long flags)
 	if (ret)
 		goto setup_fail;
 
+	/*
+	 * EXAMPLE: Let's say that if we're using an SMMU, we'd rather waste
+	 * a little memory by forcing DMA allocation and mapping to section
+	 * granularity so the whole buffer fits in the TLBs, than waste power
+	 * by having the SMMU constantly walking page tables all the time we're
+	 * scanning out. In this case we know our default domain isn't shared
+	 * with any other devices, so we can cheat and mangle that directly.
+	 */
+	dom = iommu_get_domain_for_dev(drm->dev);
+	if (dom) {
+		dom->pgsize_bitmap &= ~(SZ_1M - 1);
+		if (!dom->pgsize_bitmap)
+			goto setup_fail;
+	}
+
 	ret = hdlcd_setup_crtc(drm);
 	if (ret < 0) {
 		DRM_ERROR("failed to create crtc\n");
-- 
2.7.3.dirty
