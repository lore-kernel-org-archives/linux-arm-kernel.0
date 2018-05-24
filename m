From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 24 May 2018 09:07:01 +0200
Subject: [PATCH v2 11/13] dmaengine: pxa: make the filter function internal
In-Reply-To: <20180524070703.11901-1-robert.jarzmik@free.fr>
References: <20180524070703.11901-1-robert.jarzmik@free.fr>
Message-ID: <20180524070703.11901-12-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the pxa architecture and all its related drivers do not rely anymore
on the filter function, thanks to the slave map conversion, make
pxad_filter_fn() static, and remove it from the global namespace.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/dma/pxa_dma.c       |  5 ++---
 include/linux/dma/pxa-dma.h | 11 -----------
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 9505334f9c6e..a332ad1d7dfb 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -179,7 +179,7 @@ static unsigned int pxad_drcmr(unsigned int line)
 	return 0x1000 + line * 4;
 }
 
-bool pxad_filter_fn(struct dma_chan *chan, void *param);
+static bool pxad_filter_fn(struct dma_chan *chan, void *param);
 
 /*
  * Debug fs
@@ -1496,7 +1496,7 @@ static struct platform_driver pxad_driver = {
 	.remove		= pxad_remove,
 };
 
-bool pxad_filter_fn(struct dma_chan *chan, void *param)
+static bool pxad_filter_fn(struct dma_chan *chan, void *param)
 {
 	struct pxad_chan *c = to_pxad_chan(chan);
 	struct pxad_param *p = param;
@@ -1509,7 +1509,6 @@ bool pxad_filter_fn(struct dma_chan *chan, void *param)
 
 	return true;
 }
-EXPORT_SYMBOL_GPL(pxad_filter_fn);
 
 module_platform_driver(pxad_driver);
 
diff --git a/include/linux/dma/pxa-dma.h b/include/linux/dma/pxa-dma.h
index 9fc594f69eff..fceb5df07097 100644
--- a/include/linux/dma/pxa-dma.h
+++ b/include/linux/dma/pxa-dma.h
@@ -23,15 +23,4 @@ struct pxad_param {
 	enum pxad_chan_prio prio;
 };
 
-struct dma_chan;
-
-#ifdef CONFIG_PXA_DMA
-bool pxad_filter_fn(struct dma_chan *chan, void *param);
-#else
-static inline bool pxad_filter_fn(struct dma_chan *chan, void *param)
-{
-	return false;
-}
-#endif
-
 #endif /* _PXA_DMA_H_ */
-- 
2.11.0
