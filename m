From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 27 Oct 2014 15:09:23 +0000
Subject: [PATCH v7 3/8] arm64: introduce is_device_dma_coherent
In-Reply-To: <alpine.DEB.2.02.1410261621200.22875@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1410261621200.22875@kaball.uk.xensource.com>
Message-ID: <1414422568-19103-3-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a boolean flag and an accessor function to check whether a
device is dma_coherent. Set the flag from set_arch_dma_coherent_ops.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
CC: will.deacon at arm.com
---
 arch/arm64/include/asm/device.h      |    1 +
 arch/arm64/include/asm/dma-mapping.h |    6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/include/asm/device.h b/arch/arm64/include/asm/device.h
index cf98b36..243ef25 100644
--- a/arch/arm64/include/asm/device.h
+++ b/arch/arm64/include/asm/device.h
@@ -21,6 +21,7 @@ struct dev_archdata {
 #ifdef CONFIG_IOMMU_API
 	void *iommu;			/* private IOMMU data */
 #endif
+	bool dma_coherent;
 };
 
 struct pdev_archdata {
diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index adeae3f..e213dc4 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -54,11 +54,17 @@ static inline void set_dma_ops(struct device *dev, struct dma_map_ops *ops)
 
 static inline int set_arch_dma_coherent_ops(struct device *dev)
 {
+	dev->archdata.dma_coherent = true;
 	set_dma_ops(dev, &coherent_swiotlb_dma_ops);
 	return 0;
 }
 #define set_arch_dma_coherent_ops	set_arch_dma_coherent_ops
 
+static inline bool is_device_dma_coherent(struct device *dev)
+{
+	return dev->archdata.dma_coherent;
+}
+
 #include <asm-generic/dma-mapping-common.h>
 
 static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
-- 
1.7.10.4
