From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Fri, 11 May 2018 18:20:21 +0200
Subject: [PATCH 05/12] platform: export platform_device_release() locally
In-Reply-To: <20180511162028.20616-1-brgl@bgdev.pl>
References: <20180511162028.20616-1-brgl@bgdev.pl>
Message-ID: <20180511162028.20616-6-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The early platform driver mechanism will use this function as the
device release callback. Make it available in drivers/base.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/base/base.h     | 1 +
 drivers/base/platform.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 7a72ae72a98e..514a6d198f14 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -164,3 +164,4 @@ extern void device_links_unbind_consumers(struct device *dev);
 
 /* Platform device helpers. */
 extern int platform_match(struct device *dev, struct device_driver *drv);
+extern void platform_device_release(struct device *dev);
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 0ba4effb9618..417ab6071350 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -239,7 +239,7 @@ void platform_device_put(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(platform_device_put);
 
-static void platform_device_release(struct device *dev)
+void platform_device_release(struct device *dev)
 {
 	struct platform_object *pa = container_of(dev, struct platform_object,
 						  pdev.dev);
-- 
2.17.0
