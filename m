From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 10 Jun 2014 16:36:34 +0200
Subject: [PATCH v3 5/6] soc: samsung: exynos-chipid: Add Exynos Chipid
 driver support
In-Reply-To: <1399706419-13976-6-git-send-email-pankaj.dubey@samsung.com>
References: <1399706287-13919-1-git-send-email-y@samsung.com>
 <1399706419-13976-1-git-send-email-pankaj.dubey@samsung.com>
 <1399706419-13976-6-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <539717F2.3040108@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj,

On 10.05.2014 09:20, Pankaj Dubey wrote:
> Exynos SoCs have Chipid, for identification of product IDs
> and SoC revistions. Till now we are using static macros
> such as soc_is_exynosNNNN and #ifdefs for run time identification
> of SoCs and their revisions. This is leading to add new Kconfig,
> soc_is_exynosNNNN definitions each time new SoC support is getting
> added. So this driver intends to provide initialization code
> all these functionalites and thus helping in removing macros.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  drivers/soc/Kconfig                 |    1 +
>  drivers/soc/Makefile                |    1 +
>  drivers/soc/samsung/Kconfig         |   10 +++
>  drivers/soc/samsung/Makefile        |    1 +
>  drivers/soc/samsung/exynos-chipid.c |  166 +++++++++++++++++++++++++++++++++++
>  include/linux/exynos-soc.h          |   46 ++++++++++
>  6 files changed, 225 insertions(+)
>  create mode 100644 drivers/soc/samsung/Kconfig
>  create mode 100644 drivers/soc/samsung/Makefile
>  create mode 100644 drivers/soc/samsung/exynos-chipid.c
>  create mode 100644 include/linux/exynos-soc.h
> 
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index 07a11be..86e52b1 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -1,5 +1,6 @@
>  menu "SOC specific Drivers"
>  
>  source "drivers/soc/qcom/Kconfig"
> +source "drivers/soc/samsung/Kconfig"
>  
>  endmenu
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 0f7c447..ee890aa 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -3,3 +3,4 @@
>  #
>  
>  obj-$(CONFIG_ARCH_QCOM)		+= qcom/
> +obj-$(CONFIG_ARCH_EXYNOS)	+= samsung/

EXYNOS or samsung/?

Also this is just a single file, is it necessary to create a directory
for it?

> diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
> new file mode 100644
> index 0000000..dacc95d
> --- /dev/null
> +++ b/drivers/soc/samsung/Kconfig
> @@ -0,0 +1,10 @@
> +
> +# SAMSUNG Soc drivers
> +#
> +config EXYNOS_CHIPID
> +	tristate "Support Exynos CHIPID"
> +	default y
> +	select SOC_BUS
> +	depends on ARCH_EXYNOS || ARM64
> +	help
> +	  If you say Y here you get support for the Exynos CHIP id.

Do we need to have this user-selectable? Couldn't we just have it
selected by ARCH_EXYNOS and its 64-bit counterpart? AFAIK per-family
Kconfig symbols are already present (see ARCH_VEXPRESS and ARCH_XGENE in
arch/arm64/Kconfig), so it is not a problem.

> diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
> new file mode 100644
> index 0000000..855ca05
> --- /dev/null
> +++ b/drivers/soc/samsung/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_EXYNOS_CHIPID)	+= exynos-chipid.o
> diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
> new file mode 100644
> index 0000000..b5bccd9
> --- /dev/null
> +++ b/drivers/soc/samsung/exynos-chipid.c
> @@ -0,0 +1,166 @@
> +/*
> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
> + *	      http://www.samsung.com/
> + *
> + * EXYNOS - CHIP ID support
> + * Author: Pankaj Dubey <pankaj.dubey@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <linux/sys_soc.h>
> +#include <linux/of_address.h>
> +#include <linux/exynos-soc.h>
> +
> +#define EXYNOS4_SOC_MASK	0xFFFE0

Even though I can see the mask defined in current code to the value
above, the documentation states that the whole bit field [31:12] is used
for product ID, so it should be safe to use the same mask as for Exynos5.

> +#define EXYNOS5_SOC_MASK	0xFFFFF
> +
> +#define PROD_ID_SHIFT	(12)
> +
> +static void __iomem	*exynos_chipid_base;
> +unsigned int exynos_soc_id = EXYNOS_SOC_UNKNOWN;

static?

> +enum exynos_soc_revision exynos_revision;

static?

> +
> +struct exynos_chipid_data {
> +	unsigned int product_id_mask;
> +	unsigned int product_id_shift;
> +};
> +
> +static struct exynos_chipid_data exynos4_chipid_data = {
> +	.product_id_mask	= EXYNOS4_SOC_MASK,
> +	.product_id_shift	= PROD_ID_SHIFT,
> +};
> +
> +static struct exynos_chipid_data exynos5_chipid_data = {
> +	.product_id_mask	= EXYNOS5_SOC_MASK,
> +	.product_id_shift	= PROD_ID_SHIFT,
> +};
> +
> +static struct of_device_id of_exynos_chipid_ids[] = {
> +	{
> +		.compatible	= "samsung,exynos4-chipid",
> +		.data		= (void *)&exynos4_chipid_data,
> +	},
> +	{
> +		.compatible	= "samsung,exynos5-chipid",
> +		.data		= (void *)&exynos5_chipid_data,

We already have "samsung,exynos4210-chipid" compatible string defined
and used in existing device tree sources (and deployed DTBs).

> +	},
> +	{},
> +};
> +
> +bool is_soc_id_compatible(enum exynos_soc_id soc_id)
> +{
> +	return soc_id == exynos_soc_id;
> +}
> +
> +bool is_soc_rev_compatible(enum exynos_soc_revision soc_rev)
> +{
> +	return soc_rev == exynos_revision;
> +}

I don't think we need this API. (See below.)

> +
> +static const char *exynos_soc_id_to_name(enum exynos_soc_id id)
> +{
> +	const char *soc_name;
> +	switch (id) {
> +	case EXYNOS4210:
> +		soc_name = "EXYNOS4210";
> +		break;
> +	case EXYNOS4212:
> +		soc_name = "EXYNOS4212";
> +		break;
> +	case EXYNOS4412:
> +		soc_name = "EXYNOS4412";
> +		break;
> +	case EXYNOS5250:
> +		soc_name = "EXYNOS5250";
> +		break;
> +	case EXYNOS5420:
> +		soc_name = "EXYNOS5420";
> +		break;
> +	case EXYNOS5440:
> +		soc_name = "EXYNOS5440";
> +		break;
> +	default:
> +		soc_name = "";
> +	}
> +	return soc_name;
> +}
> +
> +struct device * __init exynos_soc_device_init(void)
> +{
> +	struct soc_device_attribute *soc_dev_attr;
> +	struct soc_device *exynos_soc_dev;
> +	struct device_node *root;
> +	int ret;
> +
> +	if (!exynos_chipid_base)
> +		early_exynos_chipid_init();
> +
> +	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> +	if (!soc_dev_attr)
> +		return NULL;
> +
> +	soc_dev_attr->family = "Samsung Exynos";
> +
> +	root = of_find_node_by_path("/");
> +	ret = of_property_read_string(root, "model", &soc_dev_attr->machine);
> +	of_node_put(root);
> +	if (ret)
> +		goto free_soc;
> +
> +	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%d", exynos_revision);
> +	if (!soc_dev_attr->revision)
> +		goto free_soc;
> +
> +	soc_dev_attr->soc_id = exynos_soc_id_to_name(exynos_soc_id);
> +
> +	exynos_soc_dev = soc_device_register(soc_dev_attr);
> +	if (IS_ERR(exynos_soc_dev))
> +		goto free_rev;
> +
> +	return soc_device_to_device(exynos_soc_dev);
> +
> +free_rev:
> +	kfree(soc_dev_attr->revision);
> +free_soc:
> +	kfree(soc_dev_attr);
> +	return NULL;
> +}
> +
> +/**
> + * early_exynos_chipid_init - Early chipid initialization
> + */
> +void __init early_exynos_chipid_init(void)
> +{
> +	struct device_node *np = NULL;
> +	const struct of_device_id *match;
> +	struct exynos_chipid_data *chipid_data;
> +	int pro_id;
> +
> +	if (!exynos_chipid_base) {
> +		np = of_find_matching_node_and_match(NULL,
> +				of_exynos_chipid_ids, &match);
> +		if (!np)
> +			panic("%s, failed to find chipid node\n", __func__);
> +
> +		chipid_data = (struct exynos_chipid_data *) match->data;
> +		exynos_chipid_base = of_iomap(np, 0);
> +
> +		if (!exynos_chipid_base)
> +			panic("%s: failed to map registers\n", __func__);
> +
> +		pro_id  = __raw_readl(exynos_chipid_base);
> +		exynos_soc_id = (pro_id >> chipid_data->product_id_shift)
> +			& chipid_data->product_id_mask;
> +		exynos_revision = pro_id & 0xFF;
> +		pr_info("Exynos: CPU[%s] CPU_REV[0x%x] Detected\n",
> +				exynos_soc_id_to_name(exynos_soc_id),
> +				exynos_revision);
> +	}
> +
> +}

Basically this API is not much better than soc_is_exynos*(). The goal is
to get rid of per-SoC checks, not provide another API to do this.

In general, a SoC driver may be useful, though. So my proposal is to
strip the whole questionable API from this driver, make it a platform
driver and let it simply register the SoC device.

> diff --git a/include/linux/exynos-soc.h b/include/linux/exynos-soc.h
> new file mode 100644
> index 0000000..ebd4366
> --- /dev/null
> +++ b/include/linux/exynos-soc.h
> @@ -0,0 +1,46 @@
> +/*
> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * Header for EXYNOS SoC Chipid support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __EXYNOS_SOC_H
> +#define __EXYNOS_SOC_H
> +
> +/* enum holding product id of Exynos SoC
> + * Any new Exynos SoC product id should be added here
> + */
> +enum exynos_soc_id {
> +	EXYNOS4210 = 0xE4210,

This is not the correct ID of Exynos4210. The correct one is 0x43210.

> +	EXYNOS4212 = 0xE4212,

Should be 0x43220.

> +	EXYNOS4412 = 0xE4412,
> +	EXYNOS5250 = 0x43520,
> +	EXYNOS5420 = 0xE5420,
> +	EXYNOS5440 = 0xE5440,
> +	EXYNOS_SOC_UNKNOWN = -1,
> +};
> +
> +/* enum holding revision id of Exynos SoC
> + * Any new Exynos SoC revision id should be added here
> + */
> +enum exynos_soc_revision {
> +	EXYNOS4210_REV_0	= 0x0,
> +	EXYNOS4210_REV_1_0	= 0x10,
> +	EXYNOS4210_REV_1_1	= 0x11,
> +};

AFAIK, considering my comments above, both SoC and revision IDs can be
defined as macros inside the .c file.

Best regards,
Tomasz
