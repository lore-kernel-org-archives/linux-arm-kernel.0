From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 12 Jan 2011 15:39:09 +0100
Subject: [PATCH 5/6] dmaengine: at_hdmac: flags located in first descriptor
In-Reply-To: <1292435416-16927-1-git-send-email-nicolas.ferre@atmel.com>
References: <1292435416-16927-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <1294843150-6962-4-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Place flags on first descriptor of chain instead of last.
This is the one used by atc_chain_complete() function while unmapping.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/dma/at_hdmac.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index a1a0fc6..99942a5 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -603,7 +603,7 @@ atc_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 	/* set end-of-link to the last link descriptor of list*/
 	set_desc_eol(desc);
 
-	desc->txd.flags = flags; /* client is in control of this ack */
+	first->txd.flags = flags; /* client is in control of this ack */
 
 	return &first->txd;
 
@@ -748,8 +748,8 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	first->txd.cookie = -EBUSY;
 	first->len = total_len;
 
-	/* last link descriptor of list is responsible of flags */
-	prev->txd.flags = flags; /* client is in control of this ack */
+	/* first link descriptor of list is responsible of flags */
+	first->txd.flags = flags; /* client is in control of this ack */
 
 	return &first->txd;
 
-- 
1.7.3
