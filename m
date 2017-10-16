From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 Oct 2017 22:54:27 +0200
Subject: [PATCH 5/5 v2] watchdog: ftwdt010: Add restart support
In-Reply-To: <20171016205427.4297-1-linus.walleij@linaro.org>
References: <20171016205427.4297-1-linus.walleij@linaro.org>
Message-ID: <20171016205427.4297-5-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the Faraday FTWDT010 to restart the system,
if need be. Set the restart priority for the watchdog to
128.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rebased, no changes.
---
 drivers/watchdog/ftwdt010_wdt.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/watchdog/ftwdt010_wdt.c b/drivers/watchdog/ftwdt010_wdt.c
index 21c3ac7f557a..0be7c2db642d 100644
--- a/drivers/watchdog/ftwdt010_wdt.c
+++ b/drivers/watchdog/ftwdt010_wdt.c
@@ -56,6 +56,22 @@ struct ftwdt010_wdt *to_ftwdt010_wdt(struct watchdog_device *wdd)
 	return container_of(wdd, struct ftwdt010_wdt, wdd);
 }
 
+static int ftwdt010_wdt_restart(struct watchdog_device *wdd,
+				unsigned long action, void *data)
+{
+	struct ftwdt010_wdt *gwdt = to_ftwdt010_wdt(wdd);
+	u32 enable;
+
+	writel(1, gwdt->base + FTWDT010_WDLOAD);
+	writel(WDRESTART_MAGIC, gwdt->base + FTWDT010_WDRESTART);
+	enable = WDCR_SYS_RST | WDCR_ENABLE;
+	if (gwdt->use_extclk)
+		enable |= WDCR_EXTCLK;
+	writel(enable, gwdt->base + FTWDT010_WDCR);
+
+	return 0;
+}
+
 static int ftwdt010_wdt_start(struct watchdog_device *wdd)
 {
 	struct ftwdt010_wdt *gwdt = to_ftwdt010_wdt(wdd);
@@ -118,6 +134,7 @@ static const struct watchdog_ops ftwdt010_wdt_ops = {
 	.stop		= ftwdt010_wdt_stop,
 	.ping		= ftwdt010_wdt_ping,
 	.set_timeout	= ftwdt010_wdt_set_timeout,
+	.restart	= ftwdt010_wdt_restart,
 	.owner		= THIS_MODULE,
 };
 
@@ -190,6 +207,7 @@ static int ftwdt010_wdt_probe(struct platform_device *pdev)
 	 */
 	gwdt->wdd.timeout = 13U;
 	watchdog_init_timeout(&gwdt->wdd, 0, dev);
+	watchdog_set_restart_priority(&gwdt->wdd, 128);
 
 	reg = readw(gwdt->base + FTWDT010_WDCR);
 	if (reg & WDCR_ENABLE) {
-- 
2.13.6
