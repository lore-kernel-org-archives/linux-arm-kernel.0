From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 4 Apr 2013 15:16:13 -0500
Subject: [PATCH 2/5] gpio/omap: remove extra context restores in
 *_runtime_resume()
In-Reply-To: <1365106576-31816-1-git-send-email-jon-hunter@ti.com>
References: <1365106576-31816-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1365106576-31816-3-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tarun Kanti DebBarma <tarun.kanti@ti.com>

68942edb09f69b6e09522d1d346665eb3aadde49 (gpio/omap: fix wakeups
on level-triggered GPIOs) already restores the fallingdetect and
risingdetect contexts in *_runtime_resume(). These registers were
modified in *_runtime_suspend() to include even those configured
as level-triggered since only edge-triggered gpios can generate
wakeup events. Therefore, the old context restores of the same
registers present later in the code is not needed any more.
Remove them.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 drivers/gpio/gpio-omap.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 1e666c8..5af7acd 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1292,10 +1292,6 @@ static int omap_gpio_runtime_resume(struct device *dev)
 		return 0;
 	}
 
-	__raw_writel(bank->context.fallingdetect,
-			bank->base + bank->regs->fallingdetect);
-	__raw_writel(bank->context.risingdetect,
-			bank->base + bank->regs->risingdetect);
 	l = __raw_readl(bank->base + bank->regs->datain);
 
 	/*
-- 
1.7.10.4
