From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Sep 2017 11:39:01 +0200
Subject: [PATCH 2/7] gpio: Make it possible for consumers to enforce open drain
In-Reply-To: <20170917093906.16325-1-linus.walleij@linaro.org>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
Message-ID: <20170917093906.16325-3-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some busses, like I2C, strictly need to have the line handled
as open drain, i.e. not actively driven high. For this reason
the i2c-gpio.c bit-banged I2C driver is reimplementing open
drain handling outside of gpiolib.

This is not very optimal. Instead make it possible for a
consumer to explcitly express that the line must be handled
as open drain instead of allowing local hacks papering over
this issue.

The descriptor tables, whether DT, ACPI or board files, should
of course have flagged these lines as open drain. E.g.:
enum gpio_lookup_flags GPIO_OPEN_DRAIN for a board file, or
gpios = <&foo 42 GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN>; in a
device tree using <dt-bindings/gpio/gpio.h>

But more often than not, these descriptors are wrong. So
we need to make it possible for consumers to enforce this
open drain behaviour.

We now have two new enumerated GPIO descriptor config flags:
GPIOD_OUT_LOW_OPEN_DRAIN and GPIOD_OUT_HIGH_OPEN_DRAIN
that will set up the lined enforced as open drain as output
low or high, using open drain (if the driver supports it)
or using open drain emulation (setting the line as input
to drive it high) from the gpiolib core.

Cc: linux-gpio at vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Obviously I authorize this patch to be applied directly
to the I2C tree as part of the refactorings.
---
 drivers/gpio/gpiolib.c        | 13 +++++++++++++
 include/linux/gpio/consumer.h |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index cd003b74512f..cb73a50a5d5d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3228,8 +3228,21 @@ int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
 
 	if (lflags & GPIO_ACTIVE_LOW)
 		set_bit(FLAG_ACTIVE_LOW, &desc->flags);
+
 	if (lflags & GPIO_OPEN_DRAIN)
 		set_bit(FLAG_OPEN_DRAIN, &desc->flags);
+	else if (dflags & GPIOD_FLAGS_BIT_OPEN_DRAIN) {
+		/*
+		 * This enforces open drain mode from the consumer side.
+		 * This is necessary for some busses like I2C, but the lookup
+		 * should *REALLY* have specified them as open drain in the
+		 * first place, so print a little warning here.
+		 */
+		set_bit(FLAG_OPEN_DRAIN, &desc->flags);
+		gpiod_warn(desc,
+			   "enforced open drain please flag it properly in DT/ACPI DSDT/board file\n");
+	}
+
 	if (lflags & GPIO_OPEN_SOURCE)
 		set_bit(FLAG_OPEN_SOURCE, &desc->flags);
 	if (lflags & GPIO_SLEEP_MAY_LOOSE_VALUE)
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 8f702fcbe485..5f72a49d1aa3 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -28,6 +28,7 @@ struct gpio_descs {
 #define GPIOD_FLAGS_BIT_DIR_SET		BIT(0)
 #define GPIOD_FLAGS_BIT_DIR_OUT		BIT(1)
 #define GPIOD_FLAGS_BIT_DIR_VAL		BIT(2)
+#define GPIOD_FLAGS_BIT_OPEN_DRAIN	BIT(3)
 
 /**
  * Optional flags that can be passed to one of gpiod_* to configure direction
@@ -39,6 +40,11 @@ enum gpiod_flags {
 	GPIOD_OUT_LOW	= GPIOD_FLAGS_BIT_DIR_SET | GPIOD_FLAGS_BIT_DIR_OUT,
 	GPIOD_OUT_HIGH	= GPIOD_FLAGS_BIT_DIR_SET | GPIOD_FLAGS_BIT_DIR_OUT |
 			  GPIOD_FLAGS_BIT_DIR_VAL,
+	GPIOD_OUT_LOW_OPEN_DRAIN = GPIOD_FLAGS_BIT_DIR_SET |
+			  GPIOD_FLAGS_BIT_DIR_OUT | GPIOD_FLAGS_BIT_OPEN_DRAIN,
+	GPIOD_OUT_HIGH_OPEN_DRAIN = GPIOD_FLAGS_BIT_DIR_SET |
+			  GPIOD_FLAGS_BIT_DIR_OUT | GPIOD_FLAGS_BIT_DIR_VAL |
+			  GPIOD_FLAGS_BIT_OPEN_DRAIN,
 };
 
 #ifdef CONFIG_GPIOLIB
-- 
2.13.5
