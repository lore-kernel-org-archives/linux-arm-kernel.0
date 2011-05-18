From: davidb@codeaurora.org (David Brown)
Date: Wed, 18 May 2011 14:50:51 -0700
Subject: [PATCH 5/7] msm: gpiomux: Move public API to public header
In-Reply-To: <1305755453-31112-1-git-send-email-davidb@codeaurora.org>
References: <1305755453-31112-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1305755453-31112-6-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpiomux.h header contains some SOC ifdefs.  However, the API that
is actually used by the GPIO driver only uses two functions that are
general.  Move these general definitions into a public header file.

Signed-off-by: David Brown <davidb@codeaurora.org>
---
 arch/arm/mach-msm/gpio.c    |    2 +-
 arch/arm/mach-msm/gpiomux.h |   17 +----------------
 include/linux/msm_gpiomux.h |   38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 17 deletions(-)
 create mode 100644 include/linux/msm_gpiomux.h

diff --git a/arch/arm/mach-msm/gpio.c b/arch/arm/mach-msm/gpio.c
index e96199d..2ac3a0f 100644
--- a/arch/arm/mach-msm/gpio.c
+++ b/arch/arm/mach-msm/gpio.c
@@ -21,8 +21,8 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <mach/cpu.h>
+#include <linux/msm_gpiomux.h>
 #include "gpio_hw.h"
-#include "gpiomux.h"
 
 #define FIRST_GPIO_IRQ MSM_GPIO_TO_INT(0)
 
diff --git a/arch/arm/mach-msm/gpiomux.h b/arch/arm/mach-msm/gpiomux.h
index b178d9c..a5290ed 100644
--- a/arch/arm/mach-msm/gpiomux.h
+++ b/arch/arm/mach-msm/gpiomux.h
@@ -19,6 +19,7 @@
 
 #include <linux/bitops.h>
 #include <linux/errno.h>
+#include <linux/msm_gpiomux.h>
 
 #if defined(CONFIG_MSM_V2_TLMM)
 #include "gpiomux-v2.h"
@@ -71,12 +72,6 @@ enum {
  */
 extern struct msm_gpiomux_config msm_gpiomux_configs[GPIOMUX_NGPIOS];
 
-/* Increment a gpio's reference count, possibly activating the line. */
-int __must_check msm_gpiomux_get(unsigned gpio);
-
-/* Decrement a gpio's reference count, possibly suspending the line. */
-int msm_gpiomux_put(unsigned gpio);
-
 /* Install a new configuration to the gpio line.  To avoid overwriting
  * a configuration, leave the VALID bit out.
  */
@@ -94,16 +89,6 @@ int msm_gpiomux_write(unsigned gpio,
  */
 void __msm_gpiomux_write(unsigned gpio, gpiomux_config_t val);
 #else
-static inline int __must_check msm_gpiomux_get(unsigned gpio)
-{
-	return -ENOSYS;
-}
-
-static inline int msm_gpiomux_put(unsigned gpio)
-{
-	return -ENOSYS;
-}
-
 static inline int msm_gpiomux_write(unsigned gpio,
 				    gpiomux_config_t active,
 				    gpiomux_config_t suspended)
diff --git a/include/linux/msm_gpiomux.h b/include/linux/msm_gpiomux.h
new file mode 100644
index 0000000..0c7d393
--- /dev/null
+++ b/include/linux/msm_gpiomux.h
@@ -0,0 +1,38 @@
+/* Copyright (c) 2011, Code Aurora Forum. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _LINUX_MSM_GPIOMUX_H
+#define _LINUX_MSM_GPIOMUX_H
+
+#ifdef CONFIG_MSM_GPIOMUX
+
+/* Increment a gpio's reference count, possibly activating the line. */
+int __must_check msm_gpiomux_get(unsigned gpio);
+
+/* Decrement a gpio's reference count, possibly suspending the line. */
+int msm_gpiomux_put(unsigned gpio);
+
+#else
+
+static inline int __must_check msm_gpiomux_get(unsigned gpio)
+{
+	return -ENOSYS;
+}
+
+static inline int msm_gpiomux_put(unsigned gpio)
+{
+	return -ENOSYS;
+}
+
+#endif
+
+#endif /* _LINUX_MSM_GPIOMUX_H */
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
