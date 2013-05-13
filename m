From: gmbnomis@gmail.com (Simon Baatz)
Date: Mon, 13 May 2013 23:18:57 +0200
Subject: [PATCH V2 06/10] mmc: tegra: handle mmc_of_parse() errors during probe
In-Reply-To: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
References: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
Message-ID: <1368479941-10084-7-git-send-email-gmbnomis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 drivers/mmc/host/sdhci-tegra.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index e0dba74..7eb62f8 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -205,7 +205,7 @@ static const struct of_device_id sdhci_tegra_dt_match[] = {
 };
 MODULE_DEVICE_TABLE(of, sdhci_tegra_dt_match);
 
-static void sdhci_tegra_parse_dt(struct device *dev)
+static int sdhci_tegra_parse_dt(struct device *dev)
 {
 	struct device_node *np = dev->of_node;
 	struct sdhci_host *host = dev_get_drvdata(dev);
@@ -213,7 +213,7 @@ static void sdhci_tegra_parse_dt(struct device *dev)
 	struct sdhci_tegra *tegra_host = pltfm_host->priv;
 
 	tegra_host->power_gpio = of_get_named_gpio(np, "power-gpios", 0);
-	mmc_of_parse(host->mmc);
+	return mmc_of_parse(host->mmc);
 }
 
 static int sdhci_tegra_probe(struct platform_device *pdev)
@@ -245,7 +245,9 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	tegra_host->soc_data = soc_data;
 	pltfm_host->priv = tegra_host;
 
-	sdhci_tegra_parse_dt(&pdev->dev);
+	rc = sdhci_tegra_parse_dt(&pdev->dev);
+	if (rc)
+		goto err_parse_dt;
 
 	if (gpio_is_valid(tegra_host->power_gpio)) {
 		rc = gpio_request(tegra_host->power_gpio, "sdhci_power");
@@ -278,6 +280,7 @@ err_add_host:
 err_clk_get:
 	if (gpio_is_valid(tegra_host->power_gpio))
 		gpio_free(tegra_host->power_gpio);
+err_parse_dt:
 err_power_req:
 err_alloc_tegra_host:
 	sdhci_pltfm_free(pdev);
-- 
1.7.9.5
