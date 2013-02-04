From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon,  4 Feb 2013 23:32:39 +0100
Subject: [PATCH] sunxi: Cleanup the reset code and add meaningful registers
 defines
Message-ID: <1360017159-24318-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/sunxi.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index 1dc8a92..f9555c3 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -29,7 +29,10 @@
 #include "sunxi.h"
 
 #define WATCHDOG_CTRL_REG	0x00
+#define WATCHDOG_CTRL_RESTART		(1 << 0)
 #define WATCHDOG_MODE_REG	0x04
+#define WATCHDOG_MODE_ENABLE		(1 << 0)
+#define WATCHDOG_MODE_RESET_ENABLE	(1 << 1)
 
 static void __iomem *wdt_base;
 
@@ -50,11 +53,19 @@ static void sunxi_restart(char mode, const char *cmd)
 		return;
 
 	/* Enable timer and set reset bit in the watchdog */
-	writel(3, wdt_base + WATCHDOG_MODE_REG);
-	writel(0xa57 << 1 | 1, wdt_base + WATCHDOG_CTRL_REG);
-	while(1) {
+	writel(WATCHDOG_MODE_ENABLE | WATCHDOG_MODE_RESET_ENABLE,
+		wdt_base + WATCHDOG_MODE_REG);
+
+	/*
+	 * Restart the watchdog. The default (and lowest) interval
+	 * value for the watchdog is 0.5s.
+	 */
+	writel(WATCHDOG_CTRL_RESTART, wdt_base + WATCHDOG_CTRL_REG);
+
+	while (1) {
 		mdelay(5);
-		writel(3, wdt_base + WATCHDOG_MODE_REG);
+		writel(WATCHDOG_MODE_ENABLE | WATCHDOG_MODE_RESET_ENABLE,
+			wdt_base + WATCHDOG_MODE_REG);
 	}
 }
 
-- 
1.7.10.4
