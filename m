From: balbi@ti.com (Felipe Balbi)
Date: Fri, 16 Oct 2015 11:22:00 -0500
Subject: [PATCH 01/11] arm: omap2: timer: always define omap4_local_timer_init
In-Reply-To: <1445012530-14126-1-git-send-email-balbi@ti.com>
References: <1445012530-14126-1-git-send-email-balbi@ti.com>
Message-ID: <1445012530-14126-2-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omap4_local_timer_init() can be used by other
platforms as is. At least AM437x wants to use
it. Instead of making omap4-only and providing
a stub for builds without OMAP4, we can just
make sure that function is always available
for all SoCs that need it.

Reported-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/timer.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index a55655127ef2..548d922cb107 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -630,32 +630,22 @@ OMAP_SYS_32K_TIMER_INIT(3_secure, 12, "secure_32k_fck", "ti,timer-secure",
 			2, "timer_sys_ck", NULL);
 #endif /* CONFIG_ARCH_OMAP3 */
 
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX) || \
-	defined(CONFIG_SOC_AM43XX)
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX)
 OMAP_SYS_GP_TIMER_INIT(3, 2, "timer_sys_ck", NULL,
 		       1, "timer_sys_ck", "ti,timer-alwon");
 #endif
 
 #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
-	defined(CONFIG_SOC_DRA7XX)
+	defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM43XX)
 static OMAP_SYS_32K_TIMER_INIT(4, 1, "timer_32k_ck", "ti,timer-alwon",
 			       2, "sys_clkin_ck", NULL);
-#endif
 
-#ifdef CONFIG_ARCH_OMAP4
-#ifdef CONFIG_HAVE_ARM_TWD
 void __init omap4_local_timer_init(void)
 {
 	omap4_sync32k_timer_init();
 	clocksource_of_init();
 }
-#else
-void __init omap4_local_timer_init(void)
-{
-	omap4_sync32k_timer_init();
-}
-#endif /* CONFIG_HAVE_ARM_TWD */
-#endif /* CONFIG_ARCH_OMAP4 */
+#endif
 
 #if defined(CONFIG_SOC_OMAP5) || defined(CONFIG_SOC_DRA7XX)
 void __init omap5_realtime_timer_init(void)
-- 
2.5.3
