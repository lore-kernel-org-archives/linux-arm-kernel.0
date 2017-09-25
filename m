From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Mon, 25 Sep 2017 07:25:30 +0200
Subject: [PATCH v3 1/2] watchdog: dw_wdt: add stop watchdog operation
Message-ID: <20170925052531.1692-1-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steffen Trumtrar <s.trumtrar@pengutronix.de>

The only way of stopping the watchdog is by resetting it.
Add the watchdog op for stopping the device and reset if
a reset line is provided.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog at vger.kernel.org
---

changes v3:
 - don't return error if rst is not present and set WDOG_HW_RUNNING bit
   to notify watchdog core.

changes v2:
 - test if dw_wdt->rst is NULL instead of IS_ERR

 drivers/watchdog/dw_wdt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 36be987ff9ef..6cc56b18ee52 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -135,6 +135,21 @@ static int dw_wdt_start(struct watchdog_device *wdd)
 	return 0;
 }
 
+static int dw_wdt_stop(struct watchdog_device *wdd)
+{
+	struct dw_wdt *dw_wdt = to_dw_wdt(wdd);
+
+	if (!dw_wdt->rst) {
+		set_bit(WDOG_HW_RUNNING, &wdd->status);
+		return 0;
+	}
+
+	reset_control_assert(dw_wdt->rst);
+	reset_control_deassert(dw_wdt->rst);
+
+	return 0;
+}
+
 static int dw_wdt_restart(struct watchdog_device *wdd,
 			  unsigned long action, void *data)
 {
@@ -173,6 +188,7 @@ static const struct watchdog_info dw_wdt_ident = {
 static const struct watchdog_ops dw_wdt_ops = {
 	.owner		= THIS_MODULE,
 	.start		= dw_wdt_start,
+	.stop		= dw_wdt_stop,
 	.ping		= dw_wdt_ping,
 	.set_timeout	= dw_wdt_set_timeout,
 	.get_timeleft	= dw_wdt_get_timeleft,
-- 
2.11.0
