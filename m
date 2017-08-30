From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 30 Aug 2017 20:07:09 +0200
Subject: [PATCH 5/7] drm/pl111: Insert delay before powering up PL11x
In-Reply-To: <20170830180711.2791-1-linus.walleij@linaro.org>
References: <20170830180711.2791-1-linus.walleij@linaro.org>
Message-ID: <20170830180711.2791-6-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The old codebase has a delay between enabling and powering up the
PL11x.

According to the manual for PL110, ARM DDI 0161E page 1-5 and
the PL111 manual ARM DDI 0293C page 1-6, the power sequence should
be such that once Vdd is stable (which we assume it is at boot)
LCDEN is enabled first and then CLPOWER should be enabled
"after the signals have stabilized" and this is said to
be display-dependent. The old codebase uses 20ms.

The delay construction in the old code is not to be trusted: it
was likely assuming a certain hard-coded display (such as the
Versatile PROSPECTOR display) and the PL11x blocks are used in
several designs with different displays. Instead rely on the
display driver to provide the proper delay in response to
the drm_panel_prepare() and drm_panel_enable() as well as
the drm_panel_disable() and drm_panel_unprepare() calls,
but make sure to set the LCDEN before these calls and then
CLPOWER after calling them (and the reverse for disabling).

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/pl111/pl111_display.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
index 6447f36c243a..39106068b158 100644
--- a/drivers/gpu/drm/pl111/pl111_display.c
+++ b/drivers/gpu/drm/pl111/pl111_display.c
@@ -157,8 +157,8 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 
 	drm_panel_prepare(priv->panel);
 
-	/* Enable and Power Up */
-	cntl = CNTL_LCDEN | CNTL_LCDTFT | CNTL_LCDPWR | CNTL_LCDVCOMP(1);
+	/* Hard-code TFT panel */
+	cntl = CNTL_LCDEN | CNTL_LCDTFT | CNTL_LCDVCOMP(1);
 
 	/* Note that the the hardware's format reader takes 'r' from
 	 * the low bit, while DRM formats list channels from high bit
@@ -201,10 +201,19 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 		break;
 	}
 
+	/* Power sequence: first enable and chill */
 	writel(cntl, priv->regs + priv->ctrl);
 
+	/*
+	 * We expect these calls to enable and stabilize the contrast
+	 * voltage Vee as stipulated by the manual
+	 */
 	drm_panel_enable(priv->panel);
 
+	/* Power Up */
+	cntl |= CNTL_LCDPWR;
+	writel(cntl, priv->regs + priv->ctrl);
+
 	drm_crtc_vblank_on(crtc);
 }
 
@@ -213,16 +222,27 @@ void pl111_display_disable(struct drm_simple_display_pipe *pipe)
 	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_device *drm = crtc->dev;
 	struct pl111_drm_dev_private *priv = drm->dev_private;
+	u32 cntl;
 
 	drm_crtc_vblank_off(crtc);
 
+	/* Power Down */
+	cntl = readl(priv->regs + priv->ctrl);
+	if (cntl & CNTL_LCDPWR) {
+		cntl &= ~CNTL_LCDPWR;
+		writel(cntl, priv->regs + priv->ctrl);
+	}
+
+	/*
+	 * We expect these calls to disable the contrast voltage Vee as
+	 * stipulated by the manual
+	 */
 	drm_panel_disable(priv->panel);
+	drm_panel_unprepare(priv->panel);
 
-	/* Disable and Power Down */
+	/* Disable */
 	writel(0, priv->regs + priv->ctrl);
 
-	drm_panel_unprepare(priv->panel);
-
 	clk_disable_unprepare(priv->clk);
 }
 
-- 
2.13.5
