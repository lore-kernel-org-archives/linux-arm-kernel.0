From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 26 May 2018 11:54:18 +0200
Subject: [RESEND PATCH] dmaengine: pxa: add a default requestor policy
Message-ID: <20180526095418.22960-1-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As what former drcmr -1 value meant, add a this as a default to each
channel, ie. that by default no requestor line is used.

This is specifically used for network drivers smc91x and smc911x, and
needed for their port to slave maps.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/dma/pxa_dma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 9505334f9c6e..604df1bdadf7 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -762,6 +762,8 @@ static void pxad_free_chan_resources(struct dma_chan *dchan)
 	dma_pool_destroy(chan->desc_pool);
 	chan->desc_pool = NULL;
 
+	chan->drcmr = (u32)-1;
+	chan->prio = PXAD_PRIO_LOWEST;
 }
 
 static void pxad_free_desc(struct virt_dma_desc *vd)
@@ -1386,6 +1388,9 @@ static int pxad_init_dmadev(struct platform_device *op,
 		c = devm_kzalloc(&op->dev, sizeof(*c), GFP_KERNEL);
 		if (!c)
 			return -ENOMEM;
+
+		c->drcmr = (u32)-1;
+		c->prio = PXAD_PRIO_LOWEST;
 		c->vc.desc_free = pxad_free_desc;
 		vchan_init(&c->vc, &pdev->slave);
 		init_waitqueue_head(&c->wq_state);
-- 
2.11.0
