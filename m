From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Thu, 10 Mar 2016 05:22:53 +0800
Subject: [PATCH v6 1/6] rockchip: power-domain: make idle handling optional
In-Reply-To: <1457558578-22049-1-git-send-email-zhangqing@rock-chips.com>
References: <1457558578-22049-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1457558578-22049-2-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not all new socs need to handle idle states on domain state changes,
so add the possibility to make them optional.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/soc/rockchip/pm_domains.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 18aee6b..c46312d 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -68,9 +68,9 @@ struct rockchip_pmu {
 {						\
 	.pwr_mask = BIT(pwr),			\
 	.status_mask = BIT(status),		\
-	.req_mask = BIT(req),			\
-	.idle_mask = BIT(idle),			\
-	.ack_mask = BIT(ack),			\
+	.req_mask = (req >= 0) ? BIT(req) : 0,		\
+	.idle_mask = (idle >= 0) ? BIT(idle) : 0,	\
+	.ack_mask = (ack >= 0) ? BIT(ack) : 0,		\
 }
 
 #define DOMAIN_RK3288(pwr, status, req)		\
@@ -96,6 +96,9 @@ static int rockchip_pmu_set_idle_request(struct rockchip_pm_domain *pd,
 	struct rockchip_pmu *pmu = pd->pmu;
 	unsigned int val;
 
+	if (pd_info->req_mask == 0)
+		return 0;
+
 	regmap_update_bits(pmu->regmap, pmu->info->req_offset,
 			   pd_info->req_mask, idle ? -1U : 0);
 
-- 
1.9.1
