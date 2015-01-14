From: will.deacon@arm.com (Will Deacon)
Date: Wed, 14 Jan 2015 19:13:22 +0000
Subject: [PATCH v2 2/3] ARM: dma-mapping: don't detach devices without an
 IOMMU during teardown
In-Reply-To: <1421262803-21003-1-git-send-email-will.deacon@arm.com>
References: <1421262803-21003-1-git-send-email-will.deacon@arm.com>
Message-ID: <1421262803-21003-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When tearing down the DMA ops for a device via of_dma_deconfigure, we
unconditionally detach the device from its IOMMU domain. For devices
that aren't actually behind an IOMMU, this produces a "Not attached"
warning message on the console.

This patch changes the teardown code so that we don't detach from the
IOMMU domain when there isn't an IOMMU dma mapping to start with.

Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/dma-mapping.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 7864797609b3..f142ddd6c40a 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2025,6 +2025,9 @@ static void arm_teardown_iommu_dma_ops(struct device *dev)
 {
 	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
 
+	if (!mapping)
+		return;
+
 	arm_iommu_detach_device(dev);
 	arm_iommu_release_mapping(mapping);
 }
-- 
2.1.4
