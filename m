From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 21 Dec 2010 10:20:02 +0000
Subject: [PATCH 2/2] ARM: use cached memory in dma_alloc_coherent() if possible
In-Reply-To: <1292926802-12326-1-git-send-email-jamie@jamieiles.com>
References: <1292926802-12326-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1292926802-12326-2-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For fully coherent architectures or systems using the ARM ACP to provide
coherency to individual device, use cached memory as the coherent
backing rather than noncached or simply bufferable memory.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mm/dma-mapping.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index b90f323..2d3c8e4 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -579,6 +579,34 @@ int coherent_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 }
 
 /*
+ * For fully coherent systems/devices we can use normal, cached memory so just
+ * get some free pages.
+ */
+static void *coherent_alloc(struct device *dev, size_t size,
+			    dma_addr_t *dma_handle, gfp_t gfp)
+{
+	void *ret;
+	u64 mask = get_coherent_dma_mask(dev);
+
+	if (!dev || mask >= 0xffffffffUL)
+		gfp &= ~GFP_DMA;
+
+	ret = (void *)__get_free_pages(gfp, get_order(size));
+	if (ret) {
+		memset(ret, 0, size);
+		*dma_handle = virt_to_phys(ret);
+	}
+
+	return ret;
+}
+
+static void coherent_free(struct device *dev, size_t size, void *virt,
+			  dma_addr_t dma_handle)
+{
+	free_pages((unsigned long)dma_handle, get_order(size));
+}
+
+/*
  * Coherent DMA ops. These can either be used for the whole system
  * automatically if arch_is_coherent() is true or on a per device basis if the
  * device is connected to the ACP port to provide coherency for that device.
@@ -586,6 +614,8 @@ int coherent_map_sg(struct device *dev, struct scatterlist *sg, int nents,
  * dev->archdata.dma_ops
  */
 struct dma_map_ops coherent_dma_ops = {
+	.alloc_coherent		= coherent_alloc,
+	.free_coherent		= coherent_free,
 	.map_page		= coherent_map_page,
 	.map_sg			= coherent_map_sg,
 };
-- 
1.7.2.3
