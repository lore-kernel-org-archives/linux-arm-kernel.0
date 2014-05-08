From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  8 May 2014 16:56:12 +0200
Subject: [PATCH 1/2] dmaengine: omap: hide filter_fn for built-in drivers
In-Reply-To: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
Message-ID: <1399560990-1402858-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is not possible to reference the omap_dma_filter_fn filter
function from a built-in driver if the dmaengine driver itself
is a loadable module, which is a valid configuration otherwise.

This provides only the dummy alternative if the function
is referenced by a built-in driver to allow a successful
build. The filter function is only required by ATAGS based
platforms, which will continue to be broken after this change
for the bogus configuration. When booting from DT, with the
dma channels correctly listed there, it will work fine.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: dmaengine at vger.kernel.org
---
 include/linux/omap-dma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/omap-dma.h b/include/linux/omap-dma.h
index 0a1a2e2..c29a6de 100644
--- a/include/linux/omap-dma.h
+++ b/include/linux/omap-dma.h
@@ -10,7 +10,7 @@
 
 struct dma_chan;
 
-#if defined(CONFIG_DMA_OMAP) || defined(CONFIG_DMA_OMAP_MODULE)
+#if defined(CONFIG_DMA_OMAP) || (defined(CONFIG_DMA_OMAP_MODULE) && defined(MODULE))
 bool omap_dma_filter_fn(struct dma_chan *, void *);
 #else
 static inline bool omap_dma_filter_fn(struct dma_chan *c, void *d)
-- 
1.8.3.2
