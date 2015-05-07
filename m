From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 07 May 2015 09:04:44 +0900
Subject: [RFT PATCH v2 1/3] drm/exynos: Fix build breakage on !DRM_EXYNOS_FIMD
In-Reply-To: <1430957086-25005-1-git-send-email-k.kozlowski@samsung.com>
References: <1430957086-25005-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1430957086-25005-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

Disabling the CONFIG_DRM_EXYNOS_FIMD (e.g. by enabling of CONFIG_FB_S3C)
leads to build error:

drivers/built-in.o: In function `exynos_dp_dpms':
binder.c:(.text+0xd6a840): undefined reference to `fimd_dp_clock_enable'
binder.c:(.text+0xd6ab54): undefined reference to `fimd_dp_clock_enable'

Fix this by changing direct call to fimd_dp_clock_enable() into optional
call to exynos_drm_crtc_ops->clock_enable(). Only the DRM_EXYNOS_FIMD
implements this op.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

---
Changes since v1:
1. Rewrite the idea into exynos_drm_crtc_ops after discussion with Inki
   Dae.
---
 drivers/gpu/drm/exynos/exynos_dp_core.c  | 11 +++++++---
 drivers/gpu/drm/exynos/exynos_drm_drv.h  |  5 +++++
 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 37 ++++++++++++++++----------------
 drivers/gpu/drm/exynos/exynos_drm_fimd.h | 15 -------------
 4 files changed, 31 insertions(+), 37 deletions(-)
 delete mode 100644 drivers/gpu/drm/exynos/exynos_drm_fimd.h

diff --git a/drivers/gpu/drm/exynos/exynos_dp_core.c b/drivers/gpu/drm/exynos/exynos_dp_core.c
index 1dbfba58f909..441ef06b8894 100644
--- a/drivers/gpu/drm/exynos/exynos_dp_core.c
+++ b/drivers/gpu/drm/exynos/exynos_dp_core.c
@@ -32,7 +32,6 @@
 #include <drm/bridge/ptn3460.h>
 
 #include "exynos_dp_core.h"
-#include "exynos_drm_fimd.h"
 
 #define ctx_from_connector(c)	container_of(c, struct exynos_dp_device, \
 					connector)
@@ -1066,6 +1065,8 @@ static void exynos_dp_phy_exit(struct exynos_dp_device *dp)
 
 static void exynos_dp_poweron(struct exynos_dp_device *dp)
 {
+	struct exynos_drm_crtc *crtc = dp_to_crtc(dp);
+
 	if (dp->dpms_mode == DRM_MODE_DPMS_ON)
 		return;
 
@@ -1076,7 +1077,8 @@ static void exynos_dp_poweron(struct exynos_dp_device *dp)
 		}
 	}
 
-	fimd_dp_clock_enable(dp_to_crtc(dp), true);
+	if (crtc->ops->clock_enable)
+		crtc->ops->clock_enable(dp_to_crtc(dp), true);
 
 	clk_prepare_enable(dp->clock);
 	exynos_dp_phy_init(dp);
@@ -1087,6 +1089,8 @@ static void exynos_dp_poweron(struct exynos_dp_device *dp)
 
 static void exynos_dp_poweroff(struct exynos_dp_device *dp)
 {
+	struct exynos_drm_crtc *crtc = dp_to_crtc(dp);
+
 	if (dp->dpms_mode != DRM_MODE_DPMS_ON)
 		return;
 
@@ -1102,7 +1106,8 @@ static void exynos_dp_poweroff(struct exynos_dp_device *dp)
 	exynos_dp_phy_exit(dp);
 	clk_disable_unprepare(dp->clock);
 
-	fimd_dp_clock_enable(dp_to_crtc(dp), false);
+	if (crtc->ops->clock_enable)
+		crtc->ops->clock_enable(dp_to_crtc(dp), false);
 
 	if (dp->panel) {
 		if (drm_panel_unprepare(dp->panel))
diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.h b/drivers/gpu/drm/exynos/exynos_drm_drv.h
index e12ecb5d5d9a..44f128a03aea 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.h
@@ -181,6 +181,10 @@ struct exynos_drm_display {
  * @win_disable: disable hardware specific overlay.
  * @te_handler: trigger to transfer video image at the tearing effect
  *	synchronization signal if there is a page flip request.
+ * @clock_enable: optional function enabling/disabling display domain clock,
+ *	called from exynos-dp driver before powering up (with
+ *	'enable' argument as true) and after powering down (with
+ *	'enable' as false).
  */
 struct exynos_drm_crtc;
 struct exynos_drm_crtc_ops {
@@ -195,6 +199,7 @@ struct exynos_drm_crtc_ops {
 	void (*win_commit)(struct exynos_drm_crtc *crtc, unsigned int zpos);
 	void (*win_disable)(struct exynos_drm_crtc *crtc, unsigned int zpos);
 	void (*te_handler)(struct exynos_drm_crtc *crtc);
+	void (*clock_enable)(struct exynos_drm_crtc *crtc, bool enable);
 };
 
 /*
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index 9819fa6a9e2a..2fb95ccb5841 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -33,7 +33,6 @@
 #include "exynos_drm_crtc.h"
 #include "exynos_drm_plane.h"
 #include "exynos_drm_iommu.h"
-#include "exynos_drm_fimd.h"
 
 /*
  * FIMD stands for Fully Interactive Mobile Display and
@@ -946,6 +945,23 @@ static void fimd_te_handler(struct exynos_drm_crtc *crtc)
 		drm_handle_vblank(ctx->drm_dev, ctx->pipe);
 }
 
+static void fimd_dp_clock_enable(struct exynos_drm_crtc *crtc, bool enable)
+{
+	struct fimd_context *ctx = crtc->ctx;
+	u32 val;
+
+	/*
+	 * Only Exynos 5250, 5260, 5410 and 542x requires enabling DP/MIE
+	 * clock. On these SoCs the bootloader may enable it but any
+	 * power domain off/on will reset it to disable state.
+	 */
+	if (ctx->driver_data != &exynos5_fimd_driver_data)
+		return;
+
+	val = enable ? DP_MIE_CLK_DP_ENABLE : DP_MIE_CLK_DISABLE;
+	writel(DP_MIE_CLK_DP_ENABLE, ctx->regs + DP_MIE_CLKCON);
+}
+
 static struct exynos_drm_crtc_ops fimd_crtc_ops = {
 	.dpms = fimd_dpms,
 	.mode_fixup = fimd_mode_fixup,
@@ -956,6 +972,7 @@ static struct exynos_drm_crtc_ops fimd_crtc_ops = {
 	.win_commit = fimd_win_commit,
 	.win_disable = fimd_win_disable,
 	.te_handler = fimd_te_handler,
+	.clock_enable = fimd_dp_clock_enable,
 };
 
 static irqreturn_t fimd_irq_handler(int irq, void *dev_id)
@@ -1192,24 +1209,6 @@ static int fimd_remove(struct platform_device *pdev)
 	return 0;
 }
 
-void fimd_dp_clock_enable(struct exynos_drm_crtc *crtc, bool enable)
-{
-	struct fimd_context *ctx = crtc->ctx;
-	u32 val;
-
-	/*
-	 * Only Exynos 5250, 5260, 5410 and 542x requires enabling DP/MIE
-	 * clock. On these SoCs the bootloader may enable it but any
-	 * power domain off/on will reset it to disable state.
-	 */
-	if (ctx->driver_data != &exynos5_fimd_driver_data)
-		return;
-
-	val = enable ? DP_MIE_CLK_DP_ENABLE : DP_MIE_CLK_DISABLE;
-	writel(DP_MIE_CLK_DP_ENABLE, ctx->regs + DP_MIE_CLKCON);
-}
-EXPORT_SYMBOL_GPL(fimd_dp_clock_enable);
-
 struct platform_driver fimd_driver = {
 	.probe		= fimd_probe,
 	.remove		= fimd_remove,
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.h b/drivers/gpu/drm/exynos/exynos_drm_fimd.h
deleted file mode 100644
index b4fcaa568456..000000000000
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/*
- * Copyright (c) 2015 Samsung Electronics Co., Ltd.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#ifndef _EXYNOS_DRM_FIMD_H_
-#define _EXYNOS_DRM_FIMD_H_
-
-extern void fimd_dp_clock_enable(struct exynos_drm_crtc *crtc, bool enable);
-
-#endif /* _EXYNOS_DRM_FIMD_H_ */
-- 
2.1.4
