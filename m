From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 23 Oct 2018 12:38:17 +0200
Subject: [PATCH v3 4/7] soc: rockchip: power-domain: add rk3188 powerdomains
In-Reply-To: <20181023103820.6464-1-heiko@sntech.de>
References: <20181023103820.6464-1-heiko@sntech.de>
Message-ID: <20181023103820.6464-5-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add power-domains found on rk3188 socs.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/soc/rockchip/pm_domains.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 6dff8682155f..58bd39cd3369 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -22,6 +22,7 @@
 #include <dt-bindings/power/px30-power.h>
 #include <dt-bindings/power/rk3036-power.h>
 #include <dt-bindings/power/rk3128-power.h>
+#include <dt-bindings/power/rk3188-power.h>
 #include <dt-bindings/power/rk3228-power.h>
 #include <dt-bindings/power/rk3288-power.h>
 #include <dt-bindings/power/rk3328-power.h>
@@ -745,6 +746,14 @@ static const struct rockchip_domain_info rk3128_pm_domains[] = {
 	[RK3128_PD_GPU]		= DOMAIN_RK3288(1, 1, 3, false),
 };
 
+static const struct rockchip_domain_info rk3188_pm_domains[] = {
+	[RK3188_PD_GPU]		= DOMAIN(9, 9, 3, 24, 29, false),
+	[RK3188_PD_VIDEO]	= DOMAIN(8, 8, 4, 23, 28, false),
+	[RK3188_PD_VIO]		= DOMAIN(7, 7, 5, 22, 27, false),
+	[RK3188_PD_PERI]	= DOMAIN(6, 6, 2, 25, 30, false),
+	[RK3188_PD_CPU]		= DOMAIN(5, 5, 1, 26, 31, false),
+};
+
 static const struct rockchip_domain_info rk3228_pm_domains[] = {
 	[RK3228_PD_CORE]	= DOMAIN_RK3036(0, 0, 16, true),
 	[RK3228_PD_MSCH]	= DOMAIN_RK3036(1, 1, 17, true),
@@ -857,6 +866,17 @@ static const struct rockchip_pmu_info rk3128_pmu = {
 	.domain_info = rk3128_pm_domains,
 };
 
+static const struct rockchip_pmu_info rk3188_pmu = {
+	.pwr_offset = 0x08,
+	.status_offset = 0x0c,
+	.req_offset = 0x38, /* PMU_MISC_CON1 */
+	.idle_offset = 0x0c,
+	.ack_offset = 0x0c,
+
+	.num_domains = ARRAY_SIZE(rk3188_pm_domains),
+	.domain_info = rk3188_pm_domains,
+};
+
 static const struct rockchip_pmu_info rk3228_pmu = {
 	.req_offset = 0x40c,
 	.idle_offset = 0x488,
@@ -952,6 +972,10 @@ static const struct of_device_id rockchip_pm_domain_dt_match[] = {
 		.compatible = "rockchip,rk3128-power-controller",
 		.data = (void *)&rk3128_pmu,
 	},
+	{
+		.compatible = "rockchip,rk3188-power-controller",
+		.data = (void *)&rk3188_pmu,
+	},
 	{
 		.compatible = "rockchip,rk3228-power-controller",
 		.data = (void *)&rk3228_pmu,
-- 
2.18.0
