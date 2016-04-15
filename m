From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 15 Apr 2016 18:23:33 +0200
Subject: [RESEND PATCH] drm/panel: simple-panel: set appropriate mode type
In-Reply-To: <1430404770-29704-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1430404770-29704-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1460737413-29799-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris Brezillon <boris.brezillon@free-electrons.com>

All modes exposed by simple panels should be tagged as driver defined
modes.
Moreover, if a panel supports only one mode, this mode is obviously the
preferred one.

Doing this also fix a problem occurring when a 'video=' parameter is passed
on the kernel cmdline. In some cases the user provided mode is preferred
over the simple panel ones, which might result in unpredictable behavior.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reviewed-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Tested-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index ceb20486dacf..45b924ebed57 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -115,6 +115,10 @@ static int panel_simple_get_fixed_modes(struct panel_simple *panel)
 			continue;
 		}
 
+		mode->type |= DRM_MODE_TYPE_DRIVER;
+		if (panel->desc->num_modes == 1)
+			mode->type |= DRM_MODE_TYPE_PREFERRED;
+
 		drm_display_mode_from_videomode(&vm, mode);
 		drm_mode_set_name(mode);
 
@@ -132,6 +136,10 @@ static int panel_simple_get_fixed_modes(struct panel_simple *panel)
 			continue;
 		}
 
+		mode->type |= DRM_MODE_TYPE_DRIVER;
+		if (panel->desc->num_modes == 1)
+			mode->type |= DRM_MODE_TYPE_PREFERRED;
+
 		drm_mode_set_name(mode);
 
 		drm_mode_probed_add(connector, mode);
-- 
2.1.3
