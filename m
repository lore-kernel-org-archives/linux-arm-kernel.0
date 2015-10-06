From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue,  6 Oct 2015 22:07:49 +0200
Subject: [PATCH 1/2] memory: omap-gpmc: dump "before" state before first
 modification
Message-ID: <1444162070-22034-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When gpmc_cs_show_timings is called in gpmc_cs_set_timings()
gpmc_cs_program_settings() was already run which modifies the CONFIG1
register. So to be more useful do the "before" dump earlier.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/memory/omap-gpmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 32ac049f2bc4..6515dfc2b805 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -696,7 +696,6 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t,
 	int div;
 	u32 l;
 
-	gpmc_cs_show_timings(cs, "before gpmc_cs_set_timings");
 	div = gpmc_calc_divider(t->sync_clk);
 	if (div < 0)
 		return div;
@@ -1988,6 +1987,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 	if (ret < 0)
 		goto err;
 
+	gpmc_cs_show_timings(cs, "before gpmc_cs_program_settings");
 	ret = gpmc_cs_program_settings(cs, &gpmc_s);
 	if (ret < 0)
 		goto err;
-- 
2.6.0
