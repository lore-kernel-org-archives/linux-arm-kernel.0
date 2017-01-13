From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Fri, 13 Jan 2017 11:00:25 +0100
Subject: [PATCH RESEND 1/2] memory: aemif: allow passing device lookup table
 as platform data
In-Reply-To: <1484301626-30345-1-git-send-email-bgolaszewski@baylibre.com>
References: <1484301626-30345-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1484301626-30345-2-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TI aemif driver creates its own subnodes of the device tree in order
to guarantee that all child devices are probed after the AEMIF timing
parameters are configured.

Some devices (e.g. da850) use struct of_dev_auxdata for clock lookup
but nodes created from within the aemif driver can't access the lookup
table.

Create a platform data structure that holds a pointer to
of_dev_auxdata so that we can use it with of_platform_populate().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Sekhar Nori <nsekhar@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
---
 drivers/memory/ti-aemif.c              |  8 +++++++-
 include/linux/platform_data/ti-aemif.h | 23 +++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/platform_data/ti-aemif.h

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index a579a0f..22c1aee 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/ti-aemif.h>
 
 #define TA_SHIFT	2
 #define RHOLD_SHIFT	4
@@ -335,6 +336,8 @@ static int aemif_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct device_node *child_np;
 	struct aemif_device *aemif;
+	struct aemif_platform_data *pdata;
+	struct of_dev_auxdata *dev_lookup;
 
 	if (np == NULL)
 		return 0;
@@ -343,6 +346,9 @@ static int aemif_probe(struct platform_device *pdev)
 	if (!aemif)
 		return -ENOMEM;
 
+	pdata = dev_get_platdata(&pdev->dev);
+	dev_lookup = pdata ? pdata->dev_lookup : NULL;
+
 	platform_set_drvdata(pdev, aemif);
 
 	aemif->clk = devm_clk_get(dev, NULL);
@@ -390,7 +396,7 @@ static int aemif_probe(struct platform_device *pdev)
 	 * parameters are set.
 	 */
 	for_each_available_child_of_node(np, child_np) {
-		ret = of_platform_populate(child_np, NULL, NULL, dev);
+		ret = of_platform_populate(child_np, NULL, dev_lookup, dev);
 		if (ret < 0)
 			goto error;
 	}
diff --git a/include/linux/platform_data/ti-aemif.h b/include/linux/platform_data/ti-aemif.h
new file mode 100644
index 0000000..ac72e11
--- /dev/null
+++ b/include/linux/platform_data/ti-aemif.h
@@ -0,0 +1,23 @@
+/*
+ * TI DaVinci AEMIF platform glue.
+ *
+ * Copyright (C) 2017 BayLibre SAS
+ *
+ * Author:
+ *   Bartosz Golaszewski <bgolaszewski@baylibre.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __TI_DAVINCI_AEMIF_DATA_H__
+#define __TI_DAVINCI_AEMIF_DATA_H__
+
+#include <linux/of_platform.h>
+
+struct aemif_platform_data {
+	struct of_dev_auxdata *dev_lookup;
+};
+
+#endif /* __TI_DAVINCI_AEMIF_DATA_H__ */
-- 
2.9.3
