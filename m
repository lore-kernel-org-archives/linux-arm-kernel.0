From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 14 Sep 2016 14:27:47 +0100
Subject: [PATCH 09/19] thermal: sti: Remove obsolete STiH416 platform support.
In-Reply-To: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1473859677-9231-10-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

STiH415/6 SoC support is being removed from the kernel.
This patch removes support from the thermal driver.
Also it updates the register defines and removes
the SoC and die prefix as neither of these are relevant
in the context of STiH407 based silicon (STiH415/6 were
dual die SoCs with an MPE die and SAS die).

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Cc: <rui.zhang@intel.com>
Cc: <edubezval@gmail.com>
---
 drivers/thermal/st/st_thermal_memmap.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/st_thermal_memmap.c
index fc0c9e1..d53965d 100644
--- a/drivers/thermal/st/st_thermal_memmap.c
+++ b/drivers/thermal/st/st_thermal_memmap.c
@@ -15,10 +15,10 @@
 
 #include "st_thermal.h"
 
-#define STIH416_MPE_CONF			0x0
-#define STIH416_MPE_STATUS			0x4
-#define STIH416_MPE_INT_THRESH			0x8
-#define STIH416_MPE_INT_EN			0xC
+#define CONF                       0x0
+#define STATUS                     0x4
+#define INT_THRESH                 0x8
+#define INT_EN                     0xC
 
 /* Power control bits for the memory mapped thermal sensor */
 #define THERMAL_PDN				BIT(4)
@@ -31,11 +31,11 @@ static const struct reg_field st_mmap_thermal_regfields[MAX_REGFIELDS] = {
 	 * written simultaneously for powering on and off the temperature
 	 * sensor. regmap_update_bits() will be used to update the register.
 	 */
-	[INT_THRESH_HI]	= REG_FIELD(STIH416_MPE_INT_THRESH, 	0,  7),
-	[DCORRECT]	= REG_FIELD(STIH416_MPE_CONF,		5,  9),
-	[OVERFLOW]	= REG_FIELD(STIH416_MPE_STATUS,		9,  9),
-	[DATA]		= REG_FIELD(STIH416_MPE_STATUS,		11, 18),
-	[INT_ENABLE]	= REG_FIELD(STIH416_MPE_INT_EN,		0,  0),
+	[INT_THRESH_HI]	= REG_FIELD(INT_THRESH,		0,  7),
+	[DCORRECT]	= REG_FIELD(CONF,		5,  9),
+	[OVERFLOW]	= REG_FIELD(STATUS,		9,  9),
+	[DATA]		= REG_FIELD(STATUS,		11, 18),
+	[INT_ENABLE]	= REG_FIELD(INT_EN,		0,  0),
 };
 
 static irqreturn_t st_mmap_thermal_trip_handler(int irq, void *sdata)
@@ -54,7 +54,7 @@ static int st_mmap_power_ctrl(struct st_thermal_sensor *sensor,
 	const unsigned int mask = (THERMAL_PDN | THERMAL_SRSTN);
 	const unsigned int val = power_state ? mask : 0;
 
-	return regmap_update_bits(sensor->regmap, STIH416_MPE_CONF, mask, val);
+	return regmap_update_bits(sensor->regmap, CONF, mask, val);
 }
 
 static int st_mmap_alloc_regfields(struct st_thermal_sensor *sensor)
@@ -114,7 +114,7 @@ static int st_mmap_register_enable_irq(struct st_thermal_sensor *sensor)
 	return st_mmap_enable_irq(sensor);
 }
 
-static const struct regmap_config st_416mpe_regmap_config = {
+static const struct regmap_config st_thermal_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
@@ -139,7 +139,7 @@ static int st_mmap_regmap_init(struct st_thermal_sensor *sensor)
 	}
 
 	sensor->regmap = devm_regmap_init_mmio(dev, sensor->mmio_base,
-				&st_416mpe_regmap_config);
+				&st_thermal_regmap_config);
 	if (IS_ERR(sensor->regmap)) {
 		dev_err(dev, "failed to initialise regmap\n");
 		return PTR_ERR(sensor->regmap);
@@ -156,15 +156,6 @@ static const struct st_thermal_sensor_ops st_mmap_sensor_ops = {
 	.enable_irq		= st_mmap_enable_irq,
 };
 
-/* Compatible device data stih416 mpe thermal sensor */
-static const struct st_thermal_compat_data st_416mpe_cdata = {
-	.reg_fields		= st_mmap_thermal_regfields,
-	.ops			= &st_mmap_sensor_ops,
-	.calibration_val	= 14,
-	.temp_adjust_val	= -95,
-	.crit_temp		= 120,
-};
-
 /* Compatible device data stih407 thermal sensor */
 static const struct st_thermal_compat_data st_407_cdata = {
 	.reg_fields		= st_mmap_thermal_regfields,
@@ -175,7 +166,6 @@ static const struct st_thermal_compat_data st_407_cdata = {
 };
 
 static const struct of_device_id st_mmap_thermal_of_match[] = {
-	{ .compatible = "st,stih416-mpe-thermal", .data = &st_416mpe_cdata },
 	{ .compatible = "st,stih407-thermal",     .data = &st_407_cdata },
 	{ /* sentinel */ }
 };
-- 
1.9.1
