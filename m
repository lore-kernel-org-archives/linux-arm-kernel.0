From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon,  2 Oct 2017 14:27:43 +0200
Subject: [PATCH 3/3] mmc: meson-gx: include tx phase in the tuning process
In-Reply-To: <20171002122743.32334-1-jbrunet@baylibre.com>
References: <20171002122743.32334-1-jbrunet@baylibre.com>
Message-ID: <20171002122743.32334-4-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It has been reported that some platforms (odroid-c2) may require
a different tx phase setting to operate at high speed (hs200 and hs400)

To improve the situation, this patch includes tx phase in the tuning
process.

Fixes: d341ca88eead ("mmc: meson-gx: rework tuning function")
Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 08a55c2e96e1..85745ef179e2 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -716,6 +716,22 @@ static int meson_mmc_clk_phase_tuning(struct mmc_host *mmc, u32 opcode,
 static int meson_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct meson_host *host = mmc_priv(mmc);
+	int ret;
+
+	/*
+	 * If this is the initial tuning, try to get a sane Rx starting
+	 * phase before doing the actual tuning.
+	 */
+	if (!mmc->doing_retune) {
+		ret = meson_mmc_clk_phase_tuning(mmc, opcode, host->rx_clk);
+
+		if (ret)
+			return ret;
+	}
+
+	ret = meson_mmc_clk_phase_tuning(mmc, opcode, host->tx_clk);
+	if (ret)
+		return ret;
 
 	return meson_mmc_clk_phase_tuning(mmc, opcode, host->rx_clk);
 }
@@ -746,8 +762,9 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		if (!IS_ERR(mmc->supply.vmmc))
 			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
 
-		/* Reset rx phase */
+		/* Reset phases */
 		clk_set_phase(host->rx_clk, 0);
+		clk_set_phase(host->tx_clk, 270);
 
 		break;
 
-- 
2.13.5
