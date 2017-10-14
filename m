From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 14 Oct 2017 17:39:17 +0200
Subject: [PATCH] pinctrl: rockchip: Add iomux-route switching support for
 rk3288
In-Reply-To: <2009704.s5LEIeT6xV@phil>
References: <20171013225337.5196-1-phh@phh.me>
 <CAJ-oXjQ3e1UHVGq=uV=yAK9Bu=ZoiNZaEbnHyvNtyc15RQQSKg@mail.gmail.com>
 <2009704.s5LEIeT6xV@phil>
Message-ID: <13020229.tRmotBUImn@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far only the hdmi cec supports using one of two different pins
as source, so add the route switching for it.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
If I didn't mess up any numbering, the pinctrl change should look like
the following patch.

Hope that helps
Heiko

 drivers/pinctrl/pinctrl-rockchip.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index b5cb7858ffdc..8dd49e2e144b 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -884,6 +884,24 @@ static struct rockchip_mux_route_data rk3228_mux_route_data[] = {
 	},
 };
 
+static struct rockchip_mux_route_data rk3288_mux_route_data[] = {
+	{
+		/* edphdmi_cecinoutt1 */
+		.bank_num = 7,
+		.pin = 16,
+		.func = 2,
+		.route_offset = 0x264,
+		.route_val = BIT(16 + 12) | BIT(12),
+	}, {
+		/* edphdmi_cecinout */
+		.bank_num = 7,
+		.pin = 23,
+		.func = 4,
+		.route_offset = 0x264,
+		.route_val = BIT(16 + 12),
+	},
+};
+
 static struct rockchip_mux_route_data rk3328_mux_route_data[] = {
 	{
 		/* uart2dbg_rxm0 */
@@ -3391,6 +3409,8 @@ static struct rockchip_pin_ctrl rk3288_pin_ctrl = {
 		.type			= RK3288,
 		.grf_mux_offset		= 0x0,
 		.pmu_mux_offset		= 0x84,
+		.iomux_routes		= rk3288_mux_route_data,
+		.niomux_routes		= ARRAY_SIZE(rk3288_mux_route_data),
 		.pull_calc_reg		= rk3288_calc_pull_reg_and_bit,
 		.drv_calc_reg		= rk3288_calc_drv_reg_and_bit,
 };
-- 
2.14.1
