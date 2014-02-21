From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 21 Feb 2014 10:41:07 +0000
Subject: [PATCH 1/5] mmc: sdhci-spear: fix error handling paths for DT
In-Reply-To: <20140221103710.GB21483@n2100.arm.linux.org.uk>
References: <20140221103710.GB21483@n2100.arm.linux.org.uk>
Message-ID: <E1WGnXX-0007Jg-JR@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the error handling paths for DT and simplify using the devm_* API
for clk_get().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci-spear.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 94ae64d23ef3..d4621eb59527 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -134,7 +134,7 @@ static int sdhci_probe(struct platform_device *pdev)
 	}
 
 	/* clk enable */
-	sdhci->clk = clk_get(&pdev->dev, NULL);
+	sdhci->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(sdhci->clk)) {
 		ret = PTR_ERR(sdhci->clk);
 		dev_dbg(&pdev->dev, "Error getting clock\n");
@@ -144,7 +144,7 @@ static int sdhci_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(sdhci->clk);
 	if (ret) {
 		dev_dbg(&pdev->dev, "Error enabling clock\n");
-		goto put_clk;
+		goto err;
 	}
 
 	ret = clk_set_rate(sdhci->clk, 50000000);
@@ -156,7 +156,7 @@ static int sdhci_probe(struct platform_device *pdev)
 		sdhci->data = sdhci_probe_config_dt(pdev);
 		if (IS_ERR(sdhci->data)) {
 			dev_err(&pdev->dev, "DT: Failed to get pdata\n");
-			return -ENODEV;
+			goto disable_clk;
 		}
 	} else {
 		sdhci->data = dev_get_platdata(&pdev->dev);
@@ -266,8 +266,6 @@ static int sdhci_probe(struct platform_device *pdev)
 	sdhci_free_host(host);
 disable_clk:
 	clk_disable_unprepare(sdhci->clk);
-put_clk:
-	clk_put(sdhci->clk);
 err:
 	dev_err(&pdev->dev, "spear-sdhci probe failed: %d\n", ret);
 	return ret;
@@ -287,7 +285,6 @@ static int sdhci_remove(struct platform_device *pdev)
 	sdhci_remove_host(host, dead);
 	sdhci_free_host(host);
 	clk_disable_unprepare(sdhci->clk);
-	clk_put(sdhci->clk);
 
 	return 0;
 }
-- 
1.8.3.1
