From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 30 Sep 2015 18:11:06 +0200
Subject: [PATCH 13/16] ARM: at91: pm: move idle functions to pm.c
In-Reply-To: <1443629469-15086-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1443629469-15086-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1443629469-15086-14-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid using code from clk/at91 for PM.
This also has the bonus effect of setting arm_pm_idle for sama5 platforms.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/at91rm9200.c |  2 --
 arch/arm/mach-at91/at91sam9.c   |  2 --
 arch/arm/mach-at91/generic.h    |  6 ++----
 arch/arm/mach-at91/pm.c         | 37 ++++++++++++++++++++++++++++++++-----
 arch/arm/mach-at91/sama5.c      |  2 +-
 drivers/clk/at91/pmc.c          | 15 ---------------
 6 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index c1a7c6cc00e1..63b4fa25b48a 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -12,7 +12,6 @@
 #include <linux/of_platform.h>
 
 #include <asm/mach/arch.h>
-#include <asm/system_misc.h>
 
 #include "generic.h"
 #include "soc.h"
@@ -33,7 +32,6 @@ static void __init at91rm9200_dt_device_init(void)
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, soc_dev);
 
-	arm_pm_idle = at91rm9200_idle;
 	at91rm9200_pm_init();
 }
 
diff --git a/arch/arm/mach-at91/at91sam9.c b/arch/arm/mach-at91/at91sam9.c
index 7eb64f763034..cada2a6412b3 100644
--- a/arch/arm/mach-at91/at91sam9.c
+++ b/arch/arm/mach-at91/at91sam9.c
@@ -62,8 +62,6 @@ static void __init at91sam9_common_init(void)
 		soc_dev = soc_device_to_device(soc);
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, soc_dev);
-
-	arm_pm_idle = at91sam9_idle;
 }
 
 static void __init at91sam9_dt_device_init(void)
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index b0fa7dc7286d..d224e195706a 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -18,20 +18,18 @@
 extern void __init at91_map_io(void);
 extern void __init at91_alt_map_io(void);
 
-/* idle */
-extern void at91rm9200_idle(void);
-extern void at91sam9_idle(void);
-
 #ifdef CONFIG_PM
 extern void __init at91rm9200_pm_init(void);
 extern void __init at91sam9260_pm_init(void);
 extern void __init at91sam9g45_pm_init(void);
 extern void __init at91sam9x5_pm_init(void);
+extern void __init sama5_pm_init(void);
 #else
 static inline void __init at91rm9200_pm_init(void) { }
 static inline void __init at91sam9260_pm_init(void) { }
 static inline void __init at91sam9g45_pm_init(void) { }
 static inline void __init at91sam9x5_pm_init(void) { }
+static inline void __init sama5_pm_init(void) { }
 #endif
 
 #endif /* _AT91_GENERIC_H */
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 1dee29b33ff9..34f7f034c589 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -31,6 +31,7 @@
 #include <asm/mach/irq.h>
 #include <asm/fncpy.h>
 #include <asm/cacheflush.h>
+#include <asm/system_misc.h>
 
 #include "generic.h"
 #include "pm.h"
@@ -349,6 +350,21 @@ static __init void at91_dt_ramc(void)
 	at91_pm_set_standby(standby);
 }
 
+void at91rm9200_idle(void)
+{
+	/*
+	 * Disable the processor clock.  The processor will be automatically
+	 * re-enabled by an interrupt or by a reset.
+	 */
+	writel(AT91_PMC_PCK, pmc + AT91_PMC_SCDR);
+}
+
+void at91sam9_idle(void)
+{
+	writel(AT91_PMC_PCK, pmc + AT91_PMC_SCDR);
+	cpu_do_idle();
+}
+
 static void __init at91_pm_sram_init(void)
 {
 	struct gen_pool *sram_pool;
@@ -405,7 +421,7 @@ static const struct of_device_id atmel_pmc_ids[] = {
 	{ /* sentinel */ },
 };
 
-static void __init at91_pm_init(void)
+static void __init at91_pm_init(void (*pm_idle)(void))
 {
 	struct device_node *pmc_np;
 
@@ -419,6 +435,9 @@ static void __init at91_pm_init(void)
 		return;
 	}
 
+	if (pm_idle)
+		arm_pm_idle = pm_idle;
+
 	at91_pm_sram_init();
 
 	if (at91_suspend_sram_fn)
@@ -439,7 +458,7 @@ void __init at91rm9200_pm_init(void)
 	at91_pm_data.uhp_udp_mask = AT91RM9200_PMC_UHP | AT91RM9200_PMC_UDP;
 	at91_pm_data.memctrl = AT91_MEMCTRL_MC;
 
-	at91_pm_init();
+	at91_pm_init(at91rm9200_idle);
 }
 
 void __init at91sam9260_pm_init(void)
@@ -447,7 +466,7 @@ void __init at91sam9260_pm_init(void)
 	at91_dt_ramc();
 	at91_pm_data.memctrl = AT91_MEMCTRL_SDRAMC;
 	at91_pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP;
-	at91_pm_init();
+	at91_pm_init(at91sam9_idle);
 }
 
 void __init at91sam9g45_pm_init(void)
@@ -455,7 +474,7 @@ void __init at91sam9g45_pm_init(void)
 	at91_dt_ramc();
 	at91_pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP;
 	at91_pm_data.memctrl = AT91_MEMCTRL_DDRSDR;
-	at91_pm_init();
+	at91_pm_init(at91sam9_idle);
 }
 
 void __init at91sam9x5_pm_init(void)
@@ -463,5 +482,13 @@ void __init at91sam9x5_pm_init(void)
 	at91_dt_ramc();
 	at91_pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP;
 	at91_pm_data.memctrl = AT91_MEMCTRL_DDRSDR;
-	at91_pm_init();
+	at91_pm_init(at91sam9_idle);
+}
+
+void __init sama5_pm_init(void)
+{
+	at91_dt_ramc();
+	at91_pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP;
+	at91_pm_data.memctrl = AT91_MEMCTRL_DDRSDR;
+	at91_pm_init(NULL);
 }
diff --git a/arch/arm/mach-at91/sama5.c b/arch/arm/mach-at91/sama5.c
index d9cf6799aec0..df8fdf1cf66d 100644
--- a/arch/arm/mach-at91/sama5.c
+++ b/arch/arm/mach-at91/sama5.c
@@ -51,7 +51,7 @@ static void __init sama5_dt_device_init(void)
 		soc_dev = soc_device_to_device(soc);
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, soc_dev);
-	at91sam9x5_pm_init();
+	sama5_pm_init();
 }
 
 static const char *const sama5_dt_board_compat[] __initconst = {
diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 3aa886849304..3e150967b45e 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -44,21 +44,6 @@ struct at91_pmc {
 void __iomem *at91_pmc_base;
 EXPORT_SYMBOL_GPL(at91_pmc_base);
 
-void at91rm9200_idle(void)
-{
-	/*
-	 * Disable the processor clock.  The processor will be automatically
-	 * re-enabled by an interrupt or by a reset.
-	 */
-	at91_pmc_write(AT91_PMC_SCDR, AT91_PMC_PCK);
-}
-
-void at91sam9_idle(void)
-{
-	at91_pmc_write(AT91_PMC_SCDR, AT91_PMC_PCK);
-	cpu_do_idle();
-}
-
 int of_at91_get_clk_range(struct device_node *np, const char *propname,
 			  struct clk_range *range)
 {
-- 
2.1.4
