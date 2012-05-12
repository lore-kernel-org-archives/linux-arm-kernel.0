From: linux-arm@overkiz.com (Boris BREZILLON)
Date: Sat, 12 May 2012 10:53:58 +0200
Subject: [PATCH 5/5] ARM: at91: Modify board_dt init sequence
In-Reply-To: <1336812838-3649-1-git-send-email-linux-arm@overkiz.com>
References: <1336812838-3649-1-git-send-email-linux-arm@overkiz.com>
Message-ID: <1336812838-3649-6-git-send-email-linux-arm@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies the init sequence defined by board_dt machine.
PMC common clk implementation needs the slab allocator to be up => late_time_init.
GPIO needs the GPIO periph clks => after clk inits.
GPIO irq init needs the GPIO chips => after GPIO inits.


---
 arch/arm/mach-at91/board-dt.c |   72 +++++++++++++++++++++++++++++++++++++++--
 arch/arm/mach-at91/setup.c    |    8 ++---
 2 files changed, 74 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-at91/board-dt.c b/arch/arm/mach-at91/board-dt.c
index a1fce05..b12d43f 100644
--- a/arch/arm/mach-at91/board-dt.c
+++ b/arch/arm/mach-at91/board-dt.c
@@ -22,6 +22,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
+#include <asm/mach/time.h>
 
 #include "generic.h"
 
@@ -29,6 +30,11 @@
 static const struct of_device_id irq_of_match[] __initconst = {
 
 	{ .compatible = "atmel,at91rm9200-aic", .data = at91_aic_of_init },
+	{ /*sentinel*/ }
+};
+
+static const struct of_device_id gpio_irq_of_match[] __initconst = {
+
 	{ .compatible = "atmel,at91rm9200-gpio", .data = at91_gpio_of_irq_setup },
 	{ .compatible = "atmel,at91sam9x5-gpio", .data = at91_gpio_of_irq_setup },
 	{ /*sentinel*/ }
@@ -49,11 +55,73 @@ static const char *at91_dt_board_compat[] __initdata = {
 	NULL
 };
 
+static void __init at91_dt_late_time_init(void);
+
+static void __init at91_dt_timer_init(void) {
+	late_time_init = at91_dt_late_time_init;
+}
+
+struct sys_timer at91_dt_timer = {
+	.init = at91_dt_timer_init,
+};
+
+extern void __init at91_pmc_of_init(struct device_node *np);
+
+static const struct of_device_id clk_of_match[] __initconst = {
+
+	{ .compatible = "atmel,at91-pmc", .data = at91_pmc_of_init },
+	{ /*sentinel*/ }
+};
+
+static const struct of_device_id timer_of_match[] __initconst = {
+
+	{ .compatible = "atmel,at91sam9260-pit", .data = &at91sam926x_timer },
+	{ /*sentinel*/ }
+};
+
+static void __init at91_dt_late_time_init(void) {
+	struct device_node *np = NULL;
+	const struct of_device_id *match;
+	struct sys_timer *timer;
+	void (*init_fn) (struct device_node *np);
+
+	np = of_find_matching_node(NULL, clk_of_match);
+	if (!np)
+		panic("unable to find compatible clock controller node in dtb\n");
+
+	match = of_match_node(clk_of_match, np);
+	init_fn = match->data;
+	init_fn(np);
+
+	of_node_put(np);
+
+	at91_dt_initialize();
+
+	of_irq_init(gpio_irq_of_match);
+
+	np = of_find_matching_node(NULL, timer_of_match);
+	if (!np)
+		panic("unable to find compatible sys timer node in dtb\n");
+
+	match = of_match_node(timer_of_match, np);
+
+	timer = match->data;
+	timer->init();
+	at91_dt_timer.suspend = timer->suspend;
+	at91_dt_timer.resume = timer->resume;
+#ifdef CONFIG_ARCH_USES_GETTIMEOFFSET
+	at91_dt_timer.offset = timer->offset;
+#endif
+
+	of_node_put(np);
+}
+
+
 DT_MACHINE_START(at91sam_dt, "Atmel AT91SAM (Device Tree)")
 	/* Maintainer: Atmel */
-	.timer		= &at91sam926x_timer,
+	.timer		= &at91_dt_timer,
 	.map_io		= at91_map_io,
-	.init_early	= at91_dt_initialize,
+/*	.init_early	= at91_dt_initialize, */
 	.init_irq	= at91_dt_init_irq,
 	.init_machine	= at91_dt_device_init,
 	.dt_compat	= at91_dt_board_compat,
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index 97cc04d..ac3ee48 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -435,15 +435,14 @@ void __init at91_dt_initialize(void)
 	at91_dt_shdwc();
 
 	/* Init clock subsystem */
-	at91_dt_clock_init();
+	/*at91_dt_clock_init();*/
 
 	/* Register the processor-specific clocks */
-	at91_boot_soc.register_clocks();
+	/*at91_boot_soc.register_clocks();*/
 
 	at91_boot_soc.init();
 }
-#endif
-
+#else
 void __init at91_initialize(unsigned long main_clock)
 {
 	at91_boot_soc.ioremap_registers();
@@ -456,3 +455,4 @@ void __init at91_initialize(unsigned long main_clock)
 
 	at91_boot_soc.init();
 }
+#endif
-- 
1.7.9.5
