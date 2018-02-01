From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  1 Feb 2018 13:55:10 +0100
Subject: [PATCH 2/5 v2] drm/pl111: Handle the Versatile RGB/BGR565 mode
In-Reply-To: <20180201125513.5482-1-linus.walleij@linaro.org>
References: <20180201125513.5482-1-linus.walleij@linaro.org>
Message-ID: <20180201125513.5482-3-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM Versatile series can do RGB/BGR565 with an external
"PLD" (Programmable Logical Device). However the CLCD does not
have control bits for this, so it needs to be set into the
ordinary 16BPP mode, then the RGB/BGR565 handling of the pixel
data is handled by configuring the PLD through the external
register.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rebase on earlier changes.
---
 drivers/gpu/drm/pl111/pl111_display.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
index 7fe4040aea46..55ada00ec974 100644
--- a/drivers/gpu/drm/pl111/pl111_display.c
+++ b/drivers/gpu/drm/pl111/pl111_display.c
@@ -199,10 +199,17 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 		cntl |= CNTL_LCDBPP24 | CNTL_BGR;
 		break;
 	case DRM_FORMAT_BGR565:
-		cntl |= CNTL_LCDBPP16_565;
+		if (priv->variant->is_pl110)
+			cntl |= CNTL_LCDBPP16;
+		else
+			cntl |= CNTL_LCDBPP16_565;
 		break;
 	case DRM_FORMAT_RGB565:
-		cntl |= CNTL_LCDBPP16_565 | CNTL_BGR;
+		if (priv->variant->is_pl110)
+			cntl |= CNTL_LCDBPP16;
+		else
+			cntl |= CNTL_LCDBPP16_565;
+		cntl |= CNTL_BGR;
 		break;
 	case DRM_FORMAT_ABGR1555:
 	case DRM_FORMAT_XBGR1555:
@@ -226,6 +233,10 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 		break;
 	}
 
+	/* The PL110 in Integrator/Versatile does the BGR routing externally */
+	if (priv->variant->external_bgr)
+		cntl &= ~CNTL_BGR;
+
 	/* Power sequence: first enable and chill */
 	writel(cntl, priv->regs + priv->ctrl);
 
-- 
2.14.3
