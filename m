From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 30 Sep 2010 08:56:52 +0200
Subject: [PATCH] ARM: define a dummy filter function for ste_dma40
Message-ID: <1285829812-10991-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All platform data has to be made conditional on CONFIG_STEDMA40
or we can provide a simple dummy filter functions as to avoid
cluttering the code with other #ifdef:s.

Acked-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/plat-nomadik/include/plat/ste_dma40.h |   26 ++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-nomadik/include/plat/ste_dma40.h b/arch/arm/plat-nomadik/include/plat/ste_dma40.h
index 1127af2..cf92e74 100644
--- a/arch/arm/plat-nomadik/include/plat/ste_dma40.h
+++ b/arch/arm/plat-nomadik/include/plat/ste_dma40.h
@@ -170,6 +170,8 @@ struct stedma40_platform_data {
 	int				 disabled_channels[STEDMA40_MAX_PHYS];
 };
 
+#ifdef CONFIG_STE_DMA40
+
 /**
  * setdma40_set_psize() - Used for changing the package size of an
  * already configured dma channel.
@@ -245,4 +247,28 @@ dma_async_tx_descriptor *stedma40_slave_mem(struct dma_chan *chan,
 						  direction, flags);
 }
 
+#else
+static inline int stedma40_set_psize(struct dma_chan *chan,
+		       int src_psize,
+		       int dst_psize)
+{
+	return 0;
+}
+
+static inline bool stedma40_filter(struct dma_chan *chan, void *data)
+{
+	return false;
+}
+
+static inline struct
+dma_async_tx_descriptor *stedma40_slave_mem(struct dma_chan *chan,
+					    dma_addr_t addr,
+					    unsigned int size,
+					    enum dma_data_direction direction,
+					    unsigned long flags)
+{
+	return NULL;
+}
+#endif
+
 #endif
-- 
1.6.3.3
