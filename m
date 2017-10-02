From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon,  2 Oct 2017 14:27:42 +0200
Subject: [PATCH 2/3] mmc: meson-gx: fix rx phase reset
In-Reply-To: <20171002122743.32334-1-jbrunet@baylibre.com>
References: <20171002122743.32334-1-jbrunet@baylibre.com>
Message-ID: <20171002122743.32334-3-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resetting the phase when POWER_ON is set the set_ios() call means that the
phase is reset almost every time the set_ios() is called, while the
expected behavior was to reset the phase on a power cycle.

This had gone unnoticed until now because in all mode (except hs400) the
tuning is done after the last to set_ios(). In such case, the tuning
result is used anyway.  In HS400, there are a few calls to set_ios() after
the tuning is done, overwriting the tuning result.

Resetting the phase on POWER_UP instead of POWER_ON solve the problem.

Fixes: d341ca88eead ("mmc: meson-gx: rework tuning function")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 421c8719c202..08a55c2e96e1 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -745,6 +745,10 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	case MMC_POWER_UP:
 		if (!IS_ERR(mmc->supply.vmmc))
 			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
+
+		/* Reset rx phase */
+		clk_set_phase(host->rx_clk, 0);
+
 		break;
 
 	case MMC_POWER_ON:
@@ -758,8 +762,6 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 				host->vqmmc_enabled = true;
 		}
 
-		/* Reset rx phase */
-		clk_set_phase(host->rx_clk, 0);
 		break;
 	}
 
-- 
2.13.5
