From: sricharan@codeaurora.org (Sricharan R)
Date: Tue,  4 Oct 2016 22:33:45 +0530
Subject: [PATCH V3 1/8] arm: dma-mapping: Don't override dma_ops in
 arch_setup_dma_ops()
In-Reply-To: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
References: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1475600632-21289-2-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The arch_setup_dma_ops() function is in charge of setting dma_ops with a
call to set_dma_ops(). set_dma_ops() is also called from

- highbank and mvebu bus notifiers
- dmabounce (to be replaced with swiotlb)
- arm_iommu_attach_device

(arm_iommu_attach_device is itself called from IOMMU and bus master
device drivers)

To allow the arch_setup_dma_ops() call to be moved from device add time
to device probe time we must ensure that dma_ops already setup by any of
the above callers will not be overridden.

Aftering replacing dmabounce with swiotlb, converting IOMMU drivers to
of_xlate and taking care of highbank and mvebu, the workaround should be
removed.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mm/dma-mapping.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index c6834c0..dde6514 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2322,6 +2322,15 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
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
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
