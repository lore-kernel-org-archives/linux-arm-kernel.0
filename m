From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 12 Feb 2015 10:47:25 +0800
Subject: [PATCH 3/6] pm: at91: standby mode uses the same sram function as
 suspend to memory mode
In-Reply-To: <1423709123-8033-1-git-send-email-wenyou.yang@atmel.com>
References: <1423709123-8033-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1423709245-8142-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To simply the PM code, the suspend to standby mode uses the same sram function
as the suspend to memory mode, running in the internal SRAM, instead of the
respective code for each mode.

For the suspend to standby mode, the master clock doesn't switch to the slow
clock, and PLLA and the main oscillator doesn't turn off as well.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 arch/arm/mach-at91/pm.c           |   85 +++++++++++++++++--------------------
 arch/arm/mach-at91/pm.h           |    8 ++++
 arch/arm/mach-at91/pm_slowclock.S |   25 ++++++++++-
 3 files changed, 71 insertions(+), 47 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 9feee81..d03d6a7 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -140,62 +140,55 @@ extern void at91_slow_clock(void __iomem *pmc, void __iomem *ramc0,
 			    void __iomem *ramc1, int memctrl);
 extern u32 at91_slow_clock_sz;
 
+static void at91_pm_suspend(suspend_state_t state)
+{
+	unsigned int pm_data = at91_pm_data.memctrl;
+
+	pm_data |= (state == PM_SUSPEND_MEM) ?
+				AT91_PM_MODE(AT91_PM_SLOW_CLOCK) : 0;
+
+	slow_clock(at91_pmc_base, at91_ramc_base[0],
+			at91_ramc_base[1], pm_data);
+}
+
 static int at91_pm_enter(suspend_state_t state)
 {
 	at91_pinctrl_gpio_suspend();
 
 	switch (state) {
+	/*
+	 * Suspend-to-RAM is like STANDBY plus slow clock mode, so
+	 * drivers must suspend more deeply, the master clock switches
+	 * to the clk32k and turns off the main oscillator
+	 */
+	case PM_SUSPEND_MEM:
 		/*
-		 * Suspend-to-RAM is like STANDBY plus slow clock mode, so
-		 * drivers must suspend more deeply:  only the master clock
-		 * controller may be using the main oscillator.
+		 * Ensure that clocks are in a valid state.
 		 */
-		case PM_SUSPEND_MEM:
-			/*
-			 * Ensure that clocks are in a valid state.
-			 */
-			if (!at91_pm_verify_clocks())
-				goto error;
-
-			/*
-			 * Enter slow clock mode by switching over to clk32k and
-			 * turning off the main oscillator; reverse on wakeup.
-			 */
-			if (slow_clock) {
-				slow_clock(at91_pmc_base, at91_ramc_base[0],
-					   at91_ramc_base[1],
-					   at91_pm_data.memctrl);
-				break;
-			} else {
-				pr_info("AT91: PM - no slow clock mode enabled ...\n");
-				/* FALLTHROUGH leaving master clock alone */
-			}
+		if (!at91_pm_verify_clocks())
+			goto error;
 
-		/*
-		 * STANDBY mode has *all* drivers suspended; ignores irqs not
-		 * marked as 'wakeup' event sources; and reduces DRAM power.
-		 * But otherwise it's identical to PM_SUSPEND_ON:  cpu idle, and
-		 * nothing fancy done with main or cpu clocks.
-		 */
-		case PM_SUSPEND_STANDBY:
-			/*
-			 * NOTE: the Wait-for-Interrupt instruction needs to be
-			 * in icache so no SDRAM accesses are needed until the
-			 * wakeup IRQ occurs and self-refresh is terminated.
-			 * For ARM 926 based chips, this requirement is weaker
-			 * as at91sam9 can access a RAM in self-refresh mode.
-			 */
-			if (at91_pm_standby)
-				at91_pm_standby();
-			break;
+		at91_pm_suspend(state);
 
-		case PM_SUSPEND_ON:
-			cpu_do_idle();
-			break;
+		break;
 
-		default:
-			pr_debug("AT91: PM - bogus suspend state %d\n", state);
-			goto error;
+	/*
+	 * STANDBY mode has *all* drivers suspended; ignores irqs not
+	 * marked as 'wakeup' event sources; and reduces DRAM power.
+	 * But otherwise it's identical to PM_SUSPEND_ON: cpu idle, and
+	 * nothing fancy done with main or cpu clocks.
+	 */
+	case PM_SUSPEND_STANDBY:
+		at91_pm_suspend(state);
+		break;
+
+	case PM_SUSPEND_ON:
+		cpu_do_idle();
+		break;
+
+	default:
+		pr_debug("AT91: PM - bogus suspend state %d\n", state);
+		goto error;
 	}
 
 error:
diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index d2c8996..4eef436 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -15,6 +15,14 @@
 
 #include <mach/at91_ramc.h>
 
+#define	AT91_PM_MEMTYPE_MASK	0x0f
+
+#define	AT91_PM_MODE_OFFSET	4
+#define	AT91_PM_MODE_MASK	0x01
+#define	AT91_PM_MODE(x)		(((x) & AT91_PM_MODE_MASK) << AT91_PM_MODE_OFFSET)
+
+#define	AT91_PM_SLOW_CLOCK	0x01
+
 #ifdef CONFIG_PM
 extern void at91_pm_set_standby(void (*at91_standby)(void));
 #else
diff --git a/arch/arm/mach-at91/pm_slowclock.S b/arch/arm/mach-at91/pm_slowclock.S
index 6fdf221..bead23e 100644
--- a/arch/arm/mach-at91/pm_slowclock.S
+++ b/arch/arm/mach-at91/pm_slowclock.S
@@ -15,6 +15,7 @@
 #include <linux/clk/at91_pmc.h>
 #include <mach/hardware.h>
 #include <mach/at91_ramc.h>
+#include "pm.h"
 
 #define	SRAMC_SELF_FRESH_ACTIVE		0x01
 #define	SRAMC_SELF_FRESH_EXIT		0x00
@@ -76,12 +77,22 @@ ENTRY(at91_slow_clock)
 	str	r0, .pmc_base
 	str	r1, .sramc_base
 	str	r2, .sramc1_base
-	str	r3, .memtype
+
+	and	r0, r3, #AT91_PM_MEMTYPE_MASK
+	str	r0, .memtype
+
+	lsr	r0, r3, #AT91_PM_MODE_OFFSET
+	and	r0, r0, #AT91_PM_MODE_MASK
+	str	r0, .pm_mode
 
 	/* Active the self-refresh mode */
 	mov	r0, #SRAMC_SELF_FRESH_ACTIVE
 	bl	at91_sramc_self_refresh
 
+	ldr	r0, .pm_mode
+	tst	r0, #AT91_PM_SLOW_CLOCK
+	beq	skip_disable_main_clock
+
 	ldr	pmc, .pmc_base
 
 	/* Save Master clock setting */
@@ -109,9 +120,18 @@ ENTRY(at91_slow_clock)
 	bic	tmp1, tmp1, #AT91_PMC_MOSCEN
 	str	tmp1, [pmc, #AT91_CKGR_MOR]
 
+skip_disable_main_clock:
+	ldr	pmc, .pmc_base
+
 	/* Wait for interrupt */
 	mcr	p15, 0, tmp1, c7, c0, 4
 
+	ldr	r0, .pm_mode
+	tst	r0, #AT91_PM_SLOW_CLOCK
+	beq	skip_enable_main_clock
+
+	ldr	pmc, .pmc_base
+
 	/* Turn on the main oscillator */
 	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
 	orr	tmp1, tmp1, #AT91_PMC_MOSCEN
@@ -139,6 +159,7 @@ ENTRY(at91_slow_clock)
 
 	wait_mckrdy
 
+skip_enable_main_clock:
 	/* Exit the self-refresh mode */
 	mov	r0, #SRAMC_SELF_FRESH_EXIT
 	bl	at91_sramc_self_refresh
@@ -281,6 +302,8 @@ ENDPROC(at91_sramc_self_refresh)
 	.word 0
 .memtype:
 	.word 0
+.pm_mode:
+	.word 0
 .saved_mckr:
 	.word 0
 .saved_pllar:
-- 
1.7.9.5
