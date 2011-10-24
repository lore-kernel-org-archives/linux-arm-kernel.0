From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 24 Oct 2011 05:49:51 -0400
Subject: [PATCH 02/12] ARM: mach-at91: move special idle code to a out-of-line
	pm_idle hook
In-Reply-To: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
References: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
Message-ID: <1319449801-12367-3-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-at91/at91cap9.c            |    8 ++++++++
 arch/arm/mach-at91/at91rm9200.c          |   11 +++++++++++
 arch/arm/mach-at91/at91sam9260.c         |    8 ++++++++
 arch/arm/mach-at91/at91sam9261.c         |    8 ++++++++
 arch/arm/mach-at91/at91sam9263.c         |    8 ++++++++
 arch/arm/mach-at91/at91sam9g45.c         |    8 ++++++++
 arch/arm/mach-at91/at91sam9rl.c          |    8 ++++++++
 arch/arm/mach-at91/at91x40.c             |   11 +++++++++++
 arch/arm/mach-at91/include/mach/system.h |   16 ----------------
 9 files changed, 70 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index bfc684441e..cfacd93cb7 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -311,6 +311,13 @@ static struct at91_gpio_bank at91cap9_gpio[] = {
 	}
 };
 
+static void at91cap9_idle(void)
+{
+	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
+	cpu_do_idle();
+	local_irq_enable();
+}
+
 static void at91cap9_reset(void)
 {
 	at91_sys_write(AT91_RSTC_CR, AT91_RSTC_KEY | AT91_RSTC_PROCRST | AT91_RSTC_PERRST);
@@ -333,6 +340,7 @@ static void __init at91cap9_map_io(void)
 
 static void __init at91cap9_initialize(void)
 {
+	pm_idle = at91cap9_idle;
 	at91_arch_reset = at91cap9_reset;
 	pm_power_off = at91cap9_poweroff;
 	at91_extern_irq = (1 << AT91CAP9_ID_IRQ0) | (1 << AT91CAP9_ID_IRQ1);
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index f73302dbc6..3eff653d69 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -286,6 +286,16 @@ static struct at91_gpio_bank at91rm9200_gpio[] = {
 	}
 };
 
+static void at91rm9200_idle(void)
+{
+	/*
+	 * Disable the processor clock.  The processor will be automatically
+	 * re-enabled by an interrupt or by a reset.
+	 */
+	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
+	local_irq_enable();
+}
+
 static void at91rm9200_reset(void)
 {
 	/*
@@ -307,6 +317,7 @@ static void __init at91rm9200_map_io(void)
 
 static void __init at91rm9200_initialize(void)
 {
+	pm_idle = at91rm9200_idle;
 	at91_arch_reset = at91rm9200_reset;
 	at91_extern_irq = (1 << AT91RM9200_ID_IRQ0) | (1 << AT91RM9200_ID_IRQ1)
 			| (1 << AT91RM9200_ID_IRQ2) | (1 << AT91RM9200_ID_IRQ3)
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index cb397be144..42892a3080 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -315,8 +315,16 @@ static void __init at91sam9260_map_io(void)
 	}
 }
 
+static void at91sam9260_idle(void)
+{
+	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
+	cpu_do_idle();
+	local_irq_enable();
+}
+
 static void __init at91sam9260_initialize(void)
 {
+	pm_idle = at91sam9260_idle;
 	at91_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9260_poweroff;
 	at91_extern_irq = (1 << AT91SAM9260_ID_IRQ0) | (1 << AT91SAM9260_ID_IRQ1)
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 6c8e3b5f66..f8ced39969 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -284,8 +284,16 @@ static void __init at91sam9261_map_io(void)
 		at91_init_sram(0, AT91SAM9261_SRAM_BASE, AT91SAM9261_SRAM_SIZE);
 }
 
+static void at91sam9261_idle(void)
+{
+	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
+	cpu_do_idle();
+	local_irq_enable();
+}
+
 static void __init at91sam9261_initialize(void)
 {
+	pm_idle = at91sam9261_idle;
 	at91_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9261_poweroff;
 	at91_extern_irq = (1 << AT91SAM9261_ID_IRQ0) | (1 << AT91SAM9261_ID_IRQ1)
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 044f3c927e..acf3f1e488 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -301,8 +301,16 @@ static void __init at91sam9263_map_io(void)
 	at91_init_sram(1, AT91SAM9263_SRAM1_BASE, AT91SAM9263_SRAM1_SIZE);
 }
 
+static void at91sam9263_idle(void)
+{
+	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
+	cpu_do_idle();
+	local_irq_enable();
+}
+
 static void __init at91sam9263_initialize(void)
 {
+	pm_idle = at91sam9263_idle;
 	at91_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9263_poweroff;
 	at91_extern_irq = (1 << AT91SAM9263_ID_IRQ0) | (1 << AT91SAM9263_ID_IRQ1);
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 1532b508c8..bef812d1f1 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -302,6 +302,13 @@ static struct at91_gpio_bank at91sam9g45_gpio[] = {
 	}
 };
 
+static void at91sam9g45_idle(void)
+{
+	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
+	cpu_do_idle();
+	local_irq_enable();
+}
+
 static void at91sam9g45_reset(void)
 {
 	at91_sys_write(AT91_RSTC_CR, AT91_RSTC_KEY | AT91_RSTC_PROCRST | AT91_RSTC_PERRST);
@@ -325,6 +332,7 @@ static void __init at91sam9g45_map_io(void)
 
 static void __init at91sam9g45_initialize(void)
 {
+	pm_idle = at91sam9g45_idle;
 	at91_arch_reset = at91sam9g45_reset;
 	pm_power_off = at91sam9g45_poweroff;
 	at91_extern_irq = (1 << AT91SAM9G45_ID_IRQ0);
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index a238105d2c..4952451c8e 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -290,8 +290,16 @@ static void __init at91sam9rl_map_io(void)
 	at91_init_sram(0, AT91SAM9RL_SRAM_BASE, sram_size);
 }
 
+static void at91sam9rl_idle(void)
+{
+	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
+	cpu_do_idle();
+	local_irq_enable();
+}
+
 static void __init at91sam9rl_initialize(void)
 {
+	pm_idle = at91sam9rl_idle;
 	at91_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9rl_poweroff;
 	at91_extern_irq = (1 << AT91SAM9RL_ID_IRQ0);
diff --git a/arch/arm/mach-at91/at91x40.c b/arch/arm/mach-at91/at91x40.c
index 56ba3bd035..d6a174e155 100644
--- a/arch/arm/mach-at91/at91x40.c
+++ b/arch/arm/mach-at91/at91x40.c
@@ -37,8 +37,19 @@ unsigned long clk_get_rate(struct clk *clk)
 	return AT91X40_MASTER_CLOCK;
 }
 
+static void at91x40_idle(void)
+{
+	/*
+	 * Disable the processor clock.  The processor will be automatically
+	 * re-enabled by an interrupt or by a reset.
+	 */
+	at91_sys_write(AT91_PS_CR, AT91_PS_CR_CPU);
+	cpu_do_idle();
+}
+
 void __init at91x40_initialize(unsigned long main_clock)
 {
+	pm_idle = at91x40_idle;
 	at91_extern_irq = (1 << AT91X40_ID_IRQ0) | (1 << AT91X40_ID_IRQ1)
 			| (1 << AT91X40_ID_IRQ2);
 }
diff --git a/arch/arm/mach-at91/include/mach/system.h b/arch/arm/mach-at91/include/mach/system.h
index 36af14bc13..ed2ec8e4bc 100644
--- a/arch/arm/mach-at91/include/mach/system.h
+++ b/arch/arm/mach-at91/include/mach/system.h
@@ -28,23 +28,7 @@
 
 static inline void arch_idle(void)
 {
-	/*
-	 * Disable the processor clock.  The processor will be automatically
-	 * re-enabled by an interrupt or by a reset.
-	 */
-#ifdef AT91_PS
-	at91_sys_write(AT91_PS_CR, AT91_PS_CR_CPU);
-#else
-	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
-#endif
-#ifndef CONFIG_CPU_ARM920T
-	/*
-	 * Set the processor (CP15) into 'Wait for Interrupt' mode.
-	 * Post-RM9200 processors need this in conjunction with the above
-	 * to save power when idle.
-	 */
 	cpu_do_idle();
-#endif
 }
 
 void (*at91_arch_reset)(void);
-- 
1.7.7.1.431.g10b2a
