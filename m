From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  9 Feb 2012 20:01:13 +0100
Subject: [PATCH 1/3] pinctrl: break out a pinctrl consumer header
Message-ID: <1328814073-22753-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This breaks out a <linux/pinctrl/consumer.h> header to be used by
all pinmux and pinconfig alike, so drivers needing services from
pinctrl does not need to include different headers. This is similar
to the approach taken by the regulator API.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/pinctrl.txt        |    6 ++-
 arch/arm/mach-u300/core.c        |    2 +-
 drivers/pinctrl/pinctrl-coh901.c |    2 +-
 include/linux/pinctrl/consumer.h |  118 ++++++++++++++++++++++++++++++++++++++
 include/linux/pinctrl/pinconf.h  |   39 -------------
 include/linux/pinctrl/pinmux.h   |   52 -----------------
 6 files changed, 125 insertions(+), 94 deletions(-)
 create mode 100644 include/linux/pinctrl/consumer.h

diff --git a/Documentation/pinctrl.txt b/Documentation/pinctrl.txt
index 14aecd2..b268832 100644
--- a/Documentation/pinctrl.txt
+++ b/Documentation/pinctrl.txt
@@ -208,6 +208,8 @@ unconnected.
 
 For example, a platform may do this:
 
+#include <linux/pinctrl/consumer.h>
+
 ret = pin_config_set("foo-dev", "FOO_GPIO_PIN", PLATFORM_X_PULL_UP);
 
 To pull up a pin to VDD. The pin configuration driver implements callbacks for
@@ -920,7 +922,7 @@ this is not possible.
 A driver may request a certain mux to be activated, usually just the default
 mux like this:
 
-#include <linux/pinctrl/pinmux.h>
+#include <linux/pinctrl/consumer.h>
 
 struct foo_state {
        struct pinmux *pmx;
@@ -1019,6 +1021,8 @@ function, but with different named in the mapping as described under
 This snippet first muxes the function in the pins defined by group A, enables
 it, disables and releases it, and muxes it in on the pins defined by group B:
 
+#include <linux/pinctrl/consumer.h>
+
 foo_switch()
 {
 	struct pinmux *pmx;
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index b4c6926..1429e52 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -26,7 +26,7 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/fsmc.h>
 #include <linux/pinctrl/machine.h>
-#include <linux/pinctrl/pinmux.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/dma-mapping.h>
 
 #include <asm/types.h>
diff --git a/drivers/pinctrl/pinctrl-coh901.c b/drivers/pinctrl/pinctrl-coh901.c
index 69fb707..8bac3f0 100644
--- a/drivers/pinctrl/pinctrl-coh901.c
+++ b/drivers/pinctrl/pinctrl-coh901.c
@@ -22,7 +22,7 @@
 #include <linux/gpio.h>
 #include <linux/list.h>
 #include <linux/slab.h>
-#include <linux/pinctrl/pinmux.h>
+#include <linux/pinctrl/consumer.h>
 #include <mach/gpio-u300.h>
 
 /*
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
new file mode 100644
index 0000000..9c8513d
--- /dev/null
+++ b/include/linux/pinctrl/consumer.h
@@ -0,0 +1,118 @@
+/*
+ * Consumer interface the pin control subsystem
+ *
+ * Copyright (C) 2012 ST-Ericsson SA
+ * Written on behalf of Linaro for ST-Ericsson
+ * Based on bits of regulator core, gpio core and clk core
+ *
+ * Author: Linus Walleij <linus.walleij@linaro.org>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+#ifndef __LINUX_PINCTRL_CONSUMER_H
+#define __LINUX_PINCTRL_CONSUMER_H
+
+#include <linux/list.h>
+#include <linux/seq_file.h>
+#include "pinctrl.h"
+
+/* This struct is private to the core and should be regarded as a cookie */
+struct pinmux;
+
+#ifdef CONFIG_PINMUX
+
+/* External interface to pinmux */
+extern int pinmux_request_gpio(unsigned gpio);
+extern void pinmux_free_gpio(unsigned gpio);
+extern int pinmux_gpio_direction_input(unsigned gpio);
+extern int pinmux_gpio_direction_output(unsigned gpio);
+extern struct pinmux * __must_check pinmux_get(struct device *dev, const char *name);
+extern void pinmux_put(struct pinmux *pmx);
+extern int pinmux_enable(struct pinmux *pmx);
+extern void pinmux_disable(struct pinmux *pmx);
+
+#else /* !CONFIG_PINMUX */
+
+static inline int pinmux_request_gpio(unsigned gpio)
+{
+	return 0;
+}
+
+static inline void pinmux_free_gpio(unsigned gpio)
+{
+}
+
+static inline int pinmux_gpio_direction_input(unsigned gpio)
+{
+	return 0;
+}
+
+static inline int pinmux_gpio_direction_output(unsigned gpio)
+{
+	return 0;
+}
+
+static inline struct pinmux * __must_check pinmux_get(struct device *dev, const char *name)
+{
+	return NULL;
+}
+
+static inline void pinmux_put(struct pinmux *pmx)
+{
+}
+
+static inline int pinmux_enable(struct pinmux *pmx)
+{
+	return 0;
+}
+
+static inline void pinmux_disable(struct pinmux *pmx)
+{
+}
+
+#endif /* CONFIG_PINMUX */
+
+#ifdef CONFIG_PINCONF
+
+extern int pin_config_get(const char *dev_name, const char *name,
+			  unsigned long *config);
+extern int pin_config_set(const char *dev_name, const char *name,
+			  unsigned long config);
+extern int pin_config_group_get(const char *dev_name,
+				const char *pin_group,
+				unsigned long *config);
+extern int pin_config_group_set(const char *dev_name,
+				const char *pin_group,
+				unsigned long config);
+
+#else
+
+static inline int pin_config_get(const char *dev_name, const char *name,
+				 unsigned long *config)
+{
+	return 0;
+}
+
+static inline int pin_config_set(const char *dev_name, const char *name,
+				 unsigned long config)
+{
+	return 0;
+}
+
+static inline int pin_config_group_get(const char *dev_name,
+				       const char *pin_group,
+				       unsigned long *config)
+{
+	return 0;
+}
+
+static inline int pin_config_group_set(const char *dev_name,
+				       const char *pin_group,
+				       unsigned long config)
+{
+	return 0;
+}
+
+#endif
+
+#endif /* __LINUX_PINCTRL_CONSUMER_H */
diff --git a/include/linux/pinctrl/pinconf.h b/include/linux/pinctrl/pinconf.h
index 477922c..f8cf156 100644
--- a/include/linux/pinctrl/pinconf.h
+++ b/include/linux/pinctrl/pinconf.h
@@ -53,45 +53,6 @@ struct pinconf_ops {
 					   unsigned selector);
 };
 
-extern int pin_config_get(const char *dev_name, const char *name,
-			  unsigned long *config);
-extern int pin_config_set(const char *dev_name, const char *name,
-			  unsigned long config);
-extern int pin_config_group_get(const char *dev_name,
-				const char *pin_group,
-				unsigned long *config);
-extern int pin_config_group_set(const char *dev_name,
-				const char *pin_group,
-				unsigned long config);
-
-#else
-
-static inline int pin_config_get(const char *dev_name, const char *name,
-				 unsigned long *config)
-{
-	return 0;
-}
-
-static inline int pin_config_set(const char *dev_name, const char *name,
-				 unsigned long config)
-{
-	return 0;
-}
-
-static inline int pin_config_group_get(const char *dev_name,
-				       const char *pin_group,
-				       unsigned long *config)
-{
-	return 0;
-}
-
-static inline int pin_config_group_set(const char *dev_name,
-				       const char *pin_group,
-				       unsigned long config)
-{
-	return 0;
-}
-
 #endif
 
 #endif /* __LINUX_PINCTRL_PINCONF_H */
diff --git a/include/linux/pinctrl/pinmux.h b/include/linux/pinctrl/pinmux.h
index 937b3e2..47e9237 100644
--- a/include/linux/pinctrl/pinmux.h
+++ b/include/linux/pinctrl/pinmux.h
@@ -16,9 +16,6 @@
 #include <linux/seq_file.h>
 #include "pinctrl.h"
 
-/* This struct is private to the core and should be regarded as a cookie */
-struct pinmux;
-
 #ifdef CONFIG_PINMUX
 
 struct pinctrl_dev;
@@ -88,55 +85,6 @@ struct pinmux_ops {
 				   bool input);
 };
 
-/* External interface to pinmux */
-extern int pinmux_request_gpio(unsigned gpio);
-extern void pinmux_free_gpio(unsigned gpio);
-extern int pinmux_gpio_direction_input(unsigned gpio);
-extern int pinmux_gpio_direction_output(unsigned gpio);
-extern struct pinmux * __must_check pinmux_get(struct device *dev, const char *name);
-extern void pinmux_put(struct pinmux *pmx);
-extern int pinmux_enable(struct pinmux *pmx);
-extern void pinmux_disable(struct pinmux *pmx);
-
-#else /* !CONFIG_PINMUX */
-
-static inline int pinmux_request_gpio(unsigned gpio)
-{
-	return 0;
-}
-
-static inline void pinmux_free_gpio(unsigned gpio)
-{
-}
-
-static inline int pinmux_gpio_direction_input(unsigned gpio)
-{
-	return 0;
-}
-
-static inline int pinmux_gpio_direction_output(unsigned gpio)
-{
-	return 0;
-}
-
-static inline struct pinmux * __must_check pinmux_get(struct device *dev, const char *name)
-{
-	return NULL;
-}
-
-static inline void pinmux_put(struct pinmux *pmx)
-{
-}
-
-static inline int pinmux_enable(struct pinmux *pmx)
-{
-	return 0;
-}
-
-static inline void pinmux_disable(struct pinmux *pmx)
-{
-}
-
 #endif /* CONFIG_PINMUX */
 
 #endif /* __LINUX_PINCTRL_PINMUX_H */
-- 
1.7.7.6
