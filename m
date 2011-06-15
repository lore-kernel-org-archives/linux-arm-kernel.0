From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 15 Jun 2011 19:15:20 +0800
Subject: [PATCH v2 2/4] mmc: sdhci-esdhc-imx: SDHCI_CARD_PRESENT does not get
	cleared
In-Reply-To: <1308136522-3403-1-git-send-email-shawn.guo@linaro.org>
References: <1308136522-3403-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1308136522-3403-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function esdhc_readl_le intends to clear bit SDHCI_CARD_PRESENT,
when the card detect gpio tells there is no card.  But it does not
clear the bit actually.  The patch gives a fix on that.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 248b8e5..94097c0 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -84,7 +84,7 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 		if (boarddata && gpio_is_valid(boarddata->cd_gpio)
 				&& gpio_get_value(boarddata->cd_gpio))
 			/* no card, if a valid gpio says so... */
-			val &= SDHCI_CARD_PRESENT;
+			val &= ~SDHCI_CARD_PRESENT;
 		else
 			/* ... in all other cases assume card is present */
 			val |= SDHCI_CARD_PRESENT;
-- 
1.7.4.1
