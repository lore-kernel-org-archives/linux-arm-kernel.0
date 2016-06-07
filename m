From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue,  7 Jun 2016 17:09:15 +0100
Subject: [PATCH] dmaengine: at_xdmac: fix un-exported functions
Message-ID: <1465315755-3645-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The at_xdmac_init_used_desc() and at_xdmac_prep_dma_memset()
functions are not exported outside the driver, so make them
static to avoid the following warnings:

drivers/dma/at_xdmac.c:459:6: warning: symbol 'at_xdmac_init_used_desc' was not declared. Should it be static?
drivers/dma/at_xdmac.c:1205:32: warning: symbol 'at_xdmac_prep_dma_memset' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: dmaengine at vger.kernel.org
---
 drivers/dma/at_xdmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 8e304b1..2503b40 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -456,7 +456,7 @@ static struct at_xdmac_desc *at_xdmac_alloc_desc(struct dma_chan *chan,
 	return desc;
 }
 
-void at_xdmac_init_used_desc(struct at_xdmac_desc *desc)
+static void at_xdmac_init_used_desc(struct at_xdmac_desc *desc)
 {
 	memset(&desc->lld, 0, sizeof(desc->lld));
 	INIT_LIST_HEAD(&desc->descs_list);
@@ -1202,7 +1202,7 @@ static struct at_xdmac_desc *at_xdmac_memset_create_desc(struct dma_chan *chan,
 	return desc;
 }
 
-struct dma_async_tx_descriptor *
+static struct dma_async_tx_descriptor *
 at_xdmac_prep_dma_memset(struct dma_chan *chan, dma_addr_t dest, int value,
 			 size_t len, unsigned long flags)
 {
-- 
2.8.1
