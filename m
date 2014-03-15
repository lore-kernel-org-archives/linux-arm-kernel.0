From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 15 Mar 2014 15:17:58 -0300
Subject: [PATCH v4 3/9] watchdog: orion: Remove unneeded atomic access
In-Reply-To: <1394907484-26002-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1394907484-26002-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1394907484-26002-4-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RSTOUT register on the Armada 370 SoC variant is a dedicated register
(not shared across orthogonal subsystems) and so it's not needed to write
it atomically.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 9b513e8..7d9f93f 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -146,6 +146,7 @@ static int orion_wdt_ping(struct watchdog_device *wdt_dev)
 static int armada370_start(struct watchdog_device *wdt_dev)
 {
 	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
+	u32 reg;
 
 	/* Set watchdog duration */
 	writel(dev->clk_rate * wdt_dev->timeout,
@@ -158,8 +159,10 @@ static int armada370_start(struct watchdog_device *wdt_dev)
 	atomic_io_modify(dev->reg + TIMER_CTRL, dev->data->wdt_enable_bit,
 						dev->data->wdt_enable_bit);
 
-	atomic_io_modify(dev->rstout, dev->data->rstout_enable_bit,
-				      dev->data->rstout_enable_bit);
+	/* Enable reset on watchdog */
+	reg = readl(dev->rstout);
+	reg |= dev->data->rstout_enable_bit;
+	writel(reg, dev->rstout);
 	return 0;
 }
 
-- 
1.9.0
