From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 22 Oct 2015 11:41:58 +0200
Subject: [PATCH v2 2/6] vfio: platform: reset: add
 vfio_platform_reset_private.h
In-Reply-To: <1445506922-6005-1-git-send-email-eric.auger@linaro.org>
References: <1445506922-6005-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1445506922-6005-3-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This header is to be included in all vfio reset modules. It
defines the module_vfio_reset_handler macro whose role is
- to define a module alias
- implement module init/exit function which respectively registers
  and unregisters the reset function.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v2: creation
- this defines the module_vfio_reset_handler macro as suggested by Arnd

Although Arnd suggested me to remove the vfio_platform_register_reset
symbol_get (since the module manager can handle the case where the
vfio-platform driver is not loaded), I prefered to keep it while
introducing the macro. The rationale is, when using symbol_get/put
we are able to release the hold from the reset module on vfio-platform
as soon as the registration is complete and I think this makes sense.
---
 drivers/vfio/platform/reset/Makefile               |  2 +-
 .../platform/reset/vfio_platform_reset_private.h   | 66 ++++++++++++++++++++++
 2 files changed, 67 insertions(+), 1 deletion(-)
 create mode 100644 drivers/vfio/platform/reset/vfio_platform_reset_private.h

diff --git a/drivers/vfio/platform/reset/Makefile b/drivers/vfio/platform/reset/Makefile
index 2a486af..154a7d5 100644
--- a/drivers/vfio/platform/reset/Makefile
+++ b/drivers/vfio/platform/reset/Makefile
@@ -1,5 +1,5 @@
 vfio-platform-calxedaxgmac-y := vfio_platform_calxedaxgmac.o
 
-ccflags-y += -Idrivers/vfio/platform
+ccflags-y += -Idrivers/vfio/platform -Idrivers/vfio/platform/reset
 
 obj-$(CONFIG_VFIO_PLATFORM_CALXEDAXGMAC_RESET) += vfio-platform-calxedaxgmac.o
diff --git a/drivers/vfio/platform/reset/vfio_platform_reset_private.h b/drivers/vfio/platform/reset/vfio_platform_reset_private.h
new file mode 100644
index 0000000..f212a61
--- /dev/null
+++ b/drivers/vfio/platform/reset/vfio_platform_reset_private.h
@@ -0,0 +1,66 @@
+/*
+ * Interface used by VFIO platform reset modules to register/unregister
+ * their reset function
+ *
+ * Copyright (c) 2015 Linaro Ltd.
+ *              www.linaro.org
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef VFIO_PLATFORM_RESET_PRIVATE_H
+#define VFIO_PLATFORM_RESET_PRIVATE_H
+
+#include <linux/module.h>
+#include "vfio_platform_private.h"
+
+static int reset_module_register(struct module *module,
+				    const char *compat,
+				    vfio_platform_reset_fn_t reset)
+{
+	int (*register_reset)(struct module *, const char*,
+				vfio_platform_reset_fn_t);
+	int ret;
+
+	register_reset = symbol_get(vfio_platform_register_reset);
+	if (!register_reset)
+		return -EINVAL;
+	ret = register_reset(module, compat, reset);
+	symbol_put(vfio_platform_register_reset);
+	return ret;
+}
+
+static void reset_module_unregister(const char *compat)
+{
+	int (*unregister_reset)(const char *);
+
+	unregister_reset = symbol_get(vfio_platform_unregister_reset);
+	if (!unregister_reset)
+		return;
+
+	unregister_reset(compat);
+
+	symbol_put(vfio_platform_unregister_reset);
+}
+
+#define module_vfio_reset_handler(compat, reset)			\
+MODULE_ALIAS("vfio-reset:" compat);					\
+static int __init reset ## _module_init(void)				\
+{									\
+	return reset_module_register(THIS_MODULE, compat, &reset);	\
+};									\
+static void __exit reset ## _module_exit(void)				\
+{                                                                       \
+	reset_module_unregister(compat);				\
+};									\
+module_init(reset ## _module_init);					\
+module_exit(reset ## _module_exit)
+
+#endif /* VFIO_PLATFORM_RESET_PRIVATE_H */
-- 
1.9.1
