From: chanho.min@lge.com (Chanho Min)
Date: Mon, 14 Apr 2014 16:38:53 +0900
Subject: [PATCH] arm64:init: Move of_clk_init to time_init
Message-ID: <1397461133-12143-1-git-send-email-chanho.min@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock providers should be initialized before clocksource_of_init.
If not, Clock source initialization can be fail to get the clock.

Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 arch/arm64/kernel/setup.c |    1 -
 arch/arm64/kernel/time.c  |    3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 720853f..93e7df89 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -393,7 +393,6 @@ void __init setup_arch(char **cmdline_p)
 
 static int __init arm64_device_init(void)
 {
-	of_clk_init(NULL);
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	return 0;
 }
diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
index 29c39d5..8799242 100644
--- a/arch/arm64/kernel/time.c
+++ b/arch/arm64/kernel/time.c
@@ -33,6 +33,7 @@
 #include <linux/irq.h>
 #include <linux/delay.h>
 #include <linux/clocksource.h>
+#include <linux/clk-provider.h>
 
 #include <clocksource/arm_arch_timer.h>
 
@@ -64,7 +65,7 @@ EXPORT_SYMBOL(profile_pc);
 void __init time_init(void)
 {
 	u32 arch_timer_rate;
-
+	of_clk_init(NULL);
 	clocksource_of_init();
 
 	arch_timer_rate = arch_timer_get_rate();
-- 
1.7.9.5
