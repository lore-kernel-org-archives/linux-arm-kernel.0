From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu,  8 Mar 2018 15:52:52 +0100
Subject: [PATCH v2 6/8] mmc: sunxi: Move the reset deassertion before enabling
 the clocks
In-Reply-To: <cover.e1acb3dc84e043c8342166e7fb45f79be36ab154.1520520655.git-series.maxime.ripard@bootlin.com>
References: <cover.e1acb3dc84e043c8342166e7fb45f79be36ab154.1520520655.git-series.maxime.ripard@bootlin.com>
Message-ID: <4b3035d91ee18d544b5893470258396b5b7880a1.1520520655.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per Allwinner guidelines, the reset line should be deasserted before
turning the clocks on.

Implement it in our driver as well.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/mmc/host/sunxi-mmc.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 34bc90bc04b2..c6431f6e816f 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1188,10 +1188,19 @@ static int sunxi_mmc_enable(struct sunxi_mmc_host *host)
 {
 	int ret;
 
+	if (!IS_ERR(host->reset)) {
+		ret = reset_control_reset(host->reset);
+		if (ret) {
+			dev_err(host->dev, "Couldn't reset the MMC controller (%d)\n",
+				ret);
+			return ret;
+		}
+	}
+
 	ret = clk_prepare_enable(host->clk_ahb);
 	if (ret) {
-		dev_err(dev, "Couldn't enable the bus clocks (%d)\n", ret);
-		return ret;
+		dev_err(host->dev, "Couldn't enable the bus clocks (%d)\n", ret);
+		goto error_assert_reset;
 	}
 
 	ret = clk_prepare_enable(host->clk_mmc);
@@ -1212,28 +1221,16 @@ static int sunxi_mmc_enable(struct sunxi_mmc_host *host)
 		goto error_disable_clk_output;
 	}
 
-	if (!IS_ERR(host->reset)) {
-		ret = reset_control_reset(host->reset);
-		if (ret) {
-			dev_err(dev, "Couldn't reset the MMC controller (%d)\n",
-				ret);
-			goto error_disable_clk_sample;
-		}
-	}
-
 	/*
 	 * Sometimes the controller asserts the irq on boot for some reason,
 	 * make sure the controller is in a sane state before enabling irqs.
 	 */
 	ret = sunxi_mmc_reset_host(host);
 	if (ret)
-		goto error_assert_reset;
+		goto error_disable_clk_sample;
 
 	return 0;
 
-error_assert_reset:
-	if (!IS_ERR(host->reset))
-		reset_control_assert(host->reset);
 error_disable_clk_sample:
 	clk_disable_unprepare(host->clk_sample);
 error_disable_clk_output:
@@ -1242,6 +1239,9 @@ static int sunxi_mmc_enable(struct sunxi_mmc_host *host)
 	clk_disable_unprepare(host->clk_mmc);
 error_disable_clk_ahb:
 	clk_disable_unprepare(host->clk_ahb);
+error_assert_reset:
+	if (!IS_ERR(host->reset))
+		reset_control_assert(host->reset);
 	return ret;
 }
 
@@ -1249,13 +1249,13 @@ static void sunxi_mmc_disable(struct sunxi_mmc_host *host)
 {
 	sunxi_mmc_reset_host(host);
 
-	if (!IS_ERR(host->reset))
-		reset_control_assert(host->reset);
-
 	clk_disable_unprepare(host->clk_sample);
 	clk_disable_unprepare(host->clk_output);
 	clk_disable_unprepare(host->clk_mmc);
 	clk_disable_unprepare(host->clk_ahb);
+
+	if (!IS_ERR(host->reset))
+		reset_control_assert(host->reset);
 }
 
 static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
-- 
git-series 0.9.1
