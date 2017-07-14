From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Fri, 14 Jul 2017 15:02:43 +0800
Subject: [PATCH v1 3/3] soc: rockchip: power-domain: add power domain support
 for rk3366
In-Reply-To: <1500015763-4940-1-git-send-email-zhangqing@rock-chips.com>
References: <1500015763-4940-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1500015763-4940-4-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver is modified to support RK3366 SoC.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/soc/rockchip/pm_domains.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 796c46a6cbe7..40b75748835f 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -20,6 +20,7 @@
 #include <linux/mfd/syscon.h>
 #include <dt-bindings/power/rk3288-power.h>
 #include <dt-bindings/power/rk3328-power.h>
+#include <dt-bindings/power/rk3366-power.h>
 #include <dt-bindings/power/rk3368-power.h>
 #include <dt-bindings/power/rk3399-power.h>
 
@@ -730,6 +731,16 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 	[RK3328_PD_VPU]		= DOMAIN_RK3328(-1, 9, 9, false),
 };
 
+static const struct rockchip_domain_info rk3366_pm_domains[] = {
+	[RK3366_PD_PERI]	= DOMAIN_RK3368(10, 10, 6, true),
+	[RK3366_PD_VIO]		= DOMAIN_RK3368(14, 14, 8, false),
+	[RK3366_PD_VIDEO]	= DOMAIN_RK3368(13, 13, 7, false),
+	[RK3366_PD_RKVDEC]	= DOMAIN_RK3368(11, 11, 7, false),
+	[RK3366_PD_WIFIBT]	= DOMAIN_RK3368(8, 8, 9, false),
+	[RK3366_PD_VPU]		= DOMAIN_RK3368(12, 12, 7, false),
+	[RK3366_PD_GPU]		= DOMAIN_RK3368(15, 15, 2, false),
+};
+
 static const struct rockchip_domain_info rk3368_pm_domains[] = {
 	[RK3368_PD_PERI]	= DOMAIN_RK3368(13, 12, 6, true),
 	[RK3368_PD_VIO]		= DOMAIN_RK3368(15, 14, 8, false),
@@ -794,6 +805,23 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 	.domain_info = rk3328_pm_domains,
 };
 
+static const struct rockchip_pmu_info rk3366_pmu = {
+	.pwr_offset = 0x0c,
+	.status_offset = 0x10,
+	.req_offset = 0x3c,
+	.idle_offset = 0x40,
+	.ack_offset = 0x40,
+
+	.core_pwrcnt_offset = 0x48,
+	.gpu_pwrcnt_offset = 0x50,
+
+	.core_power_transition_time = 24,
+	.gpu_power_transition_time = 24,
+
+	.num_domains = ARRAY_SIZE(rk3366_pm_domains),
+	.domain_info = rk3366_pm_domains,
+};
+
 static const struct rockchip_pmu_info rk3368_pmu = {
 	.pwr_offset = 0x0c,
 	.status_offset = 0x10,
@@ -834,6 +862,10 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 		.data = (void *)&rk3328_pmu,
 	},
 	{
+		.compatible = "rockchip,rk3366-power-controller",
+		.data = (void *)&rk3366_pmu,
+	},
+	{
 		.compatible = "rockchip,rk3368-power-controller",
 		.data = (void *)&rk3368_pmu,
 	},
-- 
1.9.1
