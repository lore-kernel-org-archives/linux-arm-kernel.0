From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Fri, 11 May 2018 18:20:18 +0200
Subject: [PATCH 02/12] platform/early: don't WARN() on non-empty devres list
 for early devices
In-Reply-To: <20180511162028.20616-1-brgl@bgdev.pl>
References: <20180511162028.20616-1-brgl@bgdev.pl>
Message-ID: <20180511162028.20616-3-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Early platform devices can have devres objects allocated in
early_probe(). This is not a bug so don't dump stack in this case.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/base/dd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index c9f54089429b..0b94d9426757 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -410,7 +410,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	atomic_inc(&probe_count);
 	pr_debug("bus: '%s': %s: probing driver %s with device %s\n",
 		 drv->bus->name, __func__, drv->name, dev_name(dev));
-	WARN_ON(!list_empty(&dev->devres_head));
+	WARN_ON(!dev->early && !list_empty(&dev->devres_head));
 
 re_probe:
 	dev->driver = drv;
-- 
2.17.0
