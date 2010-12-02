From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 2 Dec 2010 17:15:38 +0000
Subject: [PATCH 3/4] plat-s5p: Add platform support for MIPI-CSI2 devices
In-Reply-To: <1291307862-8125-4-git-send-email-s.nawrocki@samsung.com>
References: <1291307862-8125-1-git-send-email-s.nawrocki@samsung.com>
	<1291307862-8125-4-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20101202171538.GB30933@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On Thu, Dec 02, 2010 at 05:37:41PM +0100, Sylwester Nawrocki wrote:
> diff --git a/arch/arm/plat-s5p/dev-csis0.c b/arch/arm/plat-s5p/dev-csis0.c
> new file mode 100644
> index 0000000..2b1ba43
> --- /dev/null
> +++ b/arch/arm/plat-s5p/dev-csis0.c
> @@ -0,0 +1,34 @@
> +/*
> + * Copyright (C) 2010 Samsung Electronics
> + *
> + * S5P series device definition for MIPI-CSI device 0
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/kernel.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <mach/map.h>
> +
> +static struct resource s5p_csis_resource[] = {
> +	[0] = {
> +		.start = S5P_PA_CSIS0,
> +		.end   = S5P_PA_CSIS0 + SZ_4K - 1,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start = IRQ_MIPICSI0,
> +		.end   = IRQ_MIPICSI0,
> +		.flags = IORESOURCE_IRQ,
> +	}
> +};
Do you really need the [0] and [1] here? These are only needed if you are 
sparsely initialising an array.

> +
> +struct platform_device s5p_device_mipi_csis0 = {
> +	.name		  = "s5p-mipi-csis",
> +	.id		  = 0,
> +	.num_resources	  = 2,
.num_resources = ARRAY_SIZE(s5p_csis_resource),
> +	.resource	  = &s5p_csis_resource[0],
.resource = s5p_csis_resource,
> diff --git a/arch/arm/plat-s5p/dev-csis1.c b/arch/arm/plat-s5p/dev-csis1.c
> new file mode 100644
> index 0000000..7f21ea8
> --- /dev/null
> +++ b/arch/arm/plat-s5p/dev-csis1.c
> @@ -0,0 +1,33 @@
> +/*
> + * Copyright (C) 2010 Samsung Electronics
> + *
> + * S5P series device definition for MIPI-CSI device 1
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/kernel.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <mach/map.h>
> +
> +static struct resource s5p_csis_resource[] = {
> +	[0] = {
> +		.start = S5P_PA_CSIS1,
> +		.end   = S5P_PA_CSIS1 + SZ_4K - 1,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start = IRQ_MIPICSI1,
> +		.end   = IRQ_MIPICSI1,
> +		.flags = IORESOURCE_IRQ,
> +	},
> +};
> +struct platform_device s5p_device_mipi_csis1 = {
> +	.name		  = "s5p-mipi-csis",
> +	.id		  = 1,
> +	.num_resources	  = 2,
> +	.resource	  = &s5p_csis_resource[0],
> +};
The same goes here as for device 0.
> diff --git a/arch/arm/plat-samsung/include/plat/csis.h b/arch/arm/plat-samsung/include/plat/csis.h
> new file mode 100644
> index 0000000..6ea3a40
> --- /dev/null
> +++ b/arch/arm/plat-samsung/include/plat/csis.h
> @@ -0,0 +1,28 @@
> +/*
> + * Copyright (C) 2010 Samsung Electronics Co., Ltd
> + *
> + * S5P series MIPI CSI2 device support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef PLAT_CSIS_H_
> +#define PLAT_CSIS_H_ __FILE__
> +
> +/**
> + * struct s3c_platform_csis - default platform data for MIPI CSI2 interface
> + * @clock_rate: bus clock frequency
Should be @clk_rate to match the code below.
> + * @nlanes: number of MIPI data lanes used
> + * @alignment: MIPI data alignment in bits
> + * @hs_settle: HSYNC settle time (see CSIS_DPHYCTRL register description)
> + */
> +struct s3c_platform_csis {
> +	unsigned long clk_rate;
> +	u8 nlanes;
> +	u8 alignment;
> +	u8 hs_settle;
> +};
> +
> +#endif /* PLAT_CSIS_H_ */

Jamie
