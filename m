From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Tue, 4 Dec 2012 16:51:36 +0100 (CET)
Subject: [PATCH 2/3] mmc: extend the slot-gpio card-detection to use host's
 .card_event() method
In-Reply-To: <Pine.LNX.4.64.1212041633470.26918@axis700.grange>
References: <Pine.LNX.4.64.1212041633470.26918@axis700.grange>
Message-ID: <Pine.LNX.4.64.1212041648280.26918@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The slot-gpio API provides a generic card-detection handler. To support a
wider range of hosts it has to call the host's card-event callback, if
implemented. Also increase the debounce interval to 200ms to match the 
SDHCI driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/core/slot-gpio.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 08c6b3d..16a1c0b 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -27,7 +27,13 @@ struct mmc_gpio {
 static irqreturn_t mmc_gpio_cd_irqt(int irq, void *dev_id)
 {
 	/* Schedule a card detection after a debounce timeout */
-	mmc_detect_change(dev_id, msecs_to_jiffies(100));
+	struct mmc_host *host = dev_id;
+
+	if (host->ops->card_event)
+		host->ops->card_event(host);
+
+	mmc_detect_change(host, msecs_to_jiffies(200));
+
 	return IRQ_HANDLED;
 }
 
-- 
1.7.2.5
