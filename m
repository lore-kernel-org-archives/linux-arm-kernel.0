From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  2 May 2013 16:48:09 +0100
Subject: [PATCH 3/4] mmc: mmci: Ensure return value of regulator_enable() is
 checked
In-Reply-To: <1367509690-24022-1-git-send-email-lee.jones@linaro.org>
References: <1367509690-24022-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1367509690-24022-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch suppresses the warning below:

drivers/mmc/host/mmci.c: In function ?mmci_set_ios?:
drivers/mmc/host/mmci.c:1165:20: warning: ignoring return value of
        ?regulator_enable?, declared with attribute warn_unused_result
        [-Wunused-result]

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Chris Ball <cjb@laptop.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mmc/host/mmci.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 375c109..f4f3038 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1130,6 +1130,7 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	struct variant_data *variant = host->variant;
 	u32 pwr = 0;
 	unsigned long flags;
+	int ret;
 
 	pm_runtime_get_sync(mmc_dev(mmc));
 
@@ -1161,8 +1162,12 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 	case MMC_POWER_ON:
 		if (!IS_ERR(mmc->supply.vqmmc) &&
-		    !regulator_is_enabled(mmc->supply.vqmmc))
-			regulator_enable(mmc->supply.vqmmc);
+		    !regulator_is_enabled(mmc->supply.vqmmc)) {
+			ret = regulator_enable(mmc->supply.vqmmc);
+			if (ret < 0)
+				dev_err(mmc_dev(mmc),
+					"failed to enable vqmmc regulator\n");
+		}
 
 		pwr |= MCI_PWR_ON;
 		break;
-- 
1.7.10.4
