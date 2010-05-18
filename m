From: tomi.valkeinen@nokia.com (Tomi Valkeinen)
Date: Tue, 18 May 2010 15:35:03 +0300
Subject: [PATCH 12/23] OMAP: DSS2: Taal: Fix DSI bus locking problem
In-Reply-To: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
References: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
Message-ID: <1274186114-26951-13-git-send-email-tomi.valkeinen@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ville Syrj?l? <ville.syrjala@nokia.com>

If omapdss_dsi_display_enable() failed the DSI bus was left locked. Also
if the operation failed later omapdss_dsi_display_disable() would get
called without holding the bus lock.

Signed-off-by: Ville Syrj?l? <ville.syrjala@nokia.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/displays/panel-taal.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 1799096..aaf5d30 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -702,10 +702,9 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 
 	return 0;
 err:
-	dsi_bus_unlock();
-
 	omapdss_dsi_display_disable(dssdev);
 err0:
+	dsi_bus_unlock();
 	if (dssdev->platform_disable)
 		dssdev->platform_disable(dssdev);
 
-- 
1.7.0.4
