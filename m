From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  1 Sep 2016 17:31:58 +0200
Subject: [PATCH 1/7] drm/sun4i: support TCONs without channel 1
In-Reply-To: <20160901153204.11217-1-maxime.ripard@free-electrons.com>
References: <20160901153204.11217-1-maxime.ripard@free-electrons.com>
Message-ID: <20160901153204.11217-2-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some Allwinner SoCs, such as the A33, have a variation of the TCON that
doesn't have a second channel (or it is not wired to anything).

Make sure we can handle that case.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 34 +++++++++++++++++++++-------------
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  2 ++
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 9180e7e7b551..fde6af1230d2 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -59,11 +59,13 @@ void sun4i_tcon_channel_disable(struct sun4i_tcon *tcon, int channel)
 		regmap_update_bits(tcon->regs, SUN4I_TCON0_CTL_REG,
 				   SUN4I_TCON0_CTL_TCON_ENABLE, 0);
 		clk_disable_unprepare(tcon->dclk);
-	} else if (channel == 1) {
-		regmap_update_bits(tcon->regs, SUN4I_TCON1_CTL_REG,
-				   SUN4I_TCON1_CTL_TCON_ENABLE, 0);
-		clk_disable_unprepare(tcon->sclk1);
+		return;
 	}
+
+	WARN_ON(!tcon->has_channel_1);
+	regmap_update_bits(tcon->regs, SUN4I_TCON1_CTL_REG,
+			   SUN4I_TCON1_CTL_TCON_ENABLE, 0);
+	clk_disable_unprepare(tcon->sclk1);
 }
 EXPORT_SYMBOL(sun4i_tcon_channel_disable);
 
@@ -75,12 +77,14 @@ void sun4i_tcon_channel_enable(struct sun4i_tcon *tcon, int channel)
 				   SUN4I_TCON0_CTL_TCON_ENABLE,
 				   SUN4I_TCON0_CTL_TCON_ENABLE);
 		clk_prepare_enable(tcon->dclk);
-	} else if (channel == 1) {
-		regmap_update_bits(tcon->regs, SUN4I_TCON1_CTL_REG,
-				   SUN4I_TCON1_CTL_TCON_ENABLE,
-				   SUN4I_TCON1_CTL_TCON_ENABLE);
-		clk_prepare_enable(tcon->sclk1);
+		return;
 	}
+
+	WARN_ON(!tcon->has_channel_1);
+	regmap_update_bits(tcon->regs, SUN4I_TCON1_CTL_REG,
+			   SUN4I_TCON1_CTL_TCON_ENABLE,
+			   SUN4I_TCON1_CTL_TCON_ENABLE);
+	clk_prepare_enable(tcon->sclk1);
 }
 EXPORT_SYMBOL(sun4i_tcon_channel_enable);
 
@@ -198,6 +202,8 @@ void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
 	u8 clk_delay;
 	u32 val;
 
+	WARN_ON(!tcon->has_channel_1);
+
 	/* Adjust clock delay */
 	clk_delay = sun4i_tcon_get_clk_delay(mode, 1);
 	regmap_update_bits(tcon->regs, SUN4I_TCON1_CTL_REG,
@@ -321,10 +327,12 @@ static int sun4i_tcon_init_clocks(struct device *dev,
 		return PTR_ERR(tcon->sclk0);
 	}
 
-	tcon->sclk1 = devm_clk_get(dev, "tcon-ch1");
-	if (IS_ERR(tcon->sclk1)) {
-		dev_err(dev, "Couldn't get the TCON channel 1 clock\n");
-		return PTR_ERR(tcon->sclk1);
+	if (tcon->has_channel_1) {
+		tcon->sclk1 = devm_clk_get(dev, "tcon-ch1");
+		if (IS_ERR(tcon->sclk1)) {
+			dev_err(dev, "Couldn't get the TCON channel 1 clock\n");
+			return PTR_ERR(tcon->sclk1);
+		}
 	}
 
 	return sun4i_dclk_create(dev, tcon);
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index 100bfa093277..12bd48925f4d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -164,6 +164,8 @@ struct sun4i_tcon {
 	bool				has_mux;
 
 	struct drm_panel		*panel;
+
+	bool				has_channel_1;
 };
 
 struct drm_bridge *sun4i_tcon_find_bridge(struct device_node *node);
-- 
2.9.2
