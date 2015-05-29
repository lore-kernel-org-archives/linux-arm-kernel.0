From: eric@anholt.net (Eric Anholt)
Date: Thu, 28 May 2015 17:03:12 -0700
Subject: [PATCH] mmc: sdhci-bcm2835: Actually enable the clock
Message-ID: <1432857792-7421-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're currently using a fixed frequency clock specified in the DT, so
enabling is a no-op.  However, the RPi firmware-based clocks driver
can actually disable unused clocks, so when switching to use it we
ended up losing our MMC clock once all devices were probed.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/mmc/host/sdhci-bcm2835.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
index 0ef0343..09aff3a 100644
--- a/drivers/mmc/host/sdhci-bcm2835.c
+++ b/drivers/mmc/host/sdhci-bcm2835.c
@@ -172,6 +172,11 @@ static int bcm2835_sdhci_probe(struct platform_device *pdev)
 		ret = PTR_ERR(pltfm_host->clk);
 		goto err;
 	}
+	ret = clk_prepare_enable(pltfm_host->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable host clk\n");
+		goto err;
+	}
 
 	return sdhci_add_host(host);
 
-- 
2.1.4
