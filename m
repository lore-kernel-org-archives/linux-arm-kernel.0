From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 21 Apr 2017 16:38:55 +0800
Subject: [PATCH v2 7/9] drm/sun4i: tcon: Copy ID from associated backend
In-Reply-To: <20170421083857.29636-1-wens@csie.org>
References: <20170421083857.29636-1-wens@csie.org>
Message-ID: <20170421083857.29636-8-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tcons and backends have a one-to-one relationship. Their IDs,
or indexes in the documentation, are also the same.

Copy the ID from the associated backend and save it in the tcon
structure. This will later be used when we add support for the
output data path muxes.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 1 +
 drivers/gpu/drm/sun4i/sun4i_tcon.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 4409e7b6c74d..8301389c411d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -540,6 +540,7 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 	dev_set_drvdata(dev, tcon);
 	tcon->drm = drm;
 	tcon->dev = dev;
+	tcon->id = backend->id;
 	tcon->quirks = of_device_get_match_data(dev);
 
 	tcon->lcd_rst = devm_reset_control_get(dev, "lcd");
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index 1bda4d183eec..d37e1e2ed60e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -174,6 +174,8 @@ struct sun4i_tcon {
 	/* Associated crtc */
 	struct sun4i_crtc		*crtc;
 
+	int				id;
+
 	/* TCON list management */
 	struct list_head		list;
 };
-- 
2.11.0
