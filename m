From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 19 May 2015 15:20:22 +0200
Subject: [PATCH v7 02/25] drm/exynos: fimd: ensure proper hw state in
 fimd_clear_channel()
In-Reply-To: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1432041645-11172-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One should not do any assumptions on the stare of the fimd hardware
during driver initialization, so to properly reset fimd before enabling
IOMMU, one should ensure that all power domains and clocks are really
enabled. This patch adds calls to power on/off in the
fimd_clear_channel() function to ensure that any access to fimd
registers will be performed with clocks and power domains enabled.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index 9819fa6a9e2a..cf64550df59d 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -242,12 +242,20 @@ static void fimd_enable_shadow_channel_path(struct fimd_context *ctx, int win,
 	writel(val, ctx->regs + SHADOWCON);
 }
 
-static void fimd_clear_channel(struct fimd_context *ctx)
+static int fimd_poweron(struct fimd_context *ctx);
+static int fimd_poweroff(struct fimd_context *ctx);
+
+static int fimd_clear_channel(struct fimd_context *ctx)
 {
-	int win, ch_enabled = 0;
+	int ret, win, ch_enabled = 0;
 
 	DRM_DEBUG_KMS("%s\n", __FILE__);
 
+	/* Hardware is in unknown state, so ensure it get enabled properly */
+	ret = fimd_poweron(ctx);
+	if (ret)
+		return ret;
+
 	/* Check if any channel is enabled. */
 	for (win = 0; win < WINDOWS_NR; win++) {
 		u32 val = readl(ctx->regs + WINCON(win));
@@ -258,19 +266,15 @@ static void fimd_clear_channel(struct fimd_context *ctx)
 			if (ctx->driver_data->has_shadowcon)
 				fimd_enable_shadow_channel_path(ctx, win,
 								false);
-
 			ch_enabled = 1;
 		}
 	}
 
 	/* Wait for vsync, as disable channel takes effect at next vsync */
-	if (ch_enabled) {
-		unsigned int state = ctx->suspended;
-
-		ctx->suspended = 0;
+	if (ch_enabled)
 		fimd_wait_for_vblank(ctx->crtc);
-		ctx->suspended = state;
-	}
+
+	return fimd_poweroff(ctx);
 }
 
 static int fimd_iommu_attach_devices(struct fimd_context *ctx,
@@ -285,7 +289,10 @@ static int fimd_iommu_attach_devices(struct fimd_context *ctx,
 		 * If any channel is already active, iommu will throw
 		 * a PAGE FAULT when enabled. So clear any channel if enabled.
 		 */
-		fimd_clear_channel(ctx);
+		ret = fimd_clear_channel(ctx);
+		if (ret)
+			return ret;
+
 		ret = drm_iommu_attach_device(ctx->drm_dev, ctx->dev);
 		if (ret) {
 			DRM_ERROR("drm_iommu_attach failed.\n");
-- 
1.9.2
