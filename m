From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Wed,  6 May 2015 13:17:59 +0200
Subject: [PATCH] watchdog: imx2_wdt: also set wdog->timeout to new_timeout
Message-ID: <1430911079-23738-1-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit faad5de0b104 ("watchdog: imx2_wdt: convert to watchdog core api")
removes the custom ioctl function. The generic ioctl handler is not
setting the wdog->timeout to the new_timeout but handing this preset
value back to the userspace. This patch sets the new value in the
drivers set_timeout function to fix that problem.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/watchdog/imx2_wdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 5e6d808..7cee402 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -166,6 +166,8 @@ static int imx2_wdt_set_timeout(struct watchdog_device *wdog,
 {
 	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
 
+	wdog->timeout = new_timeout;
+
 	regmap_update_bits(wdev->regmap, IMX2_WDT_WCR, IMX2_WDT_WCR_WT,
 			   WDOG_SEC_TO_COUNT(new_timeout));
 	return 0;
-- 
2.1.4
