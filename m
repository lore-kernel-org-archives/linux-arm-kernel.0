From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 22 Sep 2014 17:12:08 +0800
Subject: [PATCH v2 5/8] mmc: sdhci: do not enable card cd wakeup for gpio case
In-Reply-To: <1411377131-19741-1-git-send-email-b29396@freescale.com>
References: <1411377131-19741-1-git-send-email-b29396@freescale.com>
Message-ID: <1411377131-19741-6-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do not need to enable the controller card cd interrupt wakeup
if using GPIO as card detect since it's meaningless.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 85cbf45..2b5bba1 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2561,13 +2561,16 @@ static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
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
