From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 16 Mar 2016 14:57:42 +0100
Subject: [PATCH v2 8/9] drm: atmel-hlcdc: check display mode validity in
 crtc->mode_fixup()
In-Reply-To: <1458136663-21396-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1458136663-21396-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1458136663-21396-9-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the adjusted display mode check into ->mode_fixup().

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Tested-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 12ec204..cbba029 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -142,11 +142,13 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 			   cfg);
 }
 
-static bool atmel_hlcdc_crtc_mode_fixup(struct drm_crtc *crtc,
+static bool atmel_hlcdc_crtc_mode_fixup(struct drm_crtc *c,
 					const struct drm_display_mode *mode,
 					struct drm_display_mode *adjusted_mode)
 {
-	return true;
+	struct atmel_hlcdc_crtc *crtc = drm_crtc_to_atmel_hlcdc_crtc(c);
+
+	return atmel_hlcdc_dc_mode_valid(crtc->dc, adjusted_mode) == MODE_OK;
 }
 
 static void atmel_hlcdc_crtc_disable(struct drm_crtc *c)
@@ -311,12 +313,8 @@ static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
 static int atmel_hlcdc_crtc_atomic_check(struct drm_crtc *c,
 					 struct drm_crtc_state *s)
 {
-	struct atmel_hlcdc_crtc *crtc = drm_crtc_to_atmel_hlcdc_crtc(c);
 	int ret;
 
-	if (atmel_hlcdc_dc_mode_valid(crtc->dc, &s->adjusted_mode) != MODE_OK)
-		return -EINVAL;
-
 	ret = atmel_hlcdc_crtc_select_output_mode(s);
 	if (ret)
 		return ret;
-- 
2.5.0
