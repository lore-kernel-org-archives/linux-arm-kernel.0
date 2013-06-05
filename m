From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 5 Jun 2013 15:44:31 +0200
Subject: [PATCH 1/3] drivers: pinctrl sleep and idle states in the core
Message-ID: <1370439873-30053-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

If a device have sleep and idle states in addition to the
default state, look up these in the core and stash them in
the pinctrl state container.

Add accessor functions for pinctrl consumers to put the pins
into "default", "sleep" and "idle" states passing nothing but
the struct device * affected.

Solution suggested by Kevin Hilman, Mark Brown and Dmitry
Torokhov in response to a patch series from Hebbar
Gururaja.

Cc: Hebbar Gururaja <gururaja.hebbar@ti.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I'm seeking Gregs ACK on this in the end, so we can take this
in through the pinctrl tree. But first let's review!
---
 drivers/base/pinctrl.c           | 19 +++++++++++++
 drivers/pinctrl/core.c           | 61 ++++++++++++++++++++++++++++++++++++++++
 include/linux/pinctrl/consumer.h | 34 ++++++++++++++++++++++
 include/linux/pinctrl/devinfo.h  |  4 +++
 4 files changed, 118 insertions(+)

diff --git a/drivers/base/pinctrl.c b/drivers/base/pinctrl.c
index 67a274e..5fb74b4 100644
--- a/drivers/base/pinctrl.c
+++ b/drivers/base/pinctrl.c
@@ -48,6 +48,25 @@ int pinctrl_bind_pins(struct device *dev)
 		goto cleanup_get;
 	}
 
+#ifdef CONFIG_PM
+	/*
+	 * If power management is enabled, we also look for the optional
+	 * sleep and idle pin states, with semantics as defined in
+	 * <linux/pinctrl/pinctrl-state.h>
+	 */
+	dev->pins->sleep_state = pinctrl_lookup_state(dev->pins->p,
+					PINCTRL_STATE_SLEEP);
+	if (IS_ERR(dev->pins->sleep_state))
+		/* Not supplying this state is perfectly legal */
+		dev_dbg(dev, "no sleep pinctrl state\n");
+
+	dev->pins->idle_state = pinctrl_lookup_state(dev->pins->p,
+					PINCTRL_STATE_IDLE);
+	if (IS_ERR(dev->pins->idle_state))
+		/* Not supplying this state is perfectly legal */
+		dev_dbg(dev, "no idle pinctrl state\n");
+#endif
+
 	return 0;
 
 	/*
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 1f9608b..90fa17a 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1196,6 +1196,67 @@ int pinctrl_force_default(struct pinctrl_dev *pctldev)
 }
 EXPORT_SYMBOL_GPL(pinctrl_force_default);
 
+#ifdef CONFIG_PM
+
+/**
+ * pinctrl_pm_select_default_state() - select default pinctrl state for PM
+ * @dev: device to select default state for
+ */
+int pinctrl_pm_select_default_state(struct device *dev)
+{
+	struct dev_pin_info *pins = dev->pins;
+	int ret;
+
+	if (!pins)
+		return 0;
+	if (IS_ERR(pins->default_state))
+		return 0; /* No default state */
+	ret = pinctrl_select_state(pins->p, pins->default_state);
+	if (ret)
+		dev_err(dev, "failed to activate default pinctrl state\n");
+	return ret;
+}
+
+/**
+ * pinctrl_pm_select_sleep_state() - select sleep pinctrl state for PM
+ * @dev: device to select sleep state for
+ */
+int pinctrl_pm_select_sleep_state(struct device *dev)
+{
+	struct dev_pin_info *pins = dev->pins;
+	int ret;
+
+	if (!pins)
+		return 0;
+	if (IS_ERR(pins->sleep_state))
+		return 0; /* No default state */
+	ret = pinctrl_select_state(pins->p, pins->sleep_state);
+	if (ret)
+		dev_err(dev, "failed to activate sleep pinctrl state\n");
+	return ret;
+}
+
+/**
+ * pinctrl_pm_select_idle_state() - select idle pinctrl state for PM
+ * @dev: device to select idle state for
+ */
+int pinctrl_pm_select_idle_state(struct device *dev)
+{
+	struct dev_pin_info *pins = dev->pins;
+	int ret;
+
+	if (!pins)
+		return 0;
+	if (IS_ERR(pins->idle_state))
+		return 0; /* No default state */
+	ret = pinctrl_select_state(pins->p, pins->idle_state);
+	if (ret)
+		dev_err(dev, "failed to activate idle pinctrl state\n");
+	return ret;
+}
+
+#endif
+
 #ifdef CONFIG_DEBUG_FS
 
 static int pinctrl_pins_show(struct seq_file *s, void *what)
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index 4aad3ce..0f32f10 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -40,6 +40,25 @@ extern int pinctrl_select_state(struct pinctrl *p, struct pinctrl_state *s);
 extern struct pinctrl * __must_check devm_pinctrl_get(struct device *dev);
 extern void devm_pinctrl_put(struct pinctrl *p);
 
+#ifdef CONFIG_PM
+extern int pinctrl_pm_select_default_state(struct device *dev);
+extern int pinctrl_pm_select_sleep_state(struct device *dev);
+extern int pinctrl_pm_select_idle_state(struct device *dev);
+#else
+static inline int pinctrl_pm_select_default_state(struct device *dev)
+{
+	return 0;
+}
+static inline int pinctrl_pm_select_sleep_state(struct device *dev)
+{
+	return 0;
+}
+static inline int pinctrl_pm_select_idle_state(struct device *dev)
+{
+	return 0;
+}
+#endif
+
 #else /* !CONFIG_PINCTRL */
 
 static inline int pinctrl_request_gpio(unsigned gpio)
@@ -199,6 +218,21 @@ static inline int pin_config_group_set(const char *dev_name,
 	return 0;
 }
 
+static inline int pinctrl_pm_select_default_state(struct device *dev)
+{
+	return 0;
+}
+
+static inline int pinctrl_pm_select_sleep_state(struct device *dev)
+{
+	return 0;
+}
+
+static inline int pinctrl_pm_select_idle_state(struct device *dev)
+{
+	return 0;
+}
+
 #endif
 
 #endif /* __LINUX_PINCTRL_CONSUMER_H */
diff --git a/include/linux/pinctrl/devinfo.h b/include/linux/pinctrl/devinfo.h
index 6e5f8a9..281cb91 100644
--- a/include/linux/pinctrl/devinfo.h
+++ b/include/linux/pinctrl/devinfo.h
@@ -28,6 +28,10 @@
 struct dev_pin_info {
 	struct pinctrl *p;
 	struct pinctrl_state *default_state;
+#ifdef CONFIG_PM
+	struct pinctrl_state *sleep_state;
+	struct pinctrl_state *idle_state;
+#endif
 };
 
 extern int pinctrl_bind_pins(struct device *dev);
-- 
1.7.11.3
