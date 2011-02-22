From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 22 Feb 2011 08:52:41 +0100
Subject: [PATCH v3 2/2] ARM: mxs: add dma device
In-Reply-To: <1298284306-14710-3-git-send-email-shawn.guo@freescale.com>
References: <1298284306-14710-1-git-send-email-shawn.guo@freescale.com>
	<1298284306-14710-3-git-send-email-shawn.guo@freescale.com>
Message-ID: <20110222075241.GU24426@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 21, 2011 at 06:31:46PM +0800, Shawn Guo wrote:
> diff --git a/arch/arm/mach-mxs/devices/platform-dma.c b/arch/arm/mach-mxs/devices/platform-dma.c
> new file mode 100644
> index 0000000..ee3220e
> --- /dev/null
> +++ b/arch/arm/mach-mxs/devices/platform-dma.c
> @@ -0,0 +1,101 @@
> +/*
> + * Copyright (C) 2010 Pengutronix
> + * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
> + *
> + * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it under
> + * the terms of the GNU General Public License version 2 as published by the
> + * Free Software Foundation.
> + */
> +#include <linux/compiler.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +
> +#include <mach/mx23.h>
> +#include <mach/mx28.h>
> +#include <mach/devices-common.h>
> +
> +struct mxs_mxs_dma_data {
> +	const char *devid;
> +	resource_size_t iobase;
> +};
> +
> +#define mxs_dma_data_entry_single(soc, type, _devid)			\
> +	{								\
> +		.devid = _devid,					\
> +		.iobase = soc ## _ ## type ## _DMA ## _BASE_ADDR,	\
> +	}
> +
> +#ifdef CONFIG_SOC_IMX23
> +struct mxs_mxs_dma_data mx23_dma_data[] __initconst = {
> +	mxs_dma_data_entry_single(MX23, APBH, "mxs-dma-apbh"),
> +	mxs_dma_data_entry_single(MX23, APBX, "mxs-dma-apbx"),
> +};
> +#endif
> +
> +#ifdef CONFIG_SOC_IMX28
> +struct mxs_mxs_dma_data mx28_dma_data[] __initconst = {
> +	mxs_dma_data_entry_single(MX28, APBH, "mxs-dma-apbh"),
> +	mxs_dma_data_entry_single(MX28, APBX, "mxs-dma-apbx"),
> +};
> +#endif
> +
> +struct platform_device *__init mxs_add_dma(
> +			const struct mxs_mxs_dma_data *data)
> +{
> +	struct resource res[] = {
> +		{
> +			.start = data->iobase,
> +			.end = data->iobase + SZ_8K - 1,
> +			.flags = IORESOURCE_MEM,
> +		}
> +	};
> +
> +	return mxs_add_platform_device_dmamask(data->devid, -1,
> +				res, ARRAY_SIZE(res), NULL, 0,
> +				DMA_BIT_MASK(32));
> +}
> +
> +#define mx23_add_apbh_dma() \
> +	mxs_add_dma(&mx23_dma_data[0])
> +#define mx23_add_apbx_dma() \
> +	mxs_add_dma(&mx23_dma_data[1])
> +
> +#define mx28_add_apbh_dma() \
> +	mxs_add_dma(&mx28_dma_data[0])
> +#define mx28_add_apbx_dma() \
> +	mxs_add_dma(&mx28_dma_data[1])
> +
> +static int __init mxs_add_mxs_dma(void)
> +{
> +	struct platform_device *ret;
> +
> +#ifdef CONFIG_SOC_IMX23
> +	if (cpu_is_mx23()) {
> +		ret = mx23_add_apbh_dma();
> +		if (IS_ERR(ret))
> +			goto out;
> +
> +		ret = mx23_add_apbx_dma();
> +	} else
> +#endif
> +
> +#ifdef CONFIG_SOC_IMX28
> +	if (cpu_is_mx28()) {
> +		ret = mx28_add_apbh_dma();
> +		if (IS_ERR(ret))
> +			goto out;
> +
> +		ret = mx28_add_apbx_dma();
> +	} else
> +#endif
> +		ret = ERR_PTR(-ENODEV);
> +
> +out:
> +	if (IS_ERR(ret))
> +		return PTR_ERR(ret);
> +	else
> +		return 0;
> +}
> +arch_initcall(mxs_add_mxs_dma);

Being consistent is one thing, but this should not lead to ifdeffery
where not necessary. Wouldn't it be much simpler to do the following:

static struct platform_device * __init mxs_add_dma(const char *devid,
		resource_size_t base)
{
	struct resource res_apbh[] = {
		{
			.start = base,
			.end = base + SZ_8K - 1,
			.flags = IORESOURCE_MEM,
		},
	};

	return mxs_add_platform_device_dmamask(devid, -1,
				res, ARRAY_SIZE(res), NULL, 0,
				DMA_BIT_MASK(32));
}

static int __init mxs_add_mxs_dma(void)
{
	char *apbh = "mxs-dma-apbh";
	char *apbx = "mxs-dma-apbx";

	if (cpu_is_mx23()) {
		mxs_add_dma(apbh, MX23_APBH_DMA_BASE_ADDR);
		mxs_add_dma(apbx, MX23_APBX_DMA_BASE_ADDR);
	}

	if (cpu_is_mx28()) {
		mxs_add_dma(apbh, MX28_APBH_DMA_BASE_ADDR);
		mxs_add_dma(apbx, MX28_APBX_DMA_BASE_ADDR);
	}

	return 0;
}
arch_initcall(mxs_add_mxs_dma);

No ifdef, clear to read and only half the size.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
