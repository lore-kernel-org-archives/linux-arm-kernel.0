From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 12 Jun 2012 18:31:23 +0300
Subject: [PATCHv3 08/20] ARM: OMAP4: PM: add MPUSS power domain device off
 support
In-Reply-To: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
References: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Message-ID: <1339515095-9908-9-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device off support for MPUSS power domain. Device off
support is overloaded on top of core pwrdm functional OFF powerstate,
so the code must check the next core powerstate and set the save_state
status accordingly.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 0e5f81b..0155242 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -72,7 +72,7 @@ struct omap4_cpu_pm_info {
 };
 
 static DEFINE_PER_CPU(struct omap4_cpu_pm_info, omap4_pm_info);
-static struct powerdomain *mpuss_pd;
+static struct powerdomain *mpuss_pd, *core_pd;
 static void __iomem *sar_base;
 
 /*
@@ -265,7 +265,9 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	 * In MPUSS OSWR or device OFF, interrupt controller context is lost.
 	 */
 	mpuss_clear_prev_logic_pwrst();
-	if (pwrdm_read_next_func_pwrst(mpuss_pd) == PWRDM_FUNC_PWRST_OSWR)
+	if (pwrdm_read_next_func_pwrst(core_pd) == PWRDM_FUNC_PWRST_OFF)
+		save_state = 3;
+	else if (pwrdm_read_next_func_pwrst(mpuss_pd) == PWRDM_FUNC_PWRST_OSWR)
 		save_state = 2;
 
 	cpu_clear_prev_logic_pwrst(cpu);
@@ -386,6 +388,11 @@ int __init omap4_mpuss_init(void)
 		pr_err("Failed to lookup MPUSS power domain\n");
 		return -ENODEV;
 	}
+	core_pd = pwrdm_lookup("core_pwrdm");
+	if (!core_pd) {
+		pr_err("Failed to lookup CORE power domain\n");
+		return -ENODEV;
+	}
 	pwrdm_clear_all_prev_pwrst(mpuss_pd);
 	mpuss_clear_prev_logic_pwrst();
 
-- 
1.7.4.1
