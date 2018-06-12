From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Tue, 12 Jun 2018 22:00:33 +0200
Subject: [PATCH v2 24/27] drm: of: Export drm_crtc_port_mask()
In-Reply-To: <20180612200036.21483-1-jernej.skrabec@siol.net>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
Message-ID: <20180612200036.21483-25-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Function is useful when drm_of_find_possible_crtcs() can't be used and
custom parsing is needed. This can happen for example when there is a
node with multiple muxes between crtc and encoder.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/drm_of.c | 4 ++--
 include/drm/drm_of.h     | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index 1fe122461298..2e9cea3287b2 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -22,8 +22,8 @@ static void drm_release_of(struct device *dev, void *data)
  * Given a port OF node, return the possible mask of the corresponding
  * CRTC within a device's list of CRTCs.  Returns zero if not found.
  */
-static uint32_t drm_crtc_port_mask(struct drm_device *dev,
-				   struct device_node *port)
+uint32_t drm_crtc_port_mask(struct drm_device *dev,
+			    struct device_node *port)
 {
 	unsigned int index = 0;
 	struct drm_crtc *tmp;
diff --git a/include/drm/drm_of.h b/include/drm/drm_of.h
index b93c239afb60..a61fd77e46ba 100644
--- a/include/drm/drm_of.h
+++ b/include/drm/drm_of.h
@@ -17,6 +17,8 @@ struct drm_bridge;
 struct device_node;
 
 #ifdef CONFIG_OF
+uint32_t drm_crtc_port_mask(struct drm_device *dev,
+			    struct device_node *port);
 uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
 				    struct device_node *port);
 void drm_of_component_match_add(struct device *master,
@@ -34,6 +36,12 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 				struct drm_panel **panel,
 				struct drm_bridge **bridge);
 #else
+static inline uint32_t drm_crtc_port_mask(struct drm_device *dev,
+					  struct device_node *port)
+{
+	return 0;
+}
+
 static inline uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
 						  struct device_node *port)
 {
-- 
2.17.1
