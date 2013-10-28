From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Mon, 28 Oct 2013 23:49:23 +0100
Subject: [PATCH 06/12] i2c: sh_mobile: Convert to clk_prepare/unprepare
In-Reply-To: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1383000569-8916-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Turn clk_enable() and clk_disable() calls into clk_prepare_enable() and
clk_disable_unprepare() to get ready for the migration to the common
clock framework.

Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c at vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 55110dd..1d79585 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -235,7 +235,7 @@ static void sh_mobile_i2c_init(struct sh_mobile_i2c_data *pd)
 	int offset;
 
 	/* Get clock rate after clock is enabled */
-	clk_enable(pd->clk);
+	clk_prepare_enable(pd->clk);
 	i2c_clk_khz = clk_get_rate(pd->clk) / 1000;
 	i2c_clk_khz /= pd->clks_per_count;
 
@@ -270,14 +270,14 @@ static void sh_mobile_i2c_init(struct sh_mobile_i2c_data *pd)
 		pd->icic &= ~ICIC_ICCHB8;
 
 out:
-	clk_disable(pd->clk);
+	clk_disable_unprepare(pd->clk);
 }
 
 static void activate_ch(struct sh_mobile_i2c_data *pd)
 {
 	/* Wake up device and enable clock */
 	pm_runtime_get_sync(pd->dev);
-	clk_enable(pd->clk);
+	clk_prepare_enable(pd->clk);
 
 	/* Enable channel and configure rx ack */
 	iic_set_clr(pd, ICCR, ICCR_ICE, 0);
@@ -300,7 +300,7 @@ static void deactivate_ch(struct sh_mobile_i2c_data *pd)
 	iic_set_clr(pd, ICCR, 0, ICCR_ICE);
 
 	/* Disable clock and mark device as idle */
-	clk_disable(pd->clk);
+	clk_disable_unprepare(pd->clk);
 	pm_runtime_put_sync(pd->dev);
 }
 
-- 
1.8.1.5
