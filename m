From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Fri, 15 May 2015 02:00:02 +0300
Subject: [RFC/PATCH 1/9] arm: dma-mapping: Don't override dma_ops in
 arch_setup_dma_ops()
In-Reply-To: <1431644410-2997-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1431644410-2997-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1431644410-2997-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arch_setup_dma_ops() function is in charge of setting dma_ops with a
call to set_dma_ops(). set_dma_ops() is also called from

- highbank and mvebu bus notifiers
- dmabounce (to be replaced with swiotlb)
- arm_iommu_attach_device

(arm_iommu_attach_device is itself called from IOMMU and bus master
device drivers)

To allow the arch_setup_dma_ops() call to be moved from device add time
to device probe time we must ensure that dma_ops already setup by any of
the above callers will not be overriden.

Aftering replacing dmabounce with swiotlb, converting IOMMU drivers to
of_xlate and taking care of highbank and mvebu, the workaround should be
removed.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mm/dma-mapping.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 09c5fe3d30c2..7aa5e339a596 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2117,6 +2117,15 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 	struct dma_map_ops *dma_ops;
 
 	dev->archdata.dma_coherent = coherent;
+
+	/*
+	 * Don't override the dma_ops if they have already been set. Ideally
+	 * this should be the only location where dma_ops are set, remove this
+	 * check when all other callers of set_dma_ops will have disappeared.
+	 */
+	if (dev->archdata.dma_ops)
+		return;
+
 	if (arm_setup_iommu_dma_ops(dev, dma_base, size, iommu))
 		dma_ops = arm_get_iommu_dma_map_ops(coherent);
 	else
-- 
2.3.6
