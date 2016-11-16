From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 16 Nov 2016 17:37:32 +0800
Subject: [PATCH] drm/sun4i: tcon: Initialize regmap after enabling bus clocks
In-Reply-To: <20161116093732.12828-1-wens@csie.org>
References: <20161116093732.12828-1-wens@csie.org>
Message-ID: <20161116093732.12828-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we attempt to read/write the TCON registers before the bus clock
is enabled, those accesses get ignored.

In practice this almost never occurs because U-boot had already enabled
the bus clock as part of its firmware provided framebuffer (simplefb).

Fixes: 9026e0d122ac ("drm: Add Allwinner A10 Display Engine support")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

I was looking around the DRM driver and noticed this sequence was off.

---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index c6afb2448655..8c2db65ea229 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -506,16 +506,16 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 		return ret;
 	}
 
-	ret = sun4i_tcon_init_regmap(dev, tcon);
+	ret = sun4i_tcon_init_clocks(dev, tcon);
 	if (ret) {
-		dev_err(dev, "Couldn't init our TCON regmap\n");
+		dev_err(dev, "Couldn't init our TCON clocks\n");
 		goto err_assert_reset;
 	}
 
-	ret = sun4i_tcon_init_clocks(dev, tcon);
+	ret = sun4i_tcon_init_regmap(dev, tcon);
 	if (ret) {
-		dev_err(dev, "Couldn't init our TCON clocks\n");
-		goto err_assert_reset;
+		dev_err(dev, "Couldn't init our TCON regmap\n");
+		goto err_free_clocks;
 	}
 
 	ret = sun4i_tcon_init_irq(dev, tcon);
-- 
2.10.2
