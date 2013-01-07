From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Mon,  7 Jan 2013 12:21:57 +0100
Subject: [PATCH 15/16] dmaengine: set_dma40: ignore spurious interrupts
In-Reply-To: <1357557718-15676-1-git-send-email-fabio.baltieri@linaro.org>
References: <1357557718-15676-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <1357557718-15676-16-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some DMA channels may be used by other cores in the SoC.  This patch
modifies the dma interrupt handler to ignore interrupts from unknown
channels.

Cc: Rabin Vincent <rabin.vincent@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 drivers/dma/ste_dma40.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 2ecefb7..a97bbd3 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -1677,13 +1677,22 @@ static irqreturn_t d40_handle_interrupt(int irq, void *data)
 		row = chan / BITS_PER_LONG;
 		idx = chan & (BITS_PER_LONG - 1);
 
-		/* ACK interrupt */
-		writel(1 << idx, base->virtbase + il[row].clr);
-
 		if (il[row].offset == D40_PHY_CHAN)
 			d40c = base->lookup_phy_chans[idx];
 		else
 			d40c = base->lookup_log_chans[il[row].offset + idx];
+
+		if (!d40c) {
+			/*
+			 * No error because this can happen if something else
+			 * in the system is using the channel.
+			 */
+			continue;
+		}
+
+		/* ACK interrupt */
+		writel(1 << idx, base->virtbase + il[row].clr);
+
 		spin_lock(&d40c->lock);
 
 		if (!il[row].is_error)
-- 
1.7.12.1
