From: lina.iyer@linaro.org (Lina Iyer)
Date: Fri, 14 Oct 2016 10:47:52 -0700
Subject: [PATCH v3 4/8] PM / Domains: Save the fwnode in genpd_power_state
In-Reply-To: <1476467276-75094-1-git-send-email-lina.iyer@linaro.org>
References: <1476467276-75094-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1476467276-75094-5-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Save the fwnode for the genpd state in the state node. PM Domain clients
may use the fwnode to read in the platform specific domain state
properties and associate them with the state.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 1 +
 include/linux/pm_domain.h   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 9af75ba..1a6073aa 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1956,6 +1956,7 @@ static int genpd_parse_state(struct genpd_power_state *genpd_state,
 
 	genpd_state->power_on_latency_ns = 1000 * exit_latency;
 	genpd_state->power_off_latency_ns = 1000 * entry_latency;
+	genpd_state->fwnode = &state_node->fwnode;
 
 	return 0;
 }
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index b489496..6a89881 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -39,6 +39,7 @@ struct genpd_power_state {
 	s64 power_off_latency_ns;
 	s64 power_on_latency_ns;
 	s64 residency_ns;
+	struct fwnode_handle *fwnode;
 };
 
 struct generic_pm_domain {
-- 
2.7.4
