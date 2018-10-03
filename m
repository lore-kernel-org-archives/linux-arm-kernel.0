From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed,  3 Oct 2018 16:38:15 +0200
Subject: [PATCH v9 02/11] PM / Domains: Deal with multiple states but no
 governor in genpd
In-Reply-To: <20181003143824.13059-1-ulf.hansson@linaro.org>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
Message-ID: <20181003143824.13059-3-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A caller of pm_genpd_init() that provides some states for the genpd via the
->states pointer in the struct generic_pm_domain, should also provide a
governor. This because it's the job of the governor to pick a state that
satisfies the constraints.

Therefore, let's print a warning to inform the user about such bogus
configuration and avoid to bail out, by instead picking the shallowest
state before genpd invokes the ->power_off() callback.

Cc: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/base/power/domain.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e1bbddb02871..7f38a92b444a 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -467,6 +467,10 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 			return -EAGAIN;
 	}
 
+	/* Default to shallowest state. */
+	if (!genpd->gov)
+		genpd->state_idx = 0;
+
 	if (genpd->power_off) {
 		int ret;
 
@@ -1687,6 +1691,8 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 		ret = genpd_set_default_power_state(genpd);
 		if (ret)
 			return ret;
+	} else if (!gov) {
+		pr_warn("%s : no governor for states\n", genpd->name);
 	}
 
 	device_initialize(&genpd->dev);
-- 
2.17.1
