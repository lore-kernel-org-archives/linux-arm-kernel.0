From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 14 Oct 2009 14:57:50 -0700
Subject: [PATCH 07/27] OMAP3: PM: SRAM restore function
In-Reply-To: <1255557490-16787-7-git-send-email-khilman@deeprootsystems.com>
References: <1255557490-16787-1-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-2-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-3-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-4-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-5-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-6-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-7-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255557490-16787-8-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c           |   10 +++++++---
 arch/arm/plat-omap/include/mach/sram.h |    1 +
 arch/arm/plat-omap/sram.c              |    6 +++---
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 378c2f6..9dbb5a0 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -748,6 +748,12 @@ static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
 	return 0;
 }
 
+void omap_push_sram_idle(void)
+{
+	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
+					omap34xx_cpu_suspend_sz);
+}
+
 static int __init omap3_pm_init(void)
 {
 	struct power_state *pwrst, *tmp;
@@ -785,9 +791,7 @@ static int __init omap3_pm_init(void)
 		goto err2;
 	}
 
-	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
-					 omap34xx_cpu_suspend_sz);
-
+	omap_push_sram_idle();
 #ifdef CONFIG_SUSPEND
 	suspend_set_ops(&omap_pm_ops);
 #endif /* CONFIG_SUSPEND */
diff --git a/arch/arm/plat-omap/include/mach/sram.h b/arch/arm/plat-omap/include/mach/sram.h
index 8974e3f..a943014 100644
--- a/arch/arm/plat-omap/include/mach/sram.h
+++ b/arch/arm/plat-omap/include/mach/sram.h
@@ -67,5 +67,6 @@ extern u32 omap3_sram_configure_core_dpll(
 			u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
 			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
 extern unsigned long omap3_sram_configure_core_dpll_sz;
+extern void omap_push_sram_idle(void);
 
 #endif
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 4144f81..b20ec87 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -396,14 +396,14 @@ u32 omap3_configure_core_dpll(u32 m2, u32 unlock_dll, u32 f, u32 inc,
 			sdrc_actim_ctrl_b_1, sdrc_mr_1);
 }
 
-/* REVISIT: Should this be same as omap34xx_sram_init() after off-idle? */
-void restore_sram_functions(void)
+void omap3_sram_restore_context(void)
 {
 	omap_sram_ceil = omap_sram_base + omap_sram_size;
 
 	_omap3_sram_configure_core_dpll =
 		omap_sram_push(omap3_sram_configure_core_dpll,
 			       omap3_sram_configure_core_dpll_sz);
+	omap_push_sram_idle();
 }
 
 int __init omap34xx_sram_init(void)
@@ -411,7 +411,7 @@ int __init omap34xx_sram_init(void)
 	_omap3_sram_configure_core_dpll =
 		omap_sram_push(omap3_sram_configure_core_dpll,
 			       omap3_sram_configure_core_dpll_sz);
-
+	omap_push_sram_idle();
 	return 0;
 }
 #else
-- 
1.6.4.3
