From: rickard_strandqvist@spectrumdigital.se (Rickard Strandqvist)
Date: Sat,  3 Jan 2015 17:52:39 +0100
Subject: [PATCH] arm: mach-versatile: core:  Remove unused function
Message-ID: <1420303959-12898-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the function versatile_leds_event() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/arm/mach-versatile/core.c |   37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 08fb8c8..6ea09fe 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -728,43 +728,6 @@ struct of_dev_auxdata versatile_auxdata_lookup[] __initdata = {
 };
 #endif
 
-#ifdef CONFIG_LEDS
-#define VA_LEDS_BASE (__io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_LED_OFFSET)
-
-static void versatile_leds_event(led_event_t ledevt)
-{
-	unsigned long flags;
-	u32 val;
-
-	local_irq_save(flags);
-	val = readl(VA_LEDS_BASE);
-
-	switch (ledevt) {
-	case led_idle_start:
-		val = val & ~VERSATILE_SYS_LED0;
-		break;
-
-	case led_idle_end:
-		val = val | VERSATILE_SYS_LED0;
-		break;
-
-	case led_timer:
-		val = val ^ VERSATILE_SYS_LED1;
-		break;
-
-	case led_halted:
-		val = 0;
-		break;
-
-	default:
-		break;
-	}
-
-	writel(val, VA_LEDS_BASE);
-	local_irq_restore(flags);
-}
-#endif	/* CONFIG_LEDS */
-
 void versatile_restart(enum reboot_mode mode, const char *cmd)
 {
 	void __iomem *sys = __io_address(VERSATILE_SYS_BASE);
-- 
1.7.10.4
