From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 20 Jul 2016 11:58:51 +0200
Subject: [PATCH v2 1/7] drm/sun4i: Store TCON's device structure pointer
In-Reply-To: <20160720095857.12297-1-maxime.ripard@free-electrons.com>
References: <20160720095857.12297-1-maxime.ripard@free-electrons.com>
Message-ID: <20160720095857.12297-2-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We will need to access TCON's struct device from outside of TCON's driver
bind function. Store it in our private structure.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 1 +
 drivers/gpu/drm/sun4i/sun4i_tcon.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 652385f09735..af136dfc206e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -446,6 +446,7 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 	dev_set_drvdata(dev, tcon);
 	drv->tcon = tcon;
 	tcon->drm = drm;
+	tcon->dev = dev;
 
 	if (of_device_is_compatible(dev->of_node, "allwinner,sun5i-a13-tcon"))
 		tcon->has_mux = true;
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index 0e0b11db401b..230550b720f1 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -143,6 +143,7 @@
 #define SUN4I_TCON_MAX_CHANNELS		2
 
 struct sun4i_tcon {
+	struct device			*dev;
 	struct drm_device		*drm;
 	struct regmap			*regs;
 
-- 
2.9.0
