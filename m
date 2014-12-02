From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 2 Dec 2014 18:27:24 +0100
Subject: [PATCH 4/8] ARM: at91: at91rm9200 ST initialization is now DT only
In-Reply-To: <e093d7cf37ec9ff24b0631b0a2e405a7cf7574db.1417541118.git.nicolas.ferre@atmel.com>
References: <e093d7cf37ec9ff24b0631b0a2e405a7cf7574db.1417541118.git.nicolas.ferre@atmel.com>
Message-ID: <8117bf17fe1a2a37ba33d71e59597c0f2261ad92.1417541118.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

As at91rm9200 is now DT only, there is no need to keep old entry point in this
at91rm9200 System Timer (ST) driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[nicolas.ferre at atmel.com: split patch]
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91rm9200_time.c | 23 -----------------------
 arch/arm/mach-at91/board-dt-rm9200.c |  2 --
 arch/arm/mach-at91/generic.h         |  2 --
 3 files changed, 27 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/arch/arm/mach-at91/at91rm9200_time.c
index 7fd13aef9827..51761f8927b7 100644
--- a/arch/arm/mach-at91/at91rm9200_time.c
+++ b/arch/arm/mach-at91/at91rm9200_time.c
@@ -183,7 +183,6 @@ static struct clock_event_device clkevt = {
 void __iomem *at91_st_base;
 EXPORT_SYMBOL_GPL(at91_st_base);
 
-#ifdef CONFIG_OF
 static struct of_device_id at91rm9200_st_timer_ids[] = {
 	{ .compatible = "atmel,at91rm9200-st" },
 	{ /* sentinel */ }
@@ -219,28 +218,6 @@ node_err:
 err:
 	return -EINVAL;
 }
-#else
-static int __init of_at91rm9200_st_init(void)
-{
-	return -EINVAL;
-}
-#endif
-
-void __init at91rm9200_ioremap_st(u32 addr)
-{
-#ifdef CONFIG_OF
-	struct device_node *np;
-
-	np = of_find_matching_node(NULL, at91rm9200_st_timer_ids);
-	if (np) {
-		of_node_put(np);
-		return;
-	}
-#endif
-	at91_st_base = ioremap(addr, 256);
-	if (!at91_st_base)
-		panic("Impossible to ioremap ST\n");
-}
 
 /*
  * ST (system timer) module supports both clockevents and clocksource.
diff --git a/arch/arm/mach-at91/board-dt-rm9200.c b/arch/arm/mach-at91/board-dt-rm9200.c
index feeb1a0f258e..76dfe8f9af50 100644
--- a/arch/arm/mach-at91/board-dt-rm9200.c
+++ b/arch/arm/mach-at91/board-dt-rm9200.c
@@ -26,9 +26,7 @@
 
 static void __init at91rm9200_dt_timer_init(void)
 {
-#if defined(CONFIG_COMMON_CLK)
 	of_clk_init(NULL);
-#endif
 	at91rm9200_timer_init();
 }
 
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 13c5b255e335..8527e8bd675f 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -30,8 +30,6 @@ extern void __init at91_sysirq_mask_rtc(u32 rtc_base);
 extern void __init at91_sysirq_mask_rtt(u32 rtt_base);
 
  /* Timer */
-extern void __init at91_init_time(void);
-extern void at91rm9200_ioremap_st(u32 addr);
 extern void at91rm9200_timer_init(void);
 extern void at91sam926x_ioremap_pit(u32 addr);
 extern void at91sam926x_pit_init(int irq);
-- 
2.1.3
