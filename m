From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 22 Apr 2013 11:55:05 +0200
Subject: [PATCH 09/23] watchdog: coh901327: devicetree support
Message-ID: <1366624505-6437-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This adds support for probing the COH 901 327 watchdog from
the device tree and also adds associated bindings.

Cc: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi Wim, I'm seeking an ACK on this patch to take it into
ARM SoC along with the patches making use of this new
binding.
---
 .../devicetree/bindings/watchdog/stericsson-coh901327.txt | 15 +++++++++++++++
 drivers/watchdog/coh901327_wdt.c                          |  6 ++++++
 2 files changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/stericsson-coh901327.txt

diff --git a/Documentation/devicetree/bindings/watchdog/stericsson-coh901327.txt b/Documentation/devicetree/bindings/watchdog/stericsson-coh901327.txt
new file mode 100644
index 0000000..3d7c958
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/stericsson-coh901327.txt
@@ -0,0 +1,15 @@
+ST-Ericsson COH 901 327 Watchdog timer
+
+Required properties:
+- compatible: must be "stericsson,coh901327".
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: the interrupt used for the watchdog timeout warning.
+
+Example:
+
+watchdog: watchdog at c0012000 {
+	compatible = "stericsson,coh901327";
+	reg = <0xc0012000 0x1000>;
+	interrupts = <3>;
+};
diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
index b9b8a8b..bb7da59 100644
--- a/drivers/watchdog/coh901327_wdt.c
+++ b/drivers/watchdog/coh901327_wdt.c
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
