From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon,  7 Sep 2015 14:23:38 +0200
Subject: [PATCH v4 13/22] backlight: Probe backlight devices on demand
In-Reply-To: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1441628627-5143-14-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When looking up a backlight device through its OF node, probe it if it
hasn't already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/video/backlight/backlight.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index bddc8b17a4d8..9bcdc16eacdf 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/fb.h>
 #include <linux/slab.h>
+#include <linux/of_device.h>
 
 #ifdef CONFIG_PMAC_BACKLIGHT
 #include <asm/backlight.h>
@@ -559,6 +560,8 @@ struct backlight_device *of_find_backlight_by_node(struct device_node *node)
 {
 	struct device *dev;
 
+	of_device_probe(node);
+
 	dev = class_find_device(backlight_class, NULL, node, of_parent_match);
 
 	return dev ? to_backlight_device(dev) : NULL;
-- 
2.4.3
