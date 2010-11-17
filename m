From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:29:39 +0100
Subject: [PATCH 11/51] ARM: imx: allow specifying a dma mask when creating a
	platform device
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-11-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/devices.c                     |   23 +++++++++++++++++++++--
 arch/arm/plat-mxc/include/mach/devices-common.h |   14 ++++++++++++--
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-mxc/devices.c b/arch/arm/plat-mxc/devices.c
index 735776d..e9bcefe 100644
--- a/arch/arm/plat-mxc/devices.c
+++ b/arch/arm/plat-mxc/devices.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
@@ -36,9 +37,10 @@ int __init mxc_register_device(struct platform_device *pdev, void *data)
 	return ret;
 }
 
-struct platform_device *__init imx_add_platform_device(const char *name, int id,
+struct platform_device *__init imx_add_platform_device_dmamask(
+		const char *name, int id,
 		const struct resource *res, unsigned int num_resources,
-		const void *data, size_t size_data)
+		const void *data, size_t size_data, u64 dmamask)
 {
 	int ret = -ENOMEM;
 	struct platform_device *pdev;
@@ -47,6 +49,23 @@ struct platform_device *__init imx_add_platform_device(const char *name, int id,
 	if (!pdev)
 		goto err;
 
+	if (dmamask) {
+		/*
+		 * This memory isn't freed when the device is put,
+		 * I don't have a nice idea for that though.  Conceptually
+		 * dma_mask in struct device should not be a pointer.
+		 * See http://thread.gmane.org/gmane.linux.kernel.pci/9081
+		 */
+		pdev->dev.dma_mask =
+			kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
+		if (!pdev->dev.dma_mask)
+			/* ret is still -ENOMEM; */
+			goto err;
+
+		*pdev->dev.dma_mask = dmamask;
+		pdev->dev.coherent_dma_mask = dmamask;
+	}
+
 	if (res) {
 		ret = platform_device_add_resources(pdev, res, num_resources);
 		if (ret)
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 4eb45fa..a5e97b8 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -10,9 +10,19 @@
 #include <linux/platform_device.h>
 #include <linux/init.h>
 
-struct platform_device *imx_add_platform_device(const char *name, int id,
+struct platform_device *imx_add_platform_device_dmamask(
+		const char *name, int id,
 		const struct resource *res, unsigned int num_resources,
-		const void *data, size_t size_data);
+		const void *data, size_t size_data, u64 dmamask);
+
+static inline struct platform_device *imx_add_platform_device(
+		const char *name, int id,
+		const struct resource *res, unsigned int num_resources,
+		const void *data, size_t size_data)
+{
+	return imx_add_platform_device_dmamask(
+			name, id, res, num_resources, data, size_data, 0);
+}
 
 #include <linux/fec.h>
 struct imx_fec_data {
-- 
1.7.2.3
