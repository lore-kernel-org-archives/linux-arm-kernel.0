From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 21 Jun 2012 14:12:48 +0800
Subject: [PATCH 3/5] DRM i.MX: Add LCDC support
In-Reply-To: <1339681407-28721-4-git-send-email-s.hauer@pengutronix.de>
References: <1339681407-28721-1-git-send-email-s.hauer@pengutronix.de>
 <1339681407-28721-4-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120621061240.GD3971@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 03:43:25PM +0200, Sascha Hauer wrote:
...
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <drm/drmP.h>
> +#include <drm/drm_fb_helper.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_gem_cma_helper.h>
> +#include <drm/drm_fb_cma_helper.h>
> +#include <linux/fb.h>
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <mach/hardware.h>

This looks suspicious.

> +#include <mach/imxfb.h>

We should probably copy those needed macros into the file to save this
<mach> inclusion?

> +#include <generated/mach-types.h>
> +#include <drm/drm_gem_cma_helper.h>
> +
> +#include "imx-drm.h"
> +
> +#define LCDC_SSA		0x00
> +#define LCDC_SIZE		0x04
> +#define LCDC_VPW		0x08
> +#define LCDC_CPOS		0x0C
> +#define LCDC_LCWHB		0x10
> +#define LCDC_LCHCC		0x14
> +#define LCDC_PCR		0x18
> +#define LCDC_HCR		0x1C
> +#define LCDC_VCR		0x20
> +#define LCDC_POS		0x24
> +#define LCDC_LSCR1		0x28
> +#define LCDC_PWMR		0x2C
> +#define LCDC_DMACR		0x30
> +#define LCDC_RMCR		0x34
> +#define LCDC_LCDICR		0x38
> +#define LCDC_LIER		0x3c
> +#define LCDC_LISR		0x40
> +
> +#define SIZE_XMAX(x)		((((x) >> 4) & 0x3f) << 20)
> +
> +#define YMAX_MASK		(cpu_is_mx1() ? 0x1ff : 0x3ff)

Ah, here it needs <mach/hardware.h>.  We may not want to use
cpu_is_mx1() any more.

> +#define SIZE_YMAX(y)		((y) & YMAX_MASK)
> +
> +#define VPW_VPW(x)		((x) & 0x3ff)
> +
> +#define HCR_H_WIDTH(x)		(((x) & 0x3f) << 26)
> +#define HCR_H_WAIT_1(x)		(((x) & 0xff) << 8)
> +#define HCR_H_WAIT_2(x)		((x) & 0xff)
> +
> +#define VCR_V_WIDTH(x)		(((x) & 0x3f) << 26)
> +#define VCR_V_WAIT_1(x)		(((x) & 0xff) << 8)
> +#define VCR_V_WAIT_2(x)		((x) & 0xff)
> +
> +#define RMCR_LCDC_EN_MX1	(1 << 1)
> +
> +#define RMCR_SELF_REF		(1 << 0)
> +
> +#define LIER_EOF		(1 << 1)
> +
> +struct imx_crtc {
> +	struct drm_crtc		base;
> +	struct imx_drm_crtc	*imx_drm_crtc;
> +	int			di_no;
> +	int			enabled;
> +	void __iomem		*regs;
> +	u32			pwmr;
> +	u32			lscr1;
> +	u32			dmacr;
> +	u32			pcr;
> +	struct clk		*clk;
> +	struct device		*dev;
> +	int			vblank_enable;
> +
> +	struct drm_pending_vblank_event *page_flip_event;
> +	struct drm_framebuffer	*newfb;
> +};
> +
> +#define to_imx_crtc(x) container_of(x, struct imx_crtc, base)
> +
> +static void imx_crtc_load_lut(struct drm_crtc *crtc)
> +{
> +}
> +
> +#define PCR_BPIX_8		(3 << 25)
> +#define PCR_BPIX_12		(4 << 25)
> +#define PCR_BPIX_16		(5 << 25)
> +#define PCR_BPIX_18		(6 << 25)
> +#define PCR_END_SEL		(1 << 18)
> +#define PCR_END_BYTE_SWAP	(1 << 17)
> +
> +static const char *fourcc_to_str(u32 fourcc)
> +{
> +	static char buf[5];
> +
> +	*(u32 *)buf = fourcc;
> +	buf[4] = 0;
> +
> +	return buf;
> +}
> +
> +static int imx_drm_crtc_set(struct drm_crtc *crtc,
> +		struct drm_display_mode *mode)
> +{
> +	struct imx_crtc *imx_crtc = to_imx_crtc(crtc);
> +	struct drm_framebuffer *fb = crtc->fb;
> +	int lower_margin = mode->vsync_start - mode->vdisplay;
> +	int upper_margin = mode->vtotal - mode->vsync_end;
> +	int vsync_len = mode->vsync_end - mode->vsync_start;
> +	int hsync_len = mode->hsync_end - mode->hsync_start;
> +	int right_margin = mode->hsync_start - mode->hdisplay;
> +	int left_margin = mode->htotal - mode->hsync_end;
> +	unsigned long lcd_clk;
> +	u32 pcr;
> +
> +	lcd_clk = clk_get_rate(imx_crtc->clk) / 1000;
> +
> +	if (!mode->clock)
> +		return -EINVAL;
> +
> +	pcr = DIV_ROUND_CLOSEST(lcd_clk, mode->clock);
> +	if (--pcr > 0x3f)
> +		pcr = 0x3f;
> +
> +	switch (fb->pixel_format) {
> +	case DRM_FORMAT_XRGB8888:
> +	case DRM_FORMAT_ARGB8888:
> +		pcr |= PCR_BPIX_18;
> +		pcr |= PCR_END_SEL | PCR_END_BYTE_SWAP;
> +		break;
> +	case DRM_FORMAT_RGB565:
> +		if (cpu_is_mx1())

Ditto

> +			pcr |= PCR_BPIX_12;
> +		else
> +			pcr |= PCR_BPIX_16;
> +		break;
> +	case DRM_FORMAT_RGB332:
> +		pcr |= PCR_BPIX_8;
> +		break;
> +	default:
> +		dev_err(imx_crtc->dev, "unsupported pixel format %s\n",
> +				fourcc_to_str(fb->pixel_format));
> +		return -EINVAL;
> +	}
> +
> +	/* add sync polarities */
> +	pcr |= imx_crtc->pcr & ~(0x3f | (7 << 25));
> +
> +	dev_dbg(imx_crtc->dev,
> +			"xres=%d hsync_len=%d left_margin=%d right_margin=%d\n",
> +			mode->hdisplay, hsync_len,
> +			left_margin, right_margin);
> +	dev_dbg(imx_crtc->dev,
> +			"yres=%d vsync_len=%d upper_margin=%d lower_margin=%d\n",
> +			mode->vdisplay, vsync_len,
> +			upper_margin, lower_margin);
> +
> +	writel(VPW_VPW(mode->hdisplay * fb->bits_per_pixel / 8 / 4),
> +		imx_crtc->regs + LCDC_VPW);
> +
> +	writel(HCR_H_WIDTH(hsync_len - 1) |
> +		HCR_H_WAIT_1(right_margin - 1) |
> +		HCR_H_WAIT_2(left_margin - 3),
> +		imx_crtc->regs + LCDC_HCR);
> +
> +	writel(VCR_V_WIDTH(vsync_len) |
> +		VCR_V_WAIT_1(lower_margin) |
> +		VCR_V_WAIT_2(upper_margin),
> +		imx_crtc->regs + LCDC_VCR);
> +
> +	writel(SIZE_XMAX(mode->hdisplay) | SIZE_YMAX(mode->vdisplay),
> +			imx_crtc->regs + LCDC_SIZE);
> +
> +	writel(pcr, imx_crtc->regs + LCDC_PCR);
> +	writel(imx_crtc->pwmr, imx_crtc->regs + LCDC_PWMR);
> +	writel(imx_crtc->lscr1, imx_crtc->regs + LCDC_LSCR1);
> +	/* reset default */
> +	writel(0x00040060, imx_crtc->regs + LCDC_DMACR);
> +
> +	return 0;
> +}

...

> +static int __devinit imx_crtc_probe(struct platform_device *pdev)
> +{
> +	struct imx_crtc *imx_crtc;
> +	struct resource *res;
> +	int ret, irq;
> +	u32 pcr_value = 0xf00080c0;
> +	u32 lscr1_value = 0x00120300;
> +	u32 pwmr_value = 0x00a903ff;
> +
> +	imx_crtc = devm_kzalloc(&pdev->dev, sizeof(*imx_crtc), GFP_KERNEL);
> +	if (!imx_crtc)
> +		return -ENOMEM;
> +
> +	imx_crtc->dev = &pdev->dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	res = devm_request_mem_region(&pdev->dev, res->start,
> +			resource_size(res), DRIVER_NAME);
> +	if (!res)
> +		return -EBUSY;
> +
> +	imx_crtc->regs = devm_ioremap(&pdev->dev, res->start,
> +			resource_size(res));
> +	if (!imx_crtc->regs) {
> +		dev_err(&pdev->dev, "Cannot map frame buffer registers\n");
> +		return -EBUSY;
> +	}

devm_request_and_ioremap() can help a little bit.

> +
> +	irq = platform_get_irq(pdev, 0);
> +	ret = devm_request_irq(&pdev->dev, irq, imx_irq_handler, 0, "imx_drm",
> +			imx_crtc);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "irq request failed with %d\n", ret);
> +		return ret;
> +	}
> +
> +	imx_crtc->clk = clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(imx_crtc->clk)) {
> +		ret = PTR_ERR(imx_crtc->clk);
> +		dev_err(&pdev->dev, "unable to get clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	clk_prepare_enable(imx_crtc->clk);
> +	imx_crtc->enabled = 1;
> +
> +	platform_set_drvdata(pdev, imx_crtc);
> +
> +	imx_crtc->pcr = pcr_value & PDATA_PCR;
> +
> +	if (imx_crtc->pcr != pcr_value)
> +		dev_err(&pdev->dev, "invalid bits set in pcr: 0x%08x\n",
> +				pcr_value & ~PDATA_PCR);
> +
> +	imx_crtc->lscr1 = lscr1_value;
> +	imx_crtc->pwmr = pwmr_value;
> +
> +	ret = imx_drm_add_crtc(&imx_crtc->base,
> +			&imx_crtc->imx_drm_crtc,
> +			&imx_imx_drm_helper, THIS_MODULE,
> +			pdev->dev.of_node, 0);
> +	if (ret)
> +		goto err_init;
> +
> +	dev_info(&pdev->dev, "probed\n");
> +
> +	return 0;
> +
> +err_init:
> +	clk_disable_unprepare(imx_crtc->clk);
> +	clk_put(imx_crtc->clk);
> +
> +	return ret;
> +}
> +
> +static int __devexit imx_crtc_remove(struct platform_device *pdev)
> +{
> +	struct imx_crtc *imx_crtc = platform_get_drvdata(pdev);
> +
> +	imx_drm_remove_crtc(imx_crtc->imx_drm_crtc);
> +
> +	writel(0, imx_crtc->regs + LCDC_LIER);
> +
> +	clk_disable_unprepare(imx_crtc->clk);
> +	clk_put(imx_crtc->clk);
> +
> +	platform_set_drvdata(pdev, NULL);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id imx_lcdc_dt_ids[] = {
> +	{ .compatible = "fsl,imx1-lcdc", .data = NULL, },
> +	{ .compatible = "fsl,imx21-lcdc", .data = NULL, },

So .data will be used to kill those cpu_is_xxx uses.

> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver imx_crtc_driver = {
> +	.remove		= __devexit_p(imx_crtc_remove),
> +	.probe		= imx_crtc_probe,
> +	.driver		= {
> +		.name	= DRIVER_NAME,
> +		.owner	= THIS_MODULE,
> +		.of_match_table = imx_lcdc_dt_ids,
> +	},
> +};
> +
> +static int __init imx_lcdc_init(void)
> +{
> +	return platform_driver_register(&imx_crtc_driver);
> +}
> +
> +static void __exit imx_lcdc_exit(void)
> +{
> +	platform_driver_unregister(&imx_crtc_driver);
> +}
> +
> +module_init(imx_lcdc_init);
> +module_exit(imx_lcdc_exit)

Can these simply be module_platform_driver(imx_crtc_driver)?

> +
> +MODULE_DESCRIPTION("Freescale i.MX framebuffer driver");
> +MODULE_AUTHOR("Sascha Hauer, Pengutronix");
> +MODULE_LICENSE("GPL");
> -- 
> 1.7.10
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Regards,
Shawn
