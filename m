From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 11 Nov 2018 22:00:47 +0100
Subject: [PATCH 2/2] pinctrl: rockchip: add rk3188 routes to switch between
 nand and emmc
In-Reply-To: <20181111210047.30375-1-heiko@sntech.de>
References: <20181111210047.30375-1-heiko@sntech.de>
Message-ID: <20181111210047.30375-2-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Heiko Stuebner <heiko.stuebner@bq.com>

The rk3188 has pins that are not handled through the regular iomuxing
for handling either nand-flash or an emmc and are set through only one
specifal setting. So utilize the routing function to simply do that
setting depending on one of the core nand/emmc signals that are actually
regular pins handled through pinctrl.

Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
---
 drivers/pinctrl/pinctrl-rockchip.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 246bf14c7f72..16bf21bf69a2 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -822,6 +822,26 @@ static struct rockchip_mux_route_data rk3128_mux_route_data[] = {
 	},
 };
 
+static struct rockchip_mux_route_data rk3188_mux_route_data[] = {
+	{
+		/* non-iomuxed emmc/flash pins on flash-dqs */
+		.bank_num = 0,
+		.pin = 24,
+		.func = 1,
+		.route_location = ROCKCHIP_ROUTE_GRF,
+		.route_offset = 0xa0,
+		.route_val = BIT(16 + 11),
+	}, {
+		/* non-iomuxed emmc/flash pins on emmc-clk */
+		.bank_num = 0,
+		.pin = 24,
+		.func = 2,
+		.route_location = ROCKCHIP_ROUTE_GRF,
+		.route_offset = 0xa0,
+		.route_val = BIT(16 + 11) | BIT(11),
+	},
+};
+
 static struct rockchip_mux_route_data rk3228_mux_route_data[] = {
 	{
 		/* pwm0-0 */
@@ -3626,6 +3646,8 @@ static struct rockchip_pin_ctrl rk3188_pin_ctrl = {
 		.label			= "RK3188-GPIO",
 		.type			= RK3188,
 		.grf_mux_offset		= 0x60,
+		.iomux_routes		= rk3188_mux_route_data,
+		.niomux_routes		= ARRAY_SIZE(rk3188_mux_route_data),
 		.pull_calc_reg		= rk3188_calc_pull_reg_and_bit,
 };
 
-- 
2.18.0
