From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 13 Mar 2012 01:57:45 +0000
Subject: [PATCH 3/7 v2] ARM: orion: wdt: use resource vice direct access
In-Reply-To: <cover.1331601448.git.jason@lakedaemon.net>
References: <cover.1331601448.git.jason@lakedaemon.net>
Message-ID: <e8cd3863d70b322ee7625d0e49af0acdb82644fc.1331601448.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jason Cooper <jason@lakedaemon.net>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
Note: This code is the exact same as that originally Acked by Grant.  I've
simply removed the fdt bindings, as I need to hold off until common clock is
added.  If it's not appropriate to retain his Ack here, please let me know.

 arch/arm/plat-orion/common.c |    7 ++++++-
 drivers/watchdog/orion_wdt.c |   24 +++++++++++++++---------
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index e5a2fde..eadd1cd 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -21,6 +21,7 @@
 #include <plat/orion_wdt.h>
 #include <plat/mv_xor.h>
 #include <plat/ehci-orion.h>
+#include <mach/bridge-regs.h>
 
 /* Fill in the resources structure and link it into the platform
    device structure. There is always a memory region, and nearly
@@ -568,13 +569,17 @@ void __init orion_spi_1_init(unsigned long mapbase,
  ****************************************************************************/
 static struct orion_wdt_platform_data orion_wdt_data;
 
+static struct resource orion_wdt_resource =
+		DEFINE_RES_MEM(TIMER_VIRT_BASE, 0x28);
+
 static struct platform_device orion_wdt_device = {
 	.name		= "orion_wdt",
 	.id		= -1,
 	.dev		= {
 		.platform_data	= &orion_wdt_data,
 	},
-	.num_resources	= 0,
+	.resource	= &orion_wdt_resource,
+	.num_resources	= 1,
 };
 
 void __init orion_wdt_init(unsigned long tclk)
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 4ad78f8..1368e4c 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -28,9 +28,9 @@
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
@@ -40,6 +40,7 @@ static int nowayout = WATCHDOG_NOWAYOUT;
 static int heartbeat = -1;		/* module parameter (seconds) */
 static unsigned int wdt_max_duration;	/* (seconds) */
 static unsigned int wdt_tclk;
+static void __iomem *wdt_reg;
 static unsigned long wdt_status;
 static DEFINE_SPINLOCK(wdt_lock);
 
@@ -48,7 +49,7 @@ static void orion_wdt_ping(void)
 	spin_lock(&wdt_lock);
 
 	/* Reload watchdog duration */
-	writel(wdt_tclk * heartbeat, WDT_VAL);
+	writel(wdt_tclk * heartbeat, wdt_reg + WDT_VAL);
 
 	spin_unlock(&wdt_lock);
 }
@@ -60,7 +61,7 @@ static void orion_wdt_enable(void)
 	spin_lock(&wdt_lock);
 
 	/* Set watchdog duration */
-	writel(wdt_tclk * heartbeat, WDT_VAL);
+	writel(wdt_tclk * heartbeat, wdt_reg + WDT_VAL);
 
 	/* Clear watchdog timer interrupt */
 	reg = readl(BRIDGE_CAUSE);
@@ -68,9 +69,9 @@ static void orion_wdt_enable(void)
 	writel(reg, BRIDGE_CAUSE);
 
 	/* Enable watchdog timer */
-	reg = readl(TIMER_CTRL);
+	reg = readl(wdt_reg + TIMER_CTRL);
 	reg |= WDT_EN;
-	writel(reg, TIMER_CTRL);
+	writel(reg, wdt_reg + TIMER_CTRL);
 
 	/* Enable reset on watchdog */
 	reg = readl(RSTOUTn_MASK);
@@ -92,9 +93,9 @@ static void orion_wdt_disable(void)
 	writel(reg, RSTOUTn_MASK);
 
 	/* Disable watchdog timer */
-	reg = readl(TIMER_CTRL);
+	reg = readl(wdt_reg + TIMER_CTRL);
 	reg &= ~WDT_EN;
-	writel(reg, TIMER_CTRL);
+	writel(reg, wdt_reg + TIMER_CTRL);
 
 	spin_unlock(&wdt_lock);
 }
@@ -102,7 +103,7 @@ static void orion_wdt_disable(void)
 static int orion_wdt_get_timeleft(int *time_left)
 {
 	spin_lock(&wdt_lock);
-	*time_left = readl(WDT_VAL) / wdt_tclk;
+	*time_left = readl(wdt_reg + WDT_VAL) / wdt_tclk;
 	spin_unlock(&wdt_lock);
 	return 0;
 }
@@ -236,6 +237,7 @@ static struct miscdevice orion_wdt_miscdev = {
 static int __devinit orion_wdt_probe(struct platform_device *pdev)
 {
 	struct orion_wdt_platform_data *pdata = pdev->dev.platform_data;
+	struct resource *res;
 	int ret;
 
 	if (pdata) {
@@ -245,6 +247,10 @@ static int __devinit orion_wdt_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	wdt_reg = ioremap(res->start, resource_size(res));
+
 	if (orion_wdt_miscdev.parent)
 		return -EBUSY;
 	orion_wdt_miscdev.parent = &pdev->dev;
-- 
1.7.3.4
