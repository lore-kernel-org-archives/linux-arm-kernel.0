From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 21 Dec 2017 12:02:31 +0100
Subject: [PATCH v5 05/12] drm/sun4i: Force the mixer rate at 150MHz
In-Reply-To: <cover.e5a47cc96ec5274dd932daa2bde47df073087da9.1513854122.git-series.maxime.ripard@free-electrons.com>
References: <cover.e5a47cc96ec5274dd932daa2bde47df073087da9.1513854122.git-series.maxime.ripard@free-electrons.com>
Message-ID: <f5f05307972ed05250e8094b302d68b9e7e167f6.1513854122.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It seems like the mixer can only run properly when clocked at 150MHz. In
order to have something more robust than simply a fire-and-forget
assigned-clocks-rate, let's put that in the code.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 10 ++++++++++
 drivers/gpu/drm/sun4i/sun8i_mixer.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 29ceeb016d72..3a610a87cbd2 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -398,6 +398,15 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
 		ret = PTR_ERR(mixer->mod_clk);
 		goto err_disable_bus_clk;
 	}
+
+	/*
+	 * It seems that we need to enforce that rate for whatever
+	 * reason for the mixer to be functional. Make sure it's the
+	 * case.
+	 */
+	if (mixer->cfg->mod_rate)
+		clk_set_rate(mixer->mod_clk, mixer->cfg->mod_rate);
+
 	clk_prepare_enable(mixer->mod_clk);
 
 	list_add_tail(&mixer->engine.list, &drv->engine_list);
@@ -474,6 +483,7 @@ static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
 	.ui_num = 1,
 	.scaler_mask = 0x3,
 	.ccsc = 0,
+	.mod_rate = 150000000,
 };
 
 static const struct of_device_id sun8i_mixer_of_table[] = {
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index bc58040a88f9..f34e70c42adf 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -121,12 +121,15 @@ struct de2_fmt_info {
  *	Set value to 0 if this is first mixer or second mixer with VEP support.
  *	Set value to 1 if this is second mixer without VEP support. Other values
  *	are invalid.
+ * @mod_rate: module clock rate that needs to be set in order to have
+ *	a functional block.
  */
 struct sun8i_mixer_cfg {
 	int		vi_num;
 	int		ui_num;
 	int		scaler_mask;
 	int		ccsc;
+	unsigned long	mod_rate;
 };
 
 struct sun8i_mixer {
-- 
git-series 0.9.1
