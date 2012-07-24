From: balbi@ti.com (Felipe Balbi)
Date: Tue, 24 Jul 2012 11:54:01 +0300
Subject: [PATCH 4/5] arm: omap: debug-leds: add a remove method
In-Reply-To: <1343120042-16695-1-git-send-email-balbi@ti.com>
References: <1343120042-16695-1-git-send-email-balbi@ti.com>
Message-ID: <1343120042-16695-5-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

while at that, also convert to module_platform_driver

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/plat-omap/debug-leds.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/debug-leds.c b/arch/arm/plat-omap/debug-leds.c
index 392daa8..08fbb85 100644
--- a/arch/arm/plat-omap/debug-leds.c
+++ b/arch/arm/plat-omap/debug-leds.c
@@ -251,6 +251,14 @@ static void __devinit newled_init(struct device *dev)
 	return;
 }
 
+static void __devexit newled_exit(void)
+{
+	unsigned	i;
+	struct dbg_led	*led;
+
+	for (i = 0, led = dbg_leds; i < ARRAY_SIZE(dbg_leds); i++, led++)
+		led_classdev_unregister(&led->cdev);
+}
 
 /*-------------------------------------------------------------------------*/
 
@@ -279,6 +287,16 @@ static int __devinit fpga_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int __devexit fpga_remove(struct platform_device *pdev)
+{
+	if (new_led_api())
+		newled_exit();
+
+	iounmap(fpga);
+
+	return 0;
+}
+
 static int fpga_suspend_noirq(struct device *dev)
 {
 	__raw_writew(~0, &fpga->leds);
@@ -300,10 +318,7 @@ static struct platform_driver led_driver = {
 	.driver.name	= "omap_dbg_led",
 	.driver.pm	= &fpga_dev_pm_ops,
 	.probe		= fpga_probe,
+	.remove		= __devexit_p(fpga_remove),
 };
 
-static int __init fpga_init(void)
-{
-	return platform_driver_register(&led_driver);
-}
-module_init(fpga_init);
+module_platform_driver(led_driver);
-- 
1.7.11
