From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 10 Oct 2014 12:51:44 +0100
Subject: [PATCH v4 3/7] [RFC] arm/arm64: introduce is_dma_coherent
In-Reply-To: <alpine.DEB.2.02.1410101244090.17038@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1410101244090.17038@kaball.uk.xensource.com>
Message-ID: <1412941908-5850-3-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a function to check whether a device is dma coherent.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
CC: linux at arm.linux.org.uk
CC: catalin.marinas at arm.com
CC: will.deacon at arm.com
CC: linux-arm-kernel at lists.infradead.org
---
 arch/arm/include/asm/dma-mapping.h   |    6 ++++++
 arch/arm64/include/asm/dma-mapping.h |    5 +++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index c45b61a..bededbb 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -126,6 +126,12 @@ static inline int set_arch_dma_coherent_ops(struct device *dev)
 	set_dma_ops(dev, &arm_coherent_dma_ops);
 	return 0;
 }
+
+static inline bool is_dma_coherent(struct device *dev)
+{
+    return (__generic_dma_ops(dev) == &arm_coherent_dma_ops);
+}
+
 #define set_arch_dma_coherent_ops(dev)	set_arch_dma_coherent_ops(dev)
 
 static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index dc82e52..d51d67e 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -52,6 +52,11 @@ static inline void set_dma_ops(struct device *dev, struct dma_map_ops *ops)
 	dev->archdata.dma_ops = ops;
 }
 
+static inline bool is_dma_coherent(struct device *dev)
+{
+    return (__generic_dma_ops(dev) == &coherent_swiotlb_dma_ops);
+}
+
 #include <asm-generic/dma-mapping-common.h>
 
 static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
-- 
1.7.10.4
