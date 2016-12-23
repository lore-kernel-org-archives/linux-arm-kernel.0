From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Fri, 23 Dec 2016 11:47:52 +0800
Subject: [PATCH v1 3/3] soc: rockchip: power-domain: Modify power domain
 driver for rk3328
In-Reply-To: <1482464872-12954-1-git-send-email-zhangqing@rock-chips.com>
References: <1482464872-12954-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1482464872-12954-4-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver is modified to support RK3328 SoC.
RK3328 SoC is only support idle.
add DOMAIN_M type, for support regs have write_enable bit.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/soc/rockchip/pm_domains.c | 63 +++++++++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 1c78c42416c6..796c46a6cbe7 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -19,6 +19,7 @@
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
 #include <dt-bindings/power/rk3288-power.h>
+#include <dt-bindings/power/rk3328-power.h>
 #include <dt-bindings/power/rk3368-power.h>
 #include <dt-bindings/power/rk3399-power.h>
 
@@ -29,6 +30,8 @@ struct rockchip_domain_info {
 	int idle_mask;
 	int ack_mask;
 	bool active_wakeup;
+	int pwr_w_mask;
+	int req_w_mask;
 };
 
 struct rockchip_pmu_info {
@@ -87,9 +90,24 @@ struct rockchip_pmu {
 	.active_wakeup = wakeup,			\
 }
 
+#define DOMAIN_M(pwr, status, req, idle, ack, wakeup)	\
+{							\
+	.pwr_w_mask = (pwr >= 0) ? BIT(pwr + 16) : 0,	\
+	.pwr_mask = (pwr >= 0) ? BIT(pwr) : 0,		\
+	.status_mask = (status >= 0) ? BIT(status) : 0,	\
+	.req_w_mask = (req >= 0) ?  BIT(req + 16) : 0,	\
+	.req_mask = (req >= 0) ?  BIT(req) : 0,		\
+	.idle_mask = (idle >= 0) ? BIT(idle) : 0,	\
+	.ack_mask = (ack >= 0) ? BIT(ack) : 0,		\
+	.active_wakeup = wakeup,			\
+}
+
 #define DOMAIN_RK3288(pwr, status, req, wakeup)		\
 	DOMAIN(pwr, status, req, req, (req) + 16, wakeup)
 
+#define DOMAIN_RK3328(pwr, status, req, wakeup)		\
+	DOMAIN_M(pwr, pwr, req, (req) + 10, req, wakeup)
+
 #define DOMAIN_RK3368(pwr, status, req, wakeup)		\
 	DOMAIN(pwr, status, req, (req) + 16, req, wakeup)
 
@@ -127,9 +145,13 @@ static int rockchip_pmu_set_idle_request(struct rockchip_pm_domain *pd,
 
 	if (pd_info->req_mask == 0)
 		return 0;
-
-	regmap_update_bits(pmu->regmap, pmu->info->req_offset,
-			   pd_info->req_mask, idle ? -1U : 0);
+	else if (pd_info->req_w_mask)
+		regmap_write(pmu->regmap, pmu->info->req_offset,
+			     idle ? (pd_info->req_mask | pd_info->req_w_mask) :
+			     pd_info->req_w_mask);
+	else
+		regmap_update_bits(pmu->regmap, pmu->info->req_offset,
+				   pd_info->req_mask, idle ? -1U : 0);
 
 	dsb(sy);
 
@@ -230,9 +252,13 @@ static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
 
 	if (pd->info->pwr_mask == 0)
 		return;
-
-	regmap_update_bits(pmu->regmap, pmu->info->pwr_offset,
-			   pd->info->pwr_mask, on ? 0 : -1U);
+	else if (pd->info->pwr_w_mask)
+		regmap_write(pmu->regmap, pmu->info->pwr_offset,
+			     on ? pd->info->pwr_mask :
+			     (pd->info->pwr_mask | pd->info->pwr_w_mask));
+	else
+		regmap_update_bits(pmu->regmap, pmu->info->pwr_offset,
+				   pd->info->pwr_mask, on ? 0 : -1U);
 
 	dsb(sy);
 
@@ -692,6 +718,18 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 	[RK3288_PD_GPU]		= DOMAIN_RK3288(9, 9, 2, false),
 };
 
+static const struct rockchip_domain_info rk3328_pm_domains[] = {
+	[RK3328_PD_CORE]	= DOMAIN_RK3328(-1, 0, 0, false),
+	[RK3328_PD_GPU]		= DOMAIN_RK3328(-1, 1, 1, false),
+	[RK3328_PD_BUS]		= DOMAIN_RK3328(-1, 2, 2, true),
+	[RK3328_PD_MSCH]	= DOMAIN_RK3328(-1, 3, 3, true),
+	[RK3328_PD_PERI]	= DOMAIN_RK3328(-1, 4, 4, true),
+	[RK3328_PD_VIDEO]	= DOMAIN_RK3328(-1, 5, 5, false),
+	[RK3328_PD_HEVC]	= DOMAIN_RK3328(-1, 6, 6, false),
+	[RK3328_PD_VIO]		= DOMAIN_RK3328(-1, 8, 8, false),
+	[RK3328_PD_VPU]		= DOMAIN_RK3328(-1, 9, 9, false),
+};
+
 static const struct rockchip_domain_info rk3368_pm_domains[] = {
 	[RK3368_PD_PERI]	= DOMAIN_RK3368(13, 12, 6, true),
 	[RK3368_PD_VIO]		= DOMAIN_RK3368(15, 14, 8, false),
@@ -747,6 +785,15 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 	.domain_info = rk3288_pm_domains,
 };
 
+static const struct rockchip_pmu_info rk3328_pmu = {
+	.req_offset = 0x414,
+	.idle_offset = 0x484,
+	.ack_offset = 0x484,
+
+	.num_domains = ARRAY_SIZE(rk3328_pm_domains),
+	.domain_info = rk3328_pm_domains,
+};
+
 static const struct rockchip_pmu_info rk3368_pmu = {
 	.pwr_offset = 0x0c,
 	.status_offset = 0x10,
@@ -783,6 +830,10 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 		.data = (void *)&rk3288_pmu,
 	},
 	{
+		.compatible = "rockchip,rk3328-power-controller",
+		.data = (void *)&rk3328_pmu,
+	},
+	{
 		.compatible = "rockchip,rk3368-power-controller",
 		.data = (void *)&rk3368_pmu,
 	},
-- 
1.9.1
