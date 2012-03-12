From: rmallon@gmail.com (Ryan Mallon)
Date: Tue, 13 Mar 2012 09:48:16 +1100
Subject: [PATCH v4 05/11] ep93xx: Convert the watchdog driver into a platform
 device.
Message-ID: <1331592502-9083-6-git-send-email-rmallon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: H Hartley Sweeten <hsweeten@visionengravers.com>

From: H Hartley Sweeten <hsweeten@visionengravers.com>

Convert the ep93xx watchdog driver into a platform device and
remove it's dependency on <mach/hardware.h>.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Signed-off-by: Ryan Mallon <rmallon@gmail.com>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Reviewed-by: Mika Westerberg <mika.westerberg@iki.fi>
Cc: Arnd Bergmann <arnd@arndb.de>
---
This patch has already been applied to Wim's watchdog tree. It has
included here for completeness because this patch series is against
v3.3-rc7.

 arch/arm/mach-ep93xx/core.c                     |   15 +++++++
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    1 +
 drivers/watchdog/ep93xx_wdt.c                   |   51 ++++++++++++++++------
 3 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index c73e299..3134baf 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -889,6 +889,20 @@ void __init ep93xx_register_ac97(void)
 	platform_device_register(&ep93xx_pcm_device);
 }
 
+/*************************************************************************
+ * EP93xx Watchdog
+ *************************************************************************/
+static struct resource ep93xx_wdt_resources[] = {
+	DEFINE_RES_MEM(EP93XX_WATCHDOG_PHYS_BASE, 0x08),
+};
+
+static struct platform_device ep93xx_wdt_device = {
+	.name		= "ep93xx-wdt",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(ep93xx_wdt_resources),
+	.resource	= ep93xx_wdt_resources,
+};
+
 void __init ep93xx_init_devices(void)
 {
 	/* Disallow access to MaverickCrunch initially */
@@ -904,6 +918,7 @@ void __init ep93xx_init_devices(void)
 	platform_device_register(&ep93xx_rtc_device);
 	platform_device_register(&ep93xx_ohci_device);
 	platform_device_register(&ep93xx_leds);
+	platform_device_register(&ep93xx_wdt_device);
 }
 
 void ep93xx_restart(char mode, const char *cmd)
diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
index 72b8687..f28afcf 100644
--- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
+++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
@@ -182,6 +182,7 @@
 #define EP93XX_SYSCON_SYSCFG_LCSN1	(1<<0)
 #define EP93XX_SYSCON_SWLOCK		EP93XX_SYSCON_REG(0xc0)
 
+#define EP93XX_WATCHDOG_PHYS_BASE	EP93XX_APB_PHYS(0x00140000)
 #define EP93XX_WATCHDOG_BASE		EP93XX_APB_IOMEM(0x00140000)
 
 
diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.c
index 726b7df..09cd888 100644
--- a/drivers/watchdog/ep93xx_wdt.c
+++ b/drivers/watchdog/ep93xx_wdt.c
@@ -23,6 +23,7 @@
  *	- Add a few missing ioctls
  */
 
+#include <linux/platform_device.h>
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
@@ -30,7 +31,6 @@
 #include <linux/timer.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
-#include <mach/hardware.h>
 
 #define WDT_VERSION	"0.3"
 #define PFX		"ep93xx_wdt: "
@@ -41,6 +41,7 @@
 static int nowayout = WATCHDOG_NOWAYOUT;
 static int timeout = WDT_TIMEOUT;
 
+static void __iomem *mmio_base;
 static struct timer_list timer;
 static unsigned long next_heartbeat;
 static unsigned long wdt_status;
@@ -49,26 +50,25 @@ static unsigned long boot_status;
 #define WDT_IN_USE		0
 #define WDT_OK_TO_CLOSE		1
 
-#define EP93XX_WDT_REG(x)	(EP93XX_WATCHDOG_BASE + (x))
-#define EP93XX_WDT_WATCHDOG	EP93XX_WDT_REG(0x00)
-#define EP93XX_WDT_WDSTATUS	EP93XX_WDT_REG(0x04)
+#define EP93XX_WATCHDOG		0x00
+#define EP93XX_WDSTATUS		0x04
 
 /* reset the wdt every ~200ms */
 #define WDT_INTERVAL (HZ/5)
 
 static void wdt_enable(void)
 {
-	__raw_writew(0xaaaa, EP93XX_WDT_WATCHDOG);
+	writel(0xaaaa, mmio_base + EP93XX_WATCHDOG);
 }
 
 static void wdt_disable(void)
 {
-	__raw_writew(0xaa55, EP93XX_WDT_WATCHDOG);
+	writel(0xaa55, mmio_base + EP93XX_WATCHDOG);
 }
 
 static inline void wdt_ping(void)
 {
-	__raw_writew(0x5555, EP93XX_WDT_WATCHDOG);
+	writel(0x5555, mmio_base + EP93XX_WATCHDOG);
 }
 
 static void wdt_startup(void)
@@ -206,18 +206,32 @@ static void ep93xx_timer_ping(unsigned long data)
 	mod_timer(&timer, jiffies + WDT_INTERVAL);
 }
 
-static int __init ep93xx_wdt_init(void)
+static int __devinit ep93xx_wdt_probe(struct platform_device *pdev)
 {
+	struct resource *res;
+	unsigned long val;
 	int err;
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENXIO;
+
+	if (!devm_request_mem_region(&pdev->dev, res->start,
+				     resource_size(res), pdev->name))
+		return -EBUSY;
+
+	mmio_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!mmio_base)
+		return -ENXIO;
+
 	err = misc_register(&ep93xx_wdt_miscdev);
 
-	boot_status = __raw_readl(EP93XX_WDT_WATCHDOG) & 0x01 ? 1 : 0;
+	val = readl(mmio_base + EP93XX_WATCHDOG);
+	boot_status = val & 0x01 ? 1 : 0;
 
 	printk(KERN_INFO PFX "EP93XX watchdog, driver version "
 		WDT_VERSION "%s\n",
-		(__raw_readl(EP93XX_WDT_WATCHDOG) & 0x08)
-		? " (nCS1 disable detected)" : "");
+		(val & 0x08) ? " (nCS1 disable detected)" : "");
 
 	if (timeout < 1 || timeout > 3600) {
 		timeout = WDT_TIMEOUT;
@@ -230,14 +244,23 @@ static int __init ep93xx_wdt_init(void)
 	return err;
 }
 
-static void __exit ep93xx_wdt_exit(void)
+static int __devexit ep93xx_wdt_remove(struct platform_device *pdev)
 {
 	wdt_shutdown();
 	misc_deregister(&ep93xx_wdt_miscdev);
+	return 0;
 }
 
-module_init(ep93xx_wdt_init);
-module_exit(ep93xx_wdt_exit);
+static struct platform_driver ep93xx_wdt_driver = {
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "ep93xx-wdt",
+	},
+	.probe		= ep93xx_wdt_probe,
+	.remove		= __devexit_p(ep93xx_wdt_remove),
+};
+
+module_platform_driver(ep93xx_wdt_driver);
 
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started");
-- 
1.7.0.4
