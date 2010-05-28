From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 28 May 2010 07:19:16 +0100
Subject: [PATCH 6/9] ARM: SAMSUNG: Add helper to clone and set platform data
In-Reply-To: <1275027559-29278-1-git-send-email-ben-linux@fluff.org>
References: <1275027559-29278-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1275027559-29278-7-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a helper to clone the platform data via kmemdup() and set it into
the specified device and report any problems via printk().

This is intended to replace a number of sites in the Samsung kernel
where the same thing is being repeated in specific platform setting
code. See next patches for replacements.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-samsung/Makefile            |    2 +
 arch/arm/plat-samsung/include/plat/devs.h |   12 +++++++++
 arch/arm/plat-samsung/platformdata.c      |   37 +++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-samsung/platformdata.c

diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index b1d82cc..228c2ad 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -30,6 +30,8 @@ obj-$(CONFIG_S3C_ADC)	+= adc.o
 
 # devices
 
+obj-y				+= platformdata.o
+
 obj-$(CONFIG_S3C_DEV_HSMMC)	+= dev-hsmmc.o
 obj-$(CONFIG_S3C_DEV_HSMMC1)	+= dev-hsmmc1.o
 obj-$(CONFIG_S3C_DEV_HSMMC2)	+= dev-hsmmc2.o
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index e6144e4..6760999 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -108,3 +108,15 @@ extern struct platform_device s3c_device_camif;
 extern struct platform_device s3c_device_ac97;
 
 #endif
+
+/**
+ * s3c_set_platdata() - helper for setting platform data
+ * @pd: The default platform data for this device.
+ * @pdsize: The size of the platform data.
+ * @pdev: Pointer to the device to fill in.
+ *
+ * This helper replaces a number of calls that copy and then set the
+ * platform data of the device.
+ */
+extern void *s3c_set_platdata(void *pd, size_t pdsize,
+			      struct platform_device *pdev);
diff --git a/arch/arm/plat-samsung/platformdata.c b/arch/arm/plat-samsung/platformdata.c
new file mode 100644
index 0000000..4a05efb
--- /dev/null
+++ b/arch/arm/plat-samsung/platformdata.c
@@ -0,0 +1,37 @@
+/* linux/arch/arm/plat-samsung/platformdata.c
+ *
+ * Copyright 2010 Ben Dooks <ben-linux@fluff.org>
+ *
+ * Helper for platform data setting
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/platform_device.h>
+
+#include <plat/devs.h>
+
+void __init *s3c_set_platdata(void *pd, size_t pdsize,
+			      struct platform_device *pdev)
+{
+	void *npd;
+
+	if (!pd) {
+		/* too early to use dev_name(), may not be registered */
+		printk(KERN_ERR "%s: no platform data supplied\n", pdev->name);
+		return NULL;
+	}
+
+	npd = kmemdup(pd, pdsize, GFP_KERNEL);
+	if (!npd) {
+		printk(KERN_ERR "%s: cannot clone platform data\n", pdev->name);
+		return NULL;
+	}
+
+	pdev->dev.platform_data = npd;
+	return npd;
+}
-- 
1.6.3.3
