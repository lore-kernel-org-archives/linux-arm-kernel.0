From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 21 Jan 2014 12:56:38 +0200
Subject: [PATCHv3 06/41] OMAPFB: search for default display with DT alias
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1390301833-24944-7-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Improve the search for the default display in two ways:
* compare the given display name to the display's alias
* if no display name is given, look for "display0" DT alias

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index b7469636f15c..f121e87b30be 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2423,7 +2423,10 @@ omapfb_find_default_display(struct omapfb2_device *fbdev)
 	const char *def_name;
 	int i;
 
-	/* search with the display name from the user or the board file */
+	/*
+	 * Search with the display name from the user or the board file,
+	 * comparing to display names and aliases
+	 */
 
 	def_name = omapdss_get_default_display_name();
 
@@ -2435,12 +2438,30 @@ omapfb_find_default_display(struct omapfb2_device *fbdev)
 
 			if (dssdev->name && strcmp(def_name, dssdev->name) == 0)
 				return dssdev;
+
+			if (strcmp(def_name, dssdev->alias) == 0)
+				return dssdev;
 		}
 
 		/* def_name given but not found */
 		return NULL;
 	}
 
+	/* then look for DT alias display0 */
+	for (i = 0; i < fbdev->num_displays; ++i) {
+		struct omap_dss_device *dssdev;
+		int id;
+
+		dssdev = fbdev->displays[i].dssdev;
+
+		if (dssdev->dev->of_node == NULL)
+			continue;
+
+		id = of_alias_get_id(dssdev->dev->of_node, "display");
+		if (id == 0)
+			return dssdev;
+	}
+
 	/* return the first display we have in the list */
 	return fbdev->displays[0].dssdev;
 }
-- 
1.8.3.2
