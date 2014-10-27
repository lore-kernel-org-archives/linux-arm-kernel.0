From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 27 Oct 2014 15:09:24 +0000
Subject: [PATCH v7 4/8] arm: introduce is_device_dma_coherent
In-Reply-To: <alpine.DEB.2.02.1410261621200.22875@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1410261621200.22875@kaball.uk.xensource.com>
Message-ID: <1414422568-19103-4-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a boolean flag and an accessor function to check whether a
device is dma_coherent. Set the flag from set_arch_dma_coherent_ops.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
CC: linux at arm.linux.org.uk
CC: will.deacon at arm.com
---
 arch/arm/include/asm/device.h      |    1 +
 arch/arm/include/asm/dma-mapping.h |    6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
index dc662fc..4111592 100644
--- a/arch/arm/include/asm/device.h
+++ b/arch/arm/include/asm/device.h
@@ -17,6 +17,7 @@ struct dev_archdata {
 #ifdef CONFIG_ARM_DMA_USE_IOMMU
 	struct dma_iommu_mapping	*mapping;
 #endif
+	bool dma_coherent;
 };
 
 struct omap_device;
diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 85738b2..8c3b616 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -123,11 +123,17 @@ static inline unsigned long dma_max_pfn(struct device *dev)
 
 static inline int set_arch_dma_coherent_ops(struct device *dev)
 {
+	dev->archdata.dma_coherent = true;
 	set_dma_ops(dev, &arm_coherent_dma_ops);
 	return 0;
 }
 #define set_arch_dma_coherent_ops(dev)	set_arch_dma_coherent_ops(dev)
 
+static inline bool is_device_dma_coherent(struct device *dev)
+{
+	return dev->archdata.dma_coherent;
+}
+
 static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 	unsigned int offset = paddr & ~PAGE_MASK;
-- 
1.7.10.4
