From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Sep 2013 18:00:20 +0200
Subject: [PATCH] remoteproc/davinci: drop needless devm_clk_put
In-Reply-To: <1379951159-8294-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1379951159-8294-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1379952020-5941-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The comment above disable_irq says that it is needed to ensure that the
"devm subsystem might end up releasing things before freeing the irq,
thus allowing an interrupt to sneak in while the device is being
removed." disable_irq is enough for this purpose and there is no need to
manually free the reference to the clock.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Cc: Robert Tivy <rtivy@ti.com>
---
 drivers/remoteproc/da8xx_remoteproc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index 129f7b9..b91cd30 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -301,8 +301,6 @@ static int da8xx_rproc_remove(struct platform_device *pdev)
 	 */
 	disable_irq(drproc->irq);
 
-	devm_clk_put(dev, drproc->dsp_clk);
-
 	rproc_del(rproc);
 	rproc_put(rproc);
 
-- 
1.8.4.rc3
