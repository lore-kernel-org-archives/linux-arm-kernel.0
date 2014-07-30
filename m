From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 30 Jul 2014 10:30:21 +0200
Subject: [PATCH 1/3] dmaengine: sun6i: Remove switch statement from buswidth
 convertion routine
In-Reply-To: <1406709023-7650-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1406709023-7650-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1406709023-7650-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the conversion routine is quite trivial, we don't need this switch, and
we can just use a simple calculation.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/dma/sun6i-dma.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index c771d90b8ded..609c5d8cb947 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -248,20 +248,11 @@ static inline int convert_burst(u32 maxburst, u8 *burst)
 
 static inline int convert_buswidth(enum dma_slave_buswidth addr_width, u8 *width)
 {
-	switch (addr_width) {
-	case DMA_SLAVE_BUSWIDTH_1_BYTE:
-		*width = 0;
-		break;
-	case DMA_SLAVE_BUSWIDTH_2_BYTES:
-		*width = 1;
-		break;
-	case DMA_SLAVE_BUSWIDTH_4_BYTES:
-		*width = 2;
-		break;
-	default:
+	if ((addr_width < DMA_SLAVE_BUSWIDTH_1_BYTE) ||
+	    (addr_width > DMA_SLAVE_BUSWIDTH_4_BYTES))
 		return -EINVAL;
-	}
 
+	*width = addr_width >> 1;
 	return 0;
 }
 
-- 
2.0.2
