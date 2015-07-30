From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 30 Jul 2015 13:16:28 +0530
Subject: [PATCH 05/11] mmc: host: omap_hsmmc: set clk rate to the max frequency
In-Reply-To: <1438242394-25599-1-git-send-email-kishon@ti.com>
References: <1438242394-25599-1-git-send-email-kishon@ti.com>
Message-ID: <1438242394-25599-6-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set the clock rate of the functional clock to the max frequency
that is passed to the driver either using pdata or dt.

Also remove unnecessary setting of host->fclk to NULL.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e960b5c..0452a8b 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2219,7 +2219,12 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	host->fclk = devm_clk_get(&pdev->dev, "fck");
 	if (IS_ERR(host->fclk)) {
 		ret = PTR_ERR(host->fclk);
-		host->fclk = NULL;
+		goto err1;
+	}
+
+	ret = clk_set_rate(host->fclk, mmc->f_max);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to set clock to %d\n", mmc->f_max);
 		goto err1;
 	}
 
-- 
1.7.9.5
