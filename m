From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Tue, 23 Feb 2010 15:50:38 +0000
Subject: [PATCH] omap: McBSP: Drop unnecessary status/error bit clearing on reg_cacheretrieved register values
Message-ID: <mailman.235.1268351985.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MsBSP register cache will never have any error/status flags set, since
these flags are never written to the reg_cache. So it is kind of not
necessary to clear these flags, which are actually always 0.

In other words, clearing the status/error flags are not necessary, since the
reg_cache will never got these bits set. We can just write back the
register content from the cache as it is when clearing an error condition.

Tested on Amstrad Delta.

Reported-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Acked-by: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index e47686e..52dfcc8 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -133,8 +133,7 @@ static irqreturn_t omap_mcbsp_tx_irq_handler(int irq, void *dev_id)
 		dev_err(mcbsp_tx->dev, "TX Frame Sync Error! : 0x%x\n",
 			irqst_spcr2);
 		/* Writing zero to XSYNC_ERR clears the IRQ */
-		MCBSP_WRITE(mcbsp_tx, SPCR2,
-			    MCBSP_READ_CACHE(mcbsp_tx, SPCR2) & ~(XSYNC_ERR));
+		MCBSP_WRITE(mcbsp_tx, SPCR2, MCBSP_READ_CACHE(mcbsp_tx, SPCR2));
 	} else {
 		complete(&mcbsp_tx->tx_irq_completion);
 	}
@@ -154,8 +153,7 @@ static irqreturn_t omap_mcbsp_rx_irq_handler(int irq, void *dev_id)
 		dev_err(mcbsp_rx->dev, "RX Frame Sync Error! : 0x%x\n",
 			irqst_spcr1);
 		/* Writing zero to RSYNC_ERR clears the IRQ */
-		MCBSP_WRITE(mcbsp_rx, SPCR1,
-			    MCBSP_READ_CACHE(mcbsp_rx, SPCR1) & ~(RSYNC_ERR));
+		MCBSP_WRITE(mcbsp_rx, SPCR1, MCBSP_READ_CACHE(mcbsp_rx, SPCR1));
 	} else {
 		complete(&mcbsp_rx->tx_irq_completion);
 	}
@@ -934,8 +932,7 @@ int omap_mcbsp_pollwrite(unsigned int id, u16 buf)
 	/* if frame sync error - clear the error */
 	if (MCBSP_READ(mcbsp, SPCR2) & XSYNC_ERR) {
 		/* clear error */
-		MCBSP_WRITE(mcbsp, SPCR2,
-				MCBSP_READ_CACHE(mcbsp, SPCR2) & (~XSYNC_ERR));
+		MCBSP_WRITE(mcbsp, SPCR2, MCBSP_READ_CACHE(mcbsp, SPCR2));
 		/* resend */
 		return -1;
 	} else {
@@ -975,8 +972,7 @@ int omap_mcbsp_pollread(unsigned int id, u16 *buf)
 	/* if frame sync error - clear the error */
 	if (MCBSP_READ(mcbsp, SPCR1) & RSYNC_ERR) {
 		/* clear error */
-		MCBSP_WRITE(mcbsp, SPCR1,
-				MCBSP_READ_CACHE(mcbsp, SPCR1) & (~RSYNC_ERR));
+		MCBSP_WRITE(mcbsp, SPCR1, MCBSP_READ_CACHE(mcbsp, SPCR1));
 		/* resend */
 		return -1;
 	} else {
