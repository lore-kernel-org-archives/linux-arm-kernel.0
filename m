From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon,  2 Apr 2018 16:26:48 +0200
Subject: [PATCH 07/15] net: smc91x: remove the dmaengine compat need
In-Reply-To: <20180402142656.26815-1-robert.jarzmik@free.fr>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
Message-ID: <20180402142656.26815-8-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Jarzmik <robert.jarzmik@renault.com>

As the pxa architecture switched towards the dmaengine slave map, the
old compatibility mechanism to acquire the dma requestor line number and
priority are not needed anymore.

This patch simplifies the dma resource acquisition, using the more
generic function dma_request_slave_channel().

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/net/ethernet/smsc/smc91x.c | 12 +-----------
 drivers/net/ethernet/smsc/smc91x.h |  1 -
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
index 080428762858..4c600f430f6d 100644
--- a/drivers/net/ethernet/smsc/smc91x.c
+++ b/drivers/net/ethernet/smsc/smc91x.c
@@ -2018,18 +2018,8 @@ static int smc_probe(struct net_device *dev, void __iomem *ioaddr,
 	lp->cfg.flags |= SMC91X_USE_DMA;
 #  endif
 	if (lp->cfg.flags & SMC91X_USE_DMA) {
-		dma_cap_mask_t mask;
-		struct pxad_param param;
-
-		dma_cap_zero(mask);
-		dma_cap_set(DMA_SLAVE, mask);
-		param.prio = PXAD_PRIO_LOWEST;
-		param.drcmr = -1UL;
-
 		lp->dma_chan =
-			dma_request_slave_channel_compat(mask, pxad_filter_fn,
-							 &param, &dev->dev,
-							 "data");
+			dma_request_slave_channel(lp->device, "data");
 	}
 #endif
 
diff --git a/drivers/net/ethernet/smsc/smc91x.h b/drivers/net/ethernet/smsc/smc91x.h
index 08b17adf0a65..e849b6c2fa60 100644
--- a/drivers/net/ethernet/smsc/smc91x.h
+++ b/drivers/net/ethernet/smsc/smc91x.h
@@ -327,7 +327,6 @@ struct smc_local {
  * as RX which can overrun memory and lose packets.
  */
 #include <linux/dma-mapping.h>
-#include <linux/dma/pxa-dma.h>
 
 #ifdef SMC_insl
 #undef SMC_insl
-- 
2.11.0
