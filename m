From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:57:02 +0100
Subject: [PATCH 192/222] mmc: sdhci: plug hole in disabling card detection
 interrupts
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdekY-0007QW-OQ@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we disable card detection interrupts, we should disable both the
insert and remove interrupts irrespective of the current state - this
avoids races between the hardware card detect changing state before
we've read that updated state and altered the interrupt mask.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 02a59b051343..e7e4c18a1ff5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -133,20 +133,21 @@ static void sdhci_dumpregs(struct sdhci_host *host)
 
 static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
 {
-	u32 present, irqs;
+	u32 present;
 
 	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) ||
 	    (host->mmc->caps & MMC_CAP_NONREMOVABLE))
 		return;
 
-	present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
-			      SDHCI_CARD_PRESENT;
-	irqs = present ? SDHCI_INT_CARD_REMOVE : SDHCI_INT_CARD_INSERT;
+	if (enable) {
+		present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
+				      SDHCI_CARD_PRESENT;
 
-	if (enable)
-		host->ier |= irqs;
-	else
-		host->ier &= ~irqs;
+		host->ier |= present ? SDHCI_INT_CARD_REMOVE :
+				       SDHCI_INT_CARD_INSERT;
+	} else {
+		host->ier &= ~(SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT);
+	}
 
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
-- 
1.8.3.1
