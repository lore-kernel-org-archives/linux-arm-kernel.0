From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon, 21 Sep 2015 16:02:49 +0200
Subject: [PATCH v6 09/22] drm: Probe panels on demand
In-Reply-To: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1442844182-27787-10-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When looking up a panel through its OF node, probe it if it hasn't
already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---


 drivers/gpu/drm/drm_panel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 2ef988e037b7..ad79a7b9c74d 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -23,6 +23,7 @@
 
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 
 #include <drm/drm_crtc.h>
 #include <drm/drm_panel.h>
@@ -80,6 +81,8 @@ struct drm_panel *of_drm_find_panel(struct device_node *np)
 {
 	struct drm_panel *panel;
 
+	of_device_probe(np);
+
 	mutex_lock(&panel_lock);
 
 	list_for_each_entry(panel, &panel_list, list) {
-- 
2.4.3
