From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 4 Nov 2013 16:38:28 +0800
Subject: [PATCH v2 4/5] mmc: sdhci-esdhc-imx: fix runtime pm unblance issue
In-Reply-To: <1383554309-29065-1-git-send-email-b29396@freescale.com>
References: <1383554309-29065-1-git-send-email-b29396@freescale.com>
Message-ID: <1383554309-29065-5-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we're using common esdhc_send_command for tuning commands and
the core code will call pm_runtime_put after command is finished.
So we add a pm_runtime_get_sync here to get the blance.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 0bd99eb..da8026b 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -698,6 +698,7 @@ static void esdhc_prepare_tuning(struct sdhci_host *host, u32 val)
 	/* FIXME: delay a bit for card to be ready for next tuning due to errors */
 	mdelay(1);
 
+	pm_runtime_get_sync(host->mmc->parent);
 	reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
 	reg |= ESDHC_MIX_CTRL_EXE_TUNE | ESDHC_MIX_CTRL_SMPCLK_SEL |
 			ESDHC_MIX_CTRL_FBCLK_SEL;
-- 
1.7.2.rc3
