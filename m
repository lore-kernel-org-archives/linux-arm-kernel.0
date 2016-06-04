From: eric@anholt.net (Eric Anholt)
Date: Fri,  3 Jun 2016 19:23:33 -0700
Subject: [PATCH] dma: bcm2835: Fix compiler warning on arm64.
Message-ID: <1465007013-5300-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The min() macro was complaining about mismatched types.  The max len
is at most SZ_1G, so we can just put it in an unsigned int.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

Vinod, if you ack it, this one would be nice to be able to merge
through the -soc tree, so that when we enable of arm64 builds of this
driver we don't introduce a new compiler warning.

 drivers/dma/bcm2835-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 6149b27c33ad..1fa11fc067c6 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -393,7 +393,7 @@ static void bcm2835_dma_fill_cb_chain_with_sg(
 	unsigned int sg_len)
 {
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
-	size_t max_len = bcm2835_dma_max_frame_length(c);
+	unsigned int max_len = bcm2835_dma_max_frame_length(c);
 	unsigned int i, len;
 	dma_addr_t addr;
 	struct scatterlist *sgent;
-- 
2.8.0.rc3
