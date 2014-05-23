From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 23 May 2014 14:33:00 +0200
Subject: [PATCH 1/5] mmc: sdhci-esdhc-imx: add f_max field to private data
In-Reply-To: <1400848384-3226-1-git-send-email-s.hauer@pengutronix.de>
References: <1400848384-3226-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1400848384-3226-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver filled in the clk and clock fields in struct
sdhci_pltfm_host, but they are unused in the sdhci-pltfm
code and only ever used it for internal use. This adds
a field f_max to private data and uses it instead.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index b841bb7..d530820 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -152,6 +152,7 @@ struct pltfm_imx_data {
 	struct pinctrl_state *pins_200mhz;
 	const struct esdhc_soc_data *socdata;
 	struct esdhc_platform_data boarddata;
+	unsigned long f_max;
 	struct clk *clk_ipg;
 	struct clk *clk_ahb;
 	struct clk *clk_per;
@@ -574,19 +575,16 @@ static unsigned int esdhc_pltfm_get_max_clock(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = pltfm_host->priv;
-	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
 
-	if (boarddata->f_max && (boarddata->f_max < pltfm_host->clock))
-		return boarddata->f_max;
-	else
-		return pltfm_host->clock;
+	return imx_data->f_max;
 }
 
 static unsigned int esdhc_pltfm_get_min_clock(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = pltfm_host->priv;
 
-	return pltfm_host->clock / 256 / 16;
+	return imx_data->f_max / 256 / 16;
 }
 
 static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
@@ -594,7 +592,7 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = pltfm_host->priv;
-	unsigned int host_clock = pltfm_host->clock;
+	unsigned int host_clock = clk_get_rate(imx_data->clk_per);
 	int pre_div = 2;
 	int div = 1;
 	u32 temp, val;
@@ -994,8 +992,6 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		goto free_sdhci;
 	}
 
-	pltfm_host->clk = imx_data->clk_per;
-	pltfm_host->clock = clk_get_rate(pltfm_host->clk);
 	clk_prepare_enable(imx_data->clk_per);
 	clk_prepare_enable(imx_data->clk_ipg);
 	clk_prepare_enable(imx_data->clk_ahb);
@@ -1051,6 +1047,10 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 					host->mmc->parent->platform_data);
 	}
 
+	imx_data->f_max = clk_get_rate(imx_data->clk_per);
+	if (boarddata->f_max && boarddata->f_max < imx_data->f_max)
+		imx_data->f_max = boarddata->f_max;
+
 	/* write_protect */
 	if (boarddata->wp_type == ESDHC_WP_GPIO) {
 		err = mmc_gpio_request_ro(host->mmc, boarddata->wp_gpio);
-- 
2.0.0.rc0
