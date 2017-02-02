From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  2 Feb 2017 15:45:20 +0100
Subject: [PATCH 10/13] ARM: at91: pm: merge all at91sam9*_pm_init
In-Reply-To: <20170202144523.11706-1-alexandre.belloni@free-electrons.com>
References: <20170202144523.11706-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170202144523.11706-11-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PM initialization is now identical for all at91sam9. Merge the
functions.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/at91sam9.c | 45 +++----------------------------------------
 arch/arm/mach-at91/generic.h  |  8 ++------
 arch/arm/mach-at91/pm.c       | 14 +-------------
 3 files changed, 6 insertions(+), 61 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9.c b/arch/arm/mach-at91/at91sam9.c
index ba28e9cc584d..c089bfd0dc2f 100644
--- a/arch/arm/mach-at91/at91sam9.c
+++ b/arch/arm/mach-at91/at91sam9.c
@@ -52,7 +52,7 @@ static const struct at91_soc at91sam9_socs[] = {
 	{ /* sentinel */ },
 };
 
-static void __init at91sam9_common_init(void)
+static void __init at91sam9_init(void)
 {
 	struct soc_device *soc;
 	struct device *soc_dev = NULL;
@@ -62,12 +62,8 @@ static void __init at91sam9_common_init(void)
 		soc_dev = soc_device_to_device(soc);
 
 	of_platform_default_populate(NULL, NULL, soc_dev);
-}
 
-static void __init at91sam9_dt_device_init(void)
-{
-	at91sam9_common_init();
-	at91sam9260_pm_init();
+	at91sam9_pm_init();
 }
 
 static const char *const at91_dt_board_compat[] __initconst = {
@@ -77,41 +73,6 @@ static const char *const at91_dt_board_compat[] __initconst = {
 
 DT_MACHINE_START(at91sam_dt, "Atmel AT91SAM9")
 	/* Maintainer: Atmel */
-	.init_machine	= at91sam9_dt_device_init,
+	.init_machine	= at91sam9_init,
 	.dt_compat	= at91_dt_board_compat,
 MACHINE_END
-
-static void __init at91sam9g45_dt_device_init(void)
-{
-	at91sam9_common_init();
-	at91sam9g45_pm_init();
-}
-
-static const char *const at91sam9g45_board_compat[] __initconst = {
-	"atmel,at91sam9g45",
-	NULL
-};
-
-DT_MACHINE_START(at91sam9g45_dt, "Atmel AT91SAM9G45")
-	/* Maintainer: Atmel */
-	.init_machine	= at91sam9g45_dt_device_init,
-	.dt_compat	= at91sam9g45_board_compat,
-MACHINE_END
-
-static void __init at91sam9x5_dt_device_init(void)
-{
-	at91sam9_common_init();
-	at91sam9x5_pm_init();
-}
-
-static const char *const at91sam9x5_board_compat[] __initconst = {
-	"atmel,at91sam9x5",
-	"atmel,at91sam9n12",
-	NULL
-};
-
-DT_MACHINE_START(at91sam9x5_dt, "Atmel AT91SAM9")
-	/* Maintainer: Atmel */
-	.init_machine	= at91sam9x5_dt_device_init,
-	.dt_compat	= at91sam9x5_board_compat,
-MACHINE_END
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 28ca57a2060f..f1ead0f13c19 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -13,15 +13,11 @@
 
 #ifdef CONFIG_PM
 extern void __init at91rm9200_pm_init(void);
-extern void __init at91sam9260_pm_init(void);
-extern void __init at91sam9g45_pm_init(void);
-extern void __init at91sam9x5_pm_init(void);
+extern void __init at91sam9_pm_init(void);
 extern void __init sama5_pm_init(void);
 #else
 static inline void __init at91rm9200_pm_init(void) { }
-static inline void __init at91sam9260_pm_init(void) { }
-static inline void __init at91sam9g45_pm_init(void) { }
-static inline void __init at91sam9x5_pm_init(void) { }
+static inline void __init at91sam9_pm_init(void) { }
 static inline void __init sama5_pm_init(void) { }
 #endif
 
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index c0ef1742135c..009b57f3a62e 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -488,19 +488,7 @@ void __init at91rm9200_pm_init(void)
 	at91_pm_init(at91rm9200_idle);
 }
 
-void __init at91sam9260_pm_init(void)
-{
-	at91_dt_ramc();
-	at91_pm_init(at91sam9_idle);
-}
-
-void __init at91sam9g45_pm_init(void)
-{
-	at91_dt_ramc();
-	at91_pm_init(at91sam9_idle);
-}
-
-void __init at91sam9x5_pm_init(void)
+void __init at91sam9_pm_init(void)
 {
 	at91_dt_ramc();
 	at91_pm_init(at91sam9_idle);
-- 
2.11.0
