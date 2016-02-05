From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  5 Feb 2016 13:08:21 +0100
Subject: [PATCH v3 3/3] Input: rotary-encoder - support more than 2 gpios as
 input
In-Reply-To: <1454674101-1194-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1454674101-1194-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1454674101-1194-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This changes how the used gpios are stored (i.e. a struct gpio_descs
instead of two struct gpio_desc) and as with >2 gpios the states are
numbered differently the function rotary_encoder_get_state returns
unencoded numbers instead of grey encoded numbers before. The latter has
some implications on how the returned value is used and so the change is
bigger than one might expect at first.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 .../devicetree/bindings/input/rotary-encoder.txt   |   2 +-
 drivers/input/misc/rotary_encoder.c                | 156 +++++++++------------
 2 files changed, 65 insertions(+), 93 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
index de99cbbbf6da..6c9f0c8a846c 100644
--- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
+++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
@@ -1,7 +1,7 @@
 Rotary encoder DT bindings
 
 Required properties:
-- gpios: a spec for two GPIOs to be used
+- gpios: a spec for at least two GPIOs to be used, most significant first
 
 Optional properties:
 - linux,axis: the input subsystem axis to map to this rotary encoder.
diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index 5a4e1d69c4af..09f6de77d1af 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -40,35 +40,42 @@ struct rotary_encoder {
 
 	unsigned int pos;
 
-	struct gpio_desc *gpio_a;
-	struct gpio_desc *gpio_b;
+	struct gpio_descs *gpios;
 
-	unsigned int irq_a;
-	unsigned int irq_b;
+	unsigned int *irq;
 
 	bool armed;
-	unsigned char dir;	/* 0 - clockwise, 1 - CCW */
+	signed char dir;	/* 1 - clockwise, -1 - CCW */
 
-	char last_stable;
+	unsigned last_stable;
 };
 
-static int rotary_encoder_get_state(struct rotary_encoder *encoder)
+static unsigned rotary_encoder_get_state(struct rotary_encoder *encoder)
 {
-	int a = !!gpiod_get_value_cansleep(encoder->gpio_a);
-	int b = !!gpiod_get_value_cansleep(encoder->gpio_b);
+	int i;
+	unsigned ret = 0;
 
-	return ((a << 1) | b);
+	for (i = 0; i < encoder->gpios->ndescs; ++i) {
+		int val = gpiod_get_value(encoder->gpios->desc[i]);
+		/* convert from gray encoding to normal */
+		if (ret & 1)
+			val = !val;
+
+		ret = ret << 1 | val;
+	}
+
+	return ret & 3;
 }
 
 static void rotary_encoder_report_event(struct rotary_encoder *encoder)
 {
 	if (encoder->relative_axis) {
 		input_report_rel(encoder->input,
-				 encoder->axis, encoder->dir ? -1 : 1);
+				 encoder->axis, encoder->dir);
 	} else {
 		unsigned int pos = encoder->pos;
 
-		if (encoder->dir) {
+		if (encoder->dir < 0) {
 			/* turning counter-clockwise */
 			if (encoder->rollover)
 				pos += encoder->steps;
@@ -93,7 +100,7 @@ static void rotary_encoder_report_event(struct rotary_encoder *encoder)
 static irqreturn_t rotary_encoder_irq(int irq, void *dev_id)
 {
 	struct rotary_encoder *encoder = dev_id;
-	int state;
+	unsigned state;
 
 	mutex_lock(&encoder->access_mutex);
 
@@ -108,12 +115,12 @@ static irqreturn_t rotary_encoder_irq(int irq, void *dev_id)
 		break;
 
 	case 0x1:
-	case 0x2:
+	case 0x3:
 		if (encoder->armed)
-			encoder->dir = state - 1;
+			encoder->dir = 2 - state;
 		break;
 
-	case 0x3:
+	case 0x2:
 		encoder->armed = true;
 		break;
 	}
@@ -126,25 +133,19 @@ static irqreturn_t rotary_encoder_irq(int irq, void *dev_id)
 static irqreturn_t rotary_encoder_half_period_irq(int irq, void *dev_id)
 {
 	struct rotary_encoder *encoder = dev_id;
-	int state;
+	unsigned int state;
 
 	mutex_lock(&encoder->access_mutex);
 
 	state = rotary_encoder_get_state(encoder);
 
-	switch (state) {
-	case 0x00:
-	case 0x03:
+	if (state & 1) {
+		encoder->dir = ((encoder->last_stable - state + 1) % 4) - 1;
+	} else {
 		if (state != encoder->last_stable) {
 			rotary_encoder_report_event(encoder);
 			encoder->last_stable = state;
 		}
-		break;
-
-	case 0x01:
-	case 0x02:
-		encoder->dir = (encoder->last_stable + state) & 0x01;
-		break;
 	}
 
 	mutex_unlock(&encoder->access_mutex);
@@ -155,46 +156,18 @@ static irqreturn_t rotary_encoder_half_period_irq(int irq, void *dev_id)
 static irqreturn_t rotary_encoder_quarter_period_irq(int irq, void *dev_id)
 {
 	struct rotary_encoder *encoder = dev_id;
-	unsigned char sum;
-	int state;
+	unsigned int state;
 
 	mutex_lock(&encoder->access_mutex);
 
 	state = rotary_encoder_get_state(encoder);
 
-	/*
-	 * We encode the previous and the current state using a byte.
-	 * The previous state in the MSB nibble, the current state in the LSB
-	 * nibble. Then use a table to decide the direction of the turn.
-	 */
-	sum = (encoder->last_stable << 4) + state;
-	switch (sum) {
-	case 0x31:
-	case 0x10:
-	case 0x02:
-	case 0x23:
-		encoder->dir = 0; /* clockwise */
-		break;
-
-	case 0x13:
-	case 0x01:
-	case 0x20:
-	case 0x32:
-		encoder->dir = 1; /* counter-clockwise */
-		break;
-
-	default:
-		/*
-		 * Ignore all other values. This covers the case when the
-		 * state didn't change (a spurious interrupt) and the
-		 * cases where the state changed by two steps, making it
-		 * impossible to tell the direction.
-		 *
-		 * In either case, don't report any event and save the
-		 * state for later.
-		 */
+	if ((encoder->last_stable + 1) % 4 == state)
+		encoder->dir = 1;
+	else if (encoder->last_stable == (state + 1) % 4)
+		encoder->dir = -1;
+	else
 		goto out;
-	}
 
 	rotary_encoder_report_event(encoder);
 
@@ -213,6 +186,7 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 	irq_handler_t handler;
 	u32 steps_per_period;
 	int err;
+	unsigned i;
 
 	encoder = devm_kzalloc(dev, sizeof(struct rotary_encoder), GFP_KERNEL);
 	if (!encoder)
@@ -243,24 +217,16 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 	encoder->relative_axis =
 		device_property_read_bool(dev, "rotary-encoder,relative-axis");
 
-	encoder->gpio_a = devm_gpiod_get_index(dev, NULL, 0, GPIOD_IN);
-	if (IS_ERR(encoder->gpio_a)) {
-		err = PTR_ERR(encoder->gpio_a);
-		dev_err(dev, "unable to get GPIO at index 0: %d\n", err);
-		return err;
+	encoder->gpios = devm_gpiod_get_array(dev, NULL, GPIOD_IN);
+	if (IS_ERR(encoder->gpios)) {
+		dev_err(dev, "unable to get gpios\n");
+		return PTR_ERR(encoder->gpios);
 	}
-
-	encoder->irq_a = gpiod_to_irq(encoder->gpio_a);
-
-	encoder->gpio_b = devm_gpiod_get_index(dev, NULL, 1, GPIOD_IN);
-	if (IS_ERR(encoder->gpio_b)) {
-		err = PTR_ERR(encoder->gpio_b);
-		dev_err(dev, "unable to get GPIO at index 1: %d\n", err);
-		return err;
+	if (encoder->gpios->ndescs < 2) {
+		dev_err(dev, "not enough gpios found\n");
+		return -EINVAL;
 	}
 
-	encoder->irq_b = gpiod_to_irq(encoder->gpio_b);
-
 	input = devm_input_allocate_device(dev);
 	if (!input)
 		return -ENOMEM;
@@ -277,7 +243,7 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 		input_set_abs_params(input,
 				     encoder->axis, 0, encoder->steps, 0, 1);
 
-	switch (steps_per_period) {
+	switch (steps_per_period >> (encoder->gpios->ndescs - 2)) {
 	case 4:
 		handler = &rotary_encoder_quarter_period_irq;
 		encoder->last_stable = rotary_encoder_get_state(encoder);
@@ -295,22 +261,26 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	err = devm_request_threaded_irq(dev, encoder->irq_a, NULL, handler,
-				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
-				IRQF_ONESHOT,
-				DRV_NAME, encoder);
-	if (err) {
-		dev_err(dev, "unable to request IRQ %d\n", encoder->irq_a);
-		return err;
-	}
+	encoder->irq =
+		devm_kzalloc(dev,
+			     sizeof(*encoder->irq) * encoder->gpios->ndescs,
+			     GFP_KERNEL);
+	if (!encoder->irq)
+		return -ENOMEM;
 
-	err = devm_request_threaded_irq(dev, encoder->irq_b, NULL, handler,
+	for (i = 0; i < encoder->gpios->ndescs; ++i) {
+		encoder->irq[i] = gpiod_to_irq(encoder->gpios->desc[i]);
+
+		err = devm_request_threaded_irq(dev, encoder->irq[i],
+				NULL, handler,
 				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
 				IRQF_ONESHOT,
 				DRV_NAME, encoder);
-	if (err) {
-		dev_err(dev, "unable to request IRQ %d\n", encoder->irq_b);
-		return err;
+		if (err) {
+			dev_err(dev, "unable to request IRQ %d (gpio#%d)\n",
+				encoder->irq[i], i);
+			return err;
+		}
 	}
 
 	err = input_register_device(input);
@@ -332,8 +302,9 @@ static int __maybe_unused rotary_encoder_suspend(struct device *dev)
 	struct rotary_encoder *encoder = dev_get_drvdata(dev);
 
 	if (device_may_wakeup(dev)) {
-		enable_irq_wake(encoder->irq_a);
-		enable_irq_wake(encoder->irq_b);
+		unsigned int i;
+		for (i = 0; i < encoder->gpios->ndescs; ++i)
+			enable_irq_wake(encoder->irq[i]);
 	}
 
 	return 0;
@@ -344,8 +315,9 @@ static int __maybe_unused rotary_encoder_resume(struct device *dev)
 	struct rotary_encoder *encoder = dev_get_drvdata(dev);
 
 	if (device_may_wakeup(dev)) {
-		disable_irq_wake(encoder->irq_a);
-		disable_irq_wake(encoder->irq_b);
+		unsigned int i;
+		for (i = 0; i < encoder->gpios->ndescs; ++i)
+			disable_irq_wake(encoder->irq[i]);
 	}
 
 	return 0;
-- 
2.7.0
