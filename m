From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Dec 2011 04:47:34 -0500
Subject: [PATCH 05/20] ARM: mach-at91: move special idle code out of line
In-Reply-To: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
Message-ID: <1324288069-21940-6-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

... and hook it to arm_pm_idle.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-at91/at91cap9.c            |    8 ++++++++
 arch/arm/mach-at91/at91rm9200.c          |   10 ++++++++++
 arch/arm/mach-at91/at91sam9260.c         |    8 ++++++++
 arch/arm/mach-at91/at91sam9261.c         |    8 ++++++++
 arch/arm/mach-at91/at91sam9263.c         |    8 ++++++++
 arch/arm/mach-at91/at91sam9g45.c         |    7 +++++++
 arch/arm/mach-at91/at91sam9rl.c          |    8 ++++++++
 arch/arm/mach-at91/at91x40.c             |   12 ++++++++++++
 arch/arm/mach-at91/include/mach/system.h |   21 ---------------------
 9 files changed, 69 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index 29373397d2..f1c829f2a0 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 
+#include <asm/proc-fns.h>
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -313,6 +314,12 @@ static struct at91_gpio_bank at91cap9_gpio[] = {
 	}
 };
 
+static void at91cap9_idle(void)
+{
+	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
+	cpu_do_idle();
+}
+
 static void at91cap9_restart(char mode, const char *cmd)
 {
 	at91_sys_write(AT91_RSTC_CR, AT91_RSTC_KEY | AT91_RSTC_PROCRST | AT91_RSTC_PERRST);
@@ -335,6 +342,7 @@ static void __init at91cap9_map_io(void)
 
 static void __init at91cap9_initialize(void)
 {
+	arm_pm_idle = at91cap9_idle;
 	arm_pm_restart = at91cap9_restart;
 	pm_power_off = at91cap9_poweroff;
 	at91_extern_irq = (1 << AT91CAP9_ID_IRQ0) | (1 << AT91CAP9_ID_IRQ1);
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 430a9fdc3d..4327aa26ad 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -288,6 +288,15 @@ static struct at91_gpio_bank at91rm9200_gpio[] = {
 	}
 };
 
+static void at91rm9200_idle(void)
+{
+	/*
+	 * Disable the processor clock.  The processor will be automatically
+	 * re-enabled by an interrupt or by a reset.
+	 */
+	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
+}
+
 static void at91rm9200_restart(char mode, const char *cmd)
 {
 	/*
@@ -309,6 +318,7 @@ static void __init at91rm9200_map_io(void)
 
 static void __init at91rm9200_initialize(void)
 {
+	arm_pm_idle = at91rm9200_idle;
 	arm_pm_restart = at91rm9200_restart;
 	at91_extern_irq = (1 << AT91RM9200_ID_IRQ0) | (1 << AT91RM9200_ID_IRQ1)
 			| (1 << AT91RM9200_ID_IRQ2) | (1 << AT91RM9200_ID_IRQ3)
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index ec9e23dbce..66751edea1 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 
+#include <asm/proc-fns.h>
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -325,8 +326,15 @@ static void __init at91sam9260_map_io(void)
 	}
 }
 
+static void at91sam9260_idle(void)
+{
+	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
+	cpu_do_idle();
+}
+
 static void __init at91sam9260_initialize(void)
 {
+	arm_pm_idle = at91sam9260_idle;
 	arm_pm_restart = at91sam9_alt_restart;
 	pm_power_off = at91sam9260_poweroff;
 	at91_extern_irq = (1 << AT91SAM9260_ID_IRQ0) | (1 << AT91SAM9260_ID_IRQ1)
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 19ac7c0729..40ac62024d 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 
+#include <asm/proc-fns.h>
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -285,8 +286,15 @@ static void __init at91sam9261_map_io(void)
 		at91_init_sram(0, AT91SAM9261_SRAM_BASE, AT91SAM9261_SRAM_SIZE);
 }
 
+static void at91sam9261_idle(void)
+{
+	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
+	cpu_do_idle();
+}
+
 static void __init at91sam9261_initialize(void)
 {
+	arm_pm_idle = at91sam9261_idle;
 	arm_pm_restart = at91sam9_alt_restart;
 	pm_power_off = at91sam9261_poweroff;
 	at91_extern_irq = (1 << AT91SAM9261_ID_IRQ0) | (1 << AT91SAM9261_ID_IRQ1)
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 50d0163100..5e2485bcd3 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 
+#include <asm/proc-fns.h>
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -303,8 +304,15 @@ static void __init at91sam9263_map_io(void)
 	at91_init_sram(1, AT91SAM9263_SRAM1_BASE, AT91SAM9263_SRAM1_SIZE);
 }
 
+static void at91sam9263_idle(void)
+{
+	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
+	cpu_do_idle();
+}
+
 static void __init at91sam9263_initialize(void)
 {
+	arm_pm_idle = at91sam9263_idle;
 	arm_pm_restart = at91sam9_alt_restart;
 	pm_power_off = at91sam9263_poweroff;
 	at91_extern_irq = (1 << AT91SAM9263_ID_IRQ0) | (1 << AT91SAM9263_ID_IRQ1);
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index ff21f7a60c..e3a0f0c078 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -317,6 +317,12 @@ static struct at91_gpio_bank at91sam9g45_gpio[] = {
 	}
 };
 
+static void at91sam9g45_idle(void)
+{
+	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
+	cpu_do_idle();
+}
+
 static void at91sam9g45_restart(char mode, const char *cmd)
 {
 	at91_sys_write(AT91_RSTC_CR, AT91_RSTC_KEY | AT91_RSTC_PROCRST | AT91_RSTC_PERRST);
@@ -340,6 +346,7 @@ static void __init at91sam9g45_map_io(void)
 
 static void __init at91sam9g45_initialize(void)
 {
+	arm_pm_idle = at91sam9g45_idle;
 	arm_pm_restart = at91sam9g45_restart;
 	pm_power_off = at91sam9g45_poweroff;
 	at91_extern_irq = (1 << AT91SAM9G45_ID_IRQ0);
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 61cbb46f5b..5309b44806 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 
+#include <asm/proc-fns.h>
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -290,8 +291,15 @@ static void __init at91sam9rl_map_io(void)
 	at91_init_sram(0, AT91SAM9RL_SRAM_BASE, sram_size);
 }
 
+static void at91sam9rl_idle(void)
+{
+	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
+	cpu_do_idle();
+}
+
 static void __init at91sam9rl_initialize(void)
 {
+	arm_pm_idle = at91sam9rl_idle;
 	arm_pm_restart = at91sam9_alt_restart;
 	pm_power_off = at91sam9rl_poweroff;
 	at91_extern_irq = (1 << AT91SAM9RL_ID_IRQ0);
diff --git a/arch/arm/mach-at91/at91x40.c b/arch/arm/mach-at91/at91x40.c
index 56ba3bd035..0154b7f44f 100644
--- a/arch/arm/mach-at91/at91x40.c
+++ b/arch/arm/mach-at91/at91x40.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <asm/proc-fns.h>
 #include <asm/mach/arch.h>
 #include <mach/at91x40.h>
 #include <mach/at91_st.h>
@@ -37,8 +38,19 @@ unsigned long clk_get_rate(struct clk *clk)
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
+	arm_pm_idle = at91x40_idle;
 	at91_extern_irq = (1 << AT91X40_ID_IRQ0) | (1 << AT91X40_ID_IRQ1)
 			| (1 << AT91X40_ID_IRQ2);
 }
diff --git a/arch/arm/mach-at91/include/mach/system.h b/arch/arm/mach-at91/include/mach/system.h
index cbd64f3bce..ba85c441ca 100644
--- a/arch/arm/mach-at91/include/mach/system.h
+++ b/arch/arm/mach-at91/include/mach/system.h
@@ -21,30 +21,9 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H
 
-#include <mach/hardware.h>
-#include <mach/at91_st.h>
-#include <mach/at91_dbgu.h>
-#include <mach/at91_pmc.h>
-
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
 
 #endif
-- 
1.7.7.1.431.g10b2a
