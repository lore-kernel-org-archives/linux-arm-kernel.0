From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 10 Nov 2011 13:06:29 +0800
Subject: [PATCH 1/1] mmc: sdhci-esdhc-imx: convert to clk_prepare/clk_unprepare
Message-ID: <1320901589-13262-1-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index ae57769..b37e5d4 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -462,6 +462,7 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		err = PTR_ERR(clk);
 		goto err_clk_get;
 	}
+	clk_prepare(clk);
 	clk_enable(clk);
 	pltfm_host->clk = clk;
 
@@ -551,6 +552,7 @@ no_card_detect_irq:
 no_card_detect_pin:
 no_board_data:
 	clk_disable(pltfm_host->clk);
+	clk_unprepare(pltfm_host->clk);
 	clk_put(pltfm_host->clk);
 err_clk_get:
 	kfree(imx_data);
@@ -578,6 +580,7 @@ static int __devexit sdhci_esdhc_imx_remove(struct platform_device *pdev)
 	}
 
 	clk_disable(pltfm_host->clk);
+	clk_unprepare(pltfm_host->clk);
 	clk_put(pltfm_host->clk);
 	kfree(imx_data);
 
-- 
1.7.5.4
