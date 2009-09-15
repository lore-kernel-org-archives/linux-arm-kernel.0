From: jassi.brar@samsung.com (Jassi)
Date: Tue, 15 Sep 2009 19:01:22 +0900
Subject: [PATCH 4/7] S3C64XX DMA: S3C2410_DMAF_CIRCULAR disable
Message-ID: <1253008882-7587-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S3C2410_DMAF_CIRCULAR requires that we don't free buffer
resources after TC-IRQ because we will revisit the buffer.
During simple long term playback/capture, like movie-play,
this may block those resources(kmem/dma_pool) unncessarily.
This is especially a problem since we allocate them in IRQ
context.
For now, we disable the option and free buff resources after
it's TC-IRQ. Also, chan->curr will point to the active buffer
while chan->next is rendered useless.

Signed-Off-by: Jassi <jassi.brar@samsung.com>
---
 arch/arm/plat-s3c64xx/dma.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/dma.c b/arch/arm/plat-s3c64xx/dma.c
index 266a107..02bc82b 100644
--- a/arch/arm/plat-s3c64xx/dma.c
+++ b/arch/arm/plat-s3c64xx/dma.c
@@ -375,10 +375,12 @@ int s3c2410_dma_enqueue(unsigned int channel, void *id,
 		end->next = buff;
 		endlli->next_lli = buff->lli_dma;
 
+#if 0
 		if (chan->flags & S3C2410_DMAF_CIRCULAR) {
 			struct s3c64xx_dma_buff *curr = chan->curr;
 			lli->next_lli = curr->lli_dma;
 		}
+#endif
 
 		if (next == chan->curr) {
 			writel(buff->lli_dma, chan->regs + PL080_CH_LLI);
-- 
1.6.2.5
