From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sun, 17 Feb 2013 19:42:50 +0800
Subject: [PATCH v9 04/10] pinctrl: check pinctrl ready for gpio range
In-Reply-To: <1361101376-3783-1-git-send-email-haojian.zhuang@linaro.org>
References: <1361101376-3783-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1361101376-3783-5-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pinctrl_get_device_gpio_range() only checks whether a certain GPIO pin
is in gpio range. But maybe some GPIO pins don't have back-end pinctrl
interface, it means that these pins are always configured as GPIO
function. For example, gpio159 isn't related to back-end pinctrl device
in Hi3620 while other GPIO pins are related to back-end pinctrl device.

Append pinctrl_ready_for_gpio_range() that is used to check whether
pinctrl device with GPIO range is ready. This function will be called
after pinctrl_get_device_gpio_range() fails.

If pinctrl device with GPIO range is found, it means that pinctrl device
is already launched and a certain GPIO pin just don't have back-end pinctrl
interface. Then pinctrl_request_gpio() shouldn't return -EPROBE_DEFER in
this case.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/pinctrl/core.c |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index b0a8e9a..e333dde 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -27,6 +27,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/machine.h>
+#include <asm-generic/gpio.h>
 #include "core.h"
 #include "devicetree.h"
 #include "pinmux.h"
@@ -293,6 +294,39 @@ pinctrl_match_gpio_range(struct pinctrl_dev *pctldev, unsigned gpio)
 }
 
 /**
+ * pinctrl_ready_for_gpio_range() - check if other GPIO pins of
+ * the same GPIO chip are in range
+ * @gpio: gpio pin to check taken from the global GPIO pin space
+ *
+ * This function is complement of pinctrl_match_gpio_range(). If the return
+ * value of pinctrl_match_gpio_range() is NULL, this function could be used
+ * to check whether pinctrl device is ready or not. Maybe some GPIO pins
+ * of the same GPIO chip don't have back-end pinctrl interface.
+ * If the return value is true, it means that pinctrl device is ready & the
+ * certain GPIO pin doesn't have back-end pinctrl device. If the return value
+ * is false, it means that pinctrl device may not be ready.
+ */
+static bool pinctrl_ready_for_gpio_range(unsigned gpio)
+{
+	struct pinctrl_dev *pctldev;
+	struct pinctrl_gpio_range *range = NULL;
+	struct gpio_chip *chip = gpio_to_chip(gpio);
+
+	/* Loop over the pin controllers */
+	list_for_each_entry(pctldev, &pinctrldev_list, node) {
+		/* Loop over the ranges */
+		list_for_each_entry(range, &pctldev->gpio_ranges, node) {
+			/* Check if any gpio range overlapped with gpio chip */
+			if (range->base + range->npins - 1 < chip->base ||
+			    range->base > chip->base + chip->ngpio - 1)
+				continue;
+			return true;
+		}
+	}
+	return false;
+}
+
+/**
  * pinctrl_get_device_gpio_range() - find device for GPIO range
  * @gpio: the pin to locate the pin controller for
  * @outdev: the pin control device if found
@@ -459,6 +493,8 @@ int pinctrl_request_gpio(unsigned gpio)
 
 	ret = pinctrl_get_device_gpio_range(gpio, &pctldev, &range);
 	if (ret) {
+		if (pinctrl_ready_for_gpio_range(gpio))
+			ret = 0;
 		mutex_unlock(&pinctrl_mutex);
 		return ret;
 	}
-- 
1.7.10.4
