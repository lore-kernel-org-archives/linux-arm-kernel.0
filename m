From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Sat, 21 Apr 2018 17:12:41 +0200
Subject: [PATCH 13/27] thermal: armada: add overheat interrupt support
In-Reply-To: <20180421151255.29929-1-miquel.raynal@bootlin.com>
References: <20180421151255.29929-1-miquel.raynal@bootlin.com>
Message-ID: <20180421151255.29929-14-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IP can manage to trigger interrupts on overheat situation from all
the sensors.

However, the interrupt source changes along with the last selected
source (ie. the last read sensor), which is an inconsistent behavior.
Avoid possible glitches by always selecting back only one channel which
will then be referenced as the "overheat_sensor" (arbitrarily: the first
in the DT which has a critical trip point filled in).

It is possible that the scan of all thermal zone nodes did not bring a
critical trip point from which the overheat interrupt could be
configured. In this case just complain but do not fail the probe.

Also disable sensor switch during overheat situations because changing
the channel while the system is too hot could clear the overheat state
by changing the source while the temperature is still very high.

Even if the overheat state is not declared, overheat interrupt must be
cleared by reading the DFX interrupt cause _after_ the temperature has
fallen down to the low threshold, otherwise future possible interrupts
would not be served. A work polls the corresponding register until the
overheat flag gets cleared in this case.

Suggested-by: David Sniatkiwicz <davidsn@marvell.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/thermal/armada_thermal.c | 335 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 335 insertions(+)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 66324fc853a3..6cef29d51fb0 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -24,8 +24,14 @@
 #include <linux/of_device.h>
 #include <linux/thermal.h>
 #include <linux/iopoll.h>
+#include <linux/interrupt.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include <linux/workqueue.h>
+
+#include "thermal_core.h"
+
+#define TO_MCELSIUS(c)			(c * 1000)
 
 /* Thermal Manager Control and Status Register */
 #define PMU_TDC0_SW_RST_MASK		(0x1 << 1)
@@ -61,9 +67,13 @@
 #define CONTROL1_TSEN_AVG_MASK		0x7
 #define CONTROL1_EXT_TSEN_SW_RESET	BIT(7)
 #define CONTROL1_EXT_TSEN_HW_RESETn	BIT(8)
+#define CONTROL1_TSEN_INT_EN		BIT(25)
+#define CONTROL1_TSEN_SELECT_OFF	21
+#define CONTROL1_TSEN_SELECT_MASK	0x3
 
 #define STATUS_POLL_PERIOD_US		1000
 #define STATUS_POLL_TIMEOUT_US		100000
+#define OVERHEAT_INT_POLL_DELAY		(1 * HZ)
 
 struct armada_thermal_data;
 
@@ -73,8 +83,15 @@ struct armada_thermal_priv {
 	struct regmap *syscon;
 	char zone_name[THERMAL_NAME_LENGTH];
 	struct mutex update_lock;
+	struct thermal_zone_device *overheat_sensor;
 	struct armada_thermal_data *data;
 	int current_channel;
+	struct delayed_work wait_end_overheat_work;
+	bool overheat_int_enabled;
+	long current_threshold;
+	long current_hysteresis;
+	bool overheat_situation;
+	int interrupt_source;
 };
 
 struct armada_thermal_data {
@@ -92,12 +109,20 @@ struct armada_thermal_data {
 	/* Register shift and mask to access the sensor temperature */
 	unsigned int temp_shift;
 	unsigned int temp_mask;
+	unsigned int thresh_shift;
+	unsigned int hyst_shift;
+	unsigned int hyst_mask;
 	u32 is_valid_bit;
 
 	/* Syscon access */
 	unsigned int syscon_control0_off;
 	unsigned int syscon_control1_off;
 	unsigned int syscon_status_off;
+	unsigned int dfx_irq_cause_off;
+	unsigned int dfx_irq_mask_off;
+	unsigned int dfx_overheat_irq;
+	unsigned int dfx_server_irq_mask_off;
+	unsigned int dfx_server_irq_en;
 
 	/* One sensor is in the thermal IC, the others are in the CPUs if any */
 	unsigned int cpu_nr;
@@ -125,6 +150,12 @@ struct armada_thermal_sensor {
 	int id;
 };
 
+struct armada_thermal_priv *work_to_thermal(struct work_struct *work)
+{
+	return container_of(work, struct armada_thermal_priv,
+			    wait_end_overheat_work.work);
+}
+
 static void armadaxp_init(struct platform_device *pdev,
 			  struct armada_thermal_priv *priv)
 {
@@ -271,6 +302,44 @@ static bool armada_is_valid(struct armada_thermal_priv *priv)
 	return reg & priv->data->is_valid_bit;
 }
 
+static void armada_enable_overheat_interrupt(struct armada_thermal_priv *priv)
+{
+	struct armada_thermal_data *data = priv->data;
+	u32 reg;
+
+	/* Clear DFX temperature IRQ cause */
+	regmap_read(priv->syscon, data->dfx_irq_cause_off, &reg);
+
+	/* Enable DFX Temperature IRQ */
+	regmap_read(priv->syscon, data->dfx_irq_mask_off, &reg);
+	reg |= data->dfx_overheat_irq;
+	regmap_write(priv->syscon, data->dfx_irq_mask_off, reg);
+
+	/* Enable DFX server IRQ */
+	regmap_read(priv->syscon, data->dfx_server_irq_mask_off, &reg);
+	reg |= data->dfx_server_irq_en;
+	regmap_write(priv->syscon, data->dfx_server_irq_mask_off, reg);
+
+	/* Enable overheat interrupt */
+	regmap_read(priv->syscon, data->syscon_control1_off, &reg);
+	reg |= CONTROL1_TSEN_INT_EN;
+	regmap_write(priv->syscon, data->syscon_control1_off, reg);
+
+	priv->overheat_int_enabled = true;
+}
+
+static void armada_disable_overheat_interrupt(struct armada_thermal_priv *priv)
+{
+	struct armada_thermal_data *data = priv->data;
+	u32 reg;
+
+	regmap_read(priv->syscon, data->syscon_control1_off, &reg);
+	reg &= ~CONTROL1_TSEN_INT_EN;
+	regmap_write(priv->syscon, data->syscon_control1_off, reg);
+
+	priv->overheat_int_enabled = false;
+}
+
 /* There is currently no board with more than one sensor per channel */
 static int armada_select_channel(struct armada_thermal_priv *priv, int channel)
 {
@@ -283,6 +352,14 @@ static int armada_select_channel(struct armada_thermal_priv *priv, int channel)
 	if (priv->current_channel == channel)
 		return 0;
 
+	/*
+	 * Changing the channel while the system is too hot could clear the
+	 * overheat state by changing the source while the temperature is still
+	 * very high. Forbid any channel change in this situation.
+	 */
+	if (priv->overheat_situation)
+		return -EBUSY;
+
 	/* Stop the measurements */
 	regmap_read(priv->syscon, data->syscon_control0_off, &ctrl0);
 	ctrl0 &= ~CONTROL0_TSEN_START;
@@ -378,11 +455,18 @@ static int armada_get_temp(void *_sensor, int *temp)
 {
 	struct armada_thermal_sensor *sensor = _sensor;
 	struct armada_thermal_priv *priv = sensor->priv;
+	bool toggle_int = priv->overheat_int_enabled &&
+			  !priv->overheat_situation &&
+			  sensor->id != priv->interrupt_source;
 	long temperature;
 	int ret;
 
 	mutex_lock(&priv->update_lock);
 
+	/* Disable the interrupt the time to read another sensor */
+	if (toggle_int)
+		armada_disable_overheat_interrupt(priv);
+
 	/* Select the desired channel */
 	ret = armada_select_channel(priv, sensor->id);
 	if (ret)
@@ -393,6 +477,14 @@ static int armada_get_temp(void *_sensor, int *temp)
 	if (ret)
 		goto unlock_mutex;
 
+	/* Select back the interrupt source channel */
+	ret = armada_select_channel(priv, priv->interrupt_source);
+	if (ret)
+		goto unlock_mutex;
+
+	if (toggle_int)
+		armada_enable_overheat_interrupt(priv);
+
 	*temp = temperature;
 
 unlock_mutex:
@@ -405,6 +497,162 @@ static struct thermal_zone_of_device_ops of_ops = {
 	.get_temp = armada_get_temp,
 };
 
+static unsigned int armada_mc_to_reg_temp(struct armada_thermal_data *data,
+					  unsigned int temp_mc)
+{
+	s64 b = data->coef_b;
+	s64 m = data->coef_m;
+	s64 div = data->coef_div;
+	unsigned int sample;
+
+	if (data->inverted)
+		sample = div_s64(((temp_mc * div) + b), m);
+	else
+		sample = div_s64((b - (temp_mc * div)), m);
+
+	return sample & data->temp_mask;
+}
+
+static unsigned int armada_mc_to_reg_hyst(struct armada_thermal_data *data,
+					  unsigned int hyst_mc)
+{
+	/*
+	 * The documentation states:
+	 * high/low watermark = threshold +/- 0.4761 * 2^(hysteresis + 2)
+	 * which is the mathematical derivation for:
+	 * 0x0 <=> 1.9?C, 0x1 <=> 3.8?C, 0x2 <=> 7.6?C, 0x3 <=> 15.2
+	 */
+	unsigned int hyst_levels_mc[] = {1900, 3800, 7600, 15200};
+	int i;
+
+	/*
+	 * We will always take the smallest possible hysteresis to avoid risking
+	 * the hardware integrity by enlarging the threshold by +8?C in the
+	 * worst case.
+	 */
+	for (i = ARRAY_SIZE(hyst_levels_mc) - 1; i > 0; i--)
+		if (hyst_mc >= hyst_levels_mc[i])
+			break;
+
+	return i & data->hyst_mask;
+}
+
+static void armada_set_overheat_thresholds(struct armada_thermal_priv *priv,
+					   int thresh_mc, int hyst_mc)
+{
+	struct armada_thermal_data *data = priv->data;
+	unsigned int threshold = armada_mc_to_reg_temp(data, thresh_mc);
+	unsigned int hysteresis = armada_mc_to_reg_hyst(data, hyst_mc);
+	u32 ctrl1;
+
+	regmap_read(priv->syscon, data->syscon_control1_off, &ctrl1);
+
+	/* Set Threshold */
+	if (thresh_mc >= 0) {
+		ctrl1 &= ~(data->temp_mask << data->thresh_shift);
+		ctrl1 |= threshold << data->thresh_shift;
+		priv->current_threshold = thresh_mc;
+	}
+
+	/* Set Hysteresis */
+	if (hyst_mc >= 0) {
+		ctrl1 &= ~(data->hyst_mask << data->hyst_shift);
+		ctrl1 |= hysteresis << data->hyst_shift;
+		priv->current_hysteresis = hyst_mc;
+	}
+
+	regmap_write(priv->syscon, data->syscon_control1_off, ctrl1);
+}
+
+static bool armada_temp_is_over_threshold(struct armada_thermal_priv *priv)
+{
+	struct armada_thermal_data *data = priv->data;
+	u32 reg;
+
+	/*
+	 * When an overheat interrupt occurs, poll DFX overheat IRQ cause
+	 * register until the right bit gets cleared.
+	 */
+	regmap_read(priv->syscon, data->dfx_irq_cause_off, &reg);
+	if (reg & data->dfx_overheat_irq) {
+		/*
+		 * Threshold reached, as different CPs may share the same
+		 * interrupt, we need to mask the overheat interrupt until the
+		 * temperature climbs down to the low-threshold, otherwise if
+		 * another CP reaches its threshold temperature too, it will
+		 * re-trigger an interrupt for the CPs that are already over
+		 * heating.
+		 */
+		regmap_read(priv->syscon, data->dfx_irq_mask_off, &reg);
+		reg &= ~data->dfx_overheat_irq;
+		regmap_write(priv->syscon, data->dfx_irq_mask_off, reg);
+
+		schedule_delayed_work(&priv->wait_end_overheat_work,
+				      OVERHEAT_INT_POLL_DELAY);
+
+		priv->overheat_situation = true;
+
+		return true;
+	}
+
+	/*
+	 * The temperature level is acceptable again, unmask the overheat
+	 * interrupt.
+	 */
+	regmap_read(priv->syscon, data->dfx_irq_mask_off, &reg);
+	reg |= data->dfx_overheat_irq;
+	regmap_write(priv->syscon, data->dfx_irq_mask_off, reg);
+
+	priv->overheat_situation = false;
+
+	/* Notify the thermal core that the temperature is acceptable again */
+	thermal_zone_device_update(priv->overheat_sensor,
+				   THERMAL_EVENT_UNSPECIFIED);
+
+	return false;
+}
+
+/*
+ * Overheat interrupt must be cleared by reading the DFX interrupt cause after
+ * the temperature has fallen down to the low threshold, otherwise future
+ * interrupts will not be served. This work polls the corresponding register
+ * until the overheat flag gets cleared.
+ */
+static void armada_wait_end_overheat(struct work_struct *work)
+{
+	armada_temp_is_over_threshold(work_to_thermal(work));
+}
+
+static irqreturn_t armada_overheat_isr(int irq, void *blob)
+{
+	struct armada_thermal_priv *priv = (struct armada_thermal_priv *)blob;
+	u32 reg;
+	long temperature;
+
+	/*
+	 * As the interrupt line is shared between CPs, this handler will be
+	 * executed each time a CP triggers an overheat interrupt. Once the
+	 * interrupt is triggered for one CP, it is masked in the DFX register
+	 * until the temperature falls under the threshold, when it is unmasked.
+	 *
+	 * Check if the interrupt is masked, in this case it means the code is
+	 * running on the wrong CP and we should return IRQ_NONE.
+	 */
+	regmap_read(priv->syscon, priv->data->dfx_irq_mask_off, &reg);
+	if (!(reg & priv->data->dfx_overheat_irq))
+		return IRQ_NONE;
+
+	if (armada_temp_is_over_threshold(priv)) {
+		armada_read_sensor(priv, &temperature);
+
+		/* Notify the core about the unexpected heat level */
+		thermal_zone_device_update(priv->overheat_sensor,
+					   THERMAL_EVENT_UNSPECIFIED);
+	}
+
+	return IRQ_HANDLED;
+}
+
 static const struct armada_thermal_data armadaxp_data = {
 	.init = armadaxp_init,
 	.temp_shift = 10,
@@ -460,6 +708,9 @@ static const struct armada_thermal_data armada_ap806_data = {
 	.is_valid_bit = BIT(16),
 	.temp_shift = 0,
 	.temp_mask = 0x3ff,
+	.thresh_shift = 3,
+	.hyst_shift = 19,
+	.hyst_mask = 0x3,
 	.coef_b = -150000LL,
 	.coef_m = 423ULL,
 	.coef_div = 1,
@@ -468,6 +719,11 @@ static const struct armada_thermal_data armada_ap806_data = {
 	.syscon_control0_off = 0x84,
 	.syscon_control1_off = 0x88,
 	.syscon_status_off = 0x8C,
+	.dfx_irq_cause_off = 0x108,
+	.dfx_irq_mask_off = 0x10C,
+	.dfx_overheat_irq = BIT(22),
+	.dfx_server_irq_mask_off = 0x104,
+	.dfx_server_irq_en = BIT(1),
 	.cpu_nr = 4,
 };
 
@@ -476,6 +732,9 @@ static const struct armada_thermal_data armada_cp110_data = {
 	.is_valid_bit = BIT(10),
 	.temp_shift = 0,
 	.temp_mask = 0x3ff,
+	.thresh_shift = 16,
+	.hyst_shift = 26,
+	.hyst_mask = 0x3,
 	.coef_b = 1172499100ULL,
 	.coef_m = 2000096ULL,
 	.coef_div = 4201,
@@ -483,6 +742,11 @@ static const struct armada_thermal_data armada_cp110_data = {
 	.syscon_control0_off = 0x70,
 	.syscon_control1_off = 0x74,
 	.syscon_status_off = 0x78,
+	.dfx_irq_cause_off = 0x108,
+	.dfx_irq_mask_off = 0x10C,
+	.dfx_overheat_irq = BIT(20),
+	.dfx_server_irq_mask_off = 0x104,
+	.dfx_server_irq_en = BIT(1),
 };
 
 static const struct of_device_id armada_thermal_id_table[] = {
@@ -560,10 +824,28 @@ static int armada_thermal_probe_legacy(struct platform_device *pdev,
 static int armada_thermal_probe_syscon(struct platform_device *pdev,
 				       struct armada_thermal_priv *priv)
 {
+	int irq, ret;
+
 	priv->syscon = syscon_node_to_regmap(pdev->dev.parent->of_node);
 	if (IS_ERR(priv->syscon))
 		return PTR_ERR(priv->syscon);
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	/*
+	 * One SEI interrupt in the GIC can be triggered by each DFX server (one
+	 * per CP) upon hardware interrupt from the thermal IP itself.
+	 */
+	ret = devm_request_irq(&pdev->dev, irq, armada_overheat_isr, 0,
+			       NULL, priv);
+	if (ret)
+		return ret;
+
+	INIT_DELAYED_WORK(&priv->wait_end_overheat_work,
+			  armada_wait_end_overheat);
+
 	return 0;
 }
 
@@ -597,6 +879,47 @@ static void armada_set_sane_name(struct platform_device *pdev,
 	} while (insane_char);
 }
 
+/*
+ * The IP can manage to trigger interrupts on overheat situation from all the
+ * sensors. However, the interrupt source changes along with the last selected
+ * source (ie. the last read sensor), which is an inconsistent behavior. Avoid
+ * possible glitches by always selecting back only one channel (arbitrarily: the
+ * first in the DT which has a critical trip point). We also disable sensor
+ * switch during overheat situations.
+ */
+static int armada_configure_overheat_int(struct armada_thermal_priv *priv,
+					 struct thermal_zone_device *tz)
+{
+	/* Retrieve the critical trip point to enable the overheat interrupt */
+	const struct thermal_trip *trips = of_thermal_get_trip_points(tz);
+	struct armada_thermal_sensor *sensor = tz->devdata;
+	int ret;
+	int i;
+
+	if (!trips)
+		return -EINVAL;
+
+	for (i = 0; i < of_thermal_get_ntrips(tz); i++)
+		if (trips[i].type == THERMAL_TRIP_CRITICAL)
+			break;
+
+	if (i == of_thermal_get_ntrips(tz))
+		return -EINVAL;
+
+	ret = armada_select_channel(priv, sensor->id);
+	if (ret)
+		return ret;
+
+	armada_set_overheat_thresholds(priv,
+				       trips[i].temperature,
+				       trips[i].hysteresis);
+	armada_enable_overheat_interrupt(priv);
+	priv->overheat_sensor = tz;
+	priv->interrupt_source = sensor->id;
+
+	return 0;
+}
+
 static int armada_thermal_probe(struct platform_device *pdev)
 {
 	struct thermal_zone_device *tz;
@@ -694,8 +1017,20 @@ static int armada_thermal_probe(struct platform_device *pdev)
 			devm_kfree(&pdev->dev, sensor);
 			continue;
 		}
+
+		/*
+		 * The first channel that has a critical trip point registered
+		 * in the DT will serve as interrupt source. Others possible
+		 * critical trip points will simply be ignored by the driver.
+		 */
+		if (!priv->overheat_sensor)
+			armada_configure_overheat_int(priv, tz);
 	}
 
+	/* Just complain if no overheat interrupt was set up */
+	if (!priv->overheat_sensor)
+		dev_warn(&pdev->dev, "Overheat interrupt feature disabled\n");
+
 	drvdata->type = SYSCON;
 	drvdata->data.priv = priv;
 	platform_set_drvdata(pdev, drvdata);
-- 
2.14.1
