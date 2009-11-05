From: jassi.brar@samsung.com (Jassi Brar)
Date: Thu,  5 Nov 2009 13:44:20 +0900
Subject: [PATCH 1/5] S3C64XX DMA: Protect buffer pointers while manipulation
Message-ID: <1257396260-32141-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/plat-s3c64xx/dma.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/dma.c b/arch/arm/plat-s3c64xx/dma.c
index 266a107..6fa706f 100644
--- a/arch/arm/plat-s3c64xx/dma.c
+++ b/arch/arm/plat-s3c64xx/dma.c
@@ -339,6 +339,7 @@ int s3c2410_dma_enqueue(unsigned int channel, void *id,
 	struct s3c64xx_dma_buff *next;
 	struct s3c64xx_dma_buff *buff;
 	struct pl080s_lli *lli;
+	unsigned long flags;
 	int ret;
 
 	WARN_ON(!chan);
@@ -366,6 +367,8 @@ int s3c2410_dma_enqueue(unsigned int channel, void *id,
 
 	s3c64xx_dma_fill_lli(chan, lli, data, size);
 
+	local_irq_save(flags);
+
 	if ((next = chan->next) != NULL) {
 		struct s3c64xx_dma_buff *end = chan->end;
 		struct pl080s_lli *endlli = end->lli;
@@ -397,6 +400,8 @@ int s3c2410_dma_enqueue(unsigned int channel, void *id,
 		s3c64xx_lli_to_regs(chan, lli);
 	}
 
+	local_irq_restore(flags);
+
 	show_lli(lli);
 
 	dbg_showchan(chan);
-- 
1.6.2.5
