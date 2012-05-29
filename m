From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 29 May 2012 10:46:41 +0100
Subject: [RFC 34/34] dmaengine: PL08x: ensure all descriptors are freed when
 channel is released
In-Reply-To: <20120529093015.GF12217@n2100.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
Message-ID: <E1SZJ0j-000717-M3@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure all queued descriptors are freed when the channel is released,
ensuring we don't leak memory

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index f2a29bf..23a2974 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1110,6 +1110,8 @@ static int pl08x_alloc_chan_resources(struct dma_chan *chan)
 
 static void pl08x_free_chan_resources(struct dma_chan *chan)
 {
+	/* Ensure all queued descriptors are freed */
+	vchan_free_chan_resources(to_virt_chan(chan));
 }
 
 static struct dma_async_tx_descriptor *pl08x_prep_dma_interrupt(
-- 
1.7.4.4
