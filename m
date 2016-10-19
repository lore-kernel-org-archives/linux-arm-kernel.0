From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 19 Oct 2016 15:33:04 +0200
Subject: [PATCH v2] mmc: sunxi: Prevent against null dereference for vmmc
Message-ID: <20161019133304.22915-1-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VMMC is an optional regulator, which means that mmc_regulator_get_supply
will only return an error in case of a deferred probe, but not when the
regulator is not set in the DT.

However, the sunxi driver assumes that VMMC is always there, and doesn't
check the value of the regulator pointer before using it, which obviously
leads to a (close to) null pointer dereference.

Add proper checks to prevent that.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

---
Changes from v1:
  - remove redundant error message
---
 drivers/mmc/host/sunxi-mmc.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index c0a5c676d0e8..b1d1303389a7 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -822,10 +822,13 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 
 	case MMC_POWER_UP:
-		host->ferror = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
-						     ios->vdd);
-		if (host->ferror)
-			return;
+		if (!IS_ERR(mmc->supply.vmmc)) {
+			host->ferror = mmc_regulator_set_ocr(mmc,
+							     mmc->supply.vmmc,
+							     ios->vdd);
+			if (host->ferror)
+				return;
+		}
 
 		if (!IS_ERR(mmc->supply.vqmmc)) {
 			host->ferror = regulator_enable(mmc->supply.vqmmc);
@@ -847,7 +850,9 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	case MMC_POWER_OFF:
 		dev_dbg(mmc_dev(mmc), "power off!\n");
 		sunxi_mmc_reset_host(host);
-		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+		if (!IS_ERR(mmc->supply.vmmc))
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+
 		if (!IS_ERR(mmc->supply.vqmmc) && host->vqmmc_enabled)
 			regulator_disable(mmc->supply.vqmmc);
 		host->vqmmc_enabled = false;
-- 
2.9.3
