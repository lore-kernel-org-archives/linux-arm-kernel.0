From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 22 Sep 2014 17:12:05 +0800
Subject: [PATCH v2 2/8] mmc: sdhci-esdhc-imx: usdhc does not have missing card
 interrupt issue
In-Reply-To: <1411377131-19741-1-git-send-email-b29396@freescale.com>
References: <1411377131-19741-1-git-send-email-b29396@freescale.com>
Message-ID: <1411377131-19741-3-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The usdhc does not have missing card interrupt issue, so execute the
workaround conditionally.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 256c901..9594bf8 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -300,7 +300,7 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
 	u32 data;
 
 	if (unlikely(reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE)) {
-		if (val & SDHCI_INT_CARD_INT) {
+		if ((val & SDHCI_INT_CARD_INT) && !esdhc_is_usdhc(imx_data)) {
 			/*
 			 * Clear and then set D3CD bit to avoid missing the
 			 * card interrupt.  This is a eSDHC controller problem
-- 
1.7.8
