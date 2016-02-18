From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Thu, 18 Feb 2016 11:07:13 +0800
Subject: [PATCH v2 1/6] rockchip: power-domain: make idle handling optional
In-Reply-To: <1455764838-12928-1-git-send-email-zhangqing@rock-chips.com>
References: <1455764838-12928-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1455764838-12928-2-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not all new socs need to handle idle states on domain state changes,
so add the possibility to make them optional.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/soc/rockchip/pm_domains.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 6cdffb1..3dcc611 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -63,14 +63,16 @@ struct rockchip_pmu {
 };
 
 #define to_rockchip_pd(gpd) container_of(gpd, struct rockchip_pm_domain, genpd)
+#define NULL_BIT		-32
+#define OVERFLOW_MASK		32
 
 #define DOMAIN(pwr, status, req, idle, ack)	\
 {						\
 	.pwr_mask = BIT(pwr),			\
 	.status_mask = BIT(status),		\
-	.req_mask = BIT(req),			\
-	.idle_mask = BIT(idle),			\
-	.ack_mask = BIT(ack),			\
+	.req_mask = (req >= 0) ? BIT(req) : OVERFLOW_MASK,		\
+	.idle_mask = (idle >= 0) ? BIT(idle) : OVERFLOW_MASK,	\
+	.ack_mask = (ack >= 0) ? BIT(ack) : OVERFLOW_MASK,		\
 }
 
 #define DOMAIN_RK3288(pwr, status, req)		\
@@ -96,6 +98,9 @@ static int rockchip_pmu_set_idle_request(struct rockchip_pm_domain *pd,
 	struct rockchip_pmu *pmu = pd->pmu;
 	unsigned int val;
 
+	if (pd_info->req_mask >= OVERFLOW_MASK)
+		return 0;
+
 	regmap_update_bits(pmu->regmap, pmu->info->req_offset,
 			   pd_info->req_mask, idle ? -1U : 0);
 
-- 
1.9.1
