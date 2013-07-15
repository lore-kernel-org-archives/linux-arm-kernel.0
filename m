From: denis@eukrea.com (Denis Carikli)
Date: Mon, 15 Jul 2013 16:57:04 +0200
Subject: [PATCH 19/22] Input: tsc2007: Add device tree support.
In-Reply-To: <1373900227-341-1-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
Message-ID: <1373900227-341-20-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set the of_match_table for this driver so that devices can be described
  in the device tree.

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 .../bindings/input/touchscreen/tsc2007.txt         |   44 +++++
 drivers/input/touchscreen/tsc2007.c                |  205 ++++++++++++++++----
 2 files changed, 206 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
new file mode 100644
index 0000000..d67b33f
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
@@ -0,0 +1,44 @@
+* Texas Instruments tsc2007 touchscreen controller
+
+Required properties:
+- compatible: must be "ti,tsc2007".
+- reg: I2C address of the chip.
+- pinctrl-0: Should specify pin control groups used for this controller
+  (see pinctrl bindings[0]).
+- pinctrl-names: Should contain only one value - "default"
+  (see pinctrl bindings[0]).
+- interrupt-parent: the phandle for the interrupt controller
+  (see interrupt binding[1]).
+- interrupts: interrupt to which the chip is connected
+  (see interrupt binding[1]).
+- x-plate-ohms: X-plate resistance in ohms.
+
+Optional properties:
+- gpios: the interrupt gpio the chip is connected to (trough the penirq pin)
+  (see GPIO binding[2] for more details).
+- max-rt: maximum pressure.
+- fuzzy: specifies the fuzz value that is used to filter noise from the event
+  stream.
+- poll-period: how much time to wait(in millisecond) before reading again the
+  values from the tsc2007.
+
+[0]: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+[1]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+[2]: Documentation/devicetree/bindings/gpio/gpio.txt
+
+Example:
+	&i2c1 {
+		/* ... */
+		tsc2007 at 49 {
+			compatible = "ti,tsc2007";
+			reg = <0x49>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_tsc2007_1>;
+			interrupt-parent = <&gpio4>;
+			interrupts = <0x0 0x8>;
+			gpios = <&gpio4 0 0>;
+			x-plate-ohms = <180>;
+		};
+
+		/* ... */
+	};
diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index 0b67ba4..c0af04b 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -26,6 +26,9 @@
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
 #include <linux/i2c/tsc2007.h>
+#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
 
 #define TSC2007_MEASURE_TEMP0		(0x0 << 4)
 #define TSC2007_MEASURE_AUX		(0x2 << 4)
@@ -74,7 +77,10 @@ struct tsc2007 {
 	u16			max_rt;
 	unsigned long		poll_delay;
 	unsigned long		poll_period;
+	int			fuzzy;
+	char			of;
 
+	unsigned		gpio;
 	int			irq;
 
 	wait_queue_head_t	wait;
@@ -84,6 +90,14 @@ struct tsc2007 {
 	void			(*clear_penirq)(void);
 };
 
+static int tsc2007_get_pendown_state_dt(struct tsc2007  *ts)
+{
+	if (ts->gpio >= 0)
+		return !gpio_get_value(ts->gpio);
+	else
+		return true;
+}
+
 static inline int tsc2007_xfer(struct tsc2007 *tsc, u8 cmd)
 {
 	s32 data;
@@ -158,6 +172,9 @@ static bool tsc2007_is_pen_down(struct tsc2007 *ts)
 	 * to fall back on the pressure reading.
 	 */
 
+	if (ts->of)
+		return tsc2007_get_pendown_state_dt(ts);
+
 	if (!ts->get_pendown_state)
 		return true;
 
@@ -175,10 +192,10 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
 
 		/* pen is down, continue with the measurement */
 		tsc2007_read_values(ts, &tc);
-
 		rt = tsc2007_calculate_pressure(ts, &tc);
 
-		if (rt == 0 && !ts->get_pendown_state) {
+		if ((ts->of && rt == 0 && ts->gpio < 0) ||
+			(!ts->of && rt == 0 && !ts->get_pendown_state)) {
 			/*
 			 * If pressure reported is 0 and we don't have
 			 * callback to check pendown state, we have to
@@ -198,7 +215,6 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
 			input_report_abs(input, ABS_PRESSURE, rt);
 
 			input_sync(input);
-
 		} else {
 			/*
 			 * Sample found inconsistent by debouncing or pressure is
@@ -217,7 +233,6 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
 	input_report_key(input, BTN_TOUCH, 0);
 	input_report_abs(input, ABS_PRESSURE, 0);
 	input_sync(input);
-
 	if (ts->clear_penirq)
 		ts->clear_penirq();
 
@@ -228,11 +243,16 @@ static irqreturn_t tsc2007_hard_irq(int irq, void *handle)
 {
 	struct tsc2007 *ts = handle;
 
-	if (!ts->get_pendown_state || likely(ts->get_pendown_state()))
-		return IRQ_WAKE_THREAD;
+	if (!ts->of) {
+		if (!ts->get_pendown_state || likely(ts->get_pendown_state()))
+			return IRQ_WAKE_THREAD;
 
-	if (ts->clear_penirq)
-		ts->clear_penirq();
+		if (ts->clear_penirq)
+			ts->clear_penirq();
+	} else {
+		if (ts->gpio < 0 || likely(tsc2007_get_pendown_state_dt(ts)))
+			return IRQ_WAKE_THREAD;
+	}
 
 	return IRQ_HANDLED;
 }
@@ -273,34 +293,70 @@ static void tsc2007_close(struct input_dev *input_dev)
 	tsc2007_stop(ts);
 }
 
-static int tsc2007_probe(struct i2c_client *client,
-				   const struct i2c_device_id *id)
+#ifdef CONFIG_OF
+static int tsc2007_probe_dt(struct i2c_client *client, struct tsc2007 *ts,
+			    struct device_node *np)
 {
-	struct tsc2007 *ts;
-	struct tsc2007_platform_data *pdata = client->dev.platform_data;
-	struct input_dev *input_dev;
-	int err;
-
-	if (!pdata) {
-		dev_err(&client->dev, "platform data is required!\n");
+	int err = 0;
+	struct pinctrl *pinctrl;
+	u32 val32;
+	u64 val64;
+
+	if (!of_property_read_u32(np, "max-rt", &val32))
+		ts->max_rt = val32;
+	else
+		ts->max_rt = MAX_12BIT;
+
+	if (!of_property_read_u32(np, "fuzzy", &val32))
+		ts->fuzzy = val32;
+
+	if (!of_property_read_u64(np, "poll-period", &val64))
+		ts->poll_period = val64;
+	else
+		ts->poll_period = 1;
+
+	if (!of_property_read_u32(np, "x-plate-ohms", &val32))
+		ts->x_plate_ohms = val32;
+	else {
+		dev_err(&client->dev,
+			"x-plate-ohms is not set up in the devicetree."
+			" (err %d).", err);
 		return -EINVAL;
 	}
 
-	if (!i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_READ_WORD_DATA))
-		return -EIO;
-
-	ts = kzalloc(sizeof(struct tsc2007), GFP_KERNEL);
-	input_dev = input_allocate_device();
-	if (!ts || !input_dev) {
-		err = -ENOMEM;
-		goto err_free_mem;
+	pinctrl = devm_pinctrl_get_select_default(&client->dev);
+	if (IS_ERR(pinctrl)) {
+		err = PTR_ERR(pinctrl);
+		return err;
 	}
 
-	ts->client = client;
-	ts->irq = client->irq;
-	ts->input = input_dev;
-	init_waitqueue_head(&ts->wait);
+	ts->gpio = of_get_gpio(np, 0);
+	if (ts->gpio < 0)
+		pr_err("GPIO not found (of_get_gpio returned %d)\n", ts->gpio);
+
+	/* Used to detect if it is probed trough the device tree,
+	 * in order to be able to use that information in the IRQ handler.
+	 */
+	ts->of = 1;
+
+	return 0;
+}
+#else
+static int tsc2007_probe_dt(struct i2c_client *client, struct tsc2007 *ts,
+			    struct device_node *np)
+{
+	return -ENODEV;
+}
+#endif
+
+static int tsc2007_probe_pdev(struct i2c_client *client, struct tsc2007 *ts,
+			      struct tsc2007_platform_data *pdata,
+			      const struct i2c_device_id *id)
+{
+	if (!pdata) {
+		dev_err(&client->dev, "platform data is required!\n");
+		return -EINVAL;
+	}
 
 	ts->model             = pdata->model;
 	ts->x_plate_ohms      = pdata->x_plate_ohms;
@@ -309,13 +365,59 @@ static int tsc2007_probe(struct i2c_client *client,
 	ts->poll_period       = pdata->poll_period ? : 1;
 	ts->get_pendown_state = pdata->get_pendown_state;
 	ts->clear_penirq      = pdata->clear_penirq;
+	ts->fuzzy             = pdata->fuzzy;
 
 	if (pdata->x_plate_ohms == 0) {
 		dev_err(&client->dev, "x_plate_ohms is not set up in platform data");
-		err = -EINVAL;
+		return -EINVAL;
+	}
+
+	/* Used to detect if it is probed trough the device tree,
+	 * in order to be able to use that information in the IRQ handler.
+	 */
+	ts->of = 0;
+
+	return 0;
+}
+
+static int tsc2007_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct device_node *np = client->dev.of_node;
+	struct tsc2007_platform_data *pdata = client->dev.platform_data;
+	struct tsc2007 *ts;
+	struct input_dev *input_dev;
+	int err = 0;
+
+	ts = kzalloc(sizeof(struct tsc2007), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+
+	if (np)
+		err = tsc2007_probe_dt(client, ts, np);
+	else
+		err = tsc2007_probe_pdev(client, ts, pdata, id);
+
+	if (err)
+		goto err_free_mem;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_READ_WORD_DATA)) {
+		err = -EIO;
 		goto err_free_mem;
 	}
 
+	input_dev = input_allocate_device();
+	if (!input_dev) {
+		err = -ENOMEM;
+		goto err_free_input;
+	};
+
+	ts->client = client;
+	ts->irq = client->irq;
+	ts->input = input_dev;
+	init_waitqueue_head(&ts->wait);
+
 	snprintf(ts->phys, sizeof(ts->phys),
 		 "%s/input0", dev_name(&client->dev));
 
@@ -331,19 +433,21 @@ static int tsc2007_probe(struct i2c_client *client,
 	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
 	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
 
-	input_set_abs_params(input_dev, ABS_X, 0, MAX_12BIT, pdata->fuzzx, 0);
-	input_set_abs_params(input_dev, ABS_Y, 0, MAX_12BIT, pdata->fuzzy, 0);
+	input_set_abs_params(input_dev, ABS_X, 0, MAX_12BIT, ts->fuzzy, 0);
+	input_set_abs_params(input_dev, ABS_Y, 0, MAX_12BIT, ts->fuzzy, 0);
 	input_set_abs_params(input_dev, ABS_PRESSURE, 0, MAX_12BIT,
-			pdata->fuzzz, 0);
+			     ts->fuzzy, 0);
 
-	if (pdata->init_platform_hw)
-		pdata->init_platform_hw();
+	if (!np) {
+		if (pdata->init_platform_hw)
+			pdata->init_platform_hw();
+	}
 
 	err = request_threaded_irq(ts->irq, tsc2007_hard_irq, tsc2007_soft_irq,
 				   IRQF_ONESHOT, client->dev.driver->name, ts);
 	if (err < 0) {
 		dev_err(&client->dev, "irq %d busy?\n", ts->irq);
-		goto err_free_mem;
+		goto err_free_input;
 	}
 
 	tsc2007_stop(ts);
@@ -358,23 +462,29 @@ static int tsc2007_probe(struct i2c_client *client,
 
  err_free_irq:
 	free_irq(ts->irq, ts);
-	if (pdata->exit_platform_hw)
-		pdata->exit_platform_hw();
- err_free_mem:
+	if (!np) {
+		if (pdata->exit_platform_hw)
+			pdata->exit_platform_hw();
+	}
+ err_free_input:
 	input_free_device(input_dev);
+ err_free_mem:
 	kfree(ts);
 	return err;
 }
 
 static int tsc2007_remove(struct i2c_client *client)
 {
+	struct device_node *np = client->dev.of_node;
 	struct tsc2007	*ts = i2c_get_clientdata(client);
 	struct tsc2007_platform_data *pdata = client->dev.platform_data;
 
 	free_irq(ts->irq, ts);
 
-	if (pdata->exit_platform_hw)
-		pdata->exit_platform_hw();
+	if (!np) {
+		if (pdata->exit_platform_hw)
+			pdata->exit_platform_hw();
+	}
 
 	input_unregister_device(ts->input);
 	kfree(ts);
@@ -389,10 +499,19 @@ static const struct i2c_device_id tsc2007_idtable[] = {
 
 MODULE_DEVICE_TABLE(i2c, tsc2007_idtable);
 
+#ifdef CONFIG_OF
+static const struct of_device_id tsc2007_of_match[] = {
+	{ .compatible = "ti,tsc2007" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, tsc2007_of_match);
+#endif
+
 static struct i2c_driver tsc2007_driver = {
 	.driver = {
 		.owner	= THIS_MODULE,
-		.name	= "tsc2007"
+		.name	= "tsc2007",
+		.of_match_table = of_match_ptr(tsc2007_of_match),
 	},
 	.id_table	= tsc2007_idtable,
 	.probe		= tsc2007_probe,
-- 
1.7.9.5
