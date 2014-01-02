From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:27:33 +0000
Subject: [PATCH RFC 21/46] drm: provide a helper for the encoder
 possible_crtcs mask
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1Vypnh-0007Ev-3v@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The encoder possible_crtcs mask identifies which CRTCs can be bound to
a particular encoder.  Each bit from bit 0 defines an index in the list
of CRTCs held in the DRM mode_config crtc_list.  Rather than having
drivers trying to track the position of their CRTCs in the list, expose
the code which already exists for calculating the appropriate mask bit
for a CRTC.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/drm_crtc_helper.c |   39 ++++++++++++++++++++++++------------
 include/drm/drm_crtc_helper.h     |    1 +
 2 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
index 01361aba033b..10708c248196 100644
--- a/drivers/gpu/drm/drm_crtc_helper.c
+++ b/drivers/gpu/drm/drm_crtc_helper.c
@@ -325,6 +325,29 @@ void drm_helper_disable_unused_functions(struct drm_device *dev)
 EXPORT_SYMBOL(drm_helper_disable_unused_functions);
 
 /**
+ * drm_helper_crtc_possible_mask - find the mask of a registered CRTC
+ * @crtc: crtc to find mask for
+ *
+ * Given a registered CRTC, return the mask bit of that CRTC for an
+ * encoder's possible_crtcs field.
+ */
+uint32_t drm_helper_crtc_possible_mask(struct drm_crtc *crtc)
+{
+	struct drm_device *dev = crtc->dev;
+	struct drm_crtc *tmp;
+	uint32_t crtc_mask = 1;
+
+	list_for_each_entry(tmp, &dev->mode_config.crtc_list, head) {
+		if (tmp == crtc)
+			return crtc_mask;
+		crtc_mask <<= 1;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_helper_crtc_possible_mask);
+
+/**
  * drm_encoder_crtc_ok - can a given crtc drive a given encoder?
  * @encoder: encoder to test
  * @crtc: crtc to test
@@ -334,23 +357,13 @@ EXPORT_SYMBOL(drm_helper_disable_unused_functions);
 static bool drm_encoder_crtc_ok(struct drm_encoder *encoder,
 				struct drm_crtc *crtc)
 {
-	struct drm_device *dev;
-	struct drm_crtc *tmp;
-	int crtc_mask = 1;
+	uint32_t crtc_mask;
 
 	WARN(!crtc, "checking null crtc?\n");
 
-	dev = crtc->dev;
-
-	list_for_each_entry(tmp, &dev->mode_config.crtc_list, head) {
-		if (tmp == crtc)
-			break;
-		crtc_mask <<= 1;
-	}
+	crtc_mask = drm_helper_crtc_possible_mask(crtc);
 
-	if (encoder->possible_crtcs & crtc_mask)
-		return true;
-	return false;
+	return !!(encoder->possible_crtcs & crtc_mask);
 }
 
 /*
diff --git a/include/drm/drm_crtc_helper.h b/include/drm/drm_crtc_helper.h
index ef6ad3a8e58e..21b9f47dd88c 100644
--- a/include/drm/drm_crtc_helper.h
+++ b/include/drm/drm_crtc_helper.h
@@ -127,6 +127,7 @@ struct drm_connector_helper_funcs {
 
 extern int drm_helper_probe_single_connector_modes(struct drm_connector *connector, uint32_t maxX, uint32_t maxY);
 extern void drm_helper_disable_unused_functions(struct drm_device *dev);
+extern uint32_t drm_helper_crtc_possible_mask(struct drm_crtc *crtc);
 extern int drm_crtc_helper_set_config(struct drm_mode_set *set);
 extern bool drm_crtc_helper_set_mode(struct drm_crtc *crtc,
 				     struct drm_display_mode *mode,
-- 
1.7.4.4
