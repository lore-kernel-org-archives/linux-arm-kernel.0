From: hs@denx.de (Heiko Schocher)
Date: Thu, 13 Feb 2014 14:47:38 +0100
Subject: [PATCH] gpu:drm:tilcdc: backlight node never found
Message-ID: <1392299258-16968-1-git-send-email-hs@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In panel_probe() the backlight node is never found, correct this.

Signed-off-by: Heiko Schocher <hs@denx.de>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: Benoit Parrot <bparrot@ti.com>
Cc: Rob Clark <robdclark@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sachin Kamat <sachin.kamat@linaro.org>
Cc: dri-devel at lists.freedesktop.org
Cc: linux-kernel at vger.kernel.org
Cc: devicetree at vger.kernel.org
---
 drivers/gpu/drm/tilcdc/tilcdc_panel.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_panel.c b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
index 86c6732..0b97cf4 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_panel.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
@@ -356,6 +356,7 @@ static struct of_device_id panel_of_match[];
 static int panel_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
+	struct device_node *backlight_node;
 	struct panel_module *panel_mod;
 	struct tilcdc_module *mod;
 	struct pinctrl *pinctrl;
@@ -395,9 +396,15 @@ static int panel_probe(struct platform_device *pdev)
 
 	mod->preferred_bpp = panel_mod->info->bpp;
 
-	panel_mod->backlight = of_find_backlight_by_node(node);
-	if (panel_mod->backlight)
-		dev_info(&pdev->dev, "found backlight\n");
+	backlight_node = of_parse_phandle(pdev->dev.of_node, "backlight", 0);
+	if (backlight_node) {
+		panel_mod->backlight =
+			of_find_backlight_by_node(backlight_node);
+		if (panel_mod->backlight)
+			dev_info(&pdev->dev, "found backlight\n");
+	} else {
+		dev_warn(&pdev->dev, "backlight node missing...\n");
+	}
 
 	return 0;
 
-- 
1.8.3.1
