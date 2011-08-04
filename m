From: swarren@nvidia.com (Stephen Warren)
Date: Thu,  4 Aug 2011 17:00:19 -0600
Subject: [PATCH 2/3] mmc: tegra: Don't gpio_request GPIOs used as IRQs.
In-Reply-To: <1312498820-2275-1-git-send-email-swarren@nvidia.com>
References: <1312498820-2275-1-git-send-email-swarren@nvidia.com>
Message-ID: <1312498820-2275-3-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

request_irq now performs this internally. Remove the exra calls from the
driver so that request_irq succeeds.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 93da940..d8d5ddd 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -166,14 +166,7 @@ static int __devinit sdhci_tegra_probe(struct platform_device *pdev)
 	}
 
 	if (gpio_is_valid(plat->cd_gpio)) {
-		rc = gpio_request(plat->cd_gpio, "sdhci_cd");
-		if (rc) {
-			dev_err(mmc_dev(host->mmc),
-				"failed to allocate cd gpio\n");
-			goto err_cd_req;
-		}
 		tegra_gpio_enable(plat->cd_gpio);
-		gpio_direction_input(plat->cd_gpio);
 
 		rc = request_irq(gpio_to_irq(plat->cd_gpio), carddetect_irq,
 				 IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
@@ -263,7 +256,6 @@ static int __devexit sdhci_tegra_remove(struct platform_device *pdev)
 	if (gpio_is_valid(plat->cd_gpio)) {
 		free_irq(gpio_to_irq(plat->cd_gpio), host);
 		tegra_gpio_disable(plat->cd_gpio);
-		gpio_free(plat->cd_gpio);
 	}
 
 	if (gpio_is_valid(plat->power_gpio)) {
-- 
1.7.0.4
