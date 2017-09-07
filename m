From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  7 Sep 2017 14:49:24 +0200
Subject: [PATCH 6/7 v3] drm/pl111: Add optional variant display en/disable
 callbacks
In-Reply-To: <20170907124925.13805-1-linus.walleij@linaro.org>
References: <20170907124925.13805-1-linus.walleij@linaro.org>
Message-ID: <20170907124925.13805-6-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The silcon and components around the PL111 may require some
variants to perform special set-up of the display. Add two
callbacks to manage this.

Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Rebase on DRM-TIP
ChangeLog v1->v2:
- Rebase on other display driver changes.
---
 drivers/gpu/drm/pl111/pl111_display.c | 6 ++++++
 drivers/gpu/drm/pl111/pl111_drm.h     | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
index b7df9f5df881..68847a074331 100644
--- a/drivers/gpu/drm/pl111/pl111_display.c
+++ b/drivers/gpu/drm/pl111/pl111_display.c
@@ -208,6 +208,9 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 	 */
 	msleep(20);
 
+	if (priv->variant_display_enable)
+		priv->variant_display_enable(drm, fb->format->format);
+
 	/* Power Up */
 	cntl |= CNTL_LCDPWR;
 	writel(cntl, priv->regs + priv->ctrl);
@@ -237,6 +240,9 @@ void pl111_display_disable(struct drm_simple_display_pipe *pipe)
 	 */
 	msleep(20);
 
+	if (priv->variant_display_disable)
+		priv->variant_display_disable(drm);
+
 	/* Disable */
 	writel(0, priv->regs + priv->ctrl);
 
diff --git a/drivers/gpu/drm/pl111/pl111_drm.h b/drivers/gpu/drm/pl111/pl111_drm.h
index b380a7b4fb58..440f53ebee8c 100644
--- a/drivers/gpu/drm/pl111/pl111_drm.h
+++ b/drivers/gpu/drm/pl111/pl111_drm.h
@@ -26,6 +26,7 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_bridge.h>
 #include <linux/clk-provider.h>
+#include <linux/interrupt.h>
 
 #define CLCD_IRQ_NEXTBASE_UPDATE BIT(2)
 
@@ -66,6 +67,8 @@ struct pl111_drm_dev_private {
 	 */
 	spinlock_t tim2_lock;
 	const struct pl111_variant_data *variant;
+	void (*variant_display_enable) (struct drm_device *drm, u32 format);
+	void (*variant_display_disable) (struct drm_device *drm);
 };
 
 int pl111_display_init(struct drm_device *dev);
-- 
2.13.5
