From: lrg@kernel.org (Liam Girdwood)
Date: Fri, 08 Jul 2011 19:32:30 +0100
Subject: [PATCH] of: add devicetree API for regulator
In-Reply-To: <1310120428-22700-8-git-send-email-haojian.zhuang@marvell.com>
References: <1310120428-22700-1-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-2-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-3-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-4-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-5-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-6-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-7-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-8-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1310149950.3348.8.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-07-08 at 18:20 +0800, Haojian Zhuang wrote:
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  drivers/of/Kconfig           |    4 +
>  drivers/of/Makefile          |    1 +
>  drivers/of/of_regulator.c    |  166 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of_regulator.h |   34 +++++++++
>  4 files changed, 205 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/of/of_regulator.c
>  create mode 100644 include/linux/of_regulator.h
> 
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index d06a637..edb6601 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -75,4 +75,8 @@ config OF_PCI
>  	help
>  	  OpenFirmware PCI bus accessors
>  
> +config OF_REGULATOR
> +	def_tristate REGULATOR
> +	depends on REGULATOR
> +
>  endmenu # OF
> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> index f7861ed..83ca06f 100644
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@ -10,3 +10,4 @@ obj-$(CONFIG_OF_NET)	+= of_net.o
>  obj-$(CONFIG_OF_SPI)	+= of_spi.o
>  obj-$(CONFIG_OF_MDIO)	+= of_mdio.o
>  obj-$(CONFIG_OF_PCI)	+= of_pci.o
> +obj-$(CONFIG_OF_REGULATOR)	+= of_regulator.o
> diff --git a/drivers/of/of_regulator.c b/drivers/of/of_regulator.c
> new file mode 100644
> index 0000000..d523302
> --- /dev/null
> +++ b/drivers/of/of_regulator.c
> @@ -0,0 +1,166 @@
> +/*
> + * OF helpers for the Regulator API
> + *
> + * Copyright (c) 2011 Haojian Zhuang <haojian.zhuang@marvell.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/suspend.h>
> +
> +static int of_regulator_init_constraints(struct device_node *of_dev,
> +				struct regulation_constraints *constraints)
> +{
> +	const __be32 *p;
> +	const char *cp;
> +	const char *ops[] = {"voltage", "current", "mode", "status",
> +				"drms"};
> +	int i, size, len = 0, tmp = 0;
> +
> +	memset(constraints, 0, sizeof(struct regulation_constraints));
> +
> +	p = of_get_property(of_dev, "voltages", &size);
> +	if (p && size / sizeof(int) == 2) {
> +		constraints->min_uV = be32_to_cpu(*p++);
> +		constraints->max_uV = be32_to_cpu(*p);
> +	}
> +	p = of_get_property(of_dev, "currents", &size);
> +	if (p && size / sizeof(int) == 2) {
> +		constraints->min_uA = be32_to_cpu(*p++);
> +		constraints->max_uA = be32_to_cpu(*p);
> +	}
> +	p = of_get_property(of_dev, "modes-mask", NULL);
> +	if (p)
> +		constraints->valid_modes_mask = be32_to_cpu(*p);
> +	cp = of_get_property(of_dev, "ops-mask", &size);
> +	tmp = 0;
> +	if (cp && size > 0) {
> +		i = 0;
> +		do {
> +			len = strlen(ops[i]);
> +			if (!strncmp(cp, ops[i], len)) {
> +				constraints->valid_ops_mask |= 1 << i;
> +				/* need to handle '\0' */
> +				cp += len + 1;
> +				size = size - len - 1;
> +				i = 0;
> +			} else
> +				i++;
> +		} while (i < ARRAY_SIZE(ops));
> +		if (size > 0)
> +			printk(KERN_WARNING "Invalid string:%s\n", cp);
> +	}

This code could also do with a little more comments describing some of
the more complex logic (like the above block).

Liam
