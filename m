From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 21 Jun 2012 09:10:49 +0200
Subject: [PATCH 3/5] DRM i.MX: Add LCDC support
In-Reply-To: <20120621061240.GD3971@S2101-09.ap.freescale.net>
References: <1339681407-28721-1-git-send-email-s.hauer@pengutronix.de>
 <1339681407-28721-4-git-send-email-s.hauer@pengutronix.de>
 <20120621061240.GD3971@S2101-09.ap.freescale.net>
Message-ID: <20120621071049.GZ28394@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2012 at 02:12:48PM +0800, Shawn Guo wrote:
> On Thu, Jun 14, 2012 at 03:43:25PM +0200, Sascha Hauer wrote:
> ...
> > +#include <linux/device.h>
> > +#include <linux/platform_device.h>
> > +#include <drm/drmP.h>
> > +#include <drm/drm_fb_helper.h>
> > +#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_gem_cma_helper.h>
> > +#include <drm/drm_fb_cma_helper.h>
> > +#include <linux/fb.h>
> > +#include <linux/clk.h>
> > +#include <linux/module.h>
> > +#include <mach/hardware.h>
> 
> This looks suspicious.

Indeed ;)

> 
> > +#include <mach/imxfb.h>
> 
> We should probably copy those needed macros into the file to save this
> <mach> inclusion?

I don't think they are actually needed, I will have a look at it.

> 
> > +#include <generated/mach-types.h>
> > +#include <drm/drm_gem_cma_helper.h>
> > +
> > +#include "imx-drm.h"
> > +
> > +#define LCDC_SSA		0x00
> > +#define LCDC_SIZE		0x04
> > +#define LCDC_VPW		0x08
> > +#define LCDC_CPOS		0x0C
> > +#define LCDC_LCWHB		0x10
> > +#define LCDC_LCHCC		0x14
> > +#define LCDC_PCR		0x18
> > +#define LCDC_HCR		0x1C
> > +#define LCDC_VCR		0x20
> > +#define LCDC_POS		0x24
> > +#define LCDC_LSCR1		0x28
> > +#define LCDC_PWMR		0x2C
> > +#define LCDC_DMACR		0x30
> > +#define LCDC_RMCR		0x34
> > +#define LCDC_LCDICR		0x38
> > +#define LCDC_LIER		0x3c
> > +#define LCDC_LISR		0x40
> > +
> > +#define SIZE_XMAX(x)		((((x) >> 4) & 0x3f) << 20)
> > +
> > +#define YMAX_MASK		(cpu_is_mx1() ? 0x1ff : 0x3ff)
> 
> Ah, here it needs <mach/hardware.h>.  We may not want to use
> cpu_is_mx1() any more.

Will fix.

> > +
> > +static struct platform_driver imx_crtc_driver = {
> > +	.remove		= __devexit_p(imx_crtc_remove),
> > +	.probe		= imx_crtc_probe,
> > +	.driver		= {
> > +		.name	= DRIVER_NAME,
> > +		.owner	= THIS_MODULE,
> > +		.of_match_table = imx_lcdc_dt_ids,
> > +	},
> > +};
> > +
> > +static int __init imx_lcdc_init(void)
> > +{
> > +	return platform_driver_register(&imx_crtc_driver);
> > +}
> > +
> > +static void __exit imx_lcdc_exit(void)
> > +{
> > +	platform_driver_unregister(&imx_crtc_driver);
> > +}
> > +
> > +module_init(imx_lcdc_init);
> > +module_exit(imx_lcdc_exit)
> 
> Can these simply be module_platform_driver(imx_crtc_driver)?

Yes. I had to put it in an earlier initcall in an earlier version of
this driver, hence couldn't use module_platform_driver() back then. Will
fix.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
