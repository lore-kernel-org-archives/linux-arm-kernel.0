From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed,  2 Dec 2015 11:07:13 +0100
Subject: [PATCH RFC 2/3] input: rotary_encoder: move configuration data to
 driver data
In-Reply-To: <1449050834-31779-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1449050834-31779-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1449050834-31779-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a preparation for the next few patches. There is no change in
behaviour intended.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/input/misc/rotary_encoder.c | 166 ++++++++++++++++++++----------------
 1 file changed, 94 insertions(+), 72 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index 386bdb5314e6..0582e851993f 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -32,58 +32,65 @@
 
 struct rotary_encoder {
 	struct input_dev *input;
-	const struct rotary_encoder_platform_data *pdata;
 
+	/* configuration */
+	unsigned int steps;
 	unsigned int axis;
-	unsigned int pos;
+	unsigned int gpio_a;
+	unsigned int gpio_b;
+	unsigned int inverted_a;
+	unsigned int inverted_b;
+	unsigned int steps_per_period;
+	bool relative_axis;
+	bool rollover;
+	bool wakeup_source;
 
 	unsigned int irq_a;
 	unsigned int irq_b;
 
+	/* state */
+	unsigned int pos;
 	bool armed;
 	unsigned char dir;	/* 0 - clockwise, 1 - CCW */
-
 	char last_stable;
 };
 
-static int rotary_encoder_get_state(const struct rotary_encoder_platform_data *pdata)
+static int rotary_encoder_get_state(const struct rotary_encoder *encoder)
 {
-	int a = !!gpio_get_value(pdata->gpio_a);
-	int b = !!gpio_get_value(pdata->gpio_b);
+	int a = !!gpio_get_value(encoder->gpio_a);
+	int b = !!gpio_get_value(encoder->gpio_b);
 
-	a ^= pdata->inverted_a;
-	b ^= pdata->inverted_b;
+	a ^= encoder->inverted_a;
+	b ^= encoder->inverted_b;
 
 	return ((a << 1) | b);
 }
 
 static void rotary_encoder_report_event(struct rotary_encoder *encoder)
 {
-	const struct rotary_encoder_platform_data *pdata = encoder->pdata;
-
-	if (pdata->relative_axis) {
+	if (encoder->relative_axis) {
 		input_report_rel(encoder->input,
-				 pdata->axis, encoder->dir ? -1 : 1);
+				 encoder->axis, encoder->dir ? -1 : 1);
 	} else {
 		unsigned int pos = encoder->pos;
 
 		if (encoder->dir) {
 			/* turning counter-clockwise */
-			if (pdata->rollover)
-				pos += pdata->steps;
+			if (encoder->rollover)
+				pos += encoder->steps;
 			if (pos)
 				pos--;
 		} else {
 			/* turning clockwise */
-			if (pdata->rollover || pos < pdata->steps)
+			if (encoder->rollover || pos < encoder->steps)
 				pos++;
 		}
 
-		if (pdata->rollover)
-			pos %= pdata->steps;
+		if (encoder->rollover)
+			pos %= encoder->steps;
 
 		encoder->pos = pos;
-		input_report_abs(encoder->input, pdata->axis, encoder->pos);
+		input_report_abs(encoder->input, encoder->axis, encoder->pos);
 	}
 
 	input_sync(encoder->input);
@@ -94,7 +101,7 @@ static irqreturn_t rotary_encoder_irq(int irq, void *dev_id)
 	struct rotary_encoder *encoder = dev_id;
 	int state;
 
-	state = rotary_encoder_get_state(encoder->pdata);
+	state = rotary_encoder_get_state(encoder);
 
 	switch (state) {
 	case 0x0:
@@ -123,7 +130,7 @@ static irqreturn_t rotary_encoder_half_period_irq(int irq, void *dev_id)
 	struct rotary_encoder *encoder = dev_id;
 	int state;
 
-	state = rotary_encoder_get_state(encoder->pdata);
+	state = rotary_encoder_get_state(encoder);
 
 	switch (state) {
 	case 0x00:
@@ -149,7 +156,7 @@ static irqreturn_t rotary_encoder_quarter_period_irq(int irq, void *dev_id)
 	unsigned char sum;
 	int state;
 
-	state = rotary_encoder_get_state(encoder->pdata);
+	state = rotary_encoder_get_state(encoder);
 
 	/*
 	 * We encode the previous and the current state using a byte.
@@ -199,38 +206,34 @@ static const struct of_device_id rotary_encoder_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rotary_encoder_of_match);
 
-static struct rotary_encoder_platform_data *rotary_encoder_parse_dt(struct device *dev)
+static int rotary_encoder_parse_dt(struct device *dev,
+				   struct rotary_encoder *encoder)
 {
 	const struct of_device_id *of_id =
 				of_match_device(rotary_encoder_of_match, dev);
 	struct device_node *np = dev->of_node;
-	struct rotary_encoder_platform_data *pdata;
 	enum of_gpio_flags flags;
 	int error;
 
 	if (!of_id || !np)
-		return NULL;
-
-	pdata = devm_kzalloc(dev, sizeof(struct rotary_encoder_platform_data),
-			     GFP_KERNEL);
-	if (!pdata)
-		return ERR_PTR(-ENOMEM);
+		return 1;
 
-	of_property_read_u32(np, "rotary-encoder,steps", &pdata->steps);
-	of_property_read_u32(np, "linux,axis", &pdata->axis);
+	of_property_read_u32(np, "rotary-encoder,steps", &encoder->steps);
+	of_property_read_u32(np, "linux,axis", &encoder->axis);
 
-	pdata->gpio_a = of_get_gpio_flags(np, 0, &flags);
-	pdata->inverted_a = flags & OF_GPIO_ACTIVE_LOW;
+	encoder->gpio_a = of_get_gpio_flags(np, 0, &flags);
+	encoder->inverted_a = flags & OF_GPIO_ACTIVE_LOW;
 
-	pdata->gpio_b = of_get_gpio_flags(np, 1, &flags);
-	pdata->inverted_b = flags & OF_GPIO_ACTIVE_LOW;
+	encoder->gpio_b = of_get_gpio_flags(np, 1, &flags);
+	encoder->inverted_b = flags & OF_GPIO_ACTIVE_LOW;
 
-	pdata->relative_axis =
+	encoder->relative_axis =
 		of_property_read_bool(np, "rotary-encoder,relative-axis");
-	pdata->rollover = of_property_read_bool(np, "rotary-encoder,rollover");
+	encoder->rollover =
+		of_property_read_bool(np, "rotary-encoder,rollover");
 
 	error = of_property_read_u32(np, "rotary-encoder,steps-per-period",
-				     &pdata->steps_per_period);
+				     &encoder->steps_per_period);
 	if (error) {
 		/*
 		 * The 'half-period' property has been deprecated, you must use
@@ -238,45 +241,57 @@ static struct rotary_encoder_platform_data *rotary_encoder_parse_dt(struct devic
 		 * need to parse it to maintain compatibility.
 		 */
 		if (of_property_read_bool(np, "rotary-encoder,half-period")) {
-			pdata->steps_per_period = 2;
+			encoder->steps_per_period = 2;
 		} else {
 			/* Fallback to one step per period behavior */
-			pdata->steps_per_period = 1;
+			encoder->steps_per_period = 1;
 		}
 	}
 
-	pdata->wakeup_source = of_property_read_bool(np, "wakeup-source");
+	encoder->wakeup_source = of_property_read_bool(np, "wakeup-source");
 
-	return pdata;
+	return 0;
 }
 #else
-static inline struct rotary_encoder_platform_data *
-rotary_encoder_parse_dt(struct device *dev)
+static inline int rotary_encoder_parse_dt(struct device *dev,
+					  struct rotary_encoder *encoder)
 {
-	return NULL;
+	return 1;
 }
 #endif
 
+static int rotary_encoder_parse_pdata(struct device *dev,
+				      struct rotary_encoder *encoder)
+{
+	const struct rotary_encoder_platform_data *pdata;
+
+	pdata = dev_get_platdata(dev);
+	if (!pdata) {
+		dev_err(dev, "missing platform data\n");
+		return -EINVAL;
+	}
+
+	encoder->steps = pdata->steps;
+	encoder->axis = pdata->axis;
+	encoder->gpio_a = pdata->gpio_a;
+	encoder->gpio_b = pdata->gpio_b;
+	encoder->inverted_a = pdata->inverted_a;
+	encoder->inverted_b = pdata->inverted_b;
+	encoder->steps_per_period = pdata->steps_per_period;
+	encoder->relative_axis = pdata->relative_axis;
+	encoder->rollover = pdata->rollover;
+
+	return 0;
+}
+
 static int rotary_encoder_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	const struct rotary_encoder_platform_data *pdata = dev_get_platdata(dev);
 	struct rotary_encoder *encoder;
 	struct input_dev *input;
 	irq_handler_t handler;
 	int err;
 
-	if (!pdata) {
-		pdata = rotary_encoder_parse_dt(dev);
-		if (IS_ERR(pdata))
-			return PTR_ERR(pdata);
-
-		if (!pdata) {
-			dev_err(dev, "missing platform data\n");
-			return -EINVAL;
-		}
-	}
-
 	encoder = devm_kzalloc(dev, sizeof(struct rotary_encoder), GFP_KERNEL);
 	input = devm_input_allocate_device(&pdev->dev);
 	if (!encoder || !input) {
@@ -284,55 +299,62 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	err = rotary_encoder_parse_dt(dev, encoder);
+	if (err > 0)
+		/* not instatiated by dt */
+		err = rotary_encoder_parse_pdata(dev, encoder);
+
+	if (err < 0)
+		return err;
+
 	encoder->input = input;
-	encoder->pdata = pdata;
 
 	input->name = pdev->name;
 	input->id.bustype = BUS_HOST;
 	input->dev.parent = dev;
 
-	if (pdata->relative_axis) {
+	if (encoder->relative_axis) {
 		input->evbit[0] = BIT_MASK(EV_REL);
-		input->relbit[0] = BIT_MASK(pdata->axis);
+		input->relbit[0] = BIT_MASK(encoder->axis);
 	} else {
 		input->evbit[0] = BIT_MASK(EV_ABS);
 		input_set_abs_params(encoder->input,
-				     pdata->axis, 0, pdata->steps, 0, 1);
+				     encoder->axis, 0, encoder->steps, 0, 1);
 	}
 
 	/* request the GPIOs */
-	err = devm_gpio_request_one(dev, pdata->gpio_a,
+	err = devm_gpio_request_one(dev, encoder->gpio_a,
 				    GPIOF_IN, dev_name(dev));
 	if (err) {
-		dev_err(dev, "unable to request GPIO %d\n", pdata->gpio_a);
+		dev_err(dev, "unable to request GPIO %d\n", encoder->gpio_a);
 		return err;
 	}
 
-	err = devm_gpio_request_one(dev, pdata->gpio_b,
+	err = devm_gpio_request_one(dev, encoder->gpio_b,
 				    GPIOF_IN, dev_name(dev));
 	if (err) {
-		dev_err(dev, "unable to request GPIO %d\n", pdata->gpio_b);
+		dev_err(dev, "unable to request GPIO %d\n", encoder->gpio_b);
 		return err;
 	}
 
-	encoder->irq_a = gpio_to_irq(pdata->gpio_a);
-	encoder->irq_b = gpio_to_irq(pdata->gpio_b);
+	encoder->irq_a = gpio_to_irq(encoder->gpio_a);
+	encoder->irq_b = gpio_to_irq(encoder->gpio_b);
 
-	switch (pdata->steps_per_period) {
+	switch (encoder->steps_per_period) {
 	case 4:
 		handler = &rotary_encoder_quarter_period_irq;
-		encoder->last_stable = rotary_encoder_get_state(pdata);
+		encoder->last_stable = rotary_encoder_get_state(encoder);
 		break;
 	case 2:
 		handler = &rotary_encoder_half_period_irq;
-		encoder->last_stable = rotary_encoder_get_state(pdata);
+		encoder->last_stable = rotary_encoder_get_state(encoder);
 		break;
 	case 1:
 		handler = &rotary_encoder_irq;
 		break;
 	default:
 		dev_err(dev, "'%d' is not a valid steps-per-period value\n",
-			pdata->steps_per_period);
+			encoder->steps_per_period);
 		return -EINVAL;
 	}
 
@@ -358,7 +380,7 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	device_init_wakeup(&pdev->dev, pdata->wakeup_source);
+	device_init_wakeup(&pdev->dev, encoder->wakeup_source);
 
 	platform_set_drvdata(pdev, encoder);
 
-- 
2.6.2
