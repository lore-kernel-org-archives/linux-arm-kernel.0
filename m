From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 19 Aug 2010 16:40:08 +0200 (CEST)
Subject: [PATCH 2/5] DMA: dma_declare_coherent_memory() should return an
	error if unsupported
In-Reply-To: <Pine.LNX.4.64.1008191623580.26145@axis700.grange>
References: <Pine.LNX.4.64.1008191623580.26145@axis700.grange>
Message-ID: <Pine.LNX.4.64.1008191633050.26145@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On platforms, that do not define ARCH_HAS_DMA_DECLARE_COHERENT_MEMORY,
which are currently all platforms, that do not select
CONFIG_HAVE_GENERIC_DMA_COHERENT, dma_declare_coherent_memory() is a NOP,
which means, device internal memory cannot really be used. Therefore
dma_declare_coherent_memory() has to return an error on such platforms.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 include/linux/dma-mapping.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index ce29b81..77ce97f 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -163,7 +163,7 @@ static inline int
 dma_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
 			    dma_addr_t device_addr, size_t size, int flags)
 {
-	return 0;
+	return -EINVAL;
 }
 
 static inline void
-- 
1.7.2
