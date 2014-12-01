From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon,  1 Dec 2014 12:50:23 +0100
Subject: [PATCH V4 3/3] ARM: shmobile: Convert to genpd flags for PM clocks
 for R-mobile
In-Reply-To: <1417434623-31301-1-git-send-email-ulf.hansson@linaro.org>
References: <1417434623-31301-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1417434623-31301-4-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of using the dev_ops ->stop|start() callbacks for genpd, let's
convert to use genpd's flag field and set it to GENPD_FLAG_PM_CLK.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

Changes in v4:
        Convert to renamed define.

Changes in v3:
        Convert to renamed define.

Changes in v2:
        None.
---
 arch/arm/mach-shmobile/pm-rmobile.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index 717e641..6f7d56e 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -106,9 +106,8 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 	struct generic_pm_domain *genpd = &rmobile_pd->genpd;
 	struct dev_power_governor *gov = rmobile_pd->gov;
 
+	genpd->flags = GENPD_FLAG_PM_CLK;
 	pm_genpd_init(genpd, gov ? : &simple_qos_governor, false);
-	genpd->dev_ops.stop		= pm_clk_suspend;
-	genpd->dev_ops.start		= pm_clk_resume;
 	genpd->dev_ops.active_wakeup	= rmobile_pd_active_wakeup;
 	genpd->power_off		= rmobile_pd_power_down;
 	genpd->power_on			= rmobile_pd_power_up;
-- 
1.9.1
