From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 23 Oct 2018 12:38:18 +0200
Subject: [PATCH v3 5/7] soc: rockchip: power-domain: add rk3066 powerdomains
In-Reply-To: <20181023103820.6464-1-heiko@sntech.de>
References: <20181023103820.6464-1-heiko@sntech.de>
Message-ID: <20181023103820.6464-6-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add power-domains found on rk3066 socs.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/soc/rockchip/pm_domains.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 58bd39cd3369..4587b27eeb9f 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -21,6 +21,7 @@
 #include <linux/mfd/syscon.h>
 #include <dt-bindings/power/px30-power.h>
 #include <dt-bindings/power/rk3036-power.h>
+#include <dt-bindings/power/rk3066-power.h>
 #include <dt-bindings/power/rk3128-power.h>
 #include <dt-bindings/power/rk3188-power.h>
 #include <dt-bindings/power/rk3228-power.h>
@@ -738,6 +739,14 @@ static const struct rockchip_domain_info rk3036_pm_domains[] = {
 	[RK3036_PD_SYS]		= DOMAIN_RK3036(8, 22, 29, false),
 };
 
+static const struct rockchip_domain_info rk3066_pm_domains[] = {
+	[RK3066_PD_GPU]		= DOMAIN(9, 9, 3, 24, 29, false),
+	[RK3066_PD_VIDEO]	= DOMAIN(8, 8, 4, 23, 28, false),
+	[RK3066_PD_VIO]		= DOMAIN(7, 7, 5, 22, 27, false),
+	[RK3066_PD_PERI]	= DOMAIN(6, 6, 2, 25, 30, false),
+	[RK3066_PD_CPU]		= DOMAIN(-1, 5, 1, 26, 31, false),
+};
+
 static const struct rockchip_domain_info rk3128_pm_domains[] = {
 	[RK3128_PD_CORE]	= DOMAIN_RK3288(0, 0, 4, false),
 	[RK3128_PD_MSCH]	= DOMAIN_RK3288(-1, -1, 6, true),
@@ -855,6 +864,17 @@ static const struct rockchip_pmu_info rk3036_pmu = {
 	.domain_info = rk3036_pm_domains,
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
 static const struct rockchip_pmu_info rk3128_pmu = {
 	.pwr_offset = 0x04,
 	.status_offset = 0x08,
@@ -968,6 +988,10 @@ static const struct of_device_id rockchip_pm_domain_dt_match[] = {
 		.compatible = "rockchip,rk3036-power-controller",
 		.data = (void *)&rk3036_pmu,
 	},
+	{
+		.compatible = "rockchip,rk3066-power-controller",
+		.data = (void *)&rk3066_pmu,
+	},
 	{
 		.compatible = "rockchip,rk3128-power-controller",
 		.data = (void *)&rk3128_pmu,
-- 
2.18.0
