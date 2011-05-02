From: avictor.za@gmail.com (Andrew Victor)
Date: Mon, 02 May 2011 18:16:29 +0200
Subject: AT91: PMC definitions are plaform-depenent
Message-ID: <1304352989.17141.9.camel@redbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For supporting multiple AT91 processors in a single kernel image, the
base address of the PMC controller cannot be calculated at compile-time.
Changes required:
* calculate PMC base address in processor-dependent code and pass it
through to the clocks driver at initialization time.
* arch_idle() need to call into processor-dependent code to put the CPU
to sleep.  Added an 'at91_arch_idle' callback.
* Move at91_pm_verify_clocks() from pm.c to clocks.c
* Rename definitions of AT91_PMC to AT91xxx_PMC.


Signed-off-by: Andrew Victor <linux@maxim.org.za>


diff --git a/arch/arm/mach-at91/at572d940hf.c b/arch/arm/mach-at91/at572d940hf.c
index 461735c..040366f 100644
--- a/arch/arm/mach-at91/at572d940hf.c
+++ b/arch/arm/mach-at91/at572d940hf.c
@@ -24,6 +24,7 @@
 
 #include <linux/module.h>
 
+#include <asm/proc-fns.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -292,6 +293,18 @@ static struct at91_gpio_bank at572d940hf_gpio[] = {
 	}
 };
 
+static void at572d940hf_idle(void)
+{
+	void __iomem* pmc = (void __iomem *)AT91_VA_BASE_SYS + AT572D940HF_PMC;
+
+	/*
+	 * Disable the processor clock, and set the processor (CP15)
+	 * into 'Wait for Interrupt' mode.
+	 */
+	__raw_writel(AT91_PMC_PCK, pmc + AT91_PMC_SCDR);
+	cpu_do_idle();
+}
+
 static void at572d940hf_reset(void)
 {
 	at91_sys_write(AT91_RSTC_CR, AT91_RSTC_KEY | AT91_RSTC_PROCRST | AT91_RSTC_PERRST);
@@ -304,15 +317,18 @@ static void at572d940hf_reset(void)
 
 void __init at572d940hf_initialize(unsigned long main_clock)
 {
+	void __iomem* pmc = (void __iomem *)AT91_VA_BASE_SYS + AT572D940HF_PMC;
+
 	/* Map peripherals */
 	iotable_init(at572d940hf_io_desc, ARRAY_SIZE(at572d940hf_io_desc));
 
+	at91_arch_idle = at572d940hf_idle;
 	at91_arch_reset = at572d940hf_reset;
 	at91_extern_irq = (1 << AT572D940HF_ID_IRQ0) | (1 << AT572D940HF_ID_IRQ1)
 			| (1 << AT572D940HF_ID_IRQ2);
 
 	/* Init clock subsystem */
-	at91_clock_init(main_clock);
+	at91_clock_init(pmc, main_clock);
 
 	/* Register the processor-specific clocks */
 	at572d940hf_register_clocks();
diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index ea2d820..077ed39 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 
+#include <asm/proc-fns.h>
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -288,6 +289,18 @@ static struct at91_gpio_bank at91cap9_gpio[] = {
 	}
 };
 
+static void at91cap9_idle(void)
+{
+	void __iomem* pmc = (void __iomem *)AT91_VA_BASE_SYS + AT91CAP9_PMC;
+
+	/*
+	 * Disable the processor clock, and set the processor (CP15)
+	 * into 'Wait for Interrupt' mode.
+	 */
+	__raw_writel(AT91_PMC_PCK, pmc + AT91_PMC_SCDR);
+	cpu_do_idle();
+}
+
 static void at91cap9_reset(void)
 {
 	at91_sys_write(AT91_RSTC_CR, AT91_RSTC_KEY | AT91_RSTC_PROCRST | AT91_RSTC_PERRST);
@@ -305,15 +318,18 @@ static void at91cap9_poweroff(void)
 
 void __init at91cap9_initialize(unsigned long main_clock)
 {
+	void __iomem* pmc = (void __iomem *)AT91_VA_BASE_SYS + AT91CAP9_PMC;
+
 	/* Map peripherals */
 	iotable_init(at91cap9_io_desc, ARRAY_SIZE(at91cap9_io_desc));
 
+	at91_arch_idle = at91cap9_idle;
 	at91_arch_reset = at91cap9_reset;
 	pm_power_off = at91cap9_poweroff;
 	at91_extern_irq = (1 << AT91CAP9_ID_IRQ0) | (1 << AT91CAP9_ID_IRQ1);
 
 	/* Init clock subsystem */
-	at91_clock_init(main_clock);
+	at91_clock_init(pmc, main_clock);
 
 	/* Register the processor-specific clocks */
 	at91cap9_register_clocks();
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index efb081f..da2cc9a 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -257,6 +257,17 @@ static struct at91_gpio_bank at91rm9200_gpio[] = {
 	}
 };
 
+static void at91rm9200_idle(void)
+{
+	void __iomem *pmc = (void __iomem *)AT91_VA_BASE_SYS + AT91RM9200_PMC;
+
+	/*
+	 * Disable the processor clock.  The processor will be automatically
+	 * re-enabled by an interrupt or by a reset.
+	 */
+	__raw_writel(AT91_PMC_PCK, pmc + AT91_PMC_SCDR);
+}
+
 static void at91rm9200_reset(void)
 {
 	/*
@@ -272,9 +283,12 @@ static void at91rm9200_reset(void)
  * -------------------------------------------------------------------- */
 void __init at91rm9200_initialize(unsigned long main_clock, unsigned short banks)
 {
+	void __iomem *pmc = (void __iomem *)AT91_VA_BASE_SYS + AT91RM9200_PMC;
+
 	/* Map peripherals */
 	iotable_init(at91rm9200_io_desc, ARRAY_SIZE(at91rm9200_io_desc));
 
+	at91_arch_idle = at91rm9200_idle;
 	at91_arch_reset = at91rm9200_reset;
 	at91_extern_irq = (1 << AT91RM9200_ID_IRQ0) | (1 << AT91RM9200_ID_IRQ1)
 			| (1 << AT91RM9200_ID_IRQ2) | (1 << AT91RM9200_ID_IRQ3)
@@ -282,7 +296,7 @@ void __init at91rm9200_initialize(unsigned long main_clock, unsigned short banks
 			| (1 << AT91RM9200_ID_IRQ6);
 
 	/* Init clock subsystem */
-	at91_clock_init(main_clock);
+	at91_clock_init(pmc, main_clock);
 
 	/* Register the processor-specific clocks */
 	at91rm9200_register_clocks();
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 741a2b5..a9abb4b 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 
+#include <asm/proc-fns.h>
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -279,6 +280,18 @@ static struct at91_gpio_bank at91sam9260_gpio[] = {
 	}
 };
 
+static void at91sam9260_idle(void)
+{
+	void __iomem* pmc = (void __iomem *)AT91_VA_BASE_SYS + AT91SAM9260_PMC;
+
+	/*
+	 * Disable the processor clock, and set the processor (CP15)
+	 * into 'Wait for Interrupt' mode.
+	 */
+	__raw_writel(AT91_PMC_PCK, pmc + AT91_PMC_SCDR);
+	cpu_do_idle();
+}
+
 static void at91sam9260_poweroff(void)
 {
 	at91_sys_write(AT91_SHDW_CR, AT91_SHDW_KEY | AT91_SHDW_SHDW);
@@ -310,6 +323,8 @@ static void __init at91sam9xe_initialize(void)
 
 void __init at91sam9260_initialize(unsigned long main_clock)
 {
+	void __iomem* pmc = (void __iomem *)AT91_VA_BASE_SYS + AT91SAM9260_PMC;
+
 	/* Map peripherals */
 	iotable_init(at91sam9260_io_desc, ARRAY_SIZE(at91sam9260_io_desc));
 
@@ -320,13 +335,14 @@ void __init at91sam9260_initialize(unsigned long main_clock)
 	else
 		iotable_init(at91sam9260_sram_desc, ARRAY_SIZE(at91sam9260_sram_desc));
 
+	at91_arch_idle = at91sam9260_idle;
 	at91_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9260_poweroff;
 	at91_extern_irq = (1 << AT91SAM9260_ID_IRQ0) | (1 << AT91SAM9260_ID_IRQ1)
 			| (1 << AT91SAM9260_ID_IRQ2);
 
 	/* Init clock subsystem */
-	at91_clock_init(main_clock);
+	at91_clock_init(pmc, main_clock);
 
 	/* Register the processor-specific clocks */
 	at91sam9260_register_clocks();
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 192f983..3b66462 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 
+#include <asm/proc-fns.h>
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -257,6 +258,18 @@ static struct at91_gpio_bank at91sam9261_gpio[] = {
 	}
 };
 
+static void at91sam9261_idle(void)
+{
+	void __iomem* pmc = (void __iomem *)AT91_VA_BASE_SYS + AT91SAM9261_PMC;
+
+	/*
+	 * Disable the processor clock, and set the processor (CP15)
+	 * into 'Wait for Interrupt' mode.
+	 */
+	__raw_writel(AT91_PMC_PCK, pmc + AT91_PMC_SCDR);
+	cpu_do_idle();
+}
+
 static void at91sam9261_poweroff(void)
 {
 	at91_sys_write(AT91_SHDW_CR, AT91_SHDW_KEY | AT91_SHDW_SHDW);
@@ -269,6 +282,8 @@ static void at91sam9261_poweroff(void)
 
 void __init at91sam9261_initialize(unsigned long main_clock)
 {
+	void __iomem* pmc = (void __iomem *)AT91_VA_BASE_SYS + AT91SAM9261_PMC;
+
 	/* Map peripherals */
 	iotable_init(at91sam9261_io_desc, ARRAY_SIZE(at91sam9261_io_desc));
 
@@ -277,14 +292,14 @@ void __init at91sam9261_initialize(unsigned long main_clock)
 	else
 		iotable_init(at91sam9261_sram_desc, ARRAY_SIZE(at91sam9261_sram_desc));
 
-
+	at91_arch_idle = at91sam9261_idle;
 	at91_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9261_poweroff;
 	at91_extern_irq = (1 << AT91SAM9261_ID_IRQ0) | (1 << AT91SAM9261_ID_IRQ1)
 			| (1 << AT91SAM9261_ID_IRQ2);
 
 	/* Init clock subsystem */
-	at91_clock_init(main_clock);
+	at91_clock_init(pmc, main_clock);
 
 	/* Register the processor-specific clocks */
 	at91sam9261_register_clocks();
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index a9b3687..a6c72a6 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 
+#include <asm/proc-fns.h>
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -269,6 +270,18 @@ static struct at91_gpio_bank at91sam9263_gpio[] = {
 	}
 };
 
+static void at91sam9263_idle(void)
+{
+	void __iomem* pmc = (void __iomem *)AT91_VA_BASE_SYS + AT91SAM9263_PMC;
+
+	/*
+	 * Disable the processor clock, and set the processor (CP15)
+	 * into 'Wait for Interrupt' mode.
+	 */
+	__raw_writel(AT91_PMC_PCK, pmc + AT91_PMC_SCDR);
+	cpu_do_idle();
+}
+
 static void at91sam9263_poweroff(void)
 {
 	at91_sys_write(AT91_SHDW_CR, AT91_SHDW_KEY | AT91_SHDW_SHDW);
@@ -281,15 +294,18 @@ static void at91sam9263_poweroff(void)
 
 void __init at91sam9263_initialize(unsigned long main_clock)
 {
+	void __iomem* pmc = (void __iomem *)AT91_VA_BASE_SYS + AT91SAM9263_PMC;
+
 	/* Map peripherals */
 	iotable_init(at91sam9263_io_desc, ARRAY_SIZE(at91sam9263_io_desc));
 
+	at91_arch_idle = at91sam9263_idle;
 	at91_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9263_poweroff;
 	at91_extern_irq = (1 << AT91SAM9263_ID_IRQ0) | (1 << AT91SAM9263_ID_IRQ1);
 
 	/* Init clock subsystem */
-	at91_clock_init(main_clock);
+	at91_clock_init(pmc, main_clock);
 
 	/* Register the processor-specific clocks */
 	at91sam9263_register_clocks();
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 7342c9b..180dd26 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 
+#include <asm/proc-fns.h>
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -291,6 +292,18 @@ static struct at91_gpio_bank at91sam9g45_gpio[] = {
 	}
 };
 
+static void at91sam9g45_idle(void)
+{
+	void __iomem* pmc = (void __iomem *)AT91_VA_BASE_SYS + AT91SAM9G45_PMC;
+
+	/*
+	 * Disable the processor clock, and set the processor (CP15)
+	 * into 'Wait for Interrupt' mode.
+	 */
+	__raw_writel(AT91_PMC_PCK, pmc + AT91_PMC_SCDR);
+	cpu_do_idle();
+}
+
 static void at91sam9g45_reset(void)
 {
 	at91_sys_write(AT91_RSTC_CR, AT91_RSTC_KEY | AT91_RSTC_PROCRST | AT91_RSTC_PERRST);
@@ -308,15 +321,18 @@ static void at91sam9g45_poweroff(void)
 
 void __init at91sam9g45_initialize(unsigned long main_clock)
 {
+	void __iomem* pmc = (void __iomem *)AT91_VA_BASE_SYS + AT91SAM9G45_PMC;
+
 	/* Map peripherals */
 	iotable_init(at91sam9g45_io_desc, ARRAY_SIZE(at91sam9g45_io_desc));
 
+	at91_arch_idle = at91sam9g45_idle;
 	at91_arch_reset = at91sam9g45_reset;
 	pm_power_off = at91sam9g45_poweroff;
 	at91_extern_irq = (1 << AT91SAM9G45_ID_IRQ0);
 
 	/* Init clock subsystem */
-	at91_clock_init(main_clock);
+	at91_clock_init(pmc, main_clock);
 
 	/* Register the processor-specific clocks */
 	at91sam9g45_register_clocks();
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index cdd3eab..2c0029e 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 
+#include <asm/proc-fns.h>
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -242,6 +243,18 @@ static struct at91_gpio_bank at91sam9rl_gpio[] = {
 	}
 };
 
+static void at91sam9rl_idle(void)
+{
+	void __iomem* pmc = (void __iomem *)AT91_VA_BASE_SYS + AT91SAM9RL_PMC;
+
+	/*
+	 * Disable the processor clock, and set the processor (CP15)
+	 * into 'Wait for Interrupt' mode.
+	 */
+	__raw_writel(AT91_PMC_PCK, pmc + AT91_PMC_SCDR);
+	cpu_do_idle();
+}
+
 static void at91sam9rl_poweroff(void)
 {
 	at91_sys_write(AT91_SHDW_CR, AT91_SHDW_KEY | AT91_SHDW_SHDW);
@@ -254,6 +267,7 @@ static void at91sam9rl_poweroff(void)
 
 void __init at91sam9rl_initialize(unsigned long main_clock)
 {
+	void __iomem* pmc = (void __iomem *)AT91_VA_BASE_SYS + AT91SAM9RL_PMC;
 	unsigned long sram_size;
 
 	/* Map peripherals */
@@ -274,12 +288,13 @@ void __init at91sam9rl_initialize(unsigned long main_clock)
 	/* Map SRAM */
 	iotable_init(at91sam9rl_sram_desc, ARRAY_SIZE(at91sam9rl_sram_desc));
 
+	at91_arch_idle = at91sam9rl_idle;
 	at91_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9rl_poweroff;
 	at91_extern_irq = (1 << AT91SAM9RL_ID_IRQ0);
 
 	/* Init clock subsystem */
-	at91_clock_init(main_clock);
+	at91_clock_init(pmc, main_clock);
 
 	/* Register the processor-specific clocks */
 	at91sam9rl_register_clocks();
diff --git a/arch/arm/mach-at91/at91x40.c b/arch/arm/mach-at91/at91x40.c
index 4cf8444..330bd0e 100644
--- a/arch/arm/mach-at91/at91x40.c
+++ b/arch/arm/mach-at91/at91x40.c
@@ -42,8 +42,20 @@ struct clk *clk_get(struct device *dev, const char *id)
 	return NULL;
 }
 
+static void at91x40_idle(void)
+{
+	void __iomem *ps = (void __iomem *)AT91_VA_BASE_SYS + AT91X40_PS;
+
+	/*
+	 * Disable the processor clock.  The processor will be automatically
+	 * re-enabled by an interrupt or by a reset.
+	 */
+	__raw_writel(AT91_PS_CR_CPU, ps + AT91_PS_CR);
+}
+
 void __init at91x40_initialize(unsigned long main_clock)
 {
+	at91_arch_idle = at91x40_idle;
 	at91_extern_irq = (1 << AT91X40_ID_IRQ0) | (1 << AT91X40_ID_IRQ1)
 			| (1 << AT91X40_ID_IRQ2);
 }
diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
index 9113da6..a624a23 100644
--- a/arch/arm/mach-at91/clock.c
+++ b/arch/arm/mach-at91/clock.c
@@ -68,6 +68,12 @@
 #define cpu_has_udpfs()		(!(cpu_is_at91sam9rl() \
 				|| cpu_is_at91sam9g45()))
 
+/* Base IO address of PMC */
+void __iomem *at91_pmc_base_addr __read_mostly;
+
+#define pmc_readl(reg)		__raw_readl(at91_pmc_base_addr + (reg))
+#define pmc_writel(reg, val)	__raw_writel((val), at91_pmc_base_addr + (reg))
+
 static LIST_HEAD(clocks);
 static DEFINE_SPINLOCK(clk_lock);
 
@@ -111,11 +117,11 @@ static void pllb_mode(struct clk *clk, int is_on)
 		value = 0;
 
 	// REVISIT: Add work-around for AT91RM9200 Errata #26 ?
-	at91_sys_write(AT91_CKGR_PLLBR, value);
+	pmc_writel(AT91_CKGR_PLLBR, value);
 
 	do {
 		cpu_relax();
-	} while ((at91_sys_read(AT91_PMC_SR) & AT91_PMC_LOCKB) != is_on);
+	} while ((pmc_readl(AT91_PMC_SR) & AT91_PMC_LOCKB) != is_on);
 }
 
 static struct clk pllb = {
@@ -130,14 +136,14 @@ static struct clk pllb = {
 static void pmc_sys_mode(struct clk *clk, int is_on)
 {
 	if (is_on)
-		at91_sys_write(AT91_PMC_SCER, clk->pmc_mask);
+		pmc_writel(AT91_PMC_SCER, clk->pmc_mask);
 	else
-		at91_sys_write(AT91_PMC_SCDR, clk->pmc_mask);
+		pmc_writel(AT91_PMC_SCDR, clk->pmc_mask);
 }
 
 static void pmc_uckr_mode(struct clk *clk, int is_on)
 {
-	unsigned int uckr = at91_sys_read(AT91_CKGR_UCKR);
+	unsigned int uckr = pmc_readl(AT91_CKGR_UCKR);
 
 	if (cpu_is_at91sam9g45()) {
 		if (is_on)
@@ -148,13 +154,13 @@ static void pmc_uckr_mode(struct clk *clk, int is_on)
 
 	if (is_on) {
 		is_on = AT91_PMC_LOCKU;
-		at91_sys_write(AT91_CKGR_UCKR, uckr | clk->pmc_mask);
+		pmc_writel(AT91_CKGR_UCKR, uckr | clk->pmc_mask);
 	} else
-		at91_sys_write(AT91_CKGR_UCKR, uckr & ~(clk->pmc_mask));
+		pmc_writel(AT91_CKGR_UCKR, uckr & ~(clk->pmc_mask));
 
 	do {
 		cpu_relax();
-	} while ((at91_sys_read(AT91_PMC_SR) & AT91_PMC_LOCKU) != is_on);
+	} while ((pmc_readl(AT91_PMC_SR) & AT91_PMC_LOCKU) != is_on);
 }
 
 /* USB function clocks (PLLB must be 48 MHz) */
@@ -190,9 +196,9 @@ static struct clk mck = {
 static void pmc_periph_mode(struct clk *clk, int is_on)
 {
 	if (is_on)
-		at91_sys_write(AT91_PMC_PCER, clk->pmc_mask);
+		pmc_writel(AT91_PMC_PCER, clk->pmc_mask);
 	else
-		at91_sys_write(AT91_PMC_PCDR, clk->pmc_mask);
+		pmc_writel(AT91_PMC_PCDR, clk->pmc_mask);
 }
 
 static struct clk __init *at91_css_to_clk(unsigned long css)
@@ -366,10 +372,10 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 		if (actual && actual <= rate) {
 			u32	pckr;
 
-			pckr = at91_sys_read(AT91_PMC_PCKR(clk->id));
+			pckr = pmc_readl(AT91_PMC_PCKR(clk->id));
 			pckr &= AT91_PMC_CSS;	/* clock selection */
 			pckr |= prescale << 2;
-			at91_sys_write(AT91_PMC_PCKR(clk->id), pckr);
+			pmc_writel(AT91_PMC_PCKR(clk->id), pckr);
 			clk->rate_hz = actual;
 			break;
 		}
@@ -403,7 +409,7 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 
 	clk->rate_hz = parent->rate_hz;
 	clk->parent = parent;
-	at91_sys_write(AT91_PMC_PCKR(clk->id), parent->id);
+	pmc_writel(AT91_PMC_PCKR(clk->id), parent->id);
 
 	spin_unlock_irqrestore(&clk_lock, flags);
 	return 0;
@@ -416,7 +422,7 @@ static void __init init_programmable_clock(struct clk *clk)
 	struct clk	*parent;
 	u32		pckr;
 
-	pckr = at91_sys_read(AT91_PMC_PCKR(clk->id));
+	pckr = pmc_readl(AT91_PMC_PCKR(clk->id));
 	parent = at91_css_to_clk(pckr & AT91_PMC_CSS);
 	clk->parent = parent;
 	clk->rate_hz = parent->rate_hz / (1 << ((pckr & AT91_PMC_PRES) >> 2));
@@ -433,19 +439,19 @@ static int at91_clk_show(struct seq_file *s, void *unused)
 	u32		scsr, pcsr, uckr = 0, sr;
 	struct clk	*clk;
 
-	seq_printf(s, "SCSR = %8x\n", scsr = at91_sys_read(AT91_PMC_SCSR));
-	seq_printf(s, "PCSR = %8x\n", pcsr = at91_sys_read(AT91_PMC_PCSR));
-	seq_printf(s, "MOR  = %8x\n", at91_sys_read(AT91_CKGR_MOR));
-	seq_printf(s, "MCFR = %8x\n", at91_sys_read(AT91_CKGR_MCFR));
-	seq_printf(s, "PLLA = %8x\n", at91_sys_read(AT91_CKGR_PLLAR));
+	seq_printf(s, "SCSR = %8x\n", scsr = pmc_readl(AT91_PMC_SCSR));
+	seq_printf(s, "PCSR = %8x\n", pcsr = pmc_readl(AT91_PMC_PCSR));
+	seq_printf(s, "MOR  = %8x\n", pmc_readl(AT91_CKGR_MOR));
+	seq_printf(s, "MCFR = %8x\n", pmc_readl(AT91_CKGR_MCFR));
+	seq_printf(s, "PLLA = %8x\n", pmc_readl(AT91_CKGR_PLLAR));
 	if (cpu_has_pllb())
-		seq_printf(s, "PLLB = %8x\n", at91_sys_read(AT91_CKGR_PLLBR));
+		seq_printf(s, "PLLB = %8x\n", pmc_readl(AT91_CKGR_PLLBR));
 	if (cpu_has_utmi())
-		seq_printf(s, "UCKR = %8x\n", uckr = at91_sys_read(AT91_CKGR_UCKR));
-	seq_printf(s, "MCKR = %8x\n", at91_sys_read(AT91_PMC_MCKR));
+		seq_printf(s, "UCKR = %8x\n", uckr = pmc_readl(AT91_CKGR_UCKR));
+	seq_printf(s, "MCKR = %8x\n", pmc_readl(AT91_PMC_MCKR));
 	if (cpu_has_upll())
-		seq_printf(s, "USB  = %8x\n", at91_sys_read(AT91_PMC_USB));
-	seq_printf(s, "SR   = %8x\n", sr = at91_sys_read(AT91_PMC_SR));
+		seq_printf(s, "USB  = %8x\n", pmc_readl(AT91_PMC_USB));
+	seq_printf(s, "SR   = %8x\n", sr = pmc_readl(AT91_PMC_SR));
 
 	seq_printf(s, "\n");
 
@@ -495,6 +501,59 @@ postcore_initcall(at91_clk_debugfs_init);
 
 #endif
 
+
+/*------------------------------------------------------------------------*/
+
+/*
+ * Verify that all the clocks are correct before entering
+ * slow-clock mode.
+ */
+int at91_clocks_valid_for_suspend(void)
+{
+	unsigned long scsr;
+	int i;
+
+	scsr = pmc_readl(AT91_PMC_SCSR);
+
+	/* USB must not be using PLLB */
+	if (cpu_is_at91rm9200()) {
+		if ((scsr & (AT91RM9200_PMC_UHP | AT91RM9200_PMC_UDP)) != 0) {
+			pr_err("AT91: PM - Suspend-to-RAM with USB still active\n");
+			return 0;
+		}
+	} else if (cpu_is_at91sam9260() || cpu_is_at91sam9261() || cpu_is_at91sam9263()
+			|| cpu_is_at91sam9g20() || cpu_is_at91sam9g10()) {
+		if ((scsr & (AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP)) != 0) {
+			pr_err("AT91: PM - Suspend-to-RAM with USB still active\n");
+			return 0;
+		}
+	} else if (cpu_is_at91cap9()) {
+		if ((scsr & AT91CAP9_PMC_UHP) != 0) {
+			pr_err("AT91: PM - Suspend-to-RAM with USB still active\n");
+			return 0;
+		}
+	}
+
+#ifdef CONFIG_AT91_PROGRAMMABLE_CLOCKS
+	/* PCK0..PCK3 must be disabled, or configured to use clk32k */
+	for (i = 0; i < 4; i++) {
+		u32 css;
+
+		if ((scsr & (AT91_PMC_PCK0 << i)) == 0)
+			continue;
+
+		css = pmc_readl(AT91_PMC_PCKR(i)) & AT91_PMC_CSS;
+		if (css != AT91_PMC_CSS_SLOW) {
+			pr_err("AT91: PM - Suspend-to-RAM with PCK%d src %d\n", i, css);
+			return 0;
+		}
+	}
+#endif
+
+	return 1;
+}
+
+
 /*------------------------------------------------------------------------*/
 
 /* Register a new clock */
@@ -627,7 +686,7 @@ static void __init at91_pllb_usbfs_clock_init(unsigned long main_clock)
 	if (cpu_is_at91rm9200()) {
 		uhpck.pmc_mask = AT91RM9200_PMC_UHP;
 		udpck.pmc_mask = AT91RM9200_PMC_UDP;
-		at91_sys_write(AT91_PMC_SCER, AT91RM9200_PMC_MCKUDP);
+		pmc_writel(AT91_PMC_SCER, AT91RM9200_PMC_MCKUDP);
 	} else if (cpu_is_at91sam9260() || cpu_is_at91sam9261() ||
 		   cpu_is_at91sam9263() || cpu_is_at91sam9g20() ||
 		   cpu_is_at91sam9g10() || cpu_is_at572d940hf()) {
@@ -636,7 +695,7 @@ static void __init at91_pllb_usbfs_clock_init(unsigned long main_clock)
 	} else if (cpu_is_at91cap9()) {
 		uhpck.pmc_mask = AT91CAP9_PMC_UHP;
 	}
-	at91_sys_write(AT91_CKGR_PLLBR, 0);
+	pmc_writel(AT91_CKGR_PLLBR, 0);
 
 	udpck.rate_hz = at91_usb_rate(&pllb, pllb.rate_hz, at91_pllb_usb_init);
 	uhpck.rate_hz = at91_usb_rate(&pllb, pllb.rate_hz, at91_pllb_usb_init);
@@ -653,21 +712,24 @@ static void __init at91_upll_usbfs_clock_init(unsigned long main_clock)
 	/* Setup divider by 10 to reach 48 MHz */
 	usbr |= ((10 - 1) << 8) & AT91_PMC_OHCIUSBDIV;
 
-	at91_sys_write(AT91_PMC_USB, usbr);
+	pmc_writel(AT91_PMC_USB, usbr);
 
 	/* Now set uhpck values */
 	uhpck.parent = &utmi_clk;
 	uhpck.pmc_mask = AT91SAM926x_PMC_UHP;
 	uhpck.rate_hz = utmi_clk.rate_hz;
-	uhpck.rate_hz /= 1 + ((at91_sys_read(AT91_PMC_USB) & AT91_PMC_OHCIUSBDIV) >> 8);
+	uhpck.rate_hz /= 1 + ((pmc_readl(AT91_PMC_USB) & AT91_PMC_OHCIUSBDIV) >> 8);
 }
 
-int __init at91_clock_init(unsigned long main_clock)
+int __init at91_clock_init(void __iomem *regbase, unsigned long main_clock)
 {
 	unsigned tmp, freq, mckr;
 	int i;
 	int pll_overclock = false;
 
+	/* Store base-address */
+	at91_pmc_base_addr = regbase;
+
 	/*
 	 * When the bootloader initialized the main oscillator correctly,
 	 * there's no problem using the cycle counter.  But if it didn't,
@@ -676,14 +738,14 @@ int __init at91_clock_init(unsigned long main_clock)
 	 */
 	if (!main_clock) {
 		do {
-			tmp = at91_sys_read(AT91_CKGR_MCFR);
+			tmp = pmc_readl(AT91_CKGR_MCFR);
 		} while (!(tmp & AT91_PMC_MAINRDY));
 		main_clock = (tmp & AT91_PMC_MAINF) * (AT91_SLOW_CLOCK / 16);
 	}
 	main_clk.rate_hz = main_clock;
 
 	/* report if PLLA is more than mildly overclocked */
-	plla.rate_hz = at91_pll_rate(&plla, main_clock, at91_sys_read(AT91_CKGR_PLLAR));
+	plla.rate_hz = at91_pll_rate(&plla, main_clock, pmc_readl(AT91_CKGR_PLLAR));
 	if (cpu_has_300M_plla()) {
 		if (plla.rate_hz > 300000000)
 			pll_overclock = true;
@@ -698,7 +760,7 @@ int __init at91_clock_init(unsigned long main_clock)
 		pr_info("Clocks: PLLA overclocked, %ld MHz\n", plla.rate_hz / 1000000);
 
 	if (cpu_is_at91sam9g45()) {
-		mckr = at91_sys_read(AT91_PMC_MCKR);
+		mckr = pmc_readl(AT91_PMC_MCKR);
 		plla.rate_hz /= (1 << ((mckr & AT91_PMC_PLLADIV2) >> 12));	/* plla divisor by 2 */
 	}
 
@@ -709,7 +771,6 @@ int __init at91_clock_init(unsigned long main_clock)
 		utmi_clk.id = 3;
 	}
 
-
 	/*
 	 * USB HS clock init
 	 */
@@ -734,7 +795,7 @@ int __init at91_clock_init(unsigned long main_clock)
 	 * MCK and CPU derive from one of those primary clocks.
 	 * For now, assume this parentage won't change.
 	 */
-	mckr = at91_sys_read(AT91_PMC_MCKR);
+	mckr = pmc_readl(AT91_PMC_MCKR);
 	mck.parent = at91_css_to_clk(mckr & AT91_PMC_CSS);
 	freq = mck.parent->rate_hz;
 	freq /= (1 << ((mckr & AT91_PMC_PRES) >> 2));				/* prescale */
@@ -801,8 +862,8 @@ static int __init at91_clock_reset(void)
 		pr_debug("Clocks: disable unused %s\n", clk->name);
 	}
 
-	at91_sys_write(AT91_PMC_PCDR, pcdr);
-	at91_sys_write(AT91_PMC_SCDR, scdr);
+	pmc_writel(AT91_PMC_PCDR, pcdr);
+	pmc_writel(AT91_PMC_SCDR, scdr);
 
 	return 0;
 }
diff --git a/arch/arm/mach-at91/clock.h b/arch/arm/mach-at91/clock.h
index 6cf4b78..e929ffc 100644
--- a/arch/arm/mach-at91/clock.h
+++ b/arch/arm/mach-at91/clock.h
@@ -29,3 +29,4 @@ struct clk {
 
 
 extern int __init clk_register(struct clk *clk);
+extern int at91_clocks_valid_for_suspend(void);
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index f00ad37..2bd94d8 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -38,7 +38,7 @@ extern struct sys_timer at91sam926x_timer;
 extern struct sys_timer at91x40_timer;
 
  /* Clocks */
-extern int __init at91_clock_init(unsigned long main_clock);
+extern int __init at91_clock_init(void __iomem* regbase, unsigned long main_clock);
 struct device;
 extern void __init at91_clock_associate(const char *id, struct device *dev, const char *func);
 
@@ -61,5 +61,6 @@ struct at91_gpio_bank {
 extern void __init at91_gpio_init(struct at91_gpio_bank *, int nr_banks);
 extern void __init at91_gpio_irq_setup(void);
 
+extern void (*at91_arch_idle)(void);
 extern void (*at91_arch_reset)(void);
 extern int at91_extern_irq;
diff --git a/arch/arm/mach-at91/include/mach/at572d940hf.h b/arch/arm/mach-at91/include/mach/at572d940hf.h
index c258e4d..c31a8e2 100644
--- a/arch/arm/mach-at91/include/mach/at572d940hf.h
+++ b/arch/arm/mach-at91/include/mach/at572d940hf.h
@@ -97,7 +97,7 @@
 #define AT572D940HF_PIOA	(0xfffff400 - AT91_BASE_SYS)
 #define AT572D940HF_PIOB	(0xfffff600 - AT91_BASE_SYS)
 #define AT572D940HF_PIOC	(0xfffff800 - AT91_BASE_SYS)
-#define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
+#define AT572D940HF_PMC		(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT572D940HF_RTT		(0xfffffd20 - AT91_BASE_SYS)
 #define AT91_PIT	(0xfffffd30 - AT91_BASE_SYS)
diff --git a/arch/arm/mach-at91/include/mach/at91_pmc.h b/arch/arm/mach-at91/include/mach/at91_pmc.h
index ba429f7..7d5926e 100644
--- a/arch/arm/mach-at91/include/mach/at91_pmc.h
+++ b/arch/arm/mach-at91/include/mach/at91_pmc.h
@@ -16,10 +16,10 @@
 #ifndef AT91_PMC_H
 #define AT91_PMC_H
 
-#define	AT91_PMC_SCER		(AT91_PMC + 0x00)	/* System Clock Enable Register */
-#define	AT91_PMC_SCDR		(AT91_PMC + 0x04)	/* System Clock Disable Register */
+#define	AT91_PMC_SCER		0x00			/* System Clock Enable Register */
+#define	AT91_PMC_SCDR		0x04			/* System Clock Disable Register */
 
-#define	AT91_PMC_SCSR		(AT91_PMC + 0x08)	/* System Clock Status Register */
+#define	AT91_PMC_SCSR		0x08			/* System Clock Status Register */
 #define		AT91_PMC_PCK		(1 <<  0)		/* Processor Clock */
 #define		AT91RM9200_PMC_UDP	(1 <<  1)		/* USB Devcice Port Clock [AT91RM9200 only] */
 #define		AT91RM9200_PMC_MCKUDP	(1 <<  2)		/* USB Device Port Master Clock Automatic Disable on Suspend [AT91RM9200 only] */
@@ -36,27 +36,27 @@
 #define		AT91_PMC_HCK0		(1 << 16)		/* AHB Clock (USB host) [AT91SAM9261 only] */
 #define		AT91_PMC_HCK1		(1 << 17)		/* AHB Clock (LCD) [AT91SAM9261 only] */
 
-#define	AT91_PMC_PCER		(AT91_PMC + 0x10)	/* Peripheral Clock Enable Register */
-#define	AT91_PMC_PCDR		(AT91_PMC + 0x14)	/* Peripheral Clock Disable Register */
-#define	AT91_PMC_PCSR		(AT91_PMC + 0x18)	/* Peripheral Clock Status Register */
+#define	AT91_PMC_PCER		0x10			/* Peripheral Clock Enable Register */
+#define	AT91_PMC_PCDR		0x14			/* Peripheral Clock Disable Register */
+#define	AT91_PMC_PCSR		0x18			/* Peripheral Clock Status Register */
 
-#define	AT91_CKGR_UCKR		(AT91_PMC + 0x1C)	/* UTMI Clock Register [some SAM9, CAP9] */
+#define	AT91_CKGR_UCKR		0x1C			/* UTMI Clock Register [some SAM9, CAP9] */
 #define		AT91_PMC_UPLLEN		(1   << 16)		/* UTMI PLL Enable */
 #define		AT91_PMC_UPLLCOUNT	(0xf << 20)		/* UTMI PLL Start-up Time */
 #define		AT91_PMC_BIASEN		(1   << 24)		/* UTMI BIAS Enable */
 #define		AT91_PMC_BIASCOUNT	(0xf << 28)		/* UTMI BIAS Start-up Time */
 
-#define	AT91_CKGR_MOR		(AT91_PMC + 0x20)	/* Main Oscillator Register [not on SAM9RL] */
+#define	AT91_CKGR_MOR		0x20			/* Main Oscillator Register [not on SAM9RL] */
 #define		AT91_PMC_MOSCEN		(1    << 0)		/* Main Oscillator Enable */
 #define		AT91_PMC_OSCBYPASS	(1    << 1)		/* Oscillator Bypass [SAM9x, CAP9] */
 #define		AT91_PMC_OSCOUNT	(0xff << 8)		/* Main Oscillator Start-up Time */
 
-#define	AT91_CKGR_MCFR		(AT91_PMC + 0x24)	/* Main Clock Frequency Register */
+#define	AT91_CKGR_MCFR		0x24			/* Main Clock Frequency Register */
 #define		AT91_PMC_MAINF		(0xffff <<  0)		/* Main Clock Frequency */
 #define		AT91_PMC_MAINRDY	(1	<< 16)		/* Main Clock Ready */
 
-#define	AT91_CKGR_PLLAR		(AT91_PMC + 0x28)	/* PLL A Register */
-#define	AT91_CKGR_PLLBR		(AT91_PMC + 0x2c)	/* PLL B Register */
+#define	AT91_CKGR_PLLAR		0x28			/* PLL A Register */
+#define	AT91_CKGR_PLLBR		0x2c			/* PLL B Register */
 #define		AT91_PMC_DIV		(0xff  <<  0)		/* Divider */
 #define		AT91_PMC_PLLCOUNT	(0x3f  <<  8)		/* PLL Counter */
 #define		AT91_PMC_OUT		(3     << 14)		/* PLL Clock Frequency Range */
@@ -67,7 +67,7 @@
 #define			AT91_PMC_USBDIV_4		(2 << 28)
 #define		AT91_PMC_USB96M		(1     << 28)		/* Divider by 2 Enable (PLLB only) */
 
-#define	AT91_PMC_MCKR		(AT91_PMC + 0x30)	/* Master Clock Register */
+#define	AT91_PMC_MCKR		0x30			/* Master Clock Register */
 #define		AT91_PMC_CSS		(3 <<  0)		/* Master Clock Selection */
 #define			AT91_PMC_CSS_SLOW		(0 << 0)
 #define			AT91_PMC_CSS_MAIN		(1 << 0)
@@ -99,20 +99,20 @@
 #define			AT91_PMC_PLLADIV2_OFF		(0 << 12)
 #define			AT91_PMC_PLLADIV2_ON		(1 << 12)
 
-#define	AT91_PMC_USB		(AT91_PMC + 0x38)	/* USB Clock Register [some SAM9 only] */
+#define	AT91_PMC_USB		0x38			/* USB Clock Register [some SAM9 only] */
 #define		AT91_PMC_USBS		(0x1 <<  0)		/* USB OHCI Input clock selection */
 #define			AT91_PMC_USBS_PLLA		(0 << 0)
 #define			AT91_PMC_USBS_UPLL		(1 << 0)
 #define		AT91_PMC_OHCIUSBDIV	(0xF <<  8)		/* Divider for USB OHCI Clock */
 
-#define	AT91_PMC_PCKR(n)	(AT91_PMC + 0x40 + ((n) * 4))	/* Programmable Clock 0-N Registers */
+#define	AT91_PMC_PCKR(n)	(0x40 + ((n) * 4))	/* Programmable Clock 0-N Registers */
 #define		AT91_PMC_CSSMCK		(0x1 <<  8)		/* CSS or Master Clock Selection */
 #define			AT91_PMC_CSSMCK_CSS		(0 << 8)
 #define			AT91_PMC_CSSMCK_MCK		(1 << 8)
 
-#define	AT91_PMC_IER		(AT91_PMC + 0x60)	/* Interrupt Enable Register */
-#define	AT91_PMC_IDR		(AT91_PMC + 0x64)	/* Interrupt Disable Register */
-#define	AT91_PMC_SR		(AT91_PMC + 0x68)	/* Status Register */
+#define	AT91_PMC_IER		0x60			/* Interrupt Enable Register */
+#define	AT91_PMC_IDR		0x64			/* Interrupt Disable Register */
+#define	AT91_PMC_SR		0x68			/* Status Register */
 #define		AT91_PMC_MOSCS		(1 <<  0)		/* MOSCS Flag */
 #define		AT91_PMC_LOCKA		(1 <<  1)		/* PLLA Lock */
 #define		AT91_PMC_LOCKB		(1 <<  2)		/* PLLB Lock */
@@ -123,11 +123,11 @@
 #define		AT91_PMC_PCK1RDY	(1 <<  9)		/* Programmable Clock 1 */
 #define		AT91_PMC_PCK2RDY	(1 << 10)		/* Programmable Clock 2 */
 #define		AT91_PMC_PCK3RDY	(1 << 11)		/* Programmable Clock 3 */
-#define	AT91_PMC_IMR		(AT91_PMC + 0x6c)	/* Interrupt Mask Register */
+#define	AT91_PMC_IMR		0x6c			/* Interrupt Mask Register */
 
-#define AT91_PMC_PROT		(AT91_PMC + 0xe4)	/* Protect Register [AT91CAP9 revC only] */
+#define AT91_PMC_PROT		0xe4			/* Protect Register [AT91CAP9 revC only] */
 #define		AT91_PMC_PROTKEY	0x504d4301		/* Activation Code */
 
-#define AT91_PMC_VER		(AT91_PMC + 0xfc)	/* PMC Module Version [AT91CAP9 only] */
+#define AT91_PMC_VER		0xfc			/* PMC Module Version [AT91CAP9 only] */
 
 #endif
diff --git a/arch/arm/mach-at91/include/mach/at91cap9.h b/arch/arm/mach-at91/include/mach/at91cap9.h
index 3f9b00c..1128dcf 100644
--- a/arch/arm/mach-at91/include/mach/at91cap9.h
+++ b/arch/arm/mach-at91/include/mach/at91cap9.h
@@ -95,7 +95,7 @@
 #define AT91CAP9_PIOB	(0xfffff400 - AT91_BASE_SYS)
 #define AT91CAP9_PIOC	(0xfffff600 - AT91_BASE_SYS)
 #define AT91CAP9_PIOD	(0xfffff800 - AT91_BASE_SYS)
-#define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
+#define AT91CAP9_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
 #define AT91CAP9_RTT	(0xfffffd20 - AT91_BASE_SYS)
diff --git a/arch/arm/mach-at91/include/mach/at91rm9200.h b/arch/arm/mach-at91/include/mach/at91rm9200.h
index 0da806f..ef01000 100644
--- a/arch/arm/mach-at91/include/mach/at91rm9200.h
+++ b/arch/arm/mach-at91/include/mach/at91rm9200.h
@@ -88,7 +88,7 @@
 #define AT91RM9200_PIOB	(0xfffff600 - AT91_BASE_SYS)	/* PIO Controller B */
 #define AT91RM9200_PIOC	(0xfffff800 - AT91_BASE_SYS)	/* PIO Controller C */
 #define AT91RM9200_PIOD	(0xfffffa00 - AT91_BASE_SYS)	/* PIO Controller D */
-#define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)	/* Power Management Controller */
+#define AT91RM9200_PMC	(0xfffffc00 - AT91_BASE_SYS)	/* Power Management Controller */
 #define AT91_ST		(0xfffffd00 - AT91_BASE_SYS)	/* System Timer */
 #define AT91RM9200_RTC	(0xfffffe00 - AT91_BASE_SYS)	/* Real-Time Clock */
 #define AT91_MC		(0xffffff00 - AT91_BASE_SYS)	/* Memory Controllers */
diff --git a/arch/arm/mach-at91/include/mach/at91sam9260.h b/arch/arm/mach-at91/include/mach/at91sam9260.h
index c37b67e..65cd119 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9260.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9260.h
@@ -93,7 +93,7 @@
 #define AT91SAM9260_PIOA	(0xfffff400 - AT91_BASE_SYS)
 #define AT91SAM9260_PIOB	(0xfffff600 - AT91_BASE_SYS)
 #define AT91SAM9260_PIOC	(0xfffff800 - AT91_BASE_SYS)
-#define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
+#define AT91SAM9260_PMC		(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
 #define AT91SAM9260_RTT		(0xfffffd20 - AT91_BASE_SYS)
diff --git a/arch/arm/mach-at91/include/mach/at91sam9261.h b/arch/arm/mach-at91/include/mach/at91sam9261.h
index aebd964..5807d0e 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9261.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9261.h
@@ -76,7 +76,7 @@
 #define AT91SAM9261_PIOA	(0xfffff400 - AT91_BASE_SYS)
 #define AT91SAM9261_PIOB	(0xfffff600 - AT91_BASE_SYS)
 #define AT91SAM9261_PIOC	(0xfffff800 - AT91_BASE_SYS)
-#define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
+#define AT91SAM9261_PMC		(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
 #define AT91SAM9261_RTT		(0xfffffd20 - AT91_BASE_SYS)
diff --git a/arch/arm/mach-at91/include/mach/at91sam9263.h b/arch/arm/mach-at91/include/mach/at91sam9263.h
index df10b7e..9d5ed94 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9263.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9263.h
@@ -92,7 +92,7 @@
 #define AT91SAM9263_PIOC	(0xfffff600 - AT91_BASE_SYS)
 #define AT91SAM9263_PIOD	(0xfffff800 - AT91_BASE_SYS)
 #define AT91SAM9263_PIOE	(0xfffffa00 - AT91_BASE_SYS)
-#define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
+#define AT91SAM9263_PMC		(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
 #define AT91SAM9263_RTT0	(0xfffffd20 - AT91_BASE_SYS)
diff --git a/arch/arm/mach-at91/include/mach/at91sam9g45.h b/arch/arm/mach-at91/include/mach/at91sam9g45.h
index 22fb598..10c492c 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9g45.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9g45.h
@@ -102,7 +102,7 @@
 #define AT91SAM9G45_PIOC	(0xfffff600 - AT91_BASE_SYS)
 #define AT91SAM9G45_PIOD	(0xfffff800 - AT91_BASE_SYS)
 #define AT91SAM9G45_PIOE	(0xfffffa00 - AT91_BASE_SYS)
-#define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
+#define AT91SAM9G45_PMC		(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
 #define AT91SAM9G45_RTT		(0xfffffd20 - AT91_BASE_SYS)
diff --git a/arch/arm/mach-at91/include/mach/at91sam9rl.h b/arch/arm/mach-at91/include/mach/at91sam9rl.h
index 7920d96..337a84a 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9rl.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9rl.h
@@ -84,7 +84,7 @@
 #define AT91SAM9RL_PIOB		(0xfffff600 - AT91_BASE_SYS)
 #define AT91SAM9RL_PIOC		(0xfffff800 - AT91_BASE_SYS)
 #define AT91SAM9RL_PIOD		(0xfffffa00 - AT91_BASE_SYS)
-#define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
+#define AT91SAM9RL_PMC		(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
 #define AT91SAM9RL_RTT		(0xfffffd20 - AT91_BASE_SYS)
diff --git a/arch/arm/mach-at91/include/mach/at91x40.h b/arch/arm/mach-at91/include/mach/at91x40.h
index 07e4f6e..92cbb6b 100644
--- a/arch/arm/mach-at91/include/mach/at91x40.h
+++ b/arch/arm/mach-at91/include/mach/at91x40.h
@@ -36,14 +36,17 @@
 
 #define AT91_EBI	(0xffe00000 - AT91_BASE_SYS)	/* External Bus Interface */
 #define AT91X40_SF	(0xfff00000 - AT91_BASE_SYS)	/* Special Function */
-#define AT91_USART1	(0xfffcc000 - AT91_BASE_SYS)	/* USART 1 */
-#define AT91_USART0	(0xfffd0000 - AT91_BASE_SYS)	/* USART 0 */
+#define AT91X40_USART1	(0xfffcc000 - AT91_BASE_SYS)	/* USART 1 */
+#define AT91X40_USART0	(0xfffd0000 - AT91_BASE_SYS)	/* USART 0 */
 #define AT91_TC		(0xfffe0000 - AT91_BASE_SYS)	/* Timer Counter */
 #define AT91X40_PIOA	(0xffff0000 - AT91_BASE_SYS)	/* PIO Controller A */
 #define AT91X40_PS	(0xffff4000 - AT91_BASE_SYS)	/* Power Save */
 #define AT91X40_WD	(0xffff8000 - AT91_BASE_SYS)	/* Watchdog Timer */
 #define AT91X40_AIC	(0xfffff000 - AT91_BASE_SYS)	/* Advanced Interrupt Controller */
 
+#define AT91_USART0	AT91X40_USART0
+#define AT91_USART1	AT91X40_USART1
+
 /*
  * The AT91x40 series doesn't have a debug unit like the other AT91 parts.
  * But it does have a chip identify register and extension ID, so define at
@@ -56,7 +59,7 @@
 /*
  * Support defines for the simple Power Controller module.
  */
-#define	AT91_PS_CR	(AT91X40_PS + 0)	/* PS Control register */
+#define	AT91_PS_CR	(0x00)			/* PS Control register */
 #define	AT91_PS_CR_CPU		(1 << 0)		/* CPU clock disable bit */
 
 #endif /* AT91X40_H */
diff --git a/arch/arm/mach-at91/include/mach/cpu.h b/arch/arm/mach-at91/include/mach/cpu.h
index 521d8ed..90bba33 100644
--- a/arch/arm/mach-at91/include/mach/cpu.h
+++ b/arch/arm/mach-at91/include/mach/cpu.h
@@ -83,7 +83,7 @@ static inline unsigned long at91_sram_size(void)
 
 static inline unsigned long at91cap9_rev_identify(void)
 {
-	return (at91_sys_read(AT91_PMC_VER));
+	return (at91_sys_read(AT91CAP9_PMC + AT91_PMC_VER));
 }
 #endif
 
diff --git a/arch/arm/mach-at91/include/mach/system.h b/arch/arm/mach-at91/include/mach/system.h
index 44dc3f7..3acd2d2 100644
--- a/arch/arm/mach-at91/include/mach/system.h
+++ b/arch/arm/mach-at91/include/mach/system.h
@@ -22,29 +22,14 @@
 #define __ASM_ARCH_SYSTEM_H
 
 #include <mach/hardware.h>
-#include <mach/at91_st.h>
-#include <mach/at91_dbgu.h>
-#include <mach/at91_pmc.h>
+
+void (*at91_arch_idle)(void);
 
 static inline void arch_idle(void)
 {
-	/*
-	 * Disable the processor clock.  The processor will be automatically
-	 * re-enabled by an interrupt or by a reset.
-	 */
-#ifdef AT91X40_PS
-	at91_sys_write(AT91X40_PS_CR, AT91_PS_CR_CPU);
-#else
-	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
-#endif
-#ifndef CONFIG_CPU_ARM920T
-	/*
-	 * Set the processor (CP15) into 'Wait for Interrupt' mode.
-	 * Post-RM9200 processors need this in conjunction with the above
-	 * to save power when idle.
-	 */
-	cpu_do_idle();
-#endif
+	/* call the CPU-specific idle function */
+	if (at91_arch_idle)
+		(at91_arch_idle)();
 }
 
 void (*at91_arch_reset)(void);
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 852c417..544a18f 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -29,6 +29,7 @@
 #include <mach/cpu.h>
 
 #include "generic.h"
+#include "clock.h"
 #include "pm.h"
 
 /*
@@ -130,55 +131,6 @@ static int at91_pm_begin(suspend_state_t state)
 }
 
 /*
- * Verify that all the clocks are correct before entering
- * slow-clock mode.
- */
-static int at91_pm_verify_clocks(void)
-{
-	unsigned long scsr;
-	int i;
-
-	scsr = at91_sys_read(AT91_PMC_SCSR);
-
-	/* USB must not be using PLLB */
-	if (cpu_is_at91rm9200()) {
-		if ((scsr & (AT91RM9200_PMC_UHP | AT91RM9200_PMC_UDP)) != 0) {
-			pr_err("AT91: PM - Suspend-to-RAM with USB still active\n");
-			return 0;
-		}
-	} else if (cpu_is_at91sam9260() || cpu_is_at91sam9261() || cpu_is_at91sam9263()
-			|| cpu_is_at91sam9g20() || cpu_is_at91sam9g10()) {
-		if ((scsr & (AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP)) != 0) {
-			pr_err("AT91: PM - Suspend-to-RAM with USB still active\n");
-			return 0;
-		}
-	} else if (cpu_is_at91cap9()) {
-		if ((scsr & AT91CAP9_PMC_UHP) != 0) {
-			pr_err("AT91: PM - Suspend-to-RAM with USB still active\n");
-			return 0;
-		}
-	}
-
-#ifdef CONFIG_AT91_PROGRAMMABLE_CLOCKS
-	/* PCK0..PCK3 must be disabled, or configured to use clk32k */
-	for (i = 0; i < 4; i++) {
-		u32 css;
-
-		if ((scsr & (AT91_PMC_PCK0 << i)) == 0)
-			continue;
-
-		css = at91_sys_read(AT91_PMC_PCKR(i)) & AT91_PMC_CSS;
-		if (css != AT91_PMC_CSS_SLOW) {
-			pr_err("AT91: PM - Suspend-to-RAM with PCK%d src %d\n", i, css);
-			return 0;
-		}
-	}
-#endif
-
-	return 1;
-}
-
-/*
  * Call this from platform driver suspend() to see how deeply to suspend.
  * For example, some controllers (like OHCI) need one of the PLL clocks
  * in order to act as a wakeup source, and those are not available when
@@ -228,7 +180,7 @@ static int at91_pm_enter(suspend_state_t state)
 			/*
 			 * Ensure that clocks are in a valid state.
 			 */
-			if (!at91_pm_verify_clocks())
+			if (!at91_clocks_valid_for_suspend())
 				goto error;
 
 			/*
diff --git a/arch/arm/mach-at91/pm_slowclock.S b/arch/arm/mach-at91/pm_slowclock.S
index f7922a4..467ae53 100644
--- a/arch/arm/mach-at91/pm_slowclock.S
+++ b/arch/arm/mach-at91/pm_slowclock.S
@@ -57,7 +57,7 @@
 1:	sub	r4, r4, #1
 	cmp	r4, #0
 	beq	2f
-	ldr	r3, [r1, #(AT91_PMC_SR - AT91_PMC)]
+	ldr	r3, [r1, #(AT91_PMC_SR)]
 	tst	r3, #AT91_PMC_MCKRDY
 	beq	1b
 2:
@@ -71,7 +71,7 @@
 1:	sub	r4, r4, #1
 	cmp	r4, #0
 	beq	2f
-	ldr	r3, [r1, #(AT91_PMC_SR - AT91_PMC)]
+	ldr	r3, [r1, #(AT91_PMC_SR)]
 	tst	r3, #AT91_PMC_MOSCS
 	beq	1b
 2:
@@ -85,7 +85,7 @@
 1:	sub	r4, r4, #1
 	cmp	r4, #0
 	beq	2f
-	ldr	r3, [r1, #(AT91_PMC_SR - AT91_PMC)]
+	ldr	r3, [r1, #(AT91_PMC_SR)]
 	tst	r3, #AT91_PMC_LOCKA
 	beq	1b
 2:
@@ -99,7 +99,7 @@
 1:	sub	r4, r4, #1
 	cmp	r4, #0
 	beq	2f
-	ldr	r3, [r1, #(AT91_PMC_SR - AT91_PMC)]
+	ldr	r3, [r1, #(AT91_PMC_SR)]
 	tst	r3, #AT91_PMC_LOCKB
 	beq	1b
 2:
@@ -119,7 +119,8 @@ ENTRY(at91_slow_clock)
 	 *  R4 = temporary register
 	 *  R5 = Base address of second RAM Controller or 0 if not present
 	 */
-	ldr	r1, .at91_va_base_pmc
+	ldr	r1, =at91_pmc_base_addr
+	ldr	r1, [r1]
 	ldr	r2, .at91_va_base_sdramc
 	ldr	r5, .at91_va_base_ramc1
 
@@ -161,14 +162,14 @@ ENTRY(at91_slow_clock)
 #endif
 
 	/* Save Master clock setting */
-	ldr	r3, [r1, #(AT91_PMC_MCKR - AT91_PMC)]
+	ldr	r3, [r1, #(AT91_PMC_MCKR)]
 	str	r3, .saved_mckr
 
 	/*
 	 * Set the Master clock source to slow clock
 	 */
 	bic	r3, r3, #AT91_PMC_CSS
-	str	r3, [r1, #(AT91_PMC_MCKR - AT91_PMC)]
+	str	r3, [r1, #(AT91_PMC_MCKR)]
 
 	wait_mckrdy
 
@@ -179,44 +180,44 @@ ENTRY(at91_slow_clock)
 	 * See AT91RM9200 errata #27 and #28 for details.
 	 */
 	mov	r3, #0
-	str	r3, [r1, #(AT91_PMC_MCKR - AT91_PMC)]
+	str	r3, [r1, #(AT91_PMC_MCKR)]
 
 	wait_mckrdy
 #endif
 
 	/* Save PLLA setting and disable it */
-	ldr	r3, [r1, #(AT91_CKGR_PLLAR - AT91_PMC)]
+	ldr	r3, [r1, #(AT91_CKGR_PLLAR)]
 	str	r3, .saved_pllar
 
 	mov	r3, #AT91_PMC_PLLCOUNT
 	orr	r3, r3, #(1 << 29)		/* bit 29 always set */
-	str	r3, [r1, #(AT91_CKGR_PLLAR - AT91_PMC)]
+	str	r3, [r1, #(AT91_CKGR_PLLAR)]
 
 	/* Save PLLB setting and disable it */
-	ldr	r3, [r1, #(AT91_CKGR_PLLBR - AT91_PMC)]
+	ldr	r3, [r1, #(AT91_CKGR_PLLBR)]
 	str	r3, .saved_pllbr
 
 	mov	r3, #AT91_PMC_PLLCOUNT
-	str	r3, [r1, #(AT91_CKGR_PLLBR - AT91_PMC)]
+	str	r3, [r1, #(AT91_CKGR_PLLBR)]
 
 	/* Turn off the main oscillator */
-	ldr	r3, [r1, #(AT91_CKGR_MOR - AT91_PMC)]
+	ldr	r3, [r1, #(AT91_CKGR_MOR)]
 	bic	r3, r3, #AT91_PMC_MOSCEN
-	str	r3, [r1, #(AT91_CKGR_MOR - AT91_PMC)]
+	str	r3, [r1, #(AT91_CKGR_MOR)]
 
 	/* Wait for interrupt */
 	mcr	p15, 0, r0, c7, c0, 4
 
 	/* Turn on the main oscillator */
-	ldr	r3, [r1, #(AT91_CKGR_MOR - AT91_PMC)]
+	ldr	r3, [r1, #(AT91_CKGR_MOR)]
 	orr	r3, r3, #AT91_PMC_MOSCEN
-	str	r3, [r1, #(AT91_CKGR_MOR - AT91_PMC)]
+	str	r3, [r1, #(AT91_CKGR_MOR)]
 
 	wait_moscrdy
 
 	/* Restore PLLB setting */
 	ldr	r3, .saved_pllbr
-	str	r3, [r1, #(AT91_CKGR_PLLBR - AT91_PMC)]
+	str	r3, [r1, #(AT91_CKGR_PLLBR)]
 
 	tst	r3, #(AT91_PMC_MUL &  0xff0000)
 	bne	1f
@@ -228,7 +229,7 @@ ENTRY(at91_slow_clock)
 
 	/* Restore PLLA setting */
 	ldr	r3, .saved_pllar
-	str	r3, [r1, #(AT91_CKGR_PLLAR - AT91_PMC)]
+	str	r3, [r1, #(AT91_CKGR_PLLAR)]
 
 	tst	r3, #(AT91_PMC_MUL &  0xff0000)
 	bne	3f
@@ -249,7 +250,7 @@ ENTRY(at91_slow_clock)
 	tst	r3, #AT91_PMC_PRES
 	beq	2f
 	and	r3, r3, #AT91_PMC_PRES
-	str	r3, [r1, #(AT91_PMC_MCKR - AT91_PMC)]
+	str	r3, [r1, #(AT91_PMC_MCKR)]
 
 	wait_mckrdy
 #endif
@@ -258,7 +259,7 @@ ENTRY(at91_slow_clock)
 	 * Restore master clock setting
 	 */
 2:	ldr	r3, .saved_mckr
-	str	r3, [r1, #(AT91_PMC_MCKR - AT91_PMC)]
+	str	r3, [r1, #(AT91_PMC_MCKR)]
 
 	wait_mckrdy
 
@@ -300,9 +301,6 @@ ENTRY(at91_slow_clock)
 .saved_sam9_lpr1:
 	.word 0
 
-.at91_va_base_pmc:
-	.word AT91_VA_BASE_SYS + AT91_PMC
-
 #ifdef CONFIG_ARCH_AT91RM9200
 .at91_va_base_sdramc:
 	.word AT91_VA_BASE_SYS
diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index e7c65a4..c137b99 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -332,12 +332,12 @@ static int vbus_is_present(struct usba_udc *udc)
 
 static void toggle_bias(int is_on)
 {
-	unsigned int uckr = at91_sys_read(AT91_CKGR_UCKR);
+	unsigned int uckr = at91_sys_read(AT91SAM9RL_PMC + AT91_CKGR_UCKR);
 
 	if (is_on)
-		at91_sys_write(AT91_CKGR_UCKR, uckr | AT91_PMC_BIASEN);
+		at91_sys_write(AT91SAM9RL_PMC + AT91_CKGR_UCKR, uckr | AT91_PMC_BIASEN);
 	else
-		at91_sys_write(AT91_CKGR_UCKR, uckr & ~(AT91_PMC_BIASEN));
+		at91_sys_write(AT91SAM9RL_PMC + AT91_CKGR_UCKR, uckr & ~(AT91_PMC_BIASEN));
 }
 
 #else
