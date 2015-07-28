From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 28 Jul 2015 15:19:42 +0200
Subject: [PATCH v2 11/22] drm: Probe panels on demand
In-Reply-To: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1438089593-7696-12-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When looking up a panel through its firmware node, probe it if it hasn't
already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2: None

 drivers/gpu/drm/drm_panel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 2ef988e037b7..374a964c3842 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -80,6 +80,8 @@ struct drm_panel *of_drm_find_panel(struct device_node *np)
 {
 	struct drm_panel *panel;
 
+	fwnode_ensure_device(&np->fwnode);
+
 	mutex_lock(&panel_lock);
 
 	list_for_each_entry(panel, &panel_list, list) {
-- 
2.4.3
