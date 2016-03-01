From: lina.iyer@linaro.org (Lina Iyer)
Date: Tue,  1 Mar 2016 14:15:19 -0700
Subject: [BUG FIX] PM / cpu_domains: Check for NULL callbacks
In-Reply-To: <1456866931-37851-1-git-send-email-lina.iyer@linaro.org>
References: <1456866931-37851-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1456866931-37851-2-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check for NULL platform callback before calling.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/base/power/cpu_domains.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/cpu_domains.c b/drivers/base/power/cpu_domains.c
index 7069411..bcaa474 100644
--- a/drivers/base/power/cpu_domains.c
+++ b/drivers/base/power/cpu_domains.c
@@ -157,16 +157,22 @@ static int cpu_pd_power_on(struct generic_pm_domain *genpd)
 {
 	struct cpu_pm_domain *pd = to_cpu_pd(genpd);
 
-	return pd->ops.power_on();
+	if (pd->ops.power_on)
+		return pd->ops.power_on();
+
+	return 0;
 }
 
 static int cpu_pd_power_off(struct generic_pm_domain *genpd)
 {
 	struct cpu_pm_domain *pd = to_cpu_pd(genpd);
 
-	return pd->ops.power_off(genpd->state_idx,
+	if (pd->ops.power_off)
+		return pd->ops.power_off(genpd->state_idx,
 			genpd->states[genpd->state_idx].param,
 			pd->cpus);
+
+	return 0;
 }
 
 /**
-- 
2.1.4
