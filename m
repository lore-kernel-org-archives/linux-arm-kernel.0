From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 20 Jul 2016 11:58:52 +0200
Subject: [PATCH v2 2/7] drm/sun4i: Move panel retrieval in RGB connector
In-Reply-To: <20160720095857.12297-1-maxime.ripard@free-electrons.com>
References: <20160720095857.12297-1-maxime.ripard@free-electrons.com>
Message-ID: <20160720095857.12297-3-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to properly support bridges and use drm_encoder's bridge pointer,
move the panel (and bridge eventually) retrieval code in the RGB output
init function.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_rgb.c  | 10 ++++++----
 drivers/gpu/drm/sun4i/sun4i_tcon.c |  8 +-------
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  2 ++
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index f5bbac6efb4c..d32f08f9ce5f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -206,15 +206,17 @@ int sun4i_rgb_init(struct drm_device *drm)
 	struct sun4i_rgb *rgb;
 	int ret;
 
-	/* If we don't have a panel, there's no point in going on */
-	if (IS_ERR(tcon->panel))
-		return -ENODEV;
-
 	rgb = devm_kzalloc(drm->dev, sizeof(*rgb), GFP_KERNEL);
 	if (!rgb)
 		return -ENOMEM;
 	rgb->drv = drv;
 
+	tcon->panel = sun4i_tcon_find_panel(tcon->dev->of_node);
+	if (IS_ERR(tcon->panel)) {
+		dev_info(drm->dev, "No panel found... RGB output disabled\n");
+		return 0;
+	}
+
 	drm_encoder_helper_add(&rgb->encoder,
 			       &sun4i_rgb_enc_helper_funcs);
 	ret = drm_encoder_init(drm,
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index af136dfc206e..d2f7489d29a5 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -398,7 +398,7 @@ static int sun4i_tcon_init_regmap(struct device *dev,
 	return 0;
 }
 
-static struct drm_panel *sun4i_tcon_find_panel(struct device_node *node)
+struct drm_panel *sun4i_tcon_find_panel(struct device_node *node)
 {
 	struct device_node *port, *remote, *child;
 	struct device_node *end_node = NULL;
@@ -485,12 +485,6 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 		goto err_free_clocks;
 	}
 
-	tcon->panel = sun4i_tcon_find_panel(dev->of_node);
-	if (IS_ERR(tcon->panel)) {
-		dev_info(dev, "No panel found... RGB output disabled\n");
-		return 0;
-	}
-
 	ret = sun4i_rgb_init(drm);
 	if (ret < 0)
 		goto err_free_clocks;
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index 230550b720f1..4f81d86ee5a4 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -166,6 +166,8 @@ struct sun4i_tcon {
 	struct drm_panel		*panel;
 };
 
+struct drm_panel *sun4i_tcon_find_panel(struct device_node *node);
+
 /* Global Control */
 void sun4i_tcon_disable(struct sun4i_tcon *tcon);
 void sun4i_tcon_enable(struct sun4i_tcon *tcon);
-- 
2.9.0
