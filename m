From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 18 May 2013 19:45:02 +0200
Subject: [RFC 3/4] DRM: add OF support for Dove DRM driver
In-Reply-To: <1368897139-25485-4-git-send-email-sebastian.hesselbarth@gmail.com>
References: <20130516192510.GV18614@n2100.arm.linux.org.uk>
 <1368897139-25485-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1368897139-25485-4-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130518194502.102caa9e@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 18 May 2013 19:12:18 +0200
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> This adds OF support for the Dove DRM driver recently posted as RFC by
> Russell King.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: dri-devel at lists.freedesktop.org
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Jean-Francois Moine <moinejf@free.fr>
> ---
>  drivers/gpu/drm/dove/Kconfig     |    4 ++
>  drivers/gpu/drm/dove/Makefile    |    1 +
>  drivers/gpu/drm/dove/dove_card.c |  110 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 115 insertions(+)
>  create mode 100644 drivers/gpu/drm/dove/dove_card.c
> 
> diff --git a/drivers/gpu/drm/dove/Kconfig b/drivers/gpu/drm/dove/Kconfig
> index 718d3c5..a943ea5 100644
> --- a/drivers/gpu/drm/dove/Kconfig
> +++ b/drivers/gpu/drm/dove/Kconfig
> @@ -28,4 +28,8 @@ config DRM_DOVE_TDA1998X
>  config DRM_DOVE_CURSOR
>  	bool "Enable Dove DRM hardware cursor support"
>  
> +config DRM_DOVE_OF
> +	bool "Enable Dove DRM OF video card"
> +	depends on OF
> +
>  endif
> diff --git a/drivers/gpu/drm/dove/Makefile b/drivers/gpu/drm/dove/Makefile
> index 65c701e..f0b6eed 100644
> --- a/drivers/gpu/drm/dove/Makefile
> +++ b/drivers/gpu/drm/dove/Makefile
> @@ -5,5 +5,6 @@ dove-y			:= dove_crtc.o dove_drv.o dove_fb.o dove_fbdev.o \
>  dove-$(CONFIG_DEBUG_FS) += dove_debugfs.o
>  
>  dove-$(CONFIG_DRM_DOVE_TDA1998X) += dove_tda19988.o
> +dove-$(CONFIG_DRM_DOVE_OF) += dove_card.o
>  
>  obj-$(CONFIG_DRM_DOVE) := dove.o
> diff --git a/drivers/gpu/drm/dove/dove_card.c b/drivers/gpu/drm/dove/dove_card.c
> new file mode 100644
> index 0000000..e4bcb5b
> --- /dev/null
> +++ b/drivers/gpu/drm/dove/dove_card.c
> @@ -0,0 +1,110 @@
> +/*
> + * Copyright (C) 2013
> + *   Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +
> +#define DOVE_LCD0_BASE	0x20000
> +#define DOVE_LCD1_BASE	0x10000
> +
> +static struct resource dove_drm_resources[5];
> +static struct platform_device dove_drm_platform_device = {
> +	.name = "dove-drm",
> +	.id = 0,
> +	.dev = { .coherent_dma_mask = ~0, },
> +	.resource = dove_drm_resources,
> +};
> +
> +static int dove_card_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *lcdnp;
> +	struct resource *res = dove_drm_resources;
> +	int ret, n = 0, crtcs = 0;
> +
> +	/* get video memory resource */
> +	if (of_address_to_resource(np, 0, &res[n++])) {
> +		dev_err(&pdev->dev, "invalid or missing video memory\n");
> +		return -EINVAL;
> +	}
> +
> +	/* get reg and irq resource from each enabled lcdc */
> +	for_each_compatible_node(lcdnp, NULL, "marvell,dove-lcd") {
> +		struct clk_lookup *cl;
> +		struct clk *clk;
> +		int lcd;
> +
> +		if (!of_device_is_available(lcdnp))
> +			continue;
> +
> +		ret = of_address_to_resource(lcdnp, 0, &res[n]);
> +		if (ret)
> +			return ret;
> +		lcd = ((res[n].start & 0xfffff) == DOVE_LCD1_BASE);
> +		n++;
> +
> +		ret = of_irq_to_resource(lcdnp, 0, &res[n]);
> +		if (ret < 0)
> +			return ret;
> +		n++;
> +
> +		crtcs++;
> +
> +		clk = clk_get(&pdev->dev, NULL);
> +		if (IS_ERR(clk)) {
> +			ret = PTR_ERR(clk);
> +			if (ret == -ENOENT)
> +				return -EPROBE_DEFER;
> +			return ret;
> +		}
> +
> +		/* add clock alias for dovefb.0 */
> +		cl = clkdev_alloc(clk, "extclk", "dovefb.0");
> +		if (cl)
> +			clkdev_add(cl);
> +		clk_put(clk);
> +	}
> +
> +	if (!crtcs)
> +		return -ENODEV;
> +
> +	dove_drm_platform_device.num_resources = n;
> +	ret = platform_device_register(&dove_drm_platform_device);
> +	if (ret) {
> +		dev_err(&pdev->dev, "unable to register drm device\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id dove_card_of_ids[] = {
> +	{ .compatible = "marvell,dove-video-card", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, dove_card_of_ids);
> +
> +static struct platform_driver dove_card_driver = {
> +	.probe	= dove_card_probe,
> +	.driver	= {
> +		.owner	= THIS_MODULE,
> +		.name	= "dove-drm-card",
> +		.of_match_table = of_match_ptr(dove_card_of_ids),
> +	},
> +};
> +module_platform_driver(dove_card_driver);
> +
> +MODULE_AUTHOR("Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>");
> +MODULE_DESCRIPTION("Dove DRM Graphics Card");
> +MODULE_LICENSE("GPL");

It seems we are moving backwards:
- what about the display controller?
- how do you clone the lcd 0 output to the port B?
- what occurs when the si5351 and the tda998x are modules?

My driver had the same layout as Russell's when I proposed it to you
and when you insisted to handle the 2 LCDs and the 2 ports as one card.
I spent 2 months to have a nice design and you put it to garbage!
I am not happy...

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
