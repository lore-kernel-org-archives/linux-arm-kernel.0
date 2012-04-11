From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Apr 2012 17:33:46 +0200
Subject: [PATCH 5/7] DRM: add i.MX kms simple driver
In-Reply-To: <1334158428-23735-1-git-send-email-s.hauer@pengutronix.de>
References: <1334158428-23735-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1334158428-23735-6-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a sdrm driver for the Freescale i.MX LCDC controller. It
is found on i.MX1, i.MX21, i.MX25 and i.MX27. Currently only the
base framebuffer is supported, no overlay. This has been tested
on an i.MX27 custom board with the xf86 modesetting driver.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/imxfb.h |    8 +-
 drivers/gpu/drm/Kconfig                |    2 +
 drivers/gpu/drm/Makefile               |    1 +
 drivers/gpu/drm/imx/Kconfig            |    8 +
 drivers/gpu/drm/imx/Makefile           |    1 +
 drivers/gpu/drm/imx/imx-lcdc-crtc.c    |  506 ++++++++++++++++++++++++++++++++
 6 files changed, 525 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/imx/Kconfig
 create mode 100644 drivers/gpu/drm/imx/Makefile
 create mode 100644 drivers/gpu/drm/imx/imx-lcdc-crtc.c

diff --git a/arch/arm/plat-mxc/include/mach/imxfb.h b/arch/arm/plat-mxc/include/mach/imxfb.h
index 9de8f06..5d4aa61 100644
--- a/arch/arm/plat-mxc/include/mach/imxfb.h
+++ b/arch/arm/plat-mxc/include/mach/imxfb.h
@@ -80,5 +80,11 @@ struct imx_fb_platform_data {
 	void (*backlight_power)(int);
 };
 
-void set_imx_fb_info(struct imx_fb_platform_data *);
+/* drm platform data */
+struct imx_drm_platform_data {
+	u32 lscr1;
+	u32 pcr;
+	u32 pwmr;
+};
+
 #endif /* ifndef __MACH_IMXFB_H__ */
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 93d9f79..4650d65 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -188,3 +188,5 @@ source "drivers/gpu/drm/gma500/Kconfig"
 source "drivers/gpu/drm/udl/Kconfig"
 
 source "drivers/gpu/drm/sdrm/Kconfig"
+
+source "drivers/gpu/drm/imx/Kconfig"
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 44c5949..b0c283e 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -43,4 +43,5 @@ obj-$(CONFIG_DRM_EXYNOS) +=exynos/
 obj-$(CONFIG_DRM_GMA500) += gma500/
 obj-$(CONFIG_DRM_UDL) += udl/
 obj-$(CONFIG_DRM_SDRM) += sdrm/
+obj-$(CONFIG_DRM_IMX) +=imx/
 obj-y			+= i2c/
diff --git a/drivers/gpu/drm/imx/Kconfig b/drivers/gpu/drm/imx/Kconfig
new file mode 100644
index 0000000..d5ad7ed
--- /dev/null
+++ b/drivers/gpu/drm/imx/Kconfig
@@ -0,0 +1,8 @@
+config DRM_IMX_LCDC
+	tristate "DRM Support for Freescale i.MX1 and i.MX2"
+	depends on DRM && ARCH_MXC
+	select DRM_SDRM
+	select DRM_SDRM_ENCON
+	help
+	  Choose this if you have a i.MX1, i.MX21, i.MX25 or i.MX27 processor.
+
diff --git a/drivers/gpu/drm/imx/Makefile b/drivers/gpu/drm/imx/Makefile
new file mode 100644
index 0000000..cc84f65
--- /dev/null
+++ b/drivers/gpu/drm/imx/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_DRM_IMX_LCDC) += imx-lcdc-crtc.o
diff --git a/drivers/gpu/drm/imx/imx-lcdc-crtc.c b/drivers/gpu/drm/imx/imx-lcdc-crtc.c
new file mode 100644
index 0000000..620b04b
--- /dev/null
+++ b/drivers/gpu/drm/imx/imx-lcdc-crtc.c
@@ -0,0 +1,506 @@
+/*
+ * i.MX crtc driver
+ *
+ * Copyright (C) 2012 Sascha Hauer, Pengutronix
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <drm/drmP.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_crtc_helper.h>
+#include <linux/fb.h>
+#include <linux/clk.h>
+#include <asm/fb.h>
+#include <linux/module.h>
+#include <drm/sdrm.h>
+#include <drm/sdrm_encon.h>
+#include <mach/hardware.h>
+#include <mach/imxfb.h>
+#include <generated/mach-types.h>
+
+#define LCDC_SSA		0x00
+#define LCDC_SIZE		0x04
+#define LCDC_VPW		0x08
+#define LCDC_CPOS		0x0C
+#define LCDC_LCWHB		0x10
+#define LCDC_LCHCC		0x14
+#define LCDC_PCR		0x18
+#define LCDC_HCR		0x1C
+#define LCDC_VCR		0x20
+#define LCDC_POS		0x24
+#define LCDC_LSCR1		0x28
+#define LCDC_PWMR		0x2C
+#define LCDC_DMACR		0x30
+#define LCDC_RMCR		0x34
+#define LCDC_LCDICR		0x38
+#define LCDC_LIER		0x3c
+#define LCDC_LISR		0x40
+
+#define SIZE_XMAX(x)		((((x) >> 4) & 0x3f) << 20)
+
+#define YMAX_MASK		(cpu_is_mx1() ? 0x1ff : 0x3ff)
+#define SIZE_YMAX(y)		((y) & YMAX_MASK)
+
+#define VPW_VPW(x)		((x) & 0x3ff)
+
+#define HCR_H_WIDTH(x)		(((x) & 0x3f) << 26)
+#define HCR_H_WAIT_1(x)		(((x) & 0xff) << 8)
+#define HCR_H_WAIT_2(x)		((x) & 0xff)
+
+#define VCR_V_WIDTH(x)		(((x) & 0x3f) << 26)
+#define VCR_V_WAIT_1(x)		(((x) & 0xff) << 8)
+#define VCR_V_WAIT_2(x)		((x) & 0xff)
+
+#define RMCR_LCDC_EN_MX1	(1 << 1)
+
+#define RMCR_SELF_REF		(1 << 0)
+
+#define LIER_EOF		(1 << 1)
+
+struct imx_crtc {
+	struct drm_crtc		base;
+	struct sdrm_crtc	*sdrm_crtc;
+	int			di_no;
+	int			enabled;
+	void __iomem		*regs;
+	u32			pwmr;
+	u32			lscr1;
+	u32			dmacr;
+	u32			pcr;
+	struct clk		*clk;
+	struct device		*dev;
+	int			vblank_enable;
+
+	struct drm_pending_vblank_event *page_flip_event;
+	struct drm_framebuffer	*newfb;
+};
+
+#define to_imx_crtc(x) container_of(x, struct imx_crtc, base)
+
+static void imx_crtc_load_lut(struct drm_crtc *crtc)
+{
+}
+
+#define PCR_BPIX_8		(3 << 25)
+#define PCR_BPIX_12		(4 << 25)
+#define PCR_BPIX_16		(5 << 25)
+#define PCR_BPIX_18		(6 << 25)
+#define PCR_END_SEL		(1 << 18)
+#define PCR_END_BYTE_SWAP	(1 << 17)
+
+const char *fourcc_to_str(u32 fourcc)
+{
+	static char buf[5];
+
+	*(u32 *)buf = fourcc;
+	buf[4] = 0;
+
+	return buf;
+}
+
+static int imx_drm_crtc_set(struct drm_crtc *crtc,
+		struct drm_display_mode *mode)
+{
+	struct imx_crtc *imx_crtc = to_imx_crtc(crtc);
+	struct drm_framebuffer *fb = crtc->fb;
+	int lower_margin = mode->vsync_start - mode->vdisplay;
+	int upper_margin = mode->vtotal - mode->vsync_end;
+	int vsync_len = mode->vsync_end - mode->vsync_start;
+	int hsync_len = mode->hsync_end - mode->hsync_start;
+	int right_margin = mode->hsync_start - mode->hdisplay;
+	int left_margin = mode->htotal - mode->hsync_end;
+	unsigned long lcd_clk;
+	u32 pcr;
+
+	lcd_clk = clk_get_rate(imx_crtc->clk) / 1000;
+
+	if (!mode->clock)
+		return -EINVAL;
+
+	pcr = DIV_ROUND_CLOSEST(lcd_clk, mode->clock);
+	if (--pcr > 0x3f)
+		pcr = 0x3f;
+
+	switch (fb->pixel_format) {
+	case DRM_FORMAT_XRGB8888:
+	case DRM_FORMAT_ARGB8888:
+		pcr |= PCR_BPIX_18;
+		pcr |= PCR_END_SEL | PCR_END_BYTE_SWAP;
+		break;
+	case DRM_FORMAT_RGB565:
+		if (cpu_is_mx1())
+			pcr |= PCR_BPIX_12;
+		else
+			pcr |= PCR_BPIX_16;
+		break;
+	case DRM_FORMAT_RGB332:
+		pcr |= PCR_BPIX_8;
+		break;
+	default:
+		dev_err(imx_crtc->dev, "unsupported pixel format %s\n",
+				fourcc_to_str(fb->pixel_format));
+		return -EINVAL;
+	}
+
+	/* add sync polarities */
+	pcr |= imx_crtc->pcr & ~(0x3f | (7 << 25));
+
+	dev_dbg(imx_crtc->dev,
+			"xres=%d hsync_len=%d left_margin=%d right_margin=%d\n",
+			mode->hdisplay, hsync_len,
+			left_margin, right_margin);
+	dev_dbg(imx_crtc->dev,
+			"yres=%d vsync_len=%d upper_margin=%d lower_margin=%d\n",
+			mode->vdisplay, vsync_len,
+			upper_margin, lower_margin);
+
+	writel(VPW_VPW(mode->hdisplay * fb->bits_per_pixel / 8 / 4),
+		imx_crtc->regs + LCDC_VPW);
+
+	writel(HCR_H_WIDTH(hsync_len - 1) |
+		HCR_H_WAIT_1(right_margin - 1) |
+		HCR_H_WAIT_2(left_margin - 3),
+		imx_crtc->regs + LCDC_HCR);
+
+	writel(VCR_V_WIDTH(vsync_len) |
+		VCR_V_WAIT_1(lower_margin) |
+		VCR_V_WAIT_2(upper_margin),
+		imx_crtc->regs + LCDC_VCR);
+
+	writel(SIZE_XMAX(mode->hdisplay) | SIZE_YMAX(mode->vdisplay),
+			imx_crtc->regs + LCDC_SIZE);
+
+	writel(pcr, imx_crtc->regs + LCDC_PCR);
+	writel(imx_crtc->pwmr, imx_crtc->regs + LCDC_PWMR);
+	writel(imx_crtc->lscr1, imx_crtc->regs + LCDC_LSCR1);
+	/* reset default */
+	writel(0x00040060, imx_crtc->regs + LCDC_DMACR);
+
+	return 0;
+}
+
+static int imx_drm_set_base(struct drm_crtc *crtc, int x, int y)
+{
+	struct imx_crtc *imx_crtc = to_imx_crtc(crtc);
+	struct sdrm_buf_entry *entry;
+	struct drm_framebuffer *fb = crtc->fb;
+	unsigned long phys;
+
+	entry = sdrm_fb_get_buf(fb);
+	if (!entry)
+		return -EFAULT;
+
+	phys = entry->paddr;
+	phys += x * (fb->bits_per_pixel >> 3);
+	phys += y * fb->pitches[0];
+
+	dev_dbg(imx_crtc->dev, "%s: phys: 0x%lx\n", __func__, phys);
+	dev_dbg(imx_crtc->dev, "%s: xy: %dx%d\n", __func__, x, y);
+
+	writel(phys, imx_crtc->regs + LCDC_SSA);
+
+	return 0;
+}
+
+static int imx_crtc_mode_set(struct drm_crtc *crtc,
+			       struct drm_display_mode *mode,
+			       struct drm_display_mode *adjusted_mode,
+			       int x, int y,
+			       struct drm_framebuffer *old_fb)
+{
+	struct imx_crtc *imx_crtc = to_imx_crtc(crtc);
+
+	imx_drm_set_base(crtc, x, y);
+
+	dev_dbg(imx_crtc->dev, "mode->hdisplay: %d\n", mode->hdisplay);
+	dev_dbg(imx_crtc->dev, "mode->vdisplay: %d\n", mode->vdisplay);
+
+	return imx_drm_crtc_set(crtc, mode);
+}
+
+static void imx_crtc_enable(struct imx_crtc *imx_crtc)
+{
+	if (!imx_crtc->enabled)
+		clk_enable(imx_crtc->clk);
+	imx_crtc->enabled = 1;
+}
+
+static void imx_crtc_disable(struct imx_crtc *imx_crtc)
+{
+	if (imx_crtc->enabled)
+		clk_disable(imx_crtc->clk);
+	imx_crtc->enabled = 0;
+}
+
+static void imx_crtc_dpms(struct drm_crtc *crtc, int mode)
+{
+	struct imx_crtc *imx_crtc = to_imx_crtc(crtc);
+
+	dev_dbg(imx_crtc->dev, "%s mode: %d\n", __func__, mode);
+
+	switch (mode) {
+	case DRM_MODE_DPMS_ON:
+		imx_crtc_enable(imx_crtc);
+		break;
+	default:
+		imx_crtc_disable(imx_crtc);
+		break;
+	}
+}
+
+static bool imx_crtc_mode_fixup(struct drm_crtc *crtc,
+				  struct drm_display_mode *mode,
+				  struct drm_display_mode *adjusted_mode)
+{
+	return true;
+}
+
+static void imx_crtc_prepare(struct drm_crtc *crtc)
+{
+	struct imx_crtc *imx_crtc = to_imx_crtc(crtc);
+
+	imx_crtc_disable(imx_crtc);
+}
+
+static void imx_crtc_commit(struct drm_crtc *crtc)
+{
+	struct imx_crtc *imx_crtc = to_imx_crtc(crtc);
+
+	imx_crtc_enable(imx_crtc);
+}
+
+static struct drm_crtc_helper_funcs imx_helper_funcs = {
+	.dpms = imx_crtc_dpms,
+	.mode_fixup = imx_crtc_mode_fixup,
+	.mode_set = imx_crtc_mode_set,
+	.prepare = imx_crtc_prepare,
+	.commit = imx_crtc_commit,
+	.load_lut = imx_crtc_load_lut,
+};
+
+static void sdrm_handle_pageflip(struct imx_crtc *imx_crtc)
+{
+	struct drm_pending_vblank_event *e;
+	struct timeval now;
+	unsigned long flags;
+	struct drm_device *drm = imx_crtc->base.dev;
+
+	spin_lock_irqsave(&drm->event_lock, flags);
+
+	e = imx_crtc->page_flip_event;
+
+	if (!e) {
+		spin_unlock_irqrestore(&drm->event_lock, flags);
+		return;
+	}
+
+	do_gettimeofday(&now);
+	e->event.sequence = 0;
+	e->event.tv_sec = now.tv_sec;
+	e->event.tv_usec = now.tv_usec;
+	imx_crtc->page_flip_event = NULL;
+
+	list_add_tail(&e->base.link, &e->base.file_priv->event_list);
+
+	wake_up_interruptible(&e->base.file_priv->event_wait);
+
+	spin_unlock_irqrestore(&drm->event_lock, flags);
+}
+
+static int imx_crtc_enable_vblank(struct drm_crtc *crtc)
+{
+	struct imx_crtc *imx_crtc = to_imx_crtc(crtc);
+
+	writel(LIER_EOF, imx_crtc->regs + LCDC_LIER);
+
+	return 0;
+}
+
+static void imx_crtc_disable_vblank(struct drm_crtc *crtc)
+{
+	struct imx_crtc *imx_crtc = to_imx_crtc(crtc);
+
+	writel(0, imx_crtc->regs + LCDC_LIER);
+}
+
+static irqreturn_t imx_irq_handler(int irq, void *dev_id)
+{
+	struct imx_crtc *imx_crtc = dev_id;
+	struct drm_device *drm = imx_crtc->base.dev;
+
+	/* Acknowledge interrupt */
+	readl(imx_crtc->regs + LCDC_LISR);
+
+	drm_handle_vblank(drm, 0);
+
+	if (imx_crtc->newfb) {
+		imx_crtc->base.fb = imx_crtc->newfb;
+		imx_crtc->newfb = NULL;
+		imx_drm_set_base(&imx_crtc->base, 0, 0);
+		sdrm_handle_pageflip(imx_crtc);
+		sdrm_crtc_vblank_put(imx_crtc->sdrm_crtc);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int imx_page_flip(struct drm_crtc *crtc,
+                         struct drm_framebuffer *fb,
+                         struct drm_pending_vblank_event *event)
+{
+	struct imx_crtc *imx_crtc = to_imx_crtc(crtc);
+
+	if (imx_crtc->newfb)
+		return -EBUSY;
+
+	imx_crtc->newfb = fb;
+	imx_crtc->page_flip_event = event;
+	sdrm_crtc_vblank_get(imx_crtc->sdrm_crtc);
+
+	return 0;
+}
+
+static const struct drm_crtc_funcs imx_crtc_funcs = {
+	.page_flip = imx_page_flip,
+};
+
+static const struct sdrm_crtc_helper_funcs imx_sdrm_helper = {
+	.enable_vblank = imx_crtc_enable_vblank,
+	.disable_vblank = imx_crtc_disable_vblank,
+};
+
+#define DRIVER_NAME "imx-lcdc-crtc"
+
+/*
+ * the pcr bits to be allowed to set in platform data
+ */
+#define PDATA_PCR	(PCR_PIXPOL | PCR_FLMPOL | PCR_LPPOL | \
+			PCR_CLKPOL | PCR_OEPOL | PCR_TFT | PCR_COLOR | \
+			PCR_PBSIZ_8 | PCR_ACD(0x7f) | PCR_ACD_SEL | \
+			PCR_SCLK_SEL | PCR_SHARP)
+
+static int __devinit imx_crtc_probe(struct platform_device *pdev)
+{
+	struct imx_crtc *imx_crtc;
+	struct resource *res;
+	int ret, irq;
+	struct imx_drm_platform_data *pdata = pdev->dev.platform_data;
+
+	imx_crtc = devm_kzalloc(&pdev->dev, sizeof(*imx_crtc), GFP_KERNEL);
+	if (!imx_crtc)
+		return -ENOMEM;
+
+	imx_crtc->dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	res = devm_request_mem_region(&pdev->dev, res->start,
+			resource_size(res), DRIVER_NAME);
+	if (!res)
+		return -EBUSY;
+
+	imx_crtc->regs = devm_ioremap(&pdev->dev, res->start,
+			resource_size(res));
+	if (!imx_crtc->regs) {
+		dev_err(&pdev->dev, "Cannot map frame buffer registers\n");
+		return -EBUSY;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	ret = devm_request_irq(&pdev->dev, irq, imx_irq_handler, 0, "imx_drm",
+			imx_crtc);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "irq request failed with %d\n", ret);
+		return ret;
+	}
+
+	imx_crtc->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(imx_crtc->clk)) {
+		ret = PTR_ERR(imx_crtc->clk);
+		dev_err(&pdev->dev, "unable to get clock: %d\n", ret);
+		return ret;
+	}
+
+	imx_crtc->sdrm_crtc = sdrm_add_crtc(dev_name(&pdev->dev),
+			&imx_crtc->base, &imx_crtc_funcs, &imx_helper_funcs,
+			&imx_sdrm_helper);
+	if (!imx_crtc->sdrm_crtc) {
+		ret = -EINVAL;
+		goto err_clk;
+	}
+
+	clk_prepare_enable(imx_crtc->clk);
+	imx_crtc->enabled = 1;
+
+	platform_set_drvdata(pdev, imx_crtc);
+
+	imx_crtc->pcr = pdata->pcr & PDATA_PCR;
+
+	if (imx_crtc->pcr != pdata->pcr)
+		dev_err(&pdev->dev, "invalid bits set in pcr: 0x%08x\n",
+				pdata->pcr & ~PDATA_PCR);
+
+	imx_crtc->lscr1 = pdata->lscr1;
+	imx_crtc->pwmr = pdata->pwmr;
+
+	ret = sdrm_init_drm(dev_name(&pdev->dev), pdev, 16);
+	if (ret) {
+		dev_err(&pdev->dev, "init drm failed with %d\n", ret);
+		goto err_init;
+	}
+
+	return 0;
+
+err_init:
+	sdrm_remove_crtc(imx_crtc->sdrm_crtc);
+	clk_disable_unprepare(imx_crtc->clk);
+err_clk:
+	clk_put(imx_crtc->clk);
+
+	return ret;
+}
+
+static int __devexit imx_crtc_remove(struct platform_device *pdev)
+{
+	struct imx_crtc *imx_crtc = platform_get_drvdata(pdev);
+
+	sdrm_exit_drm(dev_name(&pdev->dev));
+
+	writel(0, imx_crtc->regs + LCDC_LIER);
+
+	clk_disable_unprepare(imx_crtc->clk);
+	clk_put(imx_crtc->clk);
+
+	sdrm_remove_crtc(imx_crtc->sdrm_crtc);
+
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver imx_crtc_driver = {
+	.remove		= __devexit_p(imx_crtc_remove),
+	.probe		= imx_crtc_probe,
+	.driver		= {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+	},
+};
+
+module_platform_driver(imx_crtc_driver);
+
+MODULE_DESCRIPTION("Freescale i.MX framebuffer driver");
+MODULE_AUTHOR("Sascha Hauer, Pengutronix");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5
