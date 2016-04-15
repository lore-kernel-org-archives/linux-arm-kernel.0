From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Sat, 16 Apr 2016 01:29:30 +0800
Subject: [PATCH 06/23] mmc: sdhci: using common mmc_regulator_set_vqmmc()
In-Reply-To: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1460741387-23815-7-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of using private VCCQ regulator signal voltage switch code,
we switch to use the more robust common function mmc_regulator_set_vqmmc()
in MMC core which set the target voltage as close as possible to target
voltage.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
Don't have a board to test mmc_regulator_set_vqmmc() switch way,
need others to help verify.
---
 drivers/mmc/host/sdhci.c | 39 ++-------------------------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7f63f5d..2338aab 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1726,43 +1726,8 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 	if (ret)
 		return ret;
 
-	if (IS_ERR(mmc->supply.vqmmc))
-		return 0;
-
-	switch (ios->signal_voltage) {
-	case MMC_SIGNAL_VOLTAGE_330:
-		ret = regulator_set_voltage(mmc->supply.vqmmc, 2700000,
-					    3600000);
-		if (ret) {
-			pr_warn("%s: Switching to 3.3V signalling voltage failed\n",
-				mmc_hostname(mmc));
-			return -EIO;
-		}
-
-		return 0;
-	case MMC_SIGNAL_VOLTAGE_180:
-		ret = regulator_set_voltage(mmc->supply.vqmmc,
-				1700000, 1950000);
-		if (ret) {
-			pr_warn("%s: Switching to 1.8V signalling voltage failed\n",
-				mmc_hostname(mmc));
-			return -EIO;
-		}
-
-		return 0;
-	case MMC_SIGNAL_VOLTAGE_120:
-		ret = regulator_set_voltage(mmc->supply.vqmmc, 1100000,
-					    1300000);
-		if (ret) {
-			pr_warn("%s: Switching to 1.2V signalling voltage failed\n",
-				mmc_hostname(mmc));
-			return -EIO;
-		}
-		return 0;
-	default:
-		/* No signal voltage switch required */
-		return 0;
-	}
+	/* do regulator signal voltage switch if exist */
+	return mmc_regulator_set_vqmmc(mmc, ios);
 }
 
 static int sdhci_card_busy(struct mmc_host *mmc)
-- 
1.9.1
