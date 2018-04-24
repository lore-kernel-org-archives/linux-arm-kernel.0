From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 24 Apr 2018 19:30:42 +0200
Subject: [PATCH 02/11] platform: provide
 early_platform_driver_register_probe_all()
In-Reply-To: <20180424173051.15099-1-brgl@bgdev.pl>
References: <20180424173051.15099-1-brgl@bgdev.pl>
Message-ID: <20180424173051.15099-3-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

All users of early_platform_driver_register_all() subsequently call
early_platform_driver_probe(). Provide a helper that calls both
functions.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/platform_device.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 80942ed0f728..a06b194ba30b 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -314,6 +314,15 @@ static inline int is_early_platform_device(struct platform_device *pdev)
 extern void early_platform_driver_register_all(char *class_str);
 extern int early_platform_driver_probe(char *class_str,
 				       int nr_probe, int user_only);
+
+static inline int early_platform_driver_register_probe_all(char *class_str,
+							   int nr_probe,
+							   int user_only)
+{
+	early_platform_driver_register_all(class_str);
+	return early_platform_driver_probe(class_str, nr_probe, user_only);
+}
+
 extern void early_platform_cleanup(void);
 
 #define early_platform_init(class_string, platdrv)		\
-- 
2.17.0
