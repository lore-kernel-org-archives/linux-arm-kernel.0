From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  1 Sep 2017 11:36:35 +0200
Subject: [PATCH 5/7 v2] drm/pl111: Insert delay before powering up PL11x
In-Reply-To: <20170901093637.4041-1-linus.walleij@linaro.org>
References: <20170901093637.4041-1-linus.walleij@linaro.org>
Message-ID: <20170901093637.4041-6-linus.walleij@linaro.org>
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

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Fall back to the delay of 20 ms from the old framebuffer
  driver to stabilize Vee in shortage of other alternatives.
---
 drivers/gpu/drm/pl111/pl111_display.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
index 51e3530c876c..3ed451ca2744 100644
--- a/drivers/gpu/drm/pl111/pl111_display.c
+++ b/drivers/gpu/drm/pl111/pl111_display.c
@@ -154,8 +154,8 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 
 	writel(0, priv->regs + CLCD_TIM3);
 
-	/* Enable and Power Up */
-	cntl = CNTL_LCDEN | CNTL_LCDTFT | CNTL_LCDPWR | CNTL_LCDVCOMP(1);
+	/* Hard-code TFT panel */
+	cntl = CNTL_LCDEN | CNTL_LCDTFT | CNTL_LCDVCOMP(1);
 
 	/* Note that the the hardware's format reader takes 'r' from
 	 * the low bit, while DRM formats list channels from high bit
@@ -198,6 +198,17 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 		break;
 	}
 
+	/* Power sequence: first enable and chill */
+	writel(cntl, priv->regs + priv->ctrl);
+
+	/*
+	 * We expect this delay to stabilize the contrast
+	 * voltage Vee as stipulated by the manual
+	 */
+	msleep(20);
+
+	/* Power Up */
+	cntl |= CNTL_LCDPWR;
 	writel(cntl, priv->regs + priv->ctrl);
 
 	drm_crtc_vblank_on(crtc);
@@ -208,10 +219,24 @@ void pl111_display_disable(struct drm_simple_display_pipe *pipe)
 	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_device *drm = crtc->dev;
 	struct pl111_drm_dev_private *priv = drm->dev_private;
+	u32 cntl;
 
 	drm_crtc_vblank_off(crtc);
 
-	/* Disable and Power Down */
+	/* Power Down */
+	cntl = readl(priv->regs + priv->ctrl);
+	if (cntl & CNTL_LCDPWR) {
+		cntl &= ~CNTL_LCDPWR;
+		writel(cntl, priv->regs + priv->ctrl);
+	}
+
+	/*
+	 * We expect this delay to stabilize the contrast voltage Vee as
+	 * stipulated by the manual
+	 */
+	msleep(20);
+
+	/* Disable */
 	writel(0, priv->regs + priv->ctrl);
 
 	clk_disable_unprepare(priv->clk);
-- 
2.13.5
