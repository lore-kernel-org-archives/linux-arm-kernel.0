From: elder@linaro.org (Alex Elder)
Date: Wed, 12 Feb 2014 14:05:23 -0600
Subject: [PATCH] clk: bcm281xx: don't disable unused peripheral clocks
Message-ID: <1392235528-25795-1-git-send-email-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the CLK_IGNORE_UNUSED flag when setting up a peripheral clock.
This prevents unused clocks from getting disabled, and by doing
this we can use the common clock code even before we've resolved
all the spots that need to get a reference to their clock.

Signed-off-by: Alex Elder <elder@linaro.org>
Reviewed-by: Matt Porter <mporter@linaro.org>
---
 drivers/clk/bcm/clk-kona-setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-kona-setup.c b/drivers/clk/bcm/clk-kona-setup.c
index f1e88fe..c7607fe 100644
--- a/drivers/clk/bcm/clk-kona-setup.c
+++ b/drivers/clk/bcm/clk-kona-setup.c
@@ -579,7 +579,7 @@ static int peri_clk_setup(struct ccu_data *ccu, struct peri_clk_data *data,
 			struct clk_init_data *init_data)
 {
 	init_data->ops = &kona_peri_clk_ops;
-	init_data->flags = 0;
+	init_data->flags = CLK_IGNORE_UNUSED;
 
 	return clk_sel_setup(data->clocks, &data->sel, init_data);
 }
-- 
1.7.9.5
