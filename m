From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sat, 19 May 2018 20:31:20 +0200
Subject: [PATCH 08/15] drm/sun4i: DE2 mixer: Add index quirk
In-Reply-To: <20180519183127.2718-1-jernej.skrabec@siol.net>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
Message-ID: <20180519183127.2718-9-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When TCON sets up TCON TOP, it needs to know mixer index. Here we do that
by setting engine ID to number provided in mixer index quirk.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 4 ++--
 drivers/gpu/drm/sun4i/sun8i_mixer.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 126899d6f0d3..36d90c76317a 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -353,13 +353,13 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
 	dev_set_drvdata(dev, mixer);
 	mixer->engine.ops = &sun8i_engine_ops;
 	mixer->engine.node = dev->of_node;
-	/* The ID of the mixer currently doesn't matter */
-	mixer->engine.id = -1;
 
 	mixer->cfg = of_device_get_match_data(dev);
 	if (!mixer->cfg)
 		return -EINVAL;
 
+	mixer->engine.id = mixer->cfg->index;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(regs))
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index f34e70c42adf..aeda6e9a7627 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -123,6 +123,7 @@ struct de2_fmt_info {
  *	are invalid.
  * @mod_rate: module clock rate that needs to be set in order to have
  *	a functional block.
+ * @index: mixer index, needed to properly set TCON TOP
  */
 struct sun8i_mixer_cfg {
 	int		vi_num;
@@ -130,6 +131,7 @@ struct sun8i_mixer_cfg {
 	int		scaler_mask;
 	int		ccsc;
 	unsigned long	mod_rate;
+	int		index;
 };
 
 struct sun8i_mixer {
-- 
2.17.0
