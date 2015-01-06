From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue,  6 Jan 2015 12:08:44 +0100
Subject: [RESEND PATCH v5 2/3] drm: panel: simple-panel: add support for
 bus_format retrieval
In-Reply-To: <1420542525-13507-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1420542525-13507-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1420542525-13507-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide a way to specify panel requirement in terms of supported media bus
format (particularly useful for panels connected to an RGB or LVDS bus).

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index e95385b..4504018 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -61,6 +61,8 @@ struct panel_desc {
 		unsigned int disable;
 		unsigned int unprepare;
 	} delay;
+
+	u32 bus_format;
 };
 
 struct panel_simple {
@@ -111,6 +113,9 @@ static int panel_simple_get_fixed_modes(struct panel_simple *panel)
 	connector->display_info.bpc = panel->desc->bpc;
 	connector->display_info.width_mm = panel->desc->size.width;
 	connector->display_info.height_mm = panel->desc->size.height;
+	if (panel->desc->bus_format)
+		drm_display_info_set_bus_formats(&connector->display_info,
+						 &panel->desc->bus_format, 1);
 
 	return num;
 }
-- 
1.9.1
