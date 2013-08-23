From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 23 Aug 2013 19:12:15 -0300
Subject: [PATCH v2 2/9] watchdog: orion: Make counter register a separate
 resource
In-Reply-To: <1377295942-5955-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377295942-5955-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1377295942-5955-3-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support other SoC, it's required to distinguish
the 'control' timer register, from the 'counter' watchdog register
as different memory resources.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-dove/include/mach/bridge-regs.h     |  1 +
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h |  1 +
 arch/arm/mach-mv78xx0/include/mach/bridge-regs.h  |  1 +
 arch/arm/mach-orion5x/include/mach/bridge-regs.h  |  1 +
 arch/arm/plat-orion/common.c                      | 10 ++++++----
 drivers/watchdog/orion_wdt.c                      | 15 +++++++++++----
 6 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-dove/include/mach/bridge-regs.h b/arch/arm/mach-dove/include/mach/bridge-regs.h
index 5362df3..a0ddc94 100644
--- a/arch/arm/mach-dove/include/mach/bridge-regs.h
+++ b/arch/arm/mach-dove/include/mach/bridge-regs.h
@@ -52,5 +52,6 @@
 
 #define TIMER_VIRT_BASE		(BRIDGE_VIRT_BASE + 0x0300)
 #define TIMER_PHYS_BASE         (BRIDGE_PHYS_BASE + 0x0300)
+#define WDT_COUNTER_OFF		0x24
 
 #endif
diff --git a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
index 91242c9..05a1164 100644
--- a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
+++ b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
@@ -38,6 +38,7 @@
 
 #define TIMER_VIRT_BASE		(BRIDGE_VIRT_BASE + 0x0300)
 #define TIMER_PHYS_BASE		(BRIDGE_PHYS_BASE + 0x0300)
+#define WDT_COUNTER_OFF		0x24
 
 #define L2_CONFIG_REG		(BRIDGE_VIRT_BASE + 0x0128)
 #define L2_WRITETHROUGH		0x00000010
diff --git a/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h b/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h
index 5f03484..fa49bb6 100644
--- a/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h
+++ b/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h
@@ -32,5 +32,6 @@
 
 #define TIMER_VIRT_BASE		(BRIDGE_VIRT_BASE + 0x0300)
 #define TIMER_PHYS_BASE		(BRIDGE_PHYS_BASE + 0x0300)
+#define WDT_COUNTER_OFF		0x24
 
 #endif
diff --git a/arch/arm/mach-orion5x/include/mach/bridge-regs.h b/arch/arm/mach-orion5x/include/mach/bridge-regs.h
index f727d03..634ce6a 100644
--- a/arch/arm/mach-orion5x/include/mach/bridge-regs.h
+++ b/arch/arm/mach-orion5x/include/mach/bridge-regs.h
@@ -33,4 +33,5 @@
 
 #define TIMER_VIRT_BASE		(ORION5X_BRIDGE_VIRT_BASE + 0x300)
 #define TIMER_PHYS_BASE		(ORION5X_BRIDGE_PHYS_BASE + 0x300)
+#define WDT_COUNTER_OFF		0x24
 #endif
diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index c66d163..4e30ed6 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -594,14 +594,16 @@ void __init orion_spi_1_init(unsigned long mapbase)
 /*****************************************************************************
  * Watchdog
  ****************************************************************************/
-static struct resource orion_wdt_resource =
-		DEFINE_RES_MEM(TIMER_PHYS_BASE, 0x28);
+static struct resource orion_wdt_resource[] = {
+		DEFINE_RES_MEM(TIMER_PHYS_BASE, 0x04),
+		DEFINE_RES_MEM(TIMER_PHYS_BASE + WDT_COUNTER_OFF, 0x04),
+};
 
 static struct platform_device orion_wdt_device = {
 	.name		= "orion_wdt",
 	.id		= -1,
-	.num_resources	= 1,
-	.resource	= &orion_wdt_resource,
+	.num_resources	= ARRAY_SIZE(orion_wdt_resource),
+	.resource	= orion_wdt_resource,
 };
 
 void __init orion_wdt_init(void)
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 74d3b72..83350ad 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -32,7 +32,6 @@
  */
 #define TIMER_CTRL		0x0000
 #define WDT_EN			0x0010
-#define WDT_VAL			0x0024
 
 #define WDT_MAX_CYCLE_COUNT	0xffffffff
 #define WDT_IN_USE		0
@@ -46,6 +45,7 @@ static unsigned int wdt_max_duration;	/* (seconds) */
 static struct clk *clk;
 static unsigned int wdt_tclk;
 static void __iomem *wdt_reg;
+static void __iomem *wdt_val;
 static DEFINE_SPINLOCK(wdt_lock);
 
 static int orion_wdt_ping(struct watchdog_device *wdt_dev)
@@ -53,7 +53,7 @@ static int orion_wdt_ping(struct watchdog_device *wdt_dev)
 	spin_lock(&wdt_lock);
 
 	/* Reload watchdog duration */
-	writel(wdt_tclk * wdt_dev->timeout, wdt_reg + WDT_VAL);
+	writel(wdt_tclk * wdt_dev->timeout, wdt_val);
 
 	spin_unlock(&wdt_lock);
 	return 0;
@@ -66,7 +66,7 @@ static int orion_wdt_start(struct watchdog_device *wdt_dev)
 	spin_lock(&wdt_lock);
 
 	/* Set watchdog duration */
-	writel(wdt_tclk * wdt_dev->timeout, wdt_reg + WDT_VAL);
+	writel(wdt_tclk * wdt_dev->timeout, wdt_val);
 
 	/* Enable watchdog timer */
 	reg = readl(wdt_reg + TIMER_CTRL);
@@ -107,7 +107,7 @@ static unsigned int orion_wdt_get_timeleft(struct watchdog_device *wdt_dev)
 	unsigned int time_left;
 
 	spin_lock(&wdt_lock);
-	time_left = readl(wdt_reg + WDT_VAL) / wdt_tclk;
+	time_left = readl(wdt_val) / wdt_tclk;
 	spin_unlock(&wdt_lock);
 
 	return time_left;
@@ -160,6 +160,13 @@ static int orion_wdt_probe(struct platform_device *pdev)
 	if (!wdt_reg)
 		return -ENOMEM;
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res)
+		return -ENODEV;
+	wdt_val = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!wdt_val)
+		return -ENOMEM;
+
 	wdt_max_duration = WDT_MAX_CYCLE_COUNT / wdt_tclk;
 
 	orion_wdt.timeout = wdt_max_duration;
-- 
1.8.1.5
