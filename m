From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 3 Sep 2014 20:05:00 +0800
Subject: [PATCH 4/7] mmc: sdhci: do not enable card detect interrupt for gpio
 cd type
In-Reply-To: <1409745903-26550-1-git-send-email-b29396@freescale.com>
References: <1409745903-26550-1-git-send-email-b29396@freescale.com>
Message-ID: <1409745903-26550-5-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Except SDHCI_QUIRK_BROKEN_CARD_DETECTION and MMC_CAP_NONREMOVABLE,
we also do not need to handle controller native card detect interrupt
for gpio as card detect case.
If we wrong enabled the card detect interrupt for gpio case,
it will cause a lot of unexpected card detect interrupts during data transfer
which should not happen.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f6a683b..4d0b7b5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -136,9 +136,10 @@ static void sdhci_dumpregs(struct sdhci_host *host)
 static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
 {
 	u32 present;
+	int gpio_cd = mmc_gpio_get_cd(host->mmc);
 
 	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) ||
-	    (host->mmc->caps & MMC_CAP_NONREMOVABLE))
+	    (host->mmc->caps & MMC_CAP_NONREMOVABLE) || !IS_ERR_VALUE(gpio_cd))
 		return;
 
 	if (enable) {
-- 
1.7.8
