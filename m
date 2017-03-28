From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 28 Mar 2017 13:19:30 +0200
Subject: [PATCH v2 03/11] ARM: at91: pm: Move global variables into
 at91_pm_data
In-Reply-To: <20170328111938.21297-1-alexandre.belloni@free-electrons.com>
References: <20170328111938.21297-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170328111938.21297-4-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of having separate global variables to hold IP addresses, move them
to struct at91_pm_data.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/pm.c | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 41789aa4df86..c780dda3b604 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -26,8 +26,6 @@
 #include "generic.h"
 #include "pm.h"
 
-static void __iomem *pmc;
-
 /*
  * FIXME: this is needed to communicate between the pinctrl driver and
  * the PM implementation in the machine. Possibly part of the PM
@@ -40,17 +38,17 @@ extern void at91_pinctrl_gpio_resume(void);
 #endif
 
 static struct {
+	void __iomem *pmc;
+	void __iomem *ramc[2];
 	unsigned long uhp_udp_mask;
 	int memctrl;
 } at91_pm_data;
 
-static void __iomem *at91_ramc_base[2];
 #define at91_ramc_read(id, field) \
-	__raw_readl(at91_ramc_base[id] + field)
+	__raw_readl(at91_pm_data.ramc[id] + field)
 
 #define at91_ramc_write(id, field, value) \
-	__raw_writel(value, at91_ramc_base[id] + field)
-
+	__raw_writel(value, at91_pm_data.ramc[id] + field)
 
 static int at91_pm_valid_state(suspend_state_t state)
 {
@@ -86,7 +84,7 @@ static int at91_pm_verify_clocks(void)
 	unsigned long scsr;
 	int i;
 
-	scsr = readl(pmc + AT91_PMC_SCSR);
+	scsr = readl(at91_pm_data.pmc + AT91_PMC_SCSR);
 
 	/* USB must not be using PLLB */
 	if ((scsr & at91_pm_data.uhp_udp_mask) != 0) {
@@ -100,7 +98,7 @@ static int at91_pm_verify_clocks(void)
 
 		if ((scsr & (AT91_PMC_PCK0 << i)) == 0)
 			continue;
-		css = readl(pmc + AT91_PMC_PCKR(i)) & AT91_PMC_CSS;
+		css = readl(at91_pm_data.pmc + AT91_PMC_PCKR(i)) & AT91_PMC_CSS;
 		if (css != AT91_PMC_CSS_SLOW) {
 			pr_err("AT91: PM - Suspend-to-RAM with PCK%d src %d\n", i, css);
 			return 0;
@@ -143,8 +141,8 @@ static void at91_pm_suspend(suspend_state_t state)
 	flush_cache_all();
 	outer_disable();
 
-	at91_suspend_sram_fn(pmc, at91_ramc_base[0],
-			     at91_ramc_base[1], pm_data);
+	at91_suspend_sram_fn(at91_pm_data.pmc, at91_pm_data.ramc[0],
+			     at91_pm_data.ramc[1], pm_data);
 
 	outer_resume();
 }
@@ -247,7 +245,7 @@ static void at91rm9200_standby(void)
 		"    mcr    p15, 0, %0, c7, c0, 4\n\t"
 		"    str    %5, [%1, %2]"
 		:
-		: "r" (0), "r" (at91_ramc_base[0]), "r" (AT91_MC_SDRAMC_LPR),
+		: "r" (0), "r" (at91_pm_data.ramc[0]), "r" (AT91_MC_SDRAMC_LPR),
 		  "r" (1), "r" (AT91_MC_SDRAMC_SRR),
 		  "r" (lpr));
 }
@@ -262,7 +260,7 @@ static void at91_ddr_standby(void)
 	u32 lpr0, lpr1 = 0;
 	u32 saved_lpr0, saved_lpr1 = 0;
 
-	if (at91_ramc_base[1]) {
+	if (at91_pm_data.ramc[1]) {
 		saved_lpr1 = at91_ramc_read(1, AT91_DDRSDRC_LPR);
 		lpr1 = saved_lpr1 & ~AT91_DDRSDRC_LPCB;
 		lpr1 |= AT91_DDRSDRC_LPCB_SELF_REFRESH;
@@ -274,13 +272,13 @@ static void at91_ddr_standby(void)
 
 	/* self-refresh mode now */
 	at91_ramc_write(0, AT91_DDRSDRC_LPR, lpr0);
-	if (at91_ramc_base[1])
+	if (at91_pm_data.ramc[1])
 		at91_ramc_write(1, AT91_DDRSDRC_LPR, lpr1);
 
 	cpu_do_idle();
 
 	at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr0);
-	if (at91_ramc_base[1])
+	if (at91_pm_data.ramc[1])
 		at91_ramc_write(1, AT91_DDRSDRC_LPR, saved_lpr1);
 }
 
@@ -308,7 +306,7 @@ static void at91sam9_sdram_standby(void)
 	u32 lpr0, lpr1 = 0;
 	u32 saved_lpr0, saved_lpr1 = 0;
 
-	if (at91_ramc_base[1]) {
+	if (at91_pm_data.ramc[1]) {
 		saved_lpr1 = at91_ramc_read(1, AT91_SDRAMC_LPR);
 		lpr1 = saved_lpr1 & ~AT91_SDRAMC_LPCB;
 		lpr1 |= AT91_SDRAMC_LPCB_SELF_REFRESH;
@@ -320,13 +318,13 @@ static void at91sam9_sdram_standby(void)
 
 	/* self-refresh mode now */
 	at91_ramc_write(0, AT91_SDRAMC_LPR, lpr0);
-	if (at91_ramc_base[1])
+	if (at91_pm_data.ramc[1])
 		at91_ramc_write(1, AT91_SDRAMC_LPR, lpr1);
 
 	cpu_do_idle();
 
 	at91_ramc_write(0, AT91_SDRAMC_LPR, saved_lpr0);
-	if (at91_ramc_base[1])
+	if (at91_pm_data.ramc[1])
 		at91_ramc_write(1, AT91_SDRAMC_LPR, saved_lpr1);
 }
 
@@ -346,8 +344,8 @@ static __init void at91_dt_ramc(void)
 	const void *standby = NULL;
 
 	for_each_matching_node_and_match(np, ramc_ids, &of_id) {
-		at91_ramc_base[idx] = of_iomap(np, 0);
-		if (!at91_ramc_base[idx])
+		at91_pm_data.ramc[idx] = of_iomap(np, 0);
+		if (!at91_pm_data.ramc[idx])
 			panic(pr_fmt("unable to map ramc[%d] cpu registers\n"), idx);
 
 		if (!standby)
@@ -373,12 +371,12 @@ static void at91rm9200_idle(void)
 	 * Disable the processor clock.  The processor will be automatically
 	 * re-enabled by an interrupt or by a reset.
 	 */
-	writel(AT91_PMC_PCK, pmc + AT91_PMC_SCDR);
+	writel(AT91_PMC_PCK, at91_pm_data.pmc + AT91_PMC_SCDR);
 }
 
 static void at91sam9_idle(void)
 {
-	writel(AT91_PMC_PCK, pmc + AT91_PMC_SCDR);
+	writel(AT91_PMC_PCK, at91_pm_data.pmc + AT91_PMC_SCDR);
 	cpu_do_idle();
 }
 
@@ -447,8 +445,8 @@ static void __init at91_pm_init(void (*pm_idle)(void))
 		platform_device_register(&at91_cpuidle_device);
 
 	pmc_np = of_find_matching_node(NULL, atmel_pmc_ids);
-	pmc = of_iomap(pmc_np, 0);
-	if (!pmc) {
+	at91_pm_data.pmc = of_iomap(pmc_np, 0);
+	if (!at91_pm_data.pmc) {
 		pr_err("AT91: PM not supported, PMC not found\n");
 		return;
 	}
-- 
2.11.0
