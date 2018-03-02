From: heiko@sntech.de (Heiko Stuebner)
Date: Fri,  2 Mar 2018 13:20:31 +0100
Subject: [PATCH] soc: rockchip: disable jtag switching for RK3128 SoCs
Message-ID: <20180302122031.17426-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xiao Yao <xiaoyao@rock-chips.com>

Disable IO function switching between sdmmc and jtag
for RK3128 SoCs.

Signed-off-by: Xiao Yao <xiaoyao@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/soc/rockchip/grf.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/soc/rockchip/grf.c b/drivers/soc/rockchip/grf.c
index dd81b87d79f0..96882ffde67e 100644
--- a/drivers/soc/rockchip/grf.c
+++ b/drivers/soc/rockchip/grf.c
@@ -43,6 +43,17 @@ static const struct rockchip_grf_info rk3036_grf __initconst = {
 	.num_values = ARRAY_SIZE(rk3036_defaults),
 };
 
+#define RK3128_GRF_SOC_CON0		0x140
+
+static const struct rockchip_grf_value rk3128_defaults[] __initconst = {
+	{ "jtag switching", RK3128_GRF_SOC_CON0, HIWORD_UPDATE(0, 1, 8) },
+};
+
+static const struct rockchip_grf_info rk3128_grf __initconst = {
+	.values = rk3128_defaults,
+	.num_values = ARRAY_SIZE(rk3128_defaults),
+};
+
 #define RK3228_GRF_SOC_CON6		0x418
 
 static const struct rockchip_grf_value rk3228_defaults[] __initconst = {
@@ -102,6 +113,9 @@ static const struct of_device_id rockchip_grf_dt_match[] __initconst = {
 	{
 		.compatible = "rockchip,rk3036-grf",
 		.data = (void *)&rk3036_grf,
+	}, {
+		.compatible = "rockchip,rk3128-grf",
+		.data = (void *)&rk3128_grf,
 	}, {
 		.compatible = "rockchip,rk3228-grf",
 		.data = (void *)&rk3228_grf,
-- 
2.16.1
