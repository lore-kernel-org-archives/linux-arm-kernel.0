From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Mon, 28 Jan 2013 09:33:20 +0100
Subject: [RFC] ARM: dma-mapping: Return 0 if no ->set_dma_mask()
Message-ID: <20130128.103320.355771370936761237.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct dma_map_ops iommu_ops doesn't have ->set_dma_mask, which causes
crash when dma_set_mask() is called from some driver.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/include/asm/dma-mapping.h |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index a58e0f5..95328bf 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -32,7 +32,11 @@ static inline void set_dma_ops(struct device *dev, struct dma_map_ops *ops)
 
 static inline int dma_set_mask(struct device *dev, u64 mask)
 {
-	return get_dma_ops(dev)->set_dma_mask(dev, mask);
+	struct dma_map_ops *ops = get_dma_ops(dev);
+
+	if (ops->set_dma_mask)
+		return ops->set_dma_mask(dev, mask);
+	return 0;
 }
 
 #ifdef __arch_page_to_dma
-- 
1.7.9.5
