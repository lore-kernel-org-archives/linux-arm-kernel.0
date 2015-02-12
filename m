From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 12 Feb 2015 10:49:37 +0800
Subject: [PATCH 6/6] pm: at91: remove the at91_xxx_standby() function
 definitions
In-Reply-To: <1423709123-8033-1-git-send-email-wenyou.yang@atmel.com>
References: <1423709123-8033-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1423709377-8273-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because the the suspend to standby mode uses the sram function,
these functions will not be used.

Remove the data member at91_xxx_standby() of struct ramc_ids.

Substitue at91_pm_suspend() for at91_xxx_standby() assigned to at91_cpuidle_device.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/pm.c |   35 +++++++----------
 arch/arm/mach-at91/pm.h |   97 -----------------------------------------------
 2 files changed, 14 insertions(+), 118 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 722f921..9075b41 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -42,7 +42,6 @@ static struct {
 	int memctrl;
 } at91_pm_data;
 
-static void (*at91_pm_standby)(void);
 void __iomem *at91_ramc_base[2];
 
 static int at91_pm_valid_state(suspend_state_t state)
@@ -217,19 +216,22 @@ static struct platform_device at91_cpuidle_device = {
 	.name = "cpuidle-at91",
 };
 
-void at91_pm_set_standby(void (*at91_standby)(void))
+static void at91_cpuidle_set_suspend(void (*at91_suspend)(void))
 {
-	if (at91_standby) {
-		at91_cpuidle_device.dev.platform_data = at91_standby;
-		at91_pm_standby = at91_standby;
-	}
+	if (at91_suspend)
+		at91_cpuidle_device.dev.platform_data = at91_suspend;
+}
+
+static void at91_cpuidle_suspend(void)
+{
+	at91_pm_suspend(PM_SUSPEND_STANDBY);
 }
 
 static struct of_device_id ramc_ids[] = {
-	{ .compatible = "atmel,at91rm9200-sdramc", .data = at91rm9200_standby },
-	{ .compatible = "atmel,at91sam9260-sdramc", .data = at91sam9_sdram_standby },
-	{ .compatible = "atmel,at91sam9g45-ddramc", .data = at91_ddr_standby },
-	{ .compatible = "atmel,sama5d3-ddramc", .data = at91_ddr_standby },
+	{ .compatible = "atmel,at91rm9200-sdramc" },
+	{ .compatible = "atmel,at91sam9260-sdramc" },
+	{ .compatible = "atmel,at91sam9g45-ddramc" },
+	{ .compatible = "atmel,sama5d3-ddramc" },
 	{ /*sentinel*/ }
 };
 
@@ -238,28 +240,17 @@ static void at91_dt_ramc(void)
 	struct device_node *np;
 	const struct of_device_id *of_id;
 	int idx = 0;
-	const void *standby = NULL;
 
 	for_each_matching_node_and_match(np, ramc_ids, &of_id) {
 		at91_ramc_base[idx] = of_iomap(np, 0);
 		if (!at91_ramc_base[idx])
 			panic(pr_fmt("unable to map ramc[%d] cpu registers\n"), idx);
 
-		if (!standby)
-			standby = of_id->data;
-
 		idx++;
 	}
 
 	if (!idx)
 		panic(pr_fmt("unable to find compatible ram controller node in dtb\n"));
-
-	if (!standby) {
-		pr_warn("ramc no standby function available\n");
-		return;
-	}
-
-	at91_pm_set_standby(standby);
 }
 
 static void __init at91_pm_sram_init(void)
@@ -314,6 +305,8 @@ static void __init at91_pm_init(void)
 {
 	at91_pm_sram_init();
 
+	at91_cpuidle_set_suspend(at91_cpuidle_suspend);
+
 	if (at91_cpuidle_device.dev.platform_data)
 		platform_device_register(&at91_cpuidle_device);
 
diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index 4eef436..d7def22 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -12,7 +12,6 @@
 #define __ARCH_ARM_MACH_AT91_PM
 
 #include <asm/proc-fns.h>
-
 #include <mach/at91_ramc.h>
 
 #define	AT91_PM_MEMTYPE_MASK	0x0f
@@ -23,100 +22,4 @@
 
 #define	AT91_PM_SLOW_CLOCK	0x01
 
-#ifdef CONFIG_PM
-extern void at91_pm_set_standby(void (*at91_standby)(void));
-#else
-static inline void at91_pm_set_standby(void (*at91_standby)(void)) { }
-#endif
-
-/*
- * The AT91RM9200 goes into self-refresh mode with this command, and will
- * terminate self-refresh automatically on the next SDRAM access.
- *
- * Self-refresh mode is exited as soon as a memory access is made, but we don't
- * know for sure when that happens. However, we need to restore the low-power
- * mode if it was enabled before going idle. Restoring low-power mode while
- * still in self-refresh is "not recommended", but seems to work.
- */
-
-static inline void at91rm9200_standby(void)
-{
-	u32 lpr = at91_ramc_read(0, AT91RM9200_SDRAMC_LPR);
-
-	asm volatile(
-		"b    1f\n\t"
-		".align    5\n\t"
-		"1:  mcr    p15, 0, %0, c7, c10, 4\n\t"
-		"    str    %0, [%1, %2]\n\t"
-		"    str    %3, [%1, %4]\n\t"
-		"    mcr    p15, 0, %0, c7, c0, 4\n\t"
-		"    str    %5, [%1, %2]"
-		:
-		: "r" (0), "r" (AT91_BASE_SYS), "r" (AT91RM9200_SDRAMC_LPR),
-		  "r" (1), "r" (AT91RM9200_SDRAMC_SRR),
-		  "r" (lpr));
-}
-
-/* We manage both DDRAM/SDRAM controllers, we need more than one value to
- * remember.
- */
-static inline void at91_ddr_standby(void)
-{
-	/* Those two values allow us to delay self-refresh activation
-	 * to the maximum. */
-	u32 lpr0, lpr1 = 0;
-	u32 saved_lpr0, saved_lpr1 = 0;
-
-	if (at91_ramc_base[1]) {
-		saved_lpr1 = at91_ramc_read(1, AT91_DDRSDRC_LPR);
-		lpr1 = saved_lpr1 & ~AT91_DDRSDRC_LPCB;
-		lpr1 |= AT91_DDRSDRC_LPCB_SELF_REFRESH;
-	}
-
-	saved_lpr0 = at91_ramc_read(0, AT91_DDRSDRC_LPR);
-	lpr0 = saved_lpr0 & ~AT91_DDRSDRC_LPCB;
-	lpr0 |= AT91_DDRSDRC_LPCB_SELF_REFRESH;
-
-	/* self-refresh mode now */
-	at91_ramc_write(0, AT91_DDRSDRC_LPR, lpr0);
-	if (at91_ramc_base[1])
-		at91_ramc_write(1, AT91_DDRSDRC_LPR, lpr1);
-
-	cpu_do_idle();
-
-	at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr0);
-	if (at91_ramc_base[1])
-		at91_ramc_write(1, AT91_DDRSDRC_LPR, saved_lpr1);
-}
-
-/* We manage both DDRAM/SDRAM controllers, we need more than one value to
- * remember.
- */
-static inline void at91sam9_sdram_standby(void)
-{
-	u32 lpr0, lpr1 = 0;
-	u32 saved_lpr0, saved_lpr1 = 0;
-
-	if (at91_ramc_base[1]) {
-		saved_lpr1 = at91_ramc_read(1, AT91_SDRAMC_LPR);
-		lpr1 = saved_lpr1 & ~AT91_SDRAMC_LPCB;
-		lpr1 |= AT91_SDRAMC_LPCB_SELF_REFRESH;
-	}
-
-	saved_lpr0 = at91_ramc_read(0, AT91_SDRAMC_LPR);
-	lpr0 = saved_lpr0 & ~AT91_SDRAMC_LPCB;
-	lpr0 |= AT91_SDRAMC_LPCB_SELF_REFRESH;
-
-	/* self-refresh mode now */
-	at91_ramc_write(0, AT91_SDRAMC_LPR, lpr0);
-	if (at91_ramc_base[1])
-		at91_ramc_write(1, AT91_SDRAMC_LPR, lpr1);
-
-	cpu_do_idle();
-
-	at91_ramc_write(0, AT91_SDRAMC_LPR, saved_lpr0);
-	if (at91_ramc_base[1])
-		at91_ramc_write(1, AT91_SDRAMC_LPR, saved_lpr1);
-}
-
 #endif
-- 
1.7.9.5
