From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  5 Dec 2017 16:10:18 +0100
Subject: [PATCH v3 06/15] drm/sun4i: Force the mixer rate at 150MHz
In-Reply-To: <cover.825a49a4c1c565a548f3de0375e7537e7e8fd3a4.1512486553.git-series.maxime.ripard@free-electrons.com>
References: <cover.825a49a4c1c565a548f3de0375e7537e7e8fd3a4.1512486553.git-series.maxime.ripard@free-electrons.com>
Message-ID: <12a1d9cbd06783e06a29dade490edd299c6aed78.1512486553.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It seems like the mixer can only run properly when clocked at 150MHz. In
order to have something more robust than simply a fire-and-forget
assigned-clocks-rate, let's put that in the code.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c |  9 +++++++++
 drivers/gpu/drm/sun4i/sun8i_mixer.h |  3 +++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 29ceeb016d72..ff235e3228ce 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -400,6 +400,14 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
 	}
 	clk_prepare_enable(mixer->mod_clk);
 
+	/*
+	 * It seems that we need to enforce that rate for whatever
+	 * reason for the mixer to be functional. Make sure it's the
+	 * case.
+	 */
+	if (mixer->cfg->mod_rate)
+		clk_set_rate(mixer->mod_clk, mixer->cfg->mod_rate);
+
 	list_add_tail(&mixer->engine.list, &drv->engine_list);
 
 	/* Reset the registers */
@@ -474,6 +482,7 @@ static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
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
