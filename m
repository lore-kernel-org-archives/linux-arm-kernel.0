From: david.wu@rock-chips.com (David Wu)
Date: Wed, 11 May 2016 03:24:08 +0800
Subject: [PATCH v8 4/8] i2c: rk3x: Change SoC data to not use array
In-Reply-To: <1462908252-27016-1-git-send-email-david.wu@rock-chips.com>
References: <1462908252-27016-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1462908252-27016-5-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specifying the i2c SoC data in an array provides very little benefit and
gets unwieldly / confusing as the array grows since the next bit of code
needs to refer to elements in the array by their raw integral index.

Let's just create a single 'static const' structure for each SoC so that
we can refer to these structures by ID.

Signed-off-by: David Wu <david.wu@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Suggested-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Change in v8:
- add commit description.

 drivers/i2c/busses/i2c-rk3x.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 9eeb4e5..d7a871f 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -864,17 +864,39 @@ static const struct i2c_algorithm rk3x_i2c_algorithm = {
 	.functionality		= rk3x_i2c_func,
 };
 
-static struct rk3x_i2c_soc_data soc_data[3] = {
-	{ .grf_offset = 0x154 }, /* rk3066 */
-	{ .grf_offset = 0x0a4 }, /* rk3188 */
-	{ .grf_offset = -1 },    /* no I2C switching needed */
+static const struct rk3x_i2c_soc_data rk3066_soc_data = {
+	.grf_offset = 0x154,
+};
+
+static const struct rk3x_i2c_soc_data rk3188_soc_data = {
+	.grf_offset = 0x0a4,
+};
+
+static const struct rk3x_i2c_soc_data rk3228_soc_data = {
+	.grf_offset = -1,
+};
+
+static const struct rk3x_i2c_soc_data rk3288_soc_data = {
+	.grf_offset = -1,
 };
 
 static const struct of_device_id rk3x_i2c_match[] = {
-	{ .compatible = "rockchip,rk3066-i2c", .data = (void *)&soc_data[0] },
-	{ .compatible = "rockchip,rk3188-i2c", .data = (void *)&soc_data[1] },
-	{ .compatible = "rockchip,rk3228-i2c", .data = (void *)&soc_data[2] },
-	{ .compatible = "rockchip,rk3288-i2c", .data = (void *)&soc_data[2] },
+	{
+		.compatible = "rockchip,rk3066-i2c",
+		.data = (void *)&rk3066_soc_data
+	},
+	{
+		.compatible = "rockchip,rk3188-i2c",
+		.data = (void *)&rk3188_soc_data
+	},
+	{
+		.compatible = "rockchip,rk3228-i2c",
+		.data = (void *)&rk3228_soc_data
+	},
+	{
+		.compatible = "rockchip,rk3288-i2c",
+		.data = (void *)&rk3288_soc_data
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, rk3x_i2c_match);
-- 
1.9.1
