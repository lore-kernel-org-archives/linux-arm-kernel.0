From: ramaxlo@gmail.com (Ramax Lo)
Date: Tue,  8 Dec 2009 23:42:41 +0800
Subject: [PATCH] S3C24XX: DMA: Use valid index when accessing array
In-Reply-To: <>
References: <>
Message-ID: <1260286961-24097-1-git-send-email-ramaxlo@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DMA_CH_VALID bit used in the channel index should be masked out before
using it to access the channel array.

Signed-off-by: Ramax Lo <ramaxlo@gmail.com>
---
 arch/arm/plat-s3c24xx/dma.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/dma.c b/arch/arm/plat-s3c24xx/dma.c
index f046f8c..3623b2e 100644
--- a/arch/arm/plat-s3c24xx/dma.c
+++ b/arch/arm/plat-s3c24xx/dma.c
@@ -1403,11 +1403,13 @@ static struct s3c2410_dma_chan *s3c2410_dma_map_channel(int channel)
 		ord = &dma_order->channels[channel];
 
 		for (ch = 0; ch < dma_channels; ch++) {
+			int tmp;
 			if (!is_channel_valid(ord->list[ch]))
 				continue;
 
-			if (s3c2410_chans[ord->list[ch]].in_use == 0) {
-				ch = ord->list[ch] & ~DMA_CH_VALID;
+			tmp = ord->list[ch] & ~DMA_CH_VALID;
+			if (s3c2410_chans[tmp].in_use == 0) {
+				ch = tmp;
 				goto found;
 			}
 		}
-- 
1.5.4.3
