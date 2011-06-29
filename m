From: scott@jumpnowtek.com (Scott Ellis)
Date: Wed, 29 Jun 2011 10:09:09 -0400
Subject: [PATCH] DMA: OMAP: Remove extra looping from omap_request_dma
Message-ID: <1309356549.3995.13.camel@quad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Break from dma channel search when a free one is found.

Signed-off-by: Scott Ellis <scott@jumpnowtek.com>
---
 arch/arm/plat-omap/dma.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index c22217c..3d36fcf 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -678,10 +678,9 @@ int omap_request_dma(int dev_id, const char *dev_name,
 
 	spin_lock_irqsave(&dma_chan_lock, flags);
 	for (ch = 0; ch < dma_chan_count; ch++) {
-		if (free_ch == -1 && dma_chan[ch].dev_id == -1) {
+		if (dma_chan[ch].dev_id == -1) {
 			free_ch = ch;
-			if (dev_id == 0)
-				break;
+			break;
 		}
 	}
 	if (free_ch == -1) {
