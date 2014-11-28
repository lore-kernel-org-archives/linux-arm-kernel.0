From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 28 Nov 2014 09:30:03 +0100
Subject: [PATCH V3 3/3] ARM: shmobile: Convert to genpd flags for PM clocks
 for R-mobile
In-Reply-To: <1417163403-7070-1-git-send-email-ulf.hansson@linaro.org>
References: <1417163403-7070-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1417163403-7070-4-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of using the dev_ops ->stop|start() callbacks for genpd, let's
convert to use genpd's flag field and set it to GENPD_PM_CLK.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
        Convert to renamed define.

Changes in v2:
        None.

---
 arch/arm/mach-shmobile/pm-rmobile.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index 717e641..5aa277d 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -106,9 +106,8 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 	struct generic_pm_domain *genpd = &rmobile_pd->genpd;
 	struct dev_power_governor *gov = rmobile_pd->gov;
 
+	genpd->flags = GENPD_PM_CLK;
 	pm_genpd_init(genpd, gov ? : &simple_qos_governor, false);
-	genpd->dev_ops.stop		= pm_clk_suspend;
-	genpd->dev_ops.start		= pm_clk_resume;
 	genpd->dev_ops.active_wakeup	= rmobile_pd_active_wakeup;
 	genpd->power_off		= rmobile_pd_power_down;
 	genpd->power_on			= rmobile_pd_power_up;
-- 
1.9.1
