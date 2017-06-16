From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Jun 2017 15:31:17 +0200
Subject: [PATCH] ARM: shmobile: pm-rmobile: Use GENPD_FLAG_ALWAYS_ON
In-Reply-To: <cover.1497619609.git.horms+renesas@verge.net.au>
References: <cover.1497619609.git.horms+renesas@verge.net.au>
Message-ID: <fd8cf827d8a635df3dad46773ad828ce4c93d95b.1497619609.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Improve handling of always-on PM domains by using the
GENPD_FLAG_ALWAYS_ON flag introduced in commit ffaa42e8a40b7f10 ("PM /
Domains: Enable users of genpd to specify always on PM domains").

Note that the PM domain containing the serial console is still handled
locally.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/pm-rmobile.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index 45a195501b78..699429f28b73 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -130,7 +130,7 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 	struct generic_pm_domain *genpd = &rmobile_pd->genpd;
 	struct dev_power_governor *gov = rmobile_pd->gov;
 
-	genpd->flags = GENPD_FLAG_PM_CLK;
+	genpd->flags |= GENPD_FLAG_PM_CLK;
 	genpd->dev_ops.active_wakeup	= rmobile_pd_active_wakeup;
 	genpd->power_off		= rmobile_pd_power_down;
 	genpd->power_on			= rmobile_pd_power_up;
@@ -140,14 +140,6 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 	pm_genpd_init(genpd, gov ? : &simple_qos_governor, false);
 }
 
-static int rmobile_pd_suspend_busy(void)
-{
-	/*
-	 * This domain should not be turned off.
-	 */
-	return -EBUSY;
-}
-
 static int rmobile_pd_suspend_console(void)
 {
 	/*
@@ -260,8 +252,7 @@ static void __init rmobile_setup_pm_domain(struct device_node *np,
 		 * only be turned off if the CPU is not in use.
 		 */
 		pr_debug("PM domain %s contains CPU\n", name);
-		pd->gov = &pm_domain_always_on_gov;
-		pd->suspend = rmobile_pd_suspend_busy;
+		pd->genpd.flags |= GENPD_FLAG_ALWAYS_ON;
 		break;
 
 	case PD_CONSOLE:
@@ -277,8 +268,7 @@ static void __init rmobile_setup_pm_domain(struct device_node *np,
 		 * is not in use.
 		 */
 		pr_debug("PM domain %s contains Coresight-ETM\n", name);
-		pd->gov = &pm_domain_always_on_gov;
-		pd->suspend = rmobile_pd_suspend_busy;
+		pd->genpd.flags |= GENPD_FLAG_ALWAYS_ON;
 		break;
 
 	case PD_MEMCTL:
@@ -287,8 +277,7 @@ static void __init rmobile_setup_pm_domain(struct device_node *np,
 		 * should only be turned off if memory is not in use.
 		 */
 		pr_debug("PM domain %s contains MEMCTL\n", name);
-		pd->gov = &pm_domain_always_on_gov;
-		pd->suspend = rmobile_pd_suspend_busy;
+		pd->genpd.flags |= GENPD_FLAG_ALWAYS_ON;
 		break;
 
 	case PD_NORMAL:
-- 
2.1.4
