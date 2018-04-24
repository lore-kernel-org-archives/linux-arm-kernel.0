From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 24 Apr 2018 19:30:41 +0200
Subject: [PATCH 01/11] platform: early: provide early_platform_add_device()
In-Reply-To: <20180424173051.15099-1-brgl@bgdev.pl>
References: <20180424173051.15099-1-brgl@bgdev.pl>
Message-ID: <20180424173051.15099-2-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Currently we only have early_platform_add_devices() which takes struct
platform_device ** as argument, requiring the users to have an
intermediate array of platform_device pointers even if we're only
adding a single device. Provide a helper for adding a single device at
a time.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/platform_device.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 49f634d96118..80942ed0f728 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -301,6 +301,11 @@ extern int early_platform_driver_register(struct early_platform_driver *epdrv,
 					  char *buf);
 extern void early_platform_add_devices(struct platform_device **devs, int num);
 
+static inline void early_platform_add_device(struct platform_device *pdev)
+{
+	early_platform_add_devices(&pdev, 1);
+}
+
 static inline int is_early_platform_device(struct platform_device *pdev)
 {
 	return !pdev->dev.driver;
-- 
2.17.0
