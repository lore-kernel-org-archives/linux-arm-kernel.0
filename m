From: grinberg@compulab.co.il (Igor Grinberg)
Date: Sun, 18 Nov 2012 17:06:41 +0200
Subject: [PATCH 2/2] ARM: OMAP3: cm-t3517: use GPTIMER for system clock
In-Reply-To: <1353251201-10990-1-git-send-email-grinberg@compulab.co.il>
References: <1353251201-10990-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <1353251201-10990-2-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cm-t3517 starting from revision 1.2 does not have the 32K oscilator
wired to the AM3517 SoC.
Therefore switch to use the GPTIMER for system clock.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/board-cm-t3517.c |    2 +-
 arch/arm/mach-omap2/common.h         |    1 +
 arch/arm/mach-omap2/timer.c          |    3 +++
 3 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 699caec..ebbc2ad 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -297,6 +297,6 @@ MACHINE_START(CM_T3517, "Compulab CM-T3517")
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= cm_t3517_init,
 	.init_late	= am35xx_init_late,
-	.timer		= &omap3_timer,
+	.timer		= &omap3_gp_timer,
 	.restart	= omap3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index dae55d8..948bcaa 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -82,6 +82,7 @@ extern void omap2_init_common_infrastructure(void);
 extern struct sys_timer omap2_timer;
 extern struct sys_timer omap3_timer;
 extern struct sys_timer omap3_secure_timer;
+extern struct sys_timer omap3_gp_timer;
 extern struct sys_timer omap3_am33xx_timer;
 extern struct sys_timer omap4_timer;
 extern struct sys_timer omap5_timer;
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 418753f..4bcf080 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -596,6 +596,9 @@ OMAP_SYS_TIMER(3, sync32k);
 OMAP_SYS_32K_TIMER_INIT(3_secure, 12, OMAP3_32K_SOURCE, "ti,timer-secure",
 			2, OMAP3_MPU_SOURCE);
 OMAP_SYS_TIMER(3_secure, sync32k);
+OMAP_SYS_GP_TIMER_INIT(3_gp, 1, OMAP3_MPU_SOURCE, "ti,timer-alwon",
+		       2, OMAP3_MPU_SOURCE);
+OMAP_SYS_TIMER(3_gp, gptimer);
 #endif /* CONFIG_ARCH_OMAP3 */
 
 #ifdef CONFIG_SOC_AM33XX
-- 
1.7.3.4
