From: tony@atomide.com (Tony Lindgren)
Date: Fri, 12 Oct 2012 09:51:49 -0700
Subject: [PATCH] ARM: OMAP4: Fix twd_local_timer_register regression
Message-ID: <20121012165149.GE30339@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 7d7e1eba (ARM: OMAP2+: Prepare for irqs.h removal)
changed the interrupts to allow enabling sparse IRQ, but
accidentally added the omap3 INTC base to the local IRQ.
This causes the following:

twd: can't register interrupt 45 (-22)
twd_local_timer_register failed -22

The right fix is to not add any base, as it is a local
timer. For the OMAP44XX_IRQ_LOCALWDT we had defined earlier
there are no users, so no need to fix that.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -467,7 +467,7 @@ OMAP_SYS_TIMER(3_am33xx)
 #ifdef CONFIG_ARCH_OMAP4
 #ifdef CONFIG_LOCAL_TIMERS
 static DEFINE_TWD_LOCAL_TIMER(twd_local_timer,
-			      OMAP44XX_LOCAL_TWD_BASE, 29 + OMAP_INTC_START);
+			      OMAP44XX_LOCAL_TWD_BASE, 29);
 #endif
 
 static void __init omap4_timer_init(void)
