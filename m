From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 28 Jun 2012 11:37:25 +0800
Subject: [PATCH v8 08/14] USB: Chipidea: add ci13xxx device id management
In-Reply-To: <1340854652-24717-1-git-send-email-richard.zhao@freescale.com>
References: <1340854652-24717-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1340854652-24717-9-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We use ida_simple_get and ida_simple_remove to manage the ids.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
Reviewed-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/usb/chipidea/core.c |   21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 8b9d06f..39603d7 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -56,6 +56,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
+#include <linux/idr.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -332,17 +333,24 @@ static irqreturn_t ci_irq(int irq, void *data)
 	return ci->role == CI_ROLE_END ? ret : ci_role(ci)->irq(ci);
 }
 
+static DEFINE_IDA(ci_ida);
+
 struct platform_device *ci13xxx_add_device(struct device *dev,
 			struct resource *res, int nres,
 			struct ci13xxx_platform_data *platdata)
 {
 	struct platform_device *pdev;
-	int ret;
+	int id, ret;
 
-	/* FIXME: find a way to choose id */
-	pdev = platform_device_alloc("ci_hdrc", -1);
-	if (!pdev)
-		return ERR_PTR(-ENOMEM);
+	id = ida_simple_get(&ci_ida, 0, 0, GFP_KERNEL);
+	if (id < 0)
+		return ERR_PTR(id);
+
+	pdev = platform_device_alloc("ci_hdrc", id);
+	if (!pdev) {
+		ret = -ENOMEM;
+		goto put_id;
+	}
 
 	pdev->dev.parent = dev;
 	pdev->dev.dma_mask = dev->dma_mask;
@@ -365,6 +373,8 @@ struct platform_device *ci13xxx_add_device(struct device *dev,
 
 err:
 	platform_device_put(pdev);
+put_id:
+	ida_simple_remove(&ci_ida, id);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(ci13xxx_add_device);
@@ -372,6 +382,7 @@ EXPORT_SYMBOL_GPL(ci13xxx_add_device);
 void ci13xxx_remove_device(struct platform_device *pdev)
 {
 	platform_device_unregister(pdev);
+	ida_simple_remove(&ci_ida, pdev->id);
 }
 EXPORT_SYMBOL_GPL(ci13xxx_remove_device);
 
-- 
1.7.9.5
