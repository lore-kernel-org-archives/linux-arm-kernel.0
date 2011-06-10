From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 10 Jun 2011 18:42:49 +0800
Subject: [PATCH 1/4] mmc: sdhci: fix interrupt storm from card detection
In-Reply-To: <1307702572-22066-1-git-send-email-shawn.guo@linaro.org>
References: <1307702572-22066-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1307702572-22066-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The issue was initially found by Eric Benard as below.

http://permalink.gmane.org/gmane.linux.ports.arm.kernel/108031

Not sure about other SDHCI based controller, but on Freescale eSDHC,
the SDHCI_INT_CARD_INSERT bits will be immediately set again when it
gets cleared, if a card is inserted. The driver need to mask the irq
to prevent interrupt storm which will freeze the system.  And the
SDHCI_INT_CARD_REMOVE gets the same situation.

The patch fixes the problem based on the initial idea from
Eric Benard.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Eric Benard <eric@eukrea.com>
---
 drivers/mmc/host/sdhci.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 91d9892..71a2505 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2154,13 +2154,20 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 		mmc_hostname(host->mmc), intmask);
 
 	if (intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
+		u32 present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
+			      SDHCI_CARD_PRESENT;
+
+		sdhci_mask_irqs(host, present ? SDHCI_INT_CARD_INSERT :
+						SDHCI_INT_CARD_REMOVE);
+		sdhci_unmask_irqs(host, present ? SDHCI_INT_CARD_REMOVE :
+						  SDHCI_INT_CARD_INSERT);
+
 		sdhci_writel(host, intmask & (SDHCI_INT_CARD_INSERT |
-			SDHCI_INT_CARD_REMOVE), SDHCI_INT_STATUS);
+			     SDHCI_INT_CARD_REMOVE), SDHCI_INT_STATUS);
+		intmask &= ~(SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE);
 		tasklet_schedule(&host->card_tasklet);
 	}
 
-	intmask &= ~(SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE);
-
 	if (intmask & SDHCI_INT_CMD_MASK) {
 		sdhci_writel(host, intmask & SDHCI_INT_CMD_MASK,
 			SDHCI_INT_STATUS);
-- 
1.7.4.1
