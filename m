From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 17 May 2013 08:38:03 +0200
Subject: [PATCH] drm/i2c: nxp-tda998x: fix abort of some i2c exchanges
Message-ID: <20130517083803.5f34816e@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The signals SIGALRM (most often) and SIGPOLL (sometimes) may be raised
after irq or some parameter change and this aborts the i2c exchanges.

The problem is solved by masking these signals.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c |   40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index e68b58a..672d045 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -262,6 +262,28 @@ struct tda998x_priv {
 #define TDA19989N2                0x0202
 #define TDA19988                  0x0301
 
+/*
+ * the signals SIGALRM (most often) and SIGPOLL (sometimes)
+ *	may be raised after irq or some parameter change
+ *	and this aborts the i2c exchanges
+ * the problem is solved by masking these signals
+ */
+static void savesig(sigset_t *p_oldset)
+{
+	sigset_t newset;
+
+	sigemptyset(&newset);
+	sigaddset(&newset, SIGALRM);
+	sigaddset(&newset, SIGPOLL);
+
+	sigprocmask(SIG_BLOCK, &newset, p_oldset);
+
+}
+static void restoresig(sigset_t *p_oldset)
+{
+	sigprocmask(SIG_SETMASK, p_oldset, NULL);
+}
+
 static void
 cec_write(struct drm_encoder *encoder, uint16_t addr, uint8_t val)
 {
@@ -426,6 +448,7 @@ static void
 tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
 {
 	struct tda998x_priv *priv = to_tda998x_priv(encoder);
+	sigset_t oldset;
 
 	/* we only care about on or off: */
 	if (mode != DRM_MODE_DPMS_ON)
@@ -434,6 +457,8 @@ tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
 	if (mode == priv->dpms)
 		return;
 
+	savesig(&oldset);
+
 	switch (mode) {
 	case DRM_MODE_DPMS_ON:
 		/* enable audio and video ports */
@@ -458,6 +483,8 @@ tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
 		break;
 	}
 
+	restoresig(&oldset);
+
 	priv->dpms = mode;
 }
 
@@ -494,11 +521,14 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 			struct drm_display_mode *adjusted_mode)
 {
 	struct tda998x_priv *priv = to_tda998x_priv(encoder);
+	sigset_t oldset;
 	uint16_t hs_start, hs_end, line_start, line_end;
 	uint16_t vwin_start, vwin_end, de_start, de_end;
 	uint16_t ref_pix, ref_line, pix_start2;
 	uint8_t reg, div, rep;
 
+	savesig(&oldset);
+
 	hs_start   = mode->hsync_start - mode->hdisplay;
 	hs_end     = mode->hsync_end - mode->hdisplay;
 	line_start = 1;
@@ -613,6 +643,8 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 
 	/* must be last register set: */
 	reg_clear(encoder, REG_TBG_CNTRL_0, TBG_CNTRL_0_SYNC_ONCE);
+
+	restoresig(&oldset);
 }
 
 static enum drm_connector_status
@@ -728,15 +760,21 @@ static int
 tda998x_encoder_get_modes(struct drm_encoder *encoder,
 			 struct drm_connector *connector)
 {
-	struct edid *edid = (struct edid *)do_get_edid(encoder);
+	struct edid *edid;
+	sigset_t oldset;
 	int n = 0;
 
+	savesig(&oldset);
+
+	edid = (struct edid *) do_get_edid(encoder);
 	if (edid) {
 		drm_mode_connector_update_edid_property(connector, edid);
 		n = drm_add_edid_modes(connector, edid);
 		kfree(edid);
 	}
 
+	restoresig(&oldset);
+
 	return n;
 }
 


-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
