From: francescolavra.fl@gmail.com (Francesco Lavra)
Date: Mon, 06 Jul 2015 19:59:39 +0200
Subject: [PATCH] watchdog: sunxi: fix activation of system reset
Message-ID: <559AC20B.4090601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit f2147de3 ("watchdog: sunxi: support parameterized compatible
strings") introduced a regression in sunxi_wdt_start(), by which
the system reset function of the watchdog is not enabled upon
starting the watchdog. Fix it.

Signed-off-by: Francesco Lavra <francescolavra.fl@gmail.com>
---
 drivers/watchdog/sunxi_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
index a29afb3..47bd8a1 100644
--- a/drivers/watchdog/sunxi_wdt.c
+++ b/drivers/watchdog/sunxi_wdt.c
@@ -184,7 +184,7 @@ static int sunxi_wdt_start(struct watchdog_device *wdt_dev)
 	/* Set system reset function */
 	reg = readl(wdt_base + regs->wdt_cfg);
 	reg &= ~(regs->wdt_reset_mask);
-	reg |= ~(regs->wdt_reset_val);
+	reg |= regs->wdt_reset_val;
 	writel(reg, wdt_base + regs->wdt_cfg);
 
 	/* Enable watchdog */
-- 
1.9.1
