From: jason@lakedaemon.net (Jason Cooper)
Date: Thu,  1 Mar 2012 18:20:55 +0000
Subject: [PATCH 4/4] ARM: kirkwood: convert orion-wdt to fdt.
In-Reply-To: <cover.1330625877.git.jason@lakedaemon.net>
References: <cover.1330625877.git.jason@lakedaemon.net>
Message-ID: <2f29e88b98b2bcff0c241996e6d7216a60995d2d.1330625878.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Converted register address to a variable so that it could be set from
fdt.  Also, pull clock frequency from fdt and clean up failure logic a
bit.

Same as rtc-mv, this device is used in all kirkwood boards.  So, it is
placed in kirkwood.dtsi.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm/boot/dts/kirkwood.dtsi   |    6 +++++
 arch/arm/mach-kirkwood/board-dt.c |    1 -
 arch/arm/mach-kirkwood/common.c   |    2 +-
 arch/arm/mach-kirkwood/common.h   |    1 -
 drivers/watchdog/orion_wdt.c      |   44 ++++++++++++++++++++++++++----------
 5 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 5fb185c..bf28424 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -8,5 +8,11 @@
 		reg = <0xf1010300 0x1f>;
 		interrupts = <53>;
 	};
+
+	wdt at fed20300 {
+		compatible = "marvell,orion-wdt";
+		reg = <0xfed20300 0x28>;
+		clock-frequency = <200000000>;
+	};
 };
 
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 6fc41ae..7ef5fb7 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -135,7 +135,6 @@ static void __init kirkwood_dt_init(void)
 #endif
 
 	/* internal devices that every board has */
-	kirkwood_wdt_init();
 	kirkwood_xor0_init();
 	kirkwood_xor1_init();
 	kirkwood_crypto_init();
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 0c0375f..35dc40b 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -303,7 +303,7 @@ void __init kirkwood_xor1_init(void)
 /*****************************************************************************
  * Watchdog
  ****************************************************************************/
-void __init kirkwood_wdt_init(void)
+static void __init kirkwood_wdt_init(void)
 {
 	orion_wdt_init(kirkwood_tclk);
 }
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index ca08826..ac4b2fb 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -53,7 +53,6 @@ void kirkwood_restart(char, const char *);
 
 char *kirkwood_id(void);
 void kirkwood_l2_init(void);
-void kirkwood_wdt_init(void);
 void kirkwood_xor0_init(void);
 void kirkwood_xor1_init(void);
 void kirkwood_crypto_init(void);
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 4ad78f8..4be76ca 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -17,6 +17,7 @@
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 #include <linux/watchdog.h>
 #include <linux/init.h>
 #include <linux/uaccess.h>
@@ -28,9 +29,9 @@
 /*
  * Watchdog timer block registers.
  */
-#define TIMER_CTRL		(TIMER_VIRT_BASE + 0x0000)
+#define TIMER_CTRL		0x0000
 #define  WDT_EN			0x0010
-#define WDT_VAL			(TIMER_VIRT_BASE + 0x0024)
+#define WDT_VAL			0x0024
 
 #define WDT_MAX_CYCLE_COUNT	0xffffffff
 #define WDT_IN_USE		0
@@ -40,6 +41,7 @@ static int nowayout = WATCHDOG_NOWAYOUT;
 static int heartbeat = -1;		/* module parameter (seconds) */
 static unsigned int wdt_max_duration;	/* (seconds) */
 static unsigned int wdt_tclk;
+static unsigned int wdt_reg;
 static unsigned long wdt_status;
 static DEFINE_SPINLOCK(wdt_lock);
 
@@ -48,7 +50,7 @@ static void orion_wdt_ping(void)
 	spin_lock(&wdt_lock);
 
 	/* Reload watchdog duration */
-	writel(wdt_tclk * heartbeat, WDT_VAL);
+	writel(wdt_tclk * heartbeat, wdt_reg + WDT_VAL);
 
 	spin_unlock(&wdt_lock);
 }
@@ -60,7 +62,7 @@ static void orion_wdt_enable(void)
 	spin_lock(&wdt_lock);
 
 	/* Set watchdog duration */
-	writel(wdt_tclk * heartbeat, WDT_VAL);
+	writel(wdt_tclk * heartbeat, wdt_reg + WDT_VAL);
 
 	/* Clear watchdog timer interrupt */
 	reg = readl(BRIDGE_CAUSE);
@@ -68,9 +70,9 @@ static void orion_wdt_enable(void)
 	writel(reg, BRIDGE_CAUSE);
 
 	/* Enable watchdog timer */
-	reg = readl(TIMER_CTRL);
+	reg = readl(wdt_reg + TIMER_CTRL);
 	reg |= WDT_EN;
-	writel(reg, TIMER_CTRL);
+	writel(reg, wdt_reg + TIMER_CTRL);
 
 	/* Enable reset on watchdog */
 	reg = readl(RSTOUTn_MASK);
@@ -92,9 +94,9 @@ static void orion_wdt_disable(void)
 	writel(reg, RSTOUTn_MASK);
 
 	/* Disable watchdog timer */
-	reg = readl(TIMER_CTRL);
+	reg = readl(wdt_reg + TIMER_CTRL);
 	reg &= ~WDT_EN;
-	writel(reg, TIMER_CTRL);
+	writel(reg, wdt_reg + TIMER_CTRL);
 
 	spin_unlock(&wdt_lock);
 }
@@ -102,7 +104,7 @@ static void orion_wdt_disable(void)
 static int orion_wdt_get_timeleft(int *time_left)
 {
 	spin_lock(&wdt_lock);
-	*time_left = readl(WDT_VAL) / wdt_tclk;
+	*time_left = readl(wdt_reg + WDT_VAL) / wdt_tclk;
 	spin_unlock(&wdt_lock);
 	return 0;
 }
@@ -236,15 +238,23 @@ static struct miscdevice orion_wdt_miscdev = {
 static int __devinit orion_wdt_probe(struct platform_device *pdev)
 {
 	struct orion_wdt_platform_data *pdata = pdev->dev.platform_data;
+	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
-	if (pdata) {
+	if (pdata)
 		wdt_tclk = pdata->tclk;
-	} else {
-		printk(KERN_ERR "Orion Watchdog misses platform data\n");
+
+	of_property_read_u32(np, "clock-frequency", &wdt_tclk);
+
+	if (!wdt_tclk) {
+		printk(KERN_ERR "Orion Watchdog can't get clock freq\n");
 		return -ENODEV;
 	}
 
+	wdt_reg = TIMER_VIRT_BASE;
+
+	of_property_read_u32(np, "reg", &wdt_reg);
+
 	if (orion_wdt_miscdev.parent)
 		return -EBUSY;
 	orion_wdt_miscdev.parent = &pdev->dev;
@@ -284,6 +294,15 @@ static void orion_wdt_shutdown(struct platform_device *pdev)
 		orion_wdt_disable();
 }
 
+#ifdef CONFIG_OF
+static struct of_device_id orion_wdt_of_match_table[] = {
+	{ .compatible = "marvell,orion-wdt", },
+	{},
+};
+#else
+#define orion_wdt_of_match_table NULL
+#endif
+
 static struct platform_driver orion_wdt_driver = {
 	.probe		= orion_wdt_probe,
 	.remove		= __devexit_p(orion_wdt_remove),
@@ -291,6 +310,7 @@ static struct platform_driver orion_wdt_driver = {
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "orion_wdt",
+		.of_match_table = orion_wdt_of_match_table,
 	},
 };
 
-- 
1.7.3.4
