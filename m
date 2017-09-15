From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 15 Sep 2017 10:33:55 +0200
Subject: [PATCH 7/9] soc: rockchip: power-domain: add rk3066 powerdomains
In-Reply-To: <20170915083357.11296-1-heiko@sntech.de>
References: <20170915083357.11296-1-heiko@sntech.de>
Message-ID: <20170915083357.11296-8-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add power-domains found on rk3066 socs.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/soc/rockchip/pm_domains.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index dc3f13aacdb5..f8a5dae2db4c 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -18,6 +18,7 @@
 #include <linux/clk.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
+#include <dt-bindings/power/rk3066-power.h>
 #include <dt-bindings/power/rk3188-power.h>
 #include <dt-bindings/power/rk3288-power.h>
 #include <dt-bindings/power/rk3328-power.h>
@@ -713,6 +714,14 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 	return error;
 }
 
+static const struct rockchip_domain_info rk3066_pm_domains[] = {
+	[RK3066_PD_GPU]		= DOMAIN(9, 9, 3, 24, 29, false),
+	[RK3066_PD_VIDEO]	= DOMAIN(8, 8, 4, 23, 28, false),
+	[RK3066_PD_VIO]		= DOMAIN(7, 7, 5, 22, 27, false),
+	[RK3066_PD_PERI]	= DOMAIN(6, 6, 2, 25, 30, false),
+	[RK3066_PD_CPU]		= DOMAIN(-1, 5, 1, 26, 31, false),
+};
+
 static const struct rockchip_domain_info rk3188_pm_domains[] = {
 	[RK3188_PD_GPU]		= DOMAIN(9, 9, 3, 24, 29, false),
 	[RK3188_PD_VIDEO]	= DOMAIN(8, 8, 4, 23, 28, false),
@@ -788,6 +797,17 @@ static const struct rockchip_domain_info rk3399_pm_domains[] = {
 	[RK3399_PD_SDIOAUDIO]	= DOMAIN_RK3399(31, 31, 29, true),
 };
 
+static const struct rockchip_pmu_info rk3066_pmu = {
+	.pwr_offset = 0x08,
+	.status_offset = 0x0c,
+	.req_offset = 0x38, /* PMU_MISC_CON1 */
+	.idle_offset = 0x0c,
+	.ack_offset = 0x0c,
+
+	.num_domains = ARRAY_SIZE(rk3066_pm_domains),
+	.domain_info = rk3066_pm_domains,
+};
+
 static const struct rockchip_pmu_info rk3188_pmu = {
 	.pwr_offset = 0x08,
 	.status_offset = 0x0c,
@@ -873,6 +893,10 @@ static const struct rockchip_pmu_info rk3399_pmu = {
 };
 
 static const struct of_device_id rockchip_pm_domain_dt_match[] = {
+	{
+		.compatible = "rockchip,rk3066-power-controller",
+		.data = (void *)&rk3066_pmu,
+	},
 	{
 		.compatible = "rockchip,rk3188-power-controller",
 		.data = (void *)&rk3188_pmu,
-- 
2.14.1
