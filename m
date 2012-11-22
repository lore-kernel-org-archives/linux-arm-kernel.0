From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 22 Nov 2012 23:55:30 +0000
Subject: [PATCH 2/3] MMC: sdhci-dove: use two-stage initialization for
 sdhci-pltfm
In-Reply-To: <20121122235426.GT3332@n2100.arm.linux.org.uk>
References: <20121122235426.GT3332@n2100.arm.linux.org.uk>
Message-ID: <E1TbgcE-0007Kp-UU@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to use the two-stage initialization for sdhci-pltfm if we're
going to do anything extra at initialization time.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci-dove.c |   24 +++++++++++++++++-------
 1 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
index 4233fd9..4af64f3 100644
--- a/drivers/mmc/host/sdhci-dove.c
+++ b/drivers/mmc/host/sdhci-dove.c
@@ -93,22 +93,32 @@ static int __devinit sdhci_dove_probe(struct platform_device *pdev)
 	}
 
 	priv->clk = devm_clk_get(&pdev->dev, NULL);
-	if (!IS_ERR(priv->clk))
-		clk_prepare_enable(priv->clk);
 
-	ret = sdhci_pltfm_register(pdev, &sdhci_dove_pdata);
-	if (ret)
-		goto sdhci_dove_register_fail;
+	host = sdhci_pltfm_init(pdev, &sdhci_dove_pdata);
+	if (IS_ERR(host)) {
+		ret = PTR_ERR(host);
+		goto err_sdhci_pltfm_init;
+	}
 
-	host = platform_get_drvdata(pdev);
 	pltfm_host = sdhci_priv(host);
 	pltfm_host->priv = priv;
 
+	if (!IS_ERR(priv->clk))
+		clk_prepare_enable(priv->clk);
+
+	sdhci_get_of_property(pdev);
+
+	ret = sdhci_add_host(host);
+	if (ret)
+		goto err_sdhci_add;
+
 	return 0;
 
-sdhci_dove_register_fail:
+err_sdhci_add:
 	if (!IS_ERR(priv->clk))
 		clk_disable_unprepare(priv->clk);
+	sdhci_pltfm_free(pdev);
+err_sdhci_pltfm_init:
 	return ret;
 }
 
-- 
1.7.4.4
