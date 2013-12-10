From: b29396@freescale.com (Dong Aisheng)
Date: Tue, 10 Dec 2013 20:56:08 +0800
Subject: [PATCH 6/6] mmc: sdhci-esdhc-imx: use actual_clock to calculate
 timeout
In-Reply-To: <1386680168-5227-1-git-send-email-b29396@freescale.com>
References: <1386680168-5227-1-git-send-email-b29396@freescale.com>
Message-ID: <1386680168-5227-7-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The timeout clock for uSDHC is SDCLK, so it's reasonable to use
the actual_clock to calculate the max timeout.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index c24cb23..83236d3 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -865,7 +865,8 @@ unsigned int esdhc_get_max_timeout(struct sdhci_host *host)
 	struct pltfm_imx_data *imx_data = pltfm_host->priv;
 	u32 max_to = esdhc_is_usdhc(imx_data) ? 1 << 28 : 1 << 27;
 
-	return max_to / (esdhc_pltfm_get_max_clock(host) / 1000);
+	return host->mmc->actual_clock ?
+			max_to / (host->mmc->actual_clock / 1000) : 0;
 }
 
 void esdhc_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
-- 
1.7.2.rc3
