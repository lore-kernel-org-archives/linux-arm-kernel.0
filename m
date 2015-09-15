From: kong.kongxinwei@hisilicon.com (Xinwei Kong)
Date: Tue, 15 Sep 2015 17:37:13 +0800
Subject: [PATCH RFC 7/8] drm: hisilicon: Add support for vblank
In-Reply-To: <1442309834-21420-1-git-send-email-kong.kongxinwei@hisilicon.com>
References: <1442309834-21420-1-git-send-email-kong.kongxinwei@hisilicon.com>
Message-ID: <1442309834-21420-8-git-send-email-kong.kongxinwei@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds ldi interrupt to handle vblank.

Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Jiwen Qi <qijiwen@hisilicon.com>
Signed-off-by: Yu Gong <gongyu@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/hisi_ade.c      | 71 +++++++++++++++++++++++-
 drivers/gpu/drm/hisilicon/hisi_drm_crtc.c | 89 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/hisilicon/hisi_drm_crtc.h |  7 +++
 drivers/gpu/drm/hisilicon/hisi_drm_drv.c  |  5 ++
 4 files changed, 170 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hisi_ade.c b/drivers/gpu/drm/hisilicon/hisi_ade.c
index 2ea3f8f..44480c2 100644
--- a/drivers/gpu/drm/hisilicon/hisi_ade.c
+++ b/drivers/gpu/drm/hisilicon/hisi_ade.c
@@ -156,11 +156,12 @@ static void ade_display_commit(struct ade_crtc *acrtc)
 	/* set reset mode:soft or hw, and reload modules */
 	ade_set_reset_and_reload(acrtc);
 
-	/* enable ade */
+	/* ade enabled */
 	wmb();
 	writel(ADE_ENABLE, base + ADE_EN);
 
-	wmb(); /* memory barrier */
+	/* ldi enabled after ade */
+	wmb();
 	val = ADE_ENABLE;
 	val |= readl(base + LDI_CTRL);
 	writel(val, base + LDI_CTRL);
@@ -596,6 +597,63 @@ int ade_install_plane_properties(struct drm_device *dev,
 	return 0;
 }
 
+int ade_enable_vblank(struct hisi_crtc *hcrtc)
+{
+	struct ade_hardware_context *ctx = hcrtc->ctx;
+	void __iomem *base = ctx->base;
+	u32 intr_en;
+	int ret;
+
+	if (!ctx->power_on) {
+		ret = ade_power_up(ctx);
+		if (ret) {
+			DRM_ERROR("%s: failed to power up ade\n", __func__);
+			return ret;
+		}
+	}
+
+	intr_en = readl(base + LDI_INT_EN);
+	intr_en |= LDI_ISR_FRAME_END_INT;
+	writel(intr_en, base + LDI_INT_EN);
+
+	return 0;
+}
+
+void ade_disable_vblank(struct hisi_crtc *hcrtc)
+{
+	struct ade_hardware_context *ctx = hcrtc->ctx;
+	void __iomem *base = ctx->base;
+	u32 intr_en;
+
+	if (!ctx->power_on) {
+		DRM_ERROR("power is down! vblank disable fail\n");
+		return;
+	}
+
+	intr_en = readl(base + LDI_INT_EN);
+	intr_en &= ~LDI_ISR_FRAME_END_INT;
+	writel(intr_en, base + LDI_INT_EN);
+}
+
+irqreturn_t ade_irq_handler(int irq, struct hisi_crtc *hcrtc)
+{
+	struct ade_hardware_context *ctx = hcrtc->ctx;
+	struct drm_crtc *crtc = &hcrtc->base;
+	struct drm_device *dev = crtc->dev;
+	void __iomem *base = ctx->base;
+	u32 status;
+
+	status = readl(base + LDI_MSK_INT);
+
+	/* vblank irq */
+	if (status & LDI_ISR_FRAME_END_INT) {
+		writel(LDI_ISR_FRAME_END_INT, base + LDI_INT_CLR);
+		drm_handle_vblank(dev, drm_crtc_index(crtc));
+	}
+
+	return IRQ_HANDLED;
+}
+
 /* convert from fourcc format to ade format */
 static u32 ade_get_format(u32 pixel_format)
 {
@@ -1112,6 +1170,9 @@ static struct hisi_crtc_ops ade_crtc_ops = {
 	.mode_set_nofb = ade_crtc_mode_set_nofb,
 	.atomic_begin = ade_crtc_atomic_begin,
 	.atomic_flush = ade_crtc_atomic_flush,
+	.irq_handler = ade_irq_handler,
+	.enable_vblank = ade_enable_vblank,
+	.disable_vblank = ade_disable_vblank,
 	.install_properties = ade_install_crtc_properties,
 };
 
@@ -1226,6 +1287,12 @@ static int ade_bind(struct device *dev, struct device *master, void *data)
 		return ret;
 	}
 
+	/* ldi irq install */
+	ret = hisi_drm_crtc_irq_install(drm_dev, ctx->irq, DRIVER_IRQ_SHARED,
+					hcrtc);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_crtc.c b/drivers/gpu/drm/hisilicon/hisi_drm_crtc.c
index feeadc4..db64c2a 100644
--- a/drivers/gpu/drm/hisilicon/hisi_drm_crtc.c
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_crtc.c
@@ -17,6 +17,95 @@
 #include "hisi_drm_drv.h"
 #include "hisi_drm_crtc.h"
 
+/*
+ * drm_get_crtc_from_index - find a registered CRTC from the index
+ * @dev: DRM device
+ * @index: index of a registered CRTC
+ *
+ * Given a index, return the registered CRTC within a DRM
+ * device's list of CRTCs.
+ */
+struct drm_crtc *hisi_drm_get_crtc_from_index(struct drm_device *dev,
+					      unsigned int index)
+{
+	unsigned int index_tmp = 0;
+	struct drm_crtc *crtc;
+
+	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
+		if (index_tmp == index)
+			return crtc;
+
+		index_tmp++;
+	}
+
+	BUG();
+}
+
+int hisi_drm_crtc_enable_vblank(struct drm_device *dev, int c)
+{
+	struct drm_crtc *crtc = hisi_drm_get_crtc_from_index(dev, c);
+	struct hisi_crtc *hcrtc = to_hisi_crtc(crtc);
+	struct hisi_crtc_ops *ops = hcrtc->ops;
+	int ret = 0;
+
+	if (ops->enable_vblank)
+		ret = ops->enable_vblank(hcrtc);
+
+	return ret;
+}
+
+void hisi_drm_crtc_disable_vblank(struct drm_device *dev, int c)
+{
+	struct drm_crtc *crtc = hisi_drm_get_crtc_from_index(dev, c);
+	struct hisi_crtc *hcrtc = to_hisi_crtc(crtc);
+	struct hisi_crtc_ops *ops = hcrtc->ops;
+
+	if (ops->disable_vblank)
+		ops->disable_vblank(hcrtc);
+}
+
+irqreturn_t hisi_drm_crtc_irq_handler(int irq, void *arg)
+{
+	struct hisi_crtc *hcrtc = (struct hisi_crtc *)arg;
+	struct hisi_crtc_ops *ops = hcrtc->ops;
+	irqreturn_t ret = IRQ_HANDLED;
+
+	if (ops->irq_handler)
+		ret = ops->irq_handler(irq, hcrtc);
+
+	return ret;
+}
+
+int hisi_drm_crtc_irq_install(struct drm_device *dev, int irq,
+			      unsigned long flags, void *data)
+{
+	int ret;
+
+	if (!drm_core_check_feature(dev, DRIVER_HAVE_IRQ))
+		return -EINVAL;
+
+	if (irq == 0)
+		return -EINVAL;
+
+	/* Driver must have been initialized */
+	if (!dev->dev_private)
+		return -EINVAL;
+
+	if (dev->irq_enabled)
+		return -EBUSY;
+	dev->irq_enabled = true;
+
+	ret = request_irq(irq, hisi_drm_crtc_irq_handler,
+			  flags, dev->driver->name, data);
+
+	if (ret < 0) {
+		dev->irq_enabled = false;
+		return ret;
+	}
+
+	return 0;
+}
+
 static void  hisi_drm_crtc_enable(struct drm_crtc *crtc)
 {
 	struct hisi_crtc *hcrtc = to_hisi_crtc(crtc);
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_crtc.h b/drivers/gpu/drm/hisilicon/hisi_drm_crtc.h
index 6521ed8..f29fe76 100644
--- a/drivers/gpu/drm/hisilicon/hisi_drm_crtc.h
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_crtc.h
@@ -42,6 +42,9 @@ struct hisi_crtc_ops {
 	void (*atomic_begin)(struct hisi_crtc *hcrtc);
 	void (*atomic_flush)(struct hisi_crtc *hcrtc);
 	void (*destroy)(struct hisi_crtc *hcrtc);
+	int  (*enable_vblank)(struct hisi_crtc *hcrtc);
+	void (*disable_vblank)(struct hisi_crtc *hcrtc);
+	irqreturn_t (*irq_handler)(int irq, struct hisi_crtc *hcrtc);
 	int (*install_properties)(struct drm_device *dev,
 				  struct hisi_crtc *hcrtc);
 };
@@ -53,5 +56,9 @@ struct hisi_crtc_state {
 
 int hisi_drm_crtc_init(struct drm_device *dev, struct hisi_crtc *crtc,
 		       struct drm_plane *plane);
+int hisi_drm_crtc_enable_vblank(struct drm_device *dev, int c);
+void hisi_drm_crtc_disable_vblank(struct drm_device *dev, int c);
+int hisi_drm_crtc_irq_install(struct drm_device *dev, int irq,
+			      unsigned long flags, void *data);
 
 #endif
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_drv.c b/drivers/gpu/drm/hisilicon/hisi_drm_drv.c
index 53f2521..4ff2693 100644
--- a/drivers/gpu/drm/hisilicon/hisi_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_drv.c
@@ -18,6 +18,7 @@
 #include <drm/drm_gem_cma_helper.h>
 
 #include "hisi_drm_drv.h"
+#include "hisi_drm_crtc.h"
 #include "hisi_drm_fb.h"
 
 #define DRIVER_NAME	"hisi-drm"
@@ -130,6 +131,10 @@ static struct drm_driver hisi_drm_driver = {
 	.gem_prime_vunmap	= drm_gem_cma_prime_vunmap,
 	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
 
+	.get_vblank_counter	= drm_vblank_count,
+	.enable_vblank		= hisi_drm_crtc_enable_vblank,
+	.disable_vblank		= hisi_drm_crtc_disable_vblank,
+
 	.name			= "hisi",
 	.desc			= "Hisilicon Terminal SoCs DRM Driver",
 	.date			= "20150830",
-- 
1.9.1
