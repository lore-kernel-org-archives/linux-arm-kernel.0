From: peter.ujfalusi@nokia.com (Peter Ujfalusi)
Date: Mon,  4 Oct 2010 11:18:13 +0300
Subject: [PATCH v4 3/4] OMAP2: DMA: Use errata flag for disabling buffering
In-Reply-To: <1286180294-32618-1-git-send-email-peter.ujfalusi@nokia.com>
References: <1286180294-32618-1-git-send-email-peter.ujfalusi@nokia.com>
Message-ID: <1286180294-32618-4-git-send-email-peter.ujfalusi@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the errata handling of buffering disable on
OMAP2 platforms.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 arch/arm/plat-omap/dma.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index ae0ff64..c116c41 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -147,6 +147,7 @@ static const u8 omap1_dma_irq[OMAP1_LOGICAL_DMA_CH_COUNT] = {
 };
 
 /* Errata handling */
+#define DMA_ERRATA_IFRAME_BUFFERING	(1 << 0)
 static u16 dma_errata;
 #define IS_DMA_ERRATA(id)	(dma_errata & (id))
 
@@ -1003,8 +1004,7 @@ void omap_start_dma(int lch)
 	 * Errata: On ES2.0 BUFFERING disable must be set.
 	 * This will always fail on ES1.0
 	 */
-	if (cpu_is_omap2420() ||
-	    (cpu_is_omap2430() && (omap_type() == OMAP2430_REV_ES1_0)))
+	if (IS_DMA_ERRATA(DMA_ERRATA_IFRAME_BUFFERING))
 		l |= OMAP_DMA_CCR_BUFFERING_DISABLE;
 
 	l |= OMAP_DMA_CCR_EN;
@@ -2048,6 +2048,9 @@ void omap_dma_global_context_restore(void)
 
 static void dma_errata_configure(void)
 {
+	if (cpu_is_omap2420() ||
+	    (cpu_is_omap2430() && (omap_type() == OMAP2430_REV_ES1_0)))
+		dma_errata |= DMA_ERRATA_IFRAME_BUFFERING;
 }
 
 static int __init omap_init_dma(void)
-- 
1.7.3
