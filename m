From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 22 Apr 2016 18:02:51 +0800
Subject: [RESEND PATCH 5/8] thermal: rockchip: Support RK3366 SoCs in the
 thermal driver
In-Reply-To: <1461319374-10024-1-git-send-email-wxt@rock-chips.com>
References: <1461319374-10024-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1461319374-10024-6-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Elaine Zhang <zhangqing@rock-chips.com>

The RK3366 SoCs have two Temperature Sensors, channel 0 is for CPU
channel 1 is for GPU.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 drivers/thermal/rockchip_thermal.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 6436c00..3f1e5d4 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -685,6 +685,30 @@ static const struct rockchip_tsadc_chip rk3288_tsadc_data = {
 	},
 };
 
+static const struct rockchip_tsadc_chip rk3366_tsadc_data = {
+	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
+	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
+	.chn_num = 2, /* two channels for tsadc */
+
+	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
+	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
+	.tshut_temp = 95000,
+
+	.initialize = rk_tsadcv3_initialize,
+	.irq_ack = rk_tsadcv3_irq_ack,
+	.control = rk_tsadcv3_control,
+	.get_temp = rk_tsadcv2_get_temp,
+	.set_tshut_temp = rk_tsadcv2_tshut_temp,
+	.set_tshut_mode = rk_tsadcv2_tshut_mode,
+
+	.table = {
+		.id = rk3228_code_table,
+		.length = ARRAY_SIZE(rk3228_code_table),
+		.data_mask = TSADCV3_DATA_MASK,
+		.mode = ADC_INCREMENT,
+	},
+};
+
 static const struct rockchip_tsadc_chip rk3368_tsadc_data = {
 	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
 	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
@@ -743,6 +767,10 @@ static const struct of_device_id of_rockchip_thermal_match[] = {
 		.data = (void *)&rk3288_tsadc_data,
 	},
 	{
+		.compatible = "rockchip,rk3366-tsadc",
+		.data = (void *)&rk3366_tsadc_data,
+	},
+	{
 		.compatible = "rockchip,rk3368-tsadc",
 		.data = (void *)&rk3368_tsadc_data,
 	},
-- 
1.9.1
