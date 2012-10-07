From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun,  7 Oct 2012 09:27:20 +0200
Subject: [PATCH 6/6] arm: at91: drop at91_suspend_entering_slow_clock
In-Reply-To: <1349594840-11374-1-git-send-email-plagnioj@jcrosoft.com>
References: <20121006161429.GD12462@game.jcrosoft.org>
 <1349594840-11374-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1349594840-11374-6-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

as the driver needing to knwon if we enter in slow_clock mode (SUSPEND_MEM)
have been swtich to pm ops

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-pm at vger.kernel.org
---
 arch/arm/mach-at91/include/mach/board.h |    3 ---
 arch/arm/mach-at91/pm.c                 |   24 ------------------------
 2 files changed, 27 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
index c55a436..e3ca86a 100644
--- a/arch/arm/mach-at91/include/mach/board.h
+++ b/arch/arm/mach-at91/include/mach/board.h
@@ -190,7 +190,4 @@ extern void __init at91_add_device_can(struct at91_can_data *data);
 extern void __init at91_gpio_leds(struct gpio_led *leds, int nr);
 extern void __init at91_pwm_leds(struct gpio_led *leds, int nr);
 
-/* FIXME: this needs a better location, but gets stuff building again */
-extern int at91_suspend_entering_slow_clock(void);
-
 #endif
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 2c2d865..5e8d770 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -116,15 +116,11 @@ static int at91_pm_valid_state(suspend_state_t state)
 	}
 }
 
-
-static suspend_state_t target_state;
-
 /*
  * Called after processes are frozen, but before we shutdown devices.
  */
 static int at91_pm_begin(suspend_state_t state)
 {
-	target_state = state;
 	return 0;
 }
 
@@ -172,23 +168,6 @@ static int at91_pm_verify_clocks(void)
 	return 1;
 }
 
-/*
- * Call this from platform driver suspend() to see how deeply to suspend.
- * For example, some controllers (like OHCI) need one of the PLL clocks
- * in order to act as a wakeup source, and those are not available when
- * going into slow clock mode.
- *
- * REVISIT: generalize as clk_will_be_available(clk)?  Other platforms have
- * the very same problem (but not using at91 main_clk), and it'd be better
- * to add one generic API rather than lots of platform-specific ones.
- */
-int at91_suspend_entering_slow_clock(void)
-{
-	return (target_state == PM_SUSPEND_MEM);
-}
-EXPORT_SYMBOL(at91_suspend_entering_slow_clock);
-
-
 static void (*slow_clock)(void __iomem *pmc, void __iomem *ramc0,
 			  void __iomem *ramc1, int memctrl);
 
@@ -283,7 +262,6 @@ static int at91_pm_enter(suspend_state_t state)
 			at91_aic_read(AT91_AIC_IPR) & at91_aic_read(AT91_AIC_IMR));
 
 error:
-	target_state = PM_SUSPEND_ON;
 	at91_irq_resume();
 	at91_gpio_resume();
 	return 0;
@@ -294,10 +272,8 @@ error:
  */
 static void at91_pm_end(void)
 {
-	target_state = PM_SUSPEND_ON;
 }
 
-
 static const struct platform_suspend_ops at91_pm_ops = {
 	.valid	= at91_pm_valid_state,
 	.begin	= at91_pm_begin,
-- 
1.7.10.4
