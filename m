From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 25 Aug 2011 11:16:01 +0200
Subject: [PATCH 2/2] ARM: mxc: convert device creation to use
	platform_device_register_full
In-Reply-To: <1314263761-20213-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1314263761-20213-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1314263761-20213-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/devices.c                     |   53 -----------------------
 arch/arm/plat-mxc/include/mach/devices-common.h |   16 ++++++-
 2 files changed, 14 insertions(+), 55 deletions(-)

diff --git a/arch/arm/plat-mxc/devices.c b/arch/arm/plat-mxc/devices.c
index 0d6ed31..a34b2ae 100644
--- a/arch/arm/plat-mxc/devices.c
+++ b/arch/arm/plat-mxc/devices.c
@@ -37,59 +37,6 @@ int __init mxc_register_device(struct platform_device *pdev, void *data)
 	return ret;
 }
 
-struct platform_device *__init imx_add_platform_device_dmamask(
-		const char *name, int id,
-		const struct resource *res, unsigned int num_resources,
-		const void *data, size_t size_data, u64 dmamask)
-{
-	int ret = -ENOMEM;
-	struct platform_device *pdev;
-
-	pdev = platform_device_alloc(name, id);
-	if (!pdev)
-		goto err;
-
-	if (dmamask) {
-		/*
-		 * This memory isn't freed when the device is put,
-		 * I don't have a nice idea for that though.  Conceptually
-		 * dma_mask in struct device should not be a pointer.
-		 * See http://thread.gmane.org/gmane.linux.kernel.pci/9081
-		 */
-		pdev->dev.dma_mask =
-			kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
-		if (!pdev->dev.dma_mask)
-			/* ret is still -ENOMEM; */
-			goto err;
-
-		*pdev->dev.dma_mask = dmamask;
-		pdev->dev.coherent_dma_mask = dmamask;
-	}
-
-	if (res) {
-		ret = platform_device_add_resources(pdev, res, num_resources);
-		if (ret)
-			goto err;
-	}
-
-	if (data) {
-		ret = platform_device_add_data(pdev, data, size_data);
-		if (ret)
-			goto err;
-	}
-
-	ret = platform_device_add(pdev);
-	if (ret) {
-err:
-		if (dmamask)
-			kfree(pdev->dev.dma_mask);
-		platform_device_put(pdev);
-		return ERR_PTR(ret);
-	}
-
-	return pdev;
-}
-
 struct device mxc_aips_bus = {
 	.init_name	= "mxc_aips",
 	.parent		= &platform_bus,
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 524538a..543525d 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -14,10 +14,22 @@
 extern struct device mxc_aips_bus;
 extern struct device mxc_ahb_bus;
 
-struct platform_device *imx_add_platform_device_dmamask(
+static inline struct platform_device *imx_add_platform_device_dmamask(
 		const char *name, int id,
 		const struct resource *res, unsigned int num_resources,
-		const void *data, size_t size_data, u64 dmamask);
+		const void *data, size_t size_data, u64 dmamask)
+{
+	struct platform_device_info pdevinfo = {
+		.name = name,
+		.id = id,
+		.res = res,
+		.num_res = num_resources,
+		.data = data,
+		.size_data = size_data,
+		.dma_mask = dmamask,
+	};
+	return platform_device_register_full(&pdevinfo);
+}
 
 static inline struct platform_device *imx_add_platform_device(
 		const char *name, int id,
-- 
1.7.5.4
