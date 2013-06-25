From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 25 Jun 2013 13:52:26 +0200
Subject: [PATCH 3/9] ARM: dma-mapping: convert DMA direction into IOMMU
 protection attributes
In-Reply-To: <20130625113714.GF31838@mudshark.cambridge.arm.com>
References: <1370889285-22799-4-git-send-email-will.deacon@arm.com><20130625131215.d3cea2a5668a3d41dbbeb064@nvidia.com><20130625113714.GF31838@mudshark.cambridge.arm.com>
Message-ID: <20130625.145226.1632119404634300971.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon <will.deacon@arm.com> wrote @ Tue, 25 Jun 2013 13:37:14 +0200:
...
> > Do we need similar changes for map_sg case as well? They still passes '0' as prot.
> 
> Yes, we could use the same trick there (probably worth moving the logic into
> a helper function for translating dma_data_direction into IOMMU_* values).
> 
> There are also iommu_map calls when allocating DMA buffers, but I think 0 is
> the right thing to pass there (i.e. no permission until pages have been
> explicitly mapped). Although, to be honest, I don't see why we need to map
> the buffer at all when we allocate it.

Yes, I thought too. I have a patch for that as below. If you like,
I'll rebase and send for merge with the one which changes
dma-mapping.c.

>From 699e6bd4fef86383d197775486b47bcbdc594f4a Mon Sep 17 00:00:00 2001
From: Hiroshi Doyu <hdoyu@nvidia.com>
Date: Tue, 25 Jun 2013 13:43:29 +0300
Subject: [PATCH 1/2] iommu/core: convert DMA direction into IOMMU protection
 attributes

Introduce a new function to convert DMA direction into IOMMU
protection attributes.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 include/linux/iommu.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 00af00f..ce3be78 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -21,11 +21,26 @@
 
 #include <linux/errno.h>
 #include <linux/types.h>
+#include <linux/dma-direction.h>
 
 #define IOMMU_READ	(1)
 #define IOMMU_WRITE	(2)
 #define IOMMU_CACHE	(4) /* DMA cache coherency */
 
+static inline int to_iommu_prot(enum dma_data_direction dir)
+{
+	switch (dir) {
+	case DMA_BIDIRECTIONAL:
+		return IOMMU_READ | IOMMU_WRITE;
+	case DMA_TO_DEVICE:
+		return IOMMU_READ;
+	case DMA_FROM_DEVICE:
+		return IOMMU_WRITE;
+	default:
+		return 0;
+	}
+}
+
 struct iommu_ops;
 struct iommu_group;
 struct bus_type;
-- 
1.8.1.5
