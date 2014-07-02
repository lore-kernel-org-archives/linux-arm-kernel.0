From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 02 Jul 2014 12:48:50 +0200
Subject: [PATCH 2/4] drivers: of: initialize and assign reserved memory to
 newly created devices
In-Reply-To: <1404298132-6050-1-git-send-email-m.szyprowski@samsung.com>
References: <1404298132-6050-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1404298132-6050-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently introduced of_reserved_mem_device_init() function to
automatically assign respective reserved memory region to the newly created
platform and amba device.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/of/platform.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 500436f9be7f..a9055d3da5c2 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -21,6 +21,7 @@
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 
 const struct of_device_id of_default_bus_match_table[] = {
@@ -233,12 +234,15 @@ static struct platform_device *of_platform_device_create_pdata(
 	dev->dev.bus = &platform_bus_type;
 	dev->dev.platform_data = platform_data;
 
+	of_reserved_mem_device_init(&dev->dev);
+
 	/* We do not fill the DMA ops for platform devices by default.
 	 * This is currently the responsibility of the platform code
 	 * to do such, possibly using a device notifier
 	 */
 
 	if (of_device_add(dev) != 0) {
+		of_reserved_mem_device_release(&dev->dev);
 		platform_device_put(dev);
 		goto err_clear_flag;
 	}
@@ -300,6 +304,8 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 	else
 		of_device_make_bus_id(&dev->dev);
 
+	of_reserved_mem_device_init(&dev->dev);
+
 	/* Allow the HW Peripheral ID to be overridden */
 	prop = of_get_property(node, "arm,primecell-periphid", NULL);
 	if (prop)
@@ -326,6 +332,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 	return dev;
 
 err_free:
+	of_reserved_mem_device_release(&dev->dev);
 	amba_device_put(dev);
 err_clear_flag:
 	of_node_clear_flag(node, OF_POPULATED);
-- 
1.9.2
