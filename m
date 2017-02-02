From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  2 Feb 2017 19:51:55 +0100
Subject: [PATCH 05/23] ARM: at91: sama5d2 backup
In-Reply-To: <20170202185213.21698-1-alexandre.belloni@free-electrons.com>
References: <20170202185213.21698-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170202185213.21698-5-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/generic.h    |   2 +
 arch/arm/mach-at91/pm.c         | 163 ++++++++++++++++++++++++++++++++--------
 arch/arm/mach-at91/pm.h         |  13 +---
 arch/arm/mach-at91/pm_suspend.S | 104 +++++++++++++++++--------
 arch/arm/mach-at91/sama5.c      |  26 ++++++-
 5 files changed, 233 insertions(+), 75 deletions(-)

diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 28ca57a2060f..d7161640b3c9 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -17,12 +17,14 @@ extern void __init at91sam9260_pm_init(void);
 extern void __init at91sam9g45_pm_init(void);
 extern void __init at91sam9x5_pm_init(void);
 extern void __init sama5_pm_init(void);
+extern void __init sama5d2_pm_init(void);
 #else
 static inline void __init at91rm9200_pm_init(void) { }
 static inline void __init at91sam9260_pm_init(void) { }
 static inline void __init at91sam9g45_pm_init(void) { }
 static inline void __init at91sam9x5_pm_init(void) { }
 static inline void __init sama5_pm_init(void) { }
+static inline void __init sama5d2_pm_init(void) { }
 #endif
 
 #endif /* _AT91_GENERIC_H */
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index b4332b727e9c..c849e3d676d0 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -22,7 +22,6 @@
 #include <linux/of_platform.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
-#include <linux/platform_data/atmel.h>
 #include <linux/io.h>
 #include <linux/clk/at91_pmc.h>
 
@@ -33,12 +32,11 @@
 #include <asm/fncpy.h>
 #include <asm/cacheflush.h>
 #include <asm/system_misc.h>
+#include <asm/suspend.h>
 
 #include "generic.h"
 #include "pm.h"
 
-static void __iomem *pmc;
-
 /*
  * FIXME: this is needed to communicate between the pinctrl driver and
  * the PM implementation in the machine. Possibly part of the PM
@@ -50,12 +48,22 @@ extern void at91_pinctrl_gpio_suspend(void);
 extern void at91_pinctrl_gpio_resume(void);
 #endif
 
+extern void at91_cpu_resume(void);
+
 static struct {
 	unsigned long uhp_udp_mask;
 	int memctrl;
+	int deepest_state;
 } at91_pm_data;
 
-void __iomem *at91_ramc_base[2];
+static struct at91_pm_args {
+	void __iomem *pmc;
+	void __iomem *ramc[2];
+	unsigned int memctrl;
+	unsigned int mode;
+	void __iomem *shdwc;
+	void __iomem *sfrbu;
+} pm_args;
 
 static int at91_pm_valid_state(suspend_state_t state)
 {
@@ -70,6 +78,14 @@ static int at91_pm_valid_state(suspend_state_t state)
 	}
 }
 
+static int canary = 0xA5A5A5A5;
+
+static struct at91_pm_bu {
+	int suspended;
+	phys_addr_t canary;
+	phys_addr_t resume;
+	phys_addr_t canary2;
+} *pm_bu;
 
 static suspend_state_t target_state;
 
@@ -91,7 +107,7 @@ static int at91_pm_verify_clocks(void)
 	unsigned long scsr;
 	int i;
 
-	scsr = readl(pmc + AT91_PMC_SCSR);
+	scsr = readl(pm_args.pmc + AT91_PMC_SCSR);
 
 	/* USB must not be using PLLB */
 	if ((scsr & at91_pm_data.uhp_udp_mask) != 0) {
@@ -105,7 +121,7 @@ static int at91_pm_verify_clocks(void)
 
 		if ((scsr & (AT91_PMC_PCK0 << i)) == 0)
 			continue;
-		css = readl(pmc + AT91_PMC_PCKR(i)) & AT91_PMC_CSS;
+		css = readl(pm_args.pmc + AT91_PMC_PCKR(i)) & AT91_PMC_CSS;
 		if (css != AT91_PMC_CSS_SLOW) {
 			pr_err("AT91: PM - Suspend-to-RAM with PCK%d src %d\n", i, css);
 			return 0;
@@ -131,25 +147,43 @@ int at91_suspend_entering_slow_clock(void)
 }
 EXPORT_SYMBOL(at91_suspend_entering_slow_clock);
 
-static void (*at91_suspend_sram_fn)(void __iomem *pmc, void __iomem *ramc0,
-			  void __iomem *ramc1, int memctrl);
+static void (*at91_suspend_sram_fn)(struct at91_pm_args*);
 
-extern void at91_pm_suspend_in_sram(void __iomem *pmc, void __iomem *ramc0,
-			    void __iomem *ramc1, int memctrl);
+extern void at91_pm_suspend_in_sram(struct at91_pm_args*);
 extern u32 at91_pm_suspend_in_sram_sz;
 
-static void at91_pm_suspend(suspend_state_t state)
+static int at91_suspend_finish(unsigned long val)
 {
-	unsigned int pm_data = at91_pm_data.memctrl;
-
-	pm_data |= (state == PM_SUSPEND_MEM) ?
-				AT91_PM_MODE(AT91_PM_SLOW_CLOCK) : 0;
-
 	flush_cache_all();
 	outer_disable();
 
-	at91_suspend_sram_fn(pmc, at91_ramc_base[0],
-			     at91_ramc_base[1], pm_data);
+	at91_suspend_sram_fn(&pm_args);
+
+	return 0;
+}
+
+static void at91_pm_suspend(suspend_state_t state)
+{
+	pm_args.memctrl = at91_pm_data.memctrl;
+
+	if (at91_pm_data.deepest_state == AT91_PM_BACKUP)
+		if (state == PM_SUSPEND_MEM) {
+			/* The SRAM is lost between suspend cycles */
+			at91_suspend_sram_fn = fncpy(at91_suspend_sram_fn,
+						     &at91_pm_suspend_in_sram,
+						     at91_pm_suspend_in_sram_sz);
+			pm_args.mode = AT91_PM_BACKUP;
+			pm_bu->suspended = 1;
+		} else {
+			pm_args.mode = AT91_PM_SLOW_CLOCK;
+		}
+	else
+		pm_args.mode = (state == PM_SUSPEND_MEM)? AT91_PM_SLOW_CLOCK : 0;
+
+	if (pm_args.mode == AT91_PM_BACKUP)
+		cpu_suspend(0, at91_suspend_finish);
+	else
+		at91_suspend_finish(0);
 
 	outer_resume();
 }
@@ -252,7 +286,7 @@ static void at91rm9200_standby(void)
 		"    mcr    p15, 0, %0, c7, c0, 4\n\t"
 		"    str    %5, [%1, %2]"
 		:
-		: "r" (0), "r" (at91_ramc_base[0]), "r" (AT91_MC_SDRAMC_LPR),
+		: "r" (0), "r" (pm_args.ramc[0]), "r" (AT91_MC_SDRAMC_LPR),
 		  "r" (1), "r" (AT91_MC_SDRAMC_SRR),
 		  "r" (lpr));
 }
@@ -267,7 +301,7 @@ static void at91_ddr_standby(void)
 	u32 lpr0, lpr1 = 0;
 	u32 saved_lpr0, saved_lpr1 = 0;
 
-	if (at91_ramc_base[1]) {
+	if (pm_args.ramc[1]) {
 		saved_lpr1 = at91_ramc_read(1, AT91_DDRSDRC_LPR);
 		lpr1 = saved_lpr1 & ~AT91_DDRSDRC_LPCB;
 		lpr1 |= AT91_DDRSDRC_LPCB_SELF_REFRESH;
@@ -279,13 +313,13 @@ static void at91_ddr_standby(void)
 
 	/* self-refresh mode now */
 	at91_ramc_write(0, AT91_DDRSDRC_LPR, lpr0);
-	if (at91_ramc_base[1])
+	if (pm_args.ramc[1])
 		at91_ramc_write(1, AT91_DDRSDRC_LPR, lpr1);
 
 	cpu_do_idle();
 
 	at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr0);
-	if (at91_ramc_base[1])
+	if (pm_args.ramc[1])
 		at91_ramc_write(1, AT91_DDRSDRC_LPR, saved_lpr1);
 }
 
@@ -297,7 +331,7 @@ static void at91sam9_sdram_standby(void)
 	u32 lpr0, lpr1 = 0;
 	u32 saved_lpr0, saved_lpr1 = 0;
 
-	if (at91_ramc_base[1]) {
+	if (pm_args.ramc[1]) {
 		saved_lpr1 = at91_ramc_read(1, AT91_SDRAMC_LPR);
 		lpr1 = saved_lpr1 & ~AT91_SDRAMC_LPCB;
 		lpr1 |= AT91_SDRAMC_LPCB_SELF_REFRESH;
@@ -309,13 +343,13 @@ static void at91sam9_sdram_standby(void)
 
 	/* self-refresh mode now */
 	at91_ramc_write(0, AT91_SDRAMC_LPR, lpr0);
-	if (at91_ramc_base[1])
+	if (pm_args.ramc[1])
 		at91_ramc_write(1, AT91_SDRAMC_LPR, lpr1);
 
 	cpu_do_idle();
 
 	at91_ramc_write(0, AT91_SDRAMC_LPR, saved_lpr0);
-	if (at91_ramc_base[1])
+	if (pm_args.ramc[1])
 		at91_ramc_write(1, AT91_SDRAMC_LPR, saved_lpr1);
 }
 
@@ -335,8 +369,8 @@ static __init void at91_dt_ramc(void)
 	const void *standby = NULL;
 
 	for_each_matching_node_and_match(np, ramc_ids, &of_id) {
-		at91_ramc_base[idx] = of_iomap(np, 0);
-		if (!at91_ramc_base[idx])
+		pm_args.ramc[idx] = of_iomap(np, 0);
+		if (!pm_args.ramc[idx])
 			panic(pr_fmt("unable to map ramc[%d] cpu registers\n"), idx);
 
 		if (!standby)
@@ -356,18 +390,37 @@ static __init void at91_dt_ramc(void)
 	at91_pm_set_standby(standby);
 }
 
+static __init void at91_dt_shdwc(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d2-shdwc");
+	if (!np)
+		return;
+
+	pm_args.shdwc = of_iomap(np, 0);
+	of_node_put(np);
+
+	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d2-sfrbu");
+	if (!np)
+		return;
+
+	pm_args.sfrbu = of_iomap(np, 0);
+	of_node_put(np);
+}
+
 static void at91rm9200_idle(void)
 {
 	/*
 	 * Disable the processor clock.  The processor will be automatically
 	 * re-enabled by an interrupt or by a reset.
 	 */
-	writel(AT91_PMC_PCK, pmc + AT91_PMC_SCDR);
+	writel(AT91_PMC_PCK, pm_args.pmc + AT91_PMC_SCDR);
 }
 
 static void at91sam9_idle(void)
 {
-	writel(AT91_PMC_PCK, pmc + AT91_PMC_SCDR);
+	writel(AT91_PMC_PCK, pm_args.pmc + AT91_PMC_SCDR);
 	cpu_do_idle();
 }
 
@@ -417,6 +470,45 @@ static void __init at91_pm_sram_init(void)
 			&at91_pm_suspend_in_sram, at91_pm_suspend_in_sram_sz);
 }
 
+static void __init at91_pm_bu_sram_init(void)
+{
+	struct gen_pool *sram_pool;
+	struct device_node *node;
+	struct platform_device *pdev = NULL;
+
+	pm_bu = NULL;
+
+	for_each_compatible_node(node, NULL, "atmel,sama5d2-securam") {
+		pdev = of_find_device_by_node(node);
+		if (pdev) {
+			of_node_put(node);
+			break;
+		}
+	}
+
+	if (!pdev) {
+		pr_warn("%s: failed to find securam device!\n", __func__);
+		return;
+	}
+
+	sram_pool = gen_pool_get(&pdev->dev, NULL);
+	if (!sram_pool) {
+		pr_warn("%s: securam pool unavailable!\n", __func__);
+		return;
+	}
+
+	pm_bu = (void *)gen_pool_alloc(sram_pool, sizeof(struct at91_pm_bu));
+	if (!pm_bu) {
+		pr_warn("%s: unable to alloc securam!\n", __func__);
+		return;
+	}
+
+	pm_bu->suspended = 0;
+	pm_bu->canary = virt_to_phys(&canary);
+	pm_bu->resume = virt_to_phys(cpu_resume);
+	pm_bu->canary2 = virt_to_phys(&canary);
+}
+
 static const struct of_device_id atmel_pmc_ids[] __initconst = {
 	{ .compatible = "atmel,at91rm9200-pmc"  },
 	{ .compatible = "atmel,at91sam9260-pmc" },
@@ -436,8 +528,8 @@ static void __init at91_pm_init(void (*pm_idle)(void))
 		platform_device_register(&at91_cpuidle_device);
 
 	pmc_np = of_find_matching_node(NULL, atmel_pmc_ids);
-	pmc = of_iomap(pmc_np, 0);
-	if (!pmc) {
+	pm_args.pmc = of_iomap(pmc_np, 0);
+	if (!pm_args.pmc) {
 		pr_err("AT91: PM not supported, PMC not found\n");
 		return;
 	}
@@ -499,3 +591,12 @@ void __init sama5_pm_init(void)
 	at91_pm_data.memctrl = AT91_MEMCTRL_DDRSDR;
 	at91_pm_init(NULL);
 }
+
+
+void __init sama5d2_pm_init(void)
+{
+	at91_dt_shdwc();
+	at91_pm_bu_sram_init();
+	at91_pm_data.deepest_state = AT91_PM_BACKUP;
+	sama5_pm_init();
+}
diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index 3fcf8810f14e..560a063da5f8 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -18,25 +18,18 @@
 #include <soc/at91/at91sam9_sdramc.h>
 
 #ifndef __ASSEMBLY__
-extern void __iomem *at91_ramc_base[];
-
 #define at91_ramc_read(id, field) \
-	__raw_readl(at91_ramc_base[id] + field)
+	__raw_readl(pm_args.ramc[id] + field)
 
 #define at91_ramc_write(id, field, value) \
-	__raw_writel(value, at91_ramc_base[id] + field)
+	__raw_writel(value, pm_args.ramc[id] + field)
 #endif
 
 #define AT91_MEMCTRL_MC		0
 #define AT91_MEMCTRL_SDRAMC	1
 #define AT91_MEMCTRL_DDRSDR	2
 
-#define	AT91_PM_MEMTYPE_MASK	0x0f
-
-#define	AT91_PM_MODE_OFFSET	4
-#define	AT91_PM_MODE_MASK	0x01
-#define	AT91_PM_MODE(x)		(((x) & AT91_PM_MODE_MASK) << AT91_PM_MODE_OFFSET)
-
 #define	AT91_PM_SLOW_CLOCK	0x01
+#define	AT91_PM_BACKUP		0x02
 
 #endif
diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index a25defda3d22..fd69fbe7166b 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -75,10 +75,8 @@ tmp2	.req	r5
  * void at91_pm_suspend_in_sram(void __iomem *pmc, void __iomem *sdramc,
  *			void __iomem *ramc1, int memctrl)
  * @input param:
- * 	@r0: base address of AT91_PMC
- *  	@r1: base address of SDRAM Controller (SDRAM, DDRSDR, or AT91_SYS)
- *	@r2: base address of second SDRAM Controller or 0 if not present
- *	@r3: pm information
+ * 	@r0: base address of struct
+ *	@r1: pm information
  */
 /* at91_pm_suspend_in_sram must be 8-byte aligned per the requirements of fncpy() */
 	.align 3
@@ -90,25 +88,76 @@ ENTRY(at91_pm_suspend_in_sram)
 	mov	tmp1, #0
 	mcr	p15, 0, tmp1, c7, c10, 4
 
-	str	r0, .pmc_base
-	str	r1, .sramc_base
-	str	r2, .sramc1_base
-
-	and	r0, r3, #AT91_PM_MEMTYPE_MASK
-	str	r0, .memtype
-
-	lsr	r0, r3, #AT91_PM_MODE_OFFSET
-	and	r0, r0, #AT91_PM_MODE_MASK
-	str	r0, .pm_mode
+	ldr	tmp1, [r0, #0]
+	str	tmp1, .pmc_base
+	ldr	tmp1, [r0, #0x4]
+	str	tmp1, .sramc_base
+	ldr	tmp1, [r0, #0x8]
+	str	tmp1, .sramc1_base
+	ldr	tmp1, [r0, #0xC]
+	str	tmp1, .memtype
+	ldr	tmp1, [r0, #0x10]
+	str	tmp1, .pm_mode
+	ldr	tmp1, [r0, #0x14]
+	str	tmp1, .shdwc
+	cmp	tmp1, #0
+	ldrne	tmp2, [tmp1, #0]
+	ldr	tmp1, [r0, #0x18]
+	str	tmp1, .sfr
+	cmp	tmp1, #0
+	ldrne	tmp2, [tmp1, #0x10]
 
 	/* Active the self-refresh mode */
 	mov	r0, #SRAMC_SELF_FRESH_ACTIVE
 	bl	at91_sramc_self_refresh
 
 	ldr	r0, .pm_mode
-	tst	r0, #AT91_PM_SLOW_CLOCK
-	beq	skip_disable_main_clock
+	cmp	r0, #AT91_PM_SLOW_CLOCK
+	beq	slow_clock
+	cmp	r0, #AT91_PM_BACKUP
+	beq	backup_mode
+
+	/* Wait for interrupt */
+	ldr	pmc, .pmc_base
+	at91_cpu_idle
+	b	exit_suspend
+
+slow_clock:
+	bl	at91_slowck_mode
+	b	exit_suspend
+backup_mode:
+	bl	at91_backup_mode
+	b	exit_suspend
+
+exit_suspend:
+	/* Exit the self-refresh mode */
+	mov	r0, #SRAMC_SELF_FRESH_EXIT
+	bl	at91_sramc_self_refresh
+
+	/* Restore registers, and return */
+	ldmfd	sp!, {r4 - r12, pc}
+ENDPROC(at91_pm_suspend_in_sram)
+
+ENTRY(at91_backup_mode)
+	#if 0
+	/* Read LPR */
+	ldr	r2, .sramc_base
+	ldr	r3, [r2, #AT91_DDRSDRC_LPR]
+	#endif
 
+	/*BUMEN*/
+	ldr	r0, .sfr
+	mov	tmp1, #(0x1)
+	str	tmp1, [r0, #0x10]
+
+	/* Shutdown */
+	ldr	r0, .shdwc
+	movs    tmp1, #0x1
+	movt    tmp1, #0xA500
+	str	tmp1, [r0, #0]
+ENDPROC(at91_backup_mode)
+
+ENTRY(at91_slowck_mode)
 	ldr	pmc, .pmc_base
 
 	/* Save Master clock setting */
@@ -137,18 +186,9 @@ ENTRY(at91_pm_suspend_in_sram)
 	orr	tmp1, tmp1, #AT91_PMC_KEY
 	str	tmp1, [pmc, #AT91_CKGR_MOR]
 
-skip_disable_main_clock:
-	ldr	pmc, .pmc_base
-
 	/* Wait for interrupt */
 	at91_cpu_idle
 
-	ldr	r0, .pm_mode
-	tst	r0, #AT91_PM_SLOW_CLOCK
-	beq	skip_enable_main_clock
-
-	ldr	pmc, .pmc_base
-
 	/* Turn on the main oscillator */
 	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
 	orr	tmp1, tmp1, #AT91_PMC_MOSCEN
@@ -177,14 +217,8 @@ skip_disable_main_clock:
 
 	wait_mckrdy
 
-skip_enable_main_clock:
-	/* Exit the self-refresh mode */
-	mov	r0, #SRAMC_SELF_FRESH_EXIT
-	bl	at91_sramc_self_refresh
-
-	/* Restore registers, and return */
-	ldmfd	sp!, {r4 - r12, pc}
-ENDPROC(at91_pm_suspend_in_sram)
+	mov	pc, lr
+ENDPROC(at91_slowck_mode)
 
 /*
  * void at91_sramc_self_refresh(unsigned int is_active)
@@ -317,6 +351,10 @@ ENDPROC(at91_sramc_self_refresh)
 	.word 0
 .sramc1_base:
 	.word 0
+.shdwc:
+	.word 0
+.sfr:
+	.word 0
 .memtype:
 	.word 0
 .pm_mode:
diff --git a/arch/arm/mach-at91/sama5.c b/arch/arm/mach-at91/sama5.c
index b272c45b400f..a96f4a7e638a 100644
--- a/arch/arm/mach-at91/sama5.c
+++ b/arch/arm/mach-at91/sama5.c
@@ -84,7 +84,6 @@ DT_MACHINE_START(sama5_dt, "Atmel SAMA5")
 MACHINE_END
 
 static const char *const sama5_alt_dt_board_compat[] __initconst = {
-	"atmel,sama5d2",
 	"atmel,sama5d4",
 	NULL
 };
@@ -95,3 +94,28 @@ DT_MACHINE_START(sama5_alt_dt, "Atmel SAMA5")
 	.dt_compat	= sama5_alt_dt_board_compat,
 	.l2c_aux_mask	= ~0UL,
 MACHINE_END
+
+static void __init sama5d2_init(void)
+{
+	struct soc_device *soc;
+	struct device *soc_dev = NULL;
+
+	soc = at91_soc_init(sama5_socs);
+	if (soc != NULL)
+		soc_dev = soc_device_to_device(soc);
+
+	of_platform_default_populate(NULL, NULL, soc_dev);
+	sama5d2_pm_init();
+}
+
+static const char *const sama5d2_compat[] __initconst = {
+	"atmel,sama5d2",
+	NULL
+};
+
+DT_MACHINE_START(sama5d2, "Atmel SAMA5")
+	/* Maintainer: Atmel */
+	.init_machine	= sama5d2_init,
+	.dt_compat	= sama5d2_compat,
+	.l2c_aux_mask	= ~0UL,
+MACHINE_END
-- 
2.11.0
