From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 31 May 2013 11:18:43 +0200
Subject: [PATCH 08/39] watchdog: coh901327: devicetree support
In-Reply-To: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1369991954-17406-9-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This adds support for probing the COH 901 327 watchdog from
the device tree and also adds associated bindings.

Acked-by: Wim Van Sebroeck <wim@iguana.be>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/watchdog/stericsson-coh901327.txt        | 19 +++++++++++++++++++
 drivers/watchdog/coh901327_wdt.c                      | 12 +++++++++---
 2 files changed, 28 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/stericsson-coh901327.txt

diff --git a/Documentation/devicetree/bindings/watchdog/stericsson-coh901327.txt b/Documentation/devicetree/bindings/watchdog/stericsson-coh901327.txt
new file mode 100644
index 0000000..8ffb88e
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/stericsson-coh901327.txt
@@ -0,0 +1,19 @@
+ST-Ericsson COH 901 327 Watchdog timer
+
+Required properties:
+- compatible: must be "stericsson,coh901327".
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: the interrupt used for the watchdog timeout warning.
+
+Optional properties:
+- timeout-sec: contains the watchdog timeout in seconds.
+
+Example:
+
+watchdog: watchdog at c0012000 {
+	compatible = "stericsson,coh901327";
+	reg = <0xc0012000 0x1000>;
+	interrupts = <3>;
+	timeout-sec = <60>;
+};
diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
index b9b8a8b..4bd070f 100644
--- a/drivers/watchdog/coh901327_wdt.c
+++ b/drivers/watchdog/coh901327_wdt.c
@@ -354,9 +354,9 @@ static int __init coh901327_probe(struct platform_device *pdev)
 
 	clk_disable(clk);
 
-	if (margin < 1 || margin > 327)
-		margin = 60;
-	coh901327_wdt.timeout = margin;
+	ret = watchdog_init_timeout(&coh901327_wdt, margin, &pdev->dev);
+	if (ret < 0)
+		coh901327_wdt.timeout = 60;
 
 	ret = watchdog_register_device(&coh901327_wdt);
 	if (ret == 0)
@@ -441,10 +441,16 @@ void coh901327_watchdog_reset(void)
 	/* Return and await doom */
 }
 
+static const struct of_device_id coh901327_dt_match[] = {
+	{ .compatible = "stericsson,coh901327" },
+	{},
+};
+
 static struct platform_driver coh901327_driver = {
 	.driver = {
 		.owner	= THIS_MODULE,
 		.name	= "coh901327_wdog",
+		.of_match_table = coh901327_dt_match,
 	},
 	.remove		= __exit_p(coh901327_remove),
 	.suspend	= coh901327_suspend,
-- 
1.7.11.3
