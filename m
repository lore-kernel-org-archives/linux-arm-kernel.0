From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 3 Sep 2014 20:05:01 +0800
Subject: [PATCH 5/7] mmc: sdhci: do not enable card cd wakeup for gpio case
In-Reply-To: <1409745903-26550-1-git-send-email-b29396@freescale.com>
References: <1409745903-26550-1-git-send-email-b29396@freescale.com>
Message-ID: <1409745903-26550-6-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do not need to enable the controller card cd interrupt wakeup
if using GPIO as card detect since it's meaningless.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4d0b7b5..7aa98b9 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2548,13 +2548,16 @@ static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
 void sdhci_enable_irq_wakeups(struct sdhci_host *host)
 {
 	u8 val;
+	int gpio_cd = mmc_gpio_get_cd(host->mmc);
+
 	u8 mask = SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE
 			| SDHCI_WAKE_ON_INT;
 
 	val = sdhci_readb(host, SDHCI_WAKE_UP_CONTROL);
 	val |= mask ;
 	/* Avoid fake wake up */
-	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
+	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION ||
+	    !IS_ERR_VALUE(gpio_cd))
 		val &= ~(SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE);
 	sdhci_writeb(host, val, SDHCI_WAKE_UP_CONTROL);
 }
-- 
1.7.8
