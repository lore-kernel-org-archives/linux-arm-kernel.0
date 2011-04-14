From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 14 Apr 2011 11:25:05 +0200
Subject: [PATCH 2/7] ARM i.MX5: Add IPU device support
In-Reply-To: <1302710016-3569-2-git-send-email-weitway@gmail.com>
References: <1302710016-3569-1-git-send-email-weitway@gmail.com>
	<1302710016-3569-2-git-send-email-weitway@gmail.com>
Message-ID: <20110414092505.GB7285@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2011 at 11:53:31PM +0800, weitway at gmail.com wrote:
> From: Jason Chen <b02280@freescale.com>
> 
> diff --git a/arch/arm/plat-mxc/devices/platform-imx_ipuv3.c b/arch/arm/plat-mxc/devices/platform-imx_ipuv3.c
> new file mode 100644
> index 0000000..fe76cf1
> --- /dev/null
> +++ b/arch/arm/plat-mxc/devices/platform-imx_ipuv3.c
> @@ -0,0 +1,94 @@
> +/*
> + * Copyright (C) 2010 Pengutronix
> + * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
> + *
> + * This program is free software; you can redistribute it and/or modify it under
> + * the terms of the GNU General Public License version 2 as published by the
> + * Free Software Foundation.
> + */
> +#include <mach/hardware.h>
> +#include <mach/devices-common.h>
> +
> +#define imx5_ipuv3_data_entry_single(soc, size, ipu_init)	        \
> +	{                                                               \
> +		.iobase = soc ## _IPU_CTRL_BASE_ADDR,                   \
> +		.irq_err = soc ## _INT_IPU_ERR,                         \
> +		.irq = soc ## _INT_IPU_SYN,                             \
> +		.iosize = size,                                         \
> +		.init = ipu_init,                                       \
> +	}
> +
> +#ifdef CONFIG_SOC_IMX51
> +int __init mx51_ipuv3_init(struct platform_device *pdev)
> +{
> +	int ret = 0;
> +	u32 val;
> +
> +	/* hard reset the IPU */
> +	val = readl(MX51_IO_ADDRESS(MX51_SRC_BASE_ADDR));
> +	val |= 1 << 3;
> +	writel(val, MX51_IO_ADDRESS(MX51_SRC_BASE_ADDR));
> +
> +	return ret;
> +}
> +
> +const struct imx_ipuv3_data imx51_ipuv3_data __initconst =
> +			imx5_ipuv3_data_entry_single(MX51,
> +			SZ_512M, mx51_ipuv3_init);
> +#endif /* ifdef CONFIG_SOC_IMX51 */
> +
> +#ifdef CONFIG_SOC_IMX53
> +int __init mx53_ipuv3_init(struct platform_device *pdev)
> +{
> +	int ret = 0;
> +	u32 val;
> +	int i;
> +
> +	/* fixup ipu base address */
> +	for (i = 0; i < pdev->num_resources; i++) {
> +		struct resource *r = &pdev->resource[i];
> +
> +		if (IORESOURCE_MEM == resource_type(r))
> +			r->start -= 0x18000000;
> +	}

This is ugly. We should rather use IPU_CM_REG_BASE directly for the
resources and remove the offsets from the IPU driver.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
