From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Tue, 12 Jun 2018 22:00:20 +0200
Subject: [PATCH v2 11/27] drm/sun4i: tcon: Add support for tcon-top gate
In-Reply-To: <20180612200036.21483-1-jernej.skrabec@siol.net>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
Message-ID: <20180612200036.21483-12-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TV TCONs connected to TCON TOP have to enable additional gate in order
to work.

Add support for such TCONs.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 11 +++++++++++
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 08747fc3ee71..0afb5a94a414 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -688,6 +688,16 @@ static int sun4i_tcon_init_clocks(struct device *dev,
 		dev_err(dev, "Couldn't get the TCON bus clock\n");
 		return PTR_ERR(tcon->clk);
 	}
+
+	if (tcon->quirks->has_tcon_top_gate) {
+		tcon->top_clk = devm_clk_get(dev, "tcon-top");
+		if (IS_ERR(tcon->top_clk)) {
+			dev_err(dev, "Couldn't get the TCON TOP bus clock\n");
+			return PTR_ERR(tcon->top_clk);
+		}
+		clk_prepare_enable(tcon->top_clk);
+	}
+
 	clk_prepare_enable(tcon->clk);
 
 	if (tcon->quirks->has_channel_0) {
@@ -712,6 +722,7 @@ static int sun4i_tcon_init_clocks(struct device *dev,
 static void sun4i_tcon_free_clocks(struct sun4i_tcon *tcon)
 {
 	clk_disable_unprepare(tcon->clk);
+	clk_disable_unprepare(tcon->top_clk);
 }
 
 static int sun4i_tcon_init_irq(struct device *dev,
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index f6a071cd5a6f..652d5c37d7b4 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -224,6 +224,7 @@ struct sun4i_tcon_quirks {
 	bool	needs_de_be_mux; /* sun6i needs mux to select backend */
 	bool    needs_edp_reset; /* a80 edp reset needed for tcon0 access */
 	bool	supports_lvds;   /* Does the TCON support an LVDS output? */
+	bool	has_tcon_top_gate;  /* TCON TOP holds additional gate to enable */
 
 	/* callback to handle tcon muxing options */
 	int	(*set_mux)(struct sun4i_tcon *, const struct drm_encoder *);
@@ -249,6 +250,9 @@ struct sun4i_tcon {
 	u8				dclk_max_div;
 	u8				dclk_min_div;
 
+	/* TCON TOP clock */
+	struct clk			*top_clk;
+
 	/* Reset control */
 	struct reset_control		*lcd_rst;
 	struct reset_control		*lvds_rst;
-- 
2.17.1
