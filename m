From: zonque@gmail.com (Daniel Mack)
Date: Wed, 14 Aug 2013 22:40:13 +0200
Subject: [PATCH] mmc: omap_hsmmc: get capabilities from DT
Message-ID: <1376512813-27892-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When used in DT mode, the omap hsmmc driver has to take capabilites
given in DT by calling mmc_of_parse().

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/mmc/host/omap_hsmmc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 1865321..31337c1 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1907,7 +1907,15 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	if (mmc_slot(host).nonremovable)
 		mmc->caps |= MMC_CAP_NONREMOVABLE;
 
-	mmc->pm_caps = mmc_slot(host).pm_caps;
+	if (pdev->dev.of_node) {
+		ret = mmc_of_parse(mmc);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "mmc_of_parse() failed: %d\n", ret);
+			goto err_irq;
+		}
+	} else {
+		mmc->pm_caps = mmc_slot(host).pm_caps;
+	}
 
 	omap_hsmmc_conf_bus_power(host);
 
-- 
1.8.3.1
