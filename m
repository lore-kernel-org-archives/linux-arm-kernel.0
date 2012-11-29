From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Thu, 29 Nov 2012 10:35:35 +0530
Subject: [PATCH 2/2] i2c-s3c2410: Add bus arbitration implementation
In-Reply-To: <1354165536-18529-1-git-send-email-ch.naveen@samsung.com>
References: <1354165536-18529-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1354165536-18529-3-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Glass <sjg@chromium.org>

The arbitrator is a general purpose function which uses two GPIOs to
communicate with another device to claim/release a bus. We use it to
arbitrate an i2c port between the AP and the EC.

Signed-off-by: Simon Glass <sjg@chromium.org>
Cc: Grant Grundler <grundler@chromium.org>
Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---
 .../devicetree/bindings/i2c/samsung-i2c.txt        |   46 ++++++
 drivers/i2c/busses/i2c-s3c2410.c                   |  167 ++++++++++++++++++--
 2 files changed, 200 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/samsung-i2c.txt b/Documentation/devicetree/bindings/i2c/samsung-i2c.txt
index e9611ac..4bed49f 100644
--- a/Documentation/devicetree/bindings/i2c/samsung-i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/samsung-i2c.txt
@@ -28,6 +28,11 @@ Optional properties:
     specified, default value is 0.
   - samsung,i2c-max-bus-freq: Desired frequency in Hz of the bus. If not
     specified, the default value in Hz is 100000.
+  - samsung,arbitration-gpios : Two GPIOs to use with the GPIO-based bus
+    arbitration protocol (see below). The first should be an output, and is
+    used to claim the I2C bus, the second should be an input, and signals that
+    the other side wants to claim the bus. This allows two masters to share
+    the same I2C bus.
 
 Example:
 
@@ -52,4 +57,45 @@ Example:
 			compatible = "wlf,wm8994";
 			reg = <0x1a>;
 		};
+
+		/* If you want GPIO-based bus arbitration */
+		samsung,arbitration-gpios = <&gpf0 3 1 0 0>,	/* AP_CLAIM */
+			<&gpe0 4 0 3 0>;			/* EC_CLAIM */
 	};
+
+
+GPIO-based Arbitration
+======================
+(documented here for want of a better place - an implementation is in the
+i2c-s3c2410 driver)
+
+This uses GPIO lines between the AP (Exynos) and an attached EC (embedded
+controller) which both want to talk on the same I2C bus as master.
+
+The AP and EC each have a 'bus claim' line, which is an output that the
+other can see. These are both active low, with pull-ups enabled.
+
+- AP_CLAIM: output from AP, signalling to the EC that the AP wants the bus
+- EC_CLAIM: output from EC, signalling to the AP that the EC wants the bus
+
+
+Algorithm
+---------
+The basic algorithm is to assert your line when you want the bus, then make
+sure that the other side doesn't want it also. A detailed explanation is best
+done with an example.
+
+Let's say the AP wants to claim the bus. It:
+1. Asserts AP_CLAIM
+2. Waits a little bit for the other side to notice (slew time, say 10
+microseconds)
+3. Checks EC_CLAIM. If this is not asserted, then the AP has the bus, and
+we are done
+4. Otherwise, wait for a few milliseconds and see if EC_CLAIM is released
+5. If not, back off, release the claim and wait for a few more milliseconds
+6. Go back to 1 (until retry time has expired)
+
+To release the bus, just de-assert the claim line. If the other wants the bus
+it will notice soon enough.
+
+The same algorithm applies on the EC side.
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 2fd346d..87a6928 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -62,6 +62,13 @@ enum s3c24xx_i2c_state {
 	STATE_STOP
 };
 
+enum {
+	I2C_ARB_GPIO_AP,		/* AP claims i2c bus */
+	I2C_ARB_GPIO_EC,		/* EC claims i2c bus */
+
+	I2C_ARB_GPIO_COUNT,
+};
+
 struct s3c24xx_i2c {
 	wait_queue_head_t	wait;
 	unsigned int            quirks;
@@ -85,10 +92,16 @@ struct s3c24xx_i2c {
 
 	struct s3c2410_platform_i2c	*pdata;
 	int			gpios[2];
+	int			arb_gpios[I2C_ARB_GPIO_COUNT];
 	struct pinctrl          *pctrl;
 #ifdef CONFIG_CPU_FREQ
 	struct notifier_block	freq_transition;
 #endif
+	/* Arbitration parameters */
+	bool			arbitrate;
+	unsigned int		slew_delay_us;
+	unsigned int		wait_retry_us;
+	unsigned int		wait_free_us;
 };
 
 static struct platform_device_id s3c24xx_driver_ids[] = {
@@ -116,6 +129,61 @@ static const struct of_device_id s3c24xx_i2c_match[] = {
 MODULE_DEVICE_TABLE(of, s3c24xx_i2c_match);
 #endif
 
+/*
+ * If we have enabled arbitration on this bus, claim the i2c bus, using
+ * the GPIO-based signalling protocol.
+ */
+int s3c24xx_i2c_claim(struct s3c24xx_i2c *i2c)
+{
+	unsigned long stop_retry, stop_time;
+
+	if (!i2c->arbitrate)
+		return 0;
+
+	/* Start a round of trying to claim the bus */
+	stop_time = jiffies + usecs_to_jiffies(i2c->wait_free_us) + 1;
+	do {
+		/* Indicate that we want to claim the bus */
+		gpio_set_value(i2c->arb_gpios[I2C_ARB_GPIO_AP], 0);
+		udelay(i2c->slew_delay_us);
+
+		/* Wait for the EC to release it */
+		stop_retry = jiffies + usecs_to_jiffies(i2c->wait_retry_us) + 1;
+		while (time_before(jiffies, stop_retry)) {
+			if (gpio_get_value(i2c->arb_gpios[I2C_ARB_GPIO_EC])) {
+				/* We got it, so return */
+				return 0;
+			}
+
+			usleep_range(50, 200);
+		}
+
+		/* It didn't release, so give up, wait, and try again */
+		gpio_set_value(i2c->arb_gpios[I2C_ARB_GPIO_AP], 1);
+
+		usleep_range(i2c->wait_retry_us, i2c->wait_retry_us * 2);
+	} while (time_before(jiffies, stop_time));
+
+	/* Give up, release our claim */
+	gpio_set_value(i2c->arb_gpios[I2C_ARB_GPIO_AP], 1);
+	udelay(i2c->slew_delay_us);
+	dev_err(i2c->dev, "I2C: Could not claim bus, timeout\n");
+	return -EBUSY;
+}
+
+/*
+ * If we have enabled arbitration on this bus, release the i2c bus, using
+ * the GPIO-based signalling protocol.
+ */
+void s3c24xx_i2c_release(struct s3c24xx_i2c *i2c)
+{
+	if (i2c->arbitrate) {
+		/* Release the bus and wait for the EC to notice */
+		gpio_set_value(i2c->arb_gpios[I2C_ARB_GPIO_AP], 1);
+		udelay(i2c->slew_delay_us);
+	}
+}
+
 /* s3c24xx_get_device_quirks
  *
  * Get controller type either from device tree or platform device variant.
@@ -637,6 +705,15 @@ static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c,
 	if (i2c->suspended)
 		return -EIO;
 
+	/*
+	 * Claim the bus if needed.
+	 *
+	 * Note, this needs a lock. How come s3c24xx_i2c_set_master() below
+	 * is outside the lock?
+	 */
+	if (s3c24xx_i2c_claim(i2c))
+		return -EBUSY;
+
 	ret = s3c24xx_i2c_set_master(i2c);
 	if (ret != 0) {
 		dev_err(i2c->dev, "cannot get bus (error %d)\n", ret);
@@ -676,6 +753,9 @@ static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c,
  out:
 	i2c->state = STATE_IDLE;
 
+	/* Release the bus if needed */
+	s3c24xx_i2c_release(i2c);
+
 	return ret;
 }
 
@@ -884,20 +964,42 @@ static inline void s3c24xx_i2c_deregister_cpufreq(struct s3c24xx_i2c *i2c)
 #endif
 
 #ifdef CONFIG_OF
-static int s3c24xx_i2c_parse_dt_gpio(struct s3c24xx_i2c *i2c)
+/*
+ * Parse a list of GPIOs from a node property and request each one
+ *
+ * This might be better as of_gpio_get_array() one day.
+ *
+ * @param i2c		i2c driver data
+ * @param name		name of property to read from
+ * @param gpios		returns an array of GPIOs
+ * @param count		number of GPIOs to read
+ * @param required	true if the property is required, false if it is
+ *			optional so no warning is printed (avoids a separate
+ *			check in caller)
+ * @return 0 on success, -ve on error, in which case no GPIOs remain
+ * requested
+ */
+static int s3c24xx_i2c_parse_gpio(struct s3c24xx_i2c *i2c, const char *name,
+		int gpios[], size_t count, bool required)
 {
-	int idx, gpio, ret;
-
-	if (i2c->quirks & QUIRK_NO_GPIO)
-		return 0;
+	struct device_node *dn = i2c->dev->of_node;
+	unsigned int idx;
+	int gpio, ret;
 
-	for (idx = 0; idx < 2; idx++) {
-		gpio = of_get_gpio(i2c->dev->of_node, idx);
+	/*
+	 * It would be nice if there were an of function to return a list
+	 * of GPIOs
+	 */
+	for (idx = 0; idx < count; idx++) {
+		gpio = of_get_named_gpio(dn, name, idx);
 		if (!gpio_is_valid(gpio)) {
-			dev_err(i2c->dev, "invalid gpio[%d]: %d\n", idx, gpio);
+			if (idx || required) {
+				dev_err(i2c->dev, "invalid gpio[%d]: %d\n",
+					idx, gpio);
+			}
 			goto free_gpio;
 		}
-		i2c->gpios[idx] = gpio;
+		gpios[idx] = gpio;
 
 		ret = gpio_request(gpio, "i2c-bus");
 		if (ret) {
@@ -909,19 +1011,47 @@ static int s3c24xx_i2c_parse_dt_gpio(struct s3c24xx_i2c *i2c)
 
 free_gpio:
 	while (--idx >= 0)
-		gpio_free(i2c->gpios[idx]);
+		gpio_free(gpios[idx]);
 	return -EINVAL;
 }
 
-static void s3c24xx_i2c_dt_gpio_free(struct s3c24xx_i2c *i2c)
+/* Free a list of GPIOs */
+static void s3c24xx_i2c_free_gpios(int gpios[], int count)
 {
 	unsigned int idx;
 
+	for (idx = 0; idx < count; idx++) {
+		if (gpio_is_valid(gpios[idx]))
+			gpio_free(gpios[idx]);
+	}
+}
+
+static int s3c24xx_i2c_parse_dt_gpio(struct s3c24xx_i2c *i2c)
+{
+	if (i2c->quirks & QUIRK_NO_GPIO)
+		return 0;
+
+	if (s3c24xx_i2c_parse_gpio(i2c, "gpios", i2c->gpios, 2, true))
+		return -EINVAL;
+
+	if (!s3c24xx_i2c_parse_gpio(i2c, "samsung,arbitration-gpios",
+			i2c->arb_gpios, I2C_ARB_GPIO_COUNT, false)) {
+		i2c->arbitrate = 1;
+		dev_warn(i2c->dev, "GPIO-based arbitration enabled");
+	}
+
+	return 0;
+
+}
+
+static void s3c24xx_i2c_dt_gpio_free(struct s3c24xx_i2c *i2c)
+{
 	if (i2c->quirks & QUIRK_NO_GPIO)
 		return;
 
-	for (idx = 0; idx < 2; idx++)
-		gpio_free(i2c->gpios[idx]);
+	s3c24xx_i2c_free_gpios(i2c->gpios, 2);
+	if (i2c->arbitrate)
+		s3c24xx_i2c_free_gpios(i2c->arb_gpios, I2C_ARB_GPIO_COUNT);
 }
 #else
 static int s3c24xx_i2c_parse_dt_gpio(struct s3c24xx_i2c *i2c)
@@ -992,6 +1122,17 @@ s3c24xx_i2c_parse_dt(struct device_node *np, struct s3c24xx_i2c *i2c)
 	of_property_read_u32(np, "samsung,i2c-slave-addr", &pdata->slave_addr);
 	of_property_read_u32(np, "samsung,i2c-max-bus-freq",
 				(u32 *)&pdata->frequency);
+
+	/* Arbitration parameters */
+	if (of_property_read_u32(np, "samsung,slew-delay-us",
+				 &i2c->slew_delay_us))
+		i2c->slew_delay_us = 10;
+	if (of_property_read_u32(np, "samsung,wait-retry-us",
+				 &i2c->wait_retry_us))
+		i2c->wait_retry_us = 2000;
+	if (of_property_read_u32(np, "samsung,wait-free-us",
+				 &i2c->wait_free_us))
+		i2c->wait_free_us = 50000;
 }
 #else
 static void
-- 
1.7.9.5
