From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Wed, 8 Jul 2015 15:59:50 +0300
Subject: [PATCH 05/10] drm: panel-simple: use of_get_i2c_adapter_by_node
 interface
In-Reply-To: <1436360095-9065-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1436360095-9065-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <1436360390-9373-1-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change is needed to properly lock I2C bus driver, which serves DDC.

On release of_get_i2c_adapter_by_node() requires i2c_put_adapter() call,
which replaces put_device().

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index f94201b..b8a8b23 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -313,7 +313,7 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
 
 	ddc = of_parse_phandle(dev->of_node, "ddc-i2c-bus", 0);
 	if (ddc) {
-		panel->ddc = of_find_i2c_adapter_by_node(ddc);
+		panel->ddc = of_get_i2c_adapter_by_node(ddc);
 		of_node_put(ddc);
 
 		if (!panel->ddc) {
@@ -335,8 +335,8 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
 	return 0;
 
 free_ddc:
-	if (panel->ddc)
-		put_device(&panel->ddc->dev);
+	i2c_put_adapter(panel->ddc);
+
 free_backlight:
 	if (panel->backlight)
 		put_device(&panel->backlight->dev);
@@ -353,8 +353,7 @@ static int panel_simple_remove(struct device *dev)
 
 	panel_simple_disable(&panel->base);
 
-	if (panel->ddc)
-		put_device(&panel->ddc->dev);
+	i2c_put_adapter(panel->ddc);
 
 	if (panel->backlight)
 		put_device(&panel->backlight->dev);
-- 
2.1.4
