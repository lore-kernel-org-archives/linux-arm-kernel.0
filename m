From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 30 Aug 2017 20:07:10 +0200
Subject: [PATCH 6/7] drm/pl111: Add optional variant display en/disable
 callbacks
In-Reply-To: <20170830180711.2791-1-linus.walleij@linaro.org>
References: <20170830180711.2791-1-linus.walleij@linaro.org>
Message-ID: <20170830180711.2791-7-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The silcon and components around the PL111 may require some
variants to perform special set-up of the display. Add two
callbacks to manage this.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/pl111/pl111_display.c | 7 +++++++
 drivers/gpu/drm/pl111/pl111_drm.h     | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
index 39106068b158..37f409867934 100644
--- a/drivers/gpu/drm/pl111/pl111_display.c
+++ b/drivers/gpu/drm/pl111/pl111_display.c
@@ -208,6 +208,9 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 	 * We expect these calls to enable and stabilize the contrast
 	 * voltage Vee as stipulated by the manual
 	 */
+	if (priv->variant_display_enable)
+		priv->variant_display_enable(drm, fb->format->format);
+
 	drm_panel_enable(priv->panel);
 
 	/* Power Up */
@@ -238,6 +241,10 @@ void pl111_display_disable(struct drm_simple_display_pipe *pipe)
 	 * stipulated by the manual
 	 */
 	drm_panel_disable(priv->panel);
+
+	if (priv->variant_display_disable)
+		priv->variant_display_disable(drm);
+
 	drm_panel_unprepare(priv->panel);
 
 	/* Disable */
diff --git a/drivers/gpu/drm/pl111/pl111_drm.h b/drivers/gpu/drm/pl111/pl111_drm.h
index b316a8a0fbc0..a5368d36e9f5 100644
--- a/drivers/gpu/drm/pl111/pl111_drm.h
+++ b/drivers/gpu/drm/pl111/pl111_drm.h
@@ -26,6 +26,7 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_bridge.h>
 #include <linux/clk-provider.h>
+#include <linux/interrupt.h>
 
 #define CLCD_IRQ_NEXTBASE_UPDATE BIT(2)
 
@@ -67,6 +68,8 @@ struct pl111_drm_dev_private {
 	 */
 	spinlock_t tim2_lock;
 	struct pl111_variant_data *variant;
+	void (*variant_display_enable) (struct drm_device *drm, u32 format);
+	void (*variant_display_disable) (struct drm_device *drm);
 };
 
 int pl111_display_init(struct drm_device *dev);
-- 
2.13.5
