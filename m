From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Fri,  1 Dec 2017 07:05:30 +0100
Subject: [PATCH v2 07/27] drm/sun4i: Set blending mode for all channels (DE2)
In-Reply-To: <20171201060550.10392-1-jernej.skrabec@siol.net>
References: <20171201060550.10392-1-jernej.skrabec@siol.net>
Message-ID: <20171201060550.10392-8-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

BSP driver always sets blend mode for all channels, no matter if they
are really used or not. Do the same here.

The exact meaning of the value is not exactly known, but BSP driver
mentions "SRC OVER" and by digging through code some more info can be
found.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 5144e6d0ac56..23659ce1cf27 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -239,6 +239,7 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
 	struct sun8i_mixer *mixer;
 	struct resource *res;
 	void __iomem *regs;
+	int plane_cnt;
 	int i, ret;
 
 	/*
@@ -324,8 +325,6 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
 	/* Initialize blender */
 	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_FCOLOR_CTL,
 		     SUN8I_MIXER_BLEND_FCOLOR_CTL_DEF);
-	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_MODE(0),
-		     SUN8I_MIXER_BLEND_MODE_DEF);
 
 	regmap_write(mixer->engine.regs,
 		     SUN8I_MIXER_BLEND_ATTR_FCOLOR(0),
@@ -337,6 +336,11 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
 	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_ROUTE,
 		     mixer->cfg->vi_num);
 
+	plane_cnt = mixer->cfg->vi_num + mixer->cfg->ui_num;
+	for (i = 0; i < plane_cnt; i++)
+		regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_MODE(i),
+			     SUN8I_MIXER_BLEND_MODE_DEF);
+
 	return 0;
 
 err_disable_bus_clk:
-- 
2.15.1
