From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:24 +0200
Subject: [PATCH 28/61] ARM: imx: new helper function imx_add_platform_device
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-29-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This should be a globally available function, see

	http://thread.gmane.org/gmane.linux.kernel/998881/focus=998882

Until this hits mainline make a similar function available for imx
platforms only.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/devices.c                     |   33 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |   15 ++++++++++
 2 files changed, 48 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-mxc/include/mach/devices-common.h

diff --git a/arch/arm/plat-mxc/devices.c b/arch/arm/plat-mxc/devices.c
index 56f2fb5..735776d 100644
--- a/arch/arm/plat-mxc/devices.c
+++ b/arch/arm/plat-mxc/devices.c
@@ -18,6 +18,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/err.h>
 #include <linux/platform_device.h>
 #include <mach/common.h>
 
@@ -35,3 +36,35 @@ int __init mxc_register_device(struct platform_device *pdev, void *data)
 	return ret;
 }
 
+struct platform_device *__init imx_add_platform_device(const char *name, int id,
+		const struct resource *res, unsigned int num_resources,
+		const void *data, size_t size_data)
+{
+	int ret = -ENOMEM;
+	struct platform_device *pdev;
+
+	pdev = platform_device_alloc(name, id);
+	if (!pdev)
+		goto err;
+
+	if (res) {
+		ret = platform_device_add_resources(pdev, res, num_resources);
+		if (ret)
+			goto err;
+	}
+
+	if (data) {
+		ret = platform_device_add_data(pdev, data, size_data);
+		if (ret)
+			goto err;
+	}
+
+	ret = platform_device_add(pdev);
+	if (ret) {
+err:
+		platform_device_put(pdev);
+		return ERR_PTR(ret);
+	}
+
+	return pdev;
+}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
new file mode 100644
index 0000000..849d8ff
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright (C) 2009-2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/init.h>
+
+struct platform_device *imx_add_platform_device(const char *name, int id,
+		const struct resource *res, unsigned int num_resources,
+		const void *data, size_t size_data);
-- 
1.7.1
