From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 26 May 2014 17:19:03 +0200
Subject: [PATCH] ARM: sunxi: allow building without reset controller
Message-ID: <4307148.6KkdViVLZk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sunxi reset controller code is only used with sun6i (a31).
After the platform has been split up into per-soc options, it's
now possible to build it without the reset controller code, so
the base platform init must not call into the reset driver
if that is turned off at compile time.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index ff2e6a4..3f9587b 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -35,7 +35,8 @@ extern void __init sun6i_reset_init(void);
 static void __init sun6i_timer_init(void)
 {
 	of_clk_init(NULL);
-	sun6i_reset_init();
+	if (IS_ENABLED(CONFIG_RESET_CONTROLLER))
+		sun6i_reset_init();
 	clocksource_of_init();
 }
 
