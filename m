From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Wed, 17 Jan 2018 21:14:16 +0100
Subject: [PATCH v3 07/12] drm/sun4i: Add has_channel_0 TCON quirk
In-Reply-To: <20180117201421.25954-1-jernej.skrabec@siol.net>
References: <20180117201421.25954-1-jernej.skrabec@siol.net>
Message-ID: <20180117201421.25954-8-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some TCONs on newer SoCs doesn't support channel 0, since they are meant
to be used only with TV or HDMI encoder.

Prepare support for them with adding has_channel_0 quirk.

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 41 +++++++++++++++++++++++++++-----------
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  1 +
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index b78fed809992..0815c528d08e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -84,6 +84,7 @@ static void sun4i_tcon_channel_set_status(struct sun4i_tcon *tcon, int channel,
 
 	switch (channel) {
 	case 0:
+		WARN_ON(!tcon->quirks->has_channel_0);
 		regmap_update_bits(tcon->regs, SUN4I_TCON0_CTL_REG,
 				   SUN4I_TCON0_CTL_TCON_ENABLE,
 				   enabled ? SUN4I_TCON0_CTL_TCON_ENABLE : 0);
@@ -276,6 +277,8 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_tcon *tcon,
 	u8 clk_delay;
 	u32 reg, val = 0;
 
+	WARN_ON(!tcon->quirks->has_channel_0);
+
 	tcon->dclk_min_div = 7;
 	tcon->dclk_max_div = 7;
 	sun4i_tcon0_mode_set_common(tcon, mode);
@@ -344,6 +347,8 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 	u8 clk_delay;
 	u32 val = 0;
 
+	WARN_ON(!tcon->quirks->has_channel_0);
+
 	tcon->dclk_min_div = 6;
 	tcon->dclk_max_div = 127;
 	sun4i_tcon0_mode_set_common(tcon, mode);
@@ -570,10 +575,12 @@ static int sun4i_tcon_init_clocks(struct device *dev,
 	}
 	clk_prepare_enable(tcon->clk);
 
-	tcon->sclk0 = devm_clk_get(dev, "tcon-ch0");
-	if (IS_ERR(tcon->sclk0)) {
-		dev_err(dev, "Couldn't get the TCON channel 0 clock\n");
-		return PTR_ERR(tcon->sclk0);
+	if (tcon->quirks->has_channel_0) {
+		tcon->sclk0 = devm_clk_get(dev, "tcon-ch0");
+		if (IS_ERR(tcon->sclk0)) {
+			dev_err(dev, "Couldn't get the TCON channel 0 clock\n");
+			return PTR_ERR(tcon->sclk0);
+		}
 	}
 
 	if (tcon->quirks->has_channel_1) {
@@ -930,10 +937,12 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 		goto err_free_clocks;
 	}
 
-	ret = sun4i_dclk_create(dev, tcon);
-	if (ret) {
-		dev_err(dev, "Couldn't create our TCON dot clock\n");
-		goto err_free_clocks;
+	if (tcon->quirks->has_channel_0) {
+		ret = sun4i_dclk_create(dev, tcon);
+		if (ret) {
+			dev_err(dev, "Couldn't create our TCON dot clock\n");
+			goto err_free_clocks;
+		}
 	}
 
 	ret = sun4i_tcon_init_irq(dev, tcon);
@@ -991,7 +1000,8 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 	return 0;
 
 err_free_dotclock:
-	sun4i_dclk_free(tcon);
+	if (tcon->quirks->has_channel_0)
+		sun4i_dclk_free(tcon);
 err_free_clocks:
 	sun4i_tcon_free_clocks(tcon);
 err_assert_reset:
@@ -1005,7 +1015,8 @@ static void sun4i_tcon_unbind(struct device *dev, struct device *master,
 	struct sun4i_tcon *tcon = dev_get_drvdata(dev);
 
 	list_del(&tcon->list);
-	sun4i_dclk_free(tcon);
+	if (tcon->quirks->has_channel_0)
+		sun4i_dclk_free(tcon);
 	sun4i_tcon_free_clocks(tcon);
 }
 
@@ -1102,16 +1113,19 @@ static int sun6i_tcon_set_mux(struct sun4i_tcon *tcon,
 }
 
 static const struct sun4i_tcon_quirks sun4i_a10_quirks = {
+	.has_channel_0		= true,
 	.has_channel_1		= true,
 	.set_mux		= sun4i_a10_tcon_set_mux,
 };
 
 static const struct sun4i_tcon_quirks sun5i_a13_quirks = {
+	.has_channel_0		= true,
 	.has_channel_1		= true,
 	.set_mux		= sun5i_a13_tcon_set_mux,
 };
 
 static const struct sun4i_tcon_quirks sun6i_a31_quirks = {
+	.has_channel_0		= true,
 	.has_channel_1		= true,
 	.has_lvds_alt		= true,
 	.needs_de_be_mux	= true,
@@ -1119,26 +1133,29 @@ static const struct sun4i_tcon_quirks sun6i_a31_quirks = {
 };
 
 static const struct sun4i_tcon_quirks sun6i_a31s_quirks = {
+	.has_channel_0		= true,
 	.has_channel_1		= true,
 	.needs_de_be_mux	= true,
 };
 
 static const struct sun4i_tcon_quirks sun7i_a20_quirks = {
+	.has_channel_0		= true,
 	.has_channel_1		= true,
 	/* Same display pipeline structure as A10 */
 	.set_mux		= sun4i_a10_tcon_set_mux,
 };
 
 static const struct sun4i_tcon_quirks sun8i_a33_quirks = {
+	.has_channel_0		= true,
 	.has_lvds_alt		= true,
 };
 
 static const struct sun4i_tcon_quirks sun8i_a83t_lcd_quirks = {
-	/* nothing is supported */
+	.has_channel_0		= true,
 };
 
 static const struct sun4i_tcon_quirks sun8i_v3s_quirks = {
-	/* nothing is supported */
+	.has_channel_0		= true,
 };
 
 /* sun4i_drv uses this list to check if a device node is a TCON */
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index b761c7b823c5..78d55e7cd2b3 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -172,6 +172,7 @@
 struct sun4i_tcon;
 
 struct sun4i_tcon_quirks {
+	bool	has_channel_0;	/* a83t does not have channel 0 on second TCON */
 	bool	has_channel_1;	/* a33 does not have channel 1 */
 	bool	has_lvds_alt;	/* Does the LVDS clock have a parent other than the TCON clock? */
 	bool	needs_de_be_mux; /* sun6i needs mux to select backend */
-- 
2.15.1
