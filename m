From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 30 Jan 2017 12:41:08 +0100
Subject: [PATCH 06/14] mmc: dw_mmc: simplify optional reset handling
In-Reply-To: <20170130114116.22089-1-p.zabel@pengutronix.de>
References: <20170130114116.22089-1-p.zabel@pengutronix.de>
Message-ID: <20170130114116.22089-6-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit bb475230b8e5 ("reset: make optional functions really
optional"), the reset framework API calls use NULL pointers to describe
optional, non-present reset controls.

This allows to return errors from devm_reset_control_get_optional and to
call reset_control_(de)assert unconditionally.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Guodong Xu <guodong.xu@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/dw_mmc.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index b44306b886cb6..9039e8f81ff12 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2963,10 +2963,8 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 
 	/* find reset controller when exist */
 	pdata->rstc = devm_reset_control_get_optional(dev, "reset");
-	if (IS_ERR(pdata->rstc)) {
-		if (PTR_ERR(pdata->rstc) == -EPROBE_DEFER)
-			return ERR_PTR(-EPROBE_DEFER);
-	}
+	if (IS_ERR(pdata->rstc))
+		return ERR_CAST(pdata->rstc);
 
 	/* find out number of slots supported */
 	of_property_read_u32(np, "num-slots", &pdata->num_slots);
@@ -3090,7 +3088,7 @@ int dw_mci_probe(struct dw_mci *host)
 		}
 	}
 
-	if (!IS_ERR(host->pdata->rstc)) {
+	if (host->pdata->rstc) {
 		reset_control_assert(host->pdata->rstc);
 		usleep_range(10, 50);
 		reset_control_deassert(host->pdata->rstc);
@@ -3245,8 +3243,7 @@ int dw_mci_probe(struct dw_mci *host)
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
 
-	if (!IS_ERR(host->pdata->rstc))
-		reset_control_assert(host->pdata->rstc);
+	reset_control_assert(host->pdata->rstc);
 
 err_clk_ciu:
 	clk_disable_unprepare(host->ciu_clk);
@@ -3278,8 +3275,7 @@ void dw_mci_remove(struct dw_mci *host)
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
 
-	if (!IS_ERR(host->pdata->rstc))
-		reset_control_assert(host->pdata->rstc);
+	reset_control_assert(host->pdata->rstc);
 
 	clk_disable_unprepare(host->ciu_clk);
 	clk_disable_unprepare(host->biu_clk);
-- 
2.11.0
