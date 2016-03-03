From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Thu,  3 Mar 2016 16:03:49 +0800
Subject: [PATCH v5 2/6] power-domain: allow domains only handling idle requests
In-Reply-To: <1456992233-25164-1-git-send-email-zhangqing@rock-chips.com>
References: <1456992233-25164-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1456992233-25164-3-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some Rockchip SoC there exist child-domains only handling their
idle state with the actual power-state handled by a parent-domain.

So allow such types of domains. For them, we can determine their
state (on/of) by checking the inverse idle-state instead.

There exist one special case if both idle as well power handling
were set as not present, but as the domain-data is defined in the
code itself, we can expect the reasonable developer to define them

So allow such types of domains. For them, we can determine their
state (on/of) by checking the inverse idle-state instead.

There exist one special case if both idle as well power handling
were set as not present, but as the domain-data is defined in the
code itself, we can expect the reasonable developer to define them
in a correct, without adding more checks.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/soc/rockchip/pm_domains.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index c46312d..0465a06 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -66,8 +66,8 @@ struct rockchip_pmu {
 
 #define DOMAIN(pwr, status, req, idle, ack)	\
 {						\
-	.pwr_mask = BIT(pwr),			\
-	.status_mask = BIT(status),		\
+	.pwr_mask = (pwr >= 0) ? BIT(pwr) : 0,		\
+	.status_mask = (status >= 0) ? BIT(status) : 0,	\
 	.req_mask = (req >= 0) ? BIT(req) : 0,		\
 	.idle_mask = (idle >= 0) ? BIT(idle) : 0,	\
 	.ack_mask = (ack >= 0) ? BIT(ack) : 0,		\
@@ -119,6 +119,10 @@ static bool rockchip_pmu_domain_is_on(struct rockchip_pm_domain *pd)
 	struct rockchip_pmu *pmu = pd->pmu;
 	unsigned int val;
 
+	/* check idle status for idle-only domains */
+	if (pd->info->status_mask == 0)
+		return !rockchip_pmu_domain_is_idle(pd);
+
 	regmap_read(pmu->regmap, pmu->info->status_offset, &val);
 
 	/* 1'b0: power on, 1'b1: power off */
@@ -130,6 +134,9 @@ static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
 {
 	struct rockchip_pmu *pmu = pd->pmu;
 
+	if (pd->info->pwr_mask == 0)
+		return;
+
 	regmap_update_bits(pmu->regmap, pmu->info->pwr_offset,
 			   pd->info->pwr_mask, on ? 0 : -1U);
 
-- 
1.9.1
