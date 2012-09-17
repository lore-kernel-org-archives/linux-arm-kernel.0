From: robherring2@gmail.com (Rob Herring)
Date: Mon, 17 Sep 2012 09:55:12 -0500
Subject: [PATCH] ARM: highbank: call highbank_pm_init from .init_machine
Message-ID: <1347893712-21819-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Being a module_init call, highbank_pm_init will cause problem with
multi-platform build running on other platforms.  Call it from
.init_machine instead.

Reported-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
Arnd, Olof,

Can you please apply this to the multi-platform branch or I can send an updated
pull request if you prefer.

Rob

 arch/arm/mach-highbank/core.h     |    6 ++++++
 arch/arm/mach-highbank/highbank.c |    1 +
 arch/arm/mach-highbank/pm.c       |    4 +---
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-highbank/core.h b/arch/arm/mach-highbank/core.h
index 141ed51..8b9fb1a 100644
--- a/arch/arm/mach-highbank/core.h
+++ b/arch/arm/mach-highbank/core.h
@@ -8,4 +8,10 @@ extern void highbank_lluart_map_io(void);
 static inline void highbank_lluart_map_io(void) {}
 #endif
 
+#ifdef CONFIG_PM_SLEEP
+extern void highbank_pm_init(void);
+#else
+static inline void highbank_pm_init(void) {}
+#endif
+
 extern void highbank_smc1(int fn, int arg);
diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index d75b0a7..f376c26 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -152,6 +152,7 @@ static void highbank_power_off(void)
 static void __init highbank_init(void)
 {
 	pm_power_off = highbank_power_off;
+	highbank_pm_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
diff --git a/arch/arm/mach-highbank/pm.c b/arch/arm/mach-highbank/pm.c
index 33b3beb..de866f2 100644
--- a/arch/arm/mach-highbank/pm.c
+++ b/arch/arm/mach-highbank/pm.c
@@ -47,9 +47,7 @@ static const struct platform_suspend_ops highbank_pm_ops = {
 	.valid = suspend_valid_only_mem,
 };
 
-static int __init highbank_pm_init(void)
+void __init highbank_pm_init(void)
 {
 	suspend_set_ops(&highbank_pm_ops);
-	return 0;
 }
-module_init(highbank_pm_init);
-- 
1.7.9.5
