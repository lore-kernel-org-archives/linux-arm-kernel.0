From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Wed, 12 Dec 2012 16:50:21 +0100
Subject: [PATCH] mmc: mmci: Gate the clock when freq is 0
Message-ID: <1355327421-20187-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Johan Rudholm <johan.rudholm@stericsson.com>

In the ST Micro variant, the MMCI_CLOCK register should not be used to
gate the clock. Use MMCI_POWER to do this.

Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index edc3e9b..bf07823 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1147,6 +1147,15 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		}
 	}
 
+	/*
+	 * If clock = 0 and the block needs a certain value in the clreg
+	 * to function, we need to gate the clock by removing MCI_PWR_ON.
+	 * This is a special case for ST Micro variants, since the power
+	 * register in the ARM legacy case is used for powering the cards.
+	 */
+	if (!ios->clock && variant->clkreg)
+		pwr &= ~MCI_PWR_ON;
+
 	spin_lock_irqsave(&host->lock, flags);
 
 	mmci_set_clkreg(host, ios->clock);
-- 
1.7.10
