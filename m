From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 07 Jun 2012 11:56:11 +0100
Subject: [CFT 31/31] dmaengine: PL08x: ensure all descriptors are freed when
 channel is released
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
References: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Message-ID: <E1ScaNv-0003mb-7v@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure all queued descriptors are freed when the channel is released,
ensuring we don't leak memory

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index a5d85b1..6fbeebb 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1117,6 +1117,8 @@ static int pl08x_alloc_chan_resources(struct dma_chan *chan)
 
 static void pl08x_free_chan_resources(struct dma_chan *chan)
 {
+	/* Ensure all queued descriptors are freed */
+	vchan_free_chan_resources(to_virt_chan(chan));
 }
 
 static struct dma_async_tx_descriptor *pl08x_prep_dma_interrupt(
-- 
1.7.4.4
