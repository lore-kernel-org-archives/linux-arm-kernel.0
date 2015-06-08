From: maitysanchayan@gmail.com (maitysanchayan at gmail.com)
Date: Mon, 8 Jun 2015 10:09:41 +0530
Subject: [PATCH v5 2/2] soc: Add driver for Freescale Vybrid Platform
In-Reply-To: <1433586367.10861.52.camel@x220>
References: <cover.1433494491.git.maitysanchayan@gmail.com>
 <d702301bce77fb08dd6556e93b553485f3e84b73.1433494491.git.maitysanchayan@gmail.com>
 <1433586367.10861.52.camel@x220>
Message-ID: <20150608043940.GB3497@Sanchayan-Arch.toradex.int>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Paul,

On 15-06-06 12:26:07, Paul Bolle wrote:
> On Fri, 2015-06-05 at 14:52 +0530, Sanchayan Maity wrote:
> > --- /dev/null
> > +++ b/drivers/soc/fsl/Kconfig
> 
> > +config SOC_BUS_VF610
> > +	   tristate "SoC bus device for the Freescale Vybrid platform"
> > +	   depends on SOC_VF610
> > +	   select SOC_BUS
> > +	   help
> > +	     Include support for the SoC bus on the Freescale Vybrid platform
> > +		 providing some sysfs information about the module variant.
> 
> > --- /dev/null
> > +++ b/drivers/soc/fsl/Makefile
> 
> > +obj-$(CONFIG_SOC_BUS_VF610)		+= soc-vf610.o
> 
> > --- /dev/null
> > +++ b/drivers/soc/fsl/soc-vf610.c
> > @@ -0,0 +1,166 @@
> > +/*
> > + * Copyright 2015 Toradex AG
> > + *
> > + * Author: Sanchayan Maity <sanchayan.maity@toradex.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2, as
> > + * published by the Free Software Foundation.
> > + *
> > + */
> > +
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/regmap.h>
> > +#include <linux/random.h>
> > +#include <linux/slab.h>
> > +#include <linux/sys_soc.h>
> > +
> > +#define DRIVER_NAME "vf610-soc-bus"
> > +
> > +#define MSCM_CPxCOUNT_OFFSET   0x0000002C
> > +#define MSCM_CPxCFG1_OFFSET    0x00000014
> > +
> > +struct vf610_soc {
> > +	struct device *dev;
> > +	struct soc_device_attribute *soc_dev_attr;
> > +	struct soc_device *soc_dev;
> > +};
> > +
> > +static int vf610_soc_probe(struct platform_device *pdev)
> > +{
> > +	struct vf610_soc *info;
> > +	struct regmap *ocotp_regmap, *mscm_regmap, *rom_regmap;
> > +	struct device *dev = &pdev->dev;
> > +	struct device_node *node = pdev->dev.of_node;
> > +	struct device_node *soc_node;
> > +	struct of_phandle_args pargs;
> > +	char soc_type[] = "xx0";
> > +	u32 cfg0_offset, cfg1_offset, rom_rev_offset;
> > +	u32 soc_id1, soc_id2, rom_rev;
> > +	u32 cpxcount, cpxcfg1;
> > +	u64 soc_id;
> > +	int ret;
> > +
> > +	info = devm_kzalloc(&pdev->dev, sizeof(struct vf610_soc), GFP_KERNEL);
> > +	if (!info)
> > +		return -ENOMEM;
> > +
> > +	info->dev = &pdev->dev;
> > +	platform_set_drvdata(pdev, info);
> > +
> > +	mscm_regmap = syscon_node_to_regmap(node);
> > +	if (IS_ERR(mscm_regmap)) {
> > +		dev_err(dev, "regmap lookup for mscm failed\n");
> > +		return PTR_ERR(mscm_regmap);
> > +	}
> > +
> > +	soc_node = of_find_node_by_path("/soc");
> > +
> > +	ret = of_parse_phandle_with_fixed_args(soc_node,
> > +					"ocotp-cfg", 2, 0, &pargs);
> > +	if (ret) {
> > +		dev_err(dev, "lookup failed for ocotp-cfg node %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ocotp_regmap = syscon_node_to_regmap(pargs.np);
> > +	if (IS_ERR(ocotp_regmap)) {
> > +		of_node_put(pargs.np);
> > +		dev_err(dev, "regmap lookup for ocotp failed\n");
> > +		return PTR_ERR(ocotp_regmap);
> > +	}
> > +
> > +	cfg0_offset = pargs.args[0];
> > +	cfg1_offset = pargs.args[1];
> > +	of_node_put(pargs.np);
> > +
> > +	ret = of_parse_phandle_with_fixed_args(soc_node,
> > +					"rom-revision", 1, 0, &pargs);
> > +	if (ret) {
> > +		dev_err(dev, "lookup failed for rom-revision node %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	rom_regmap = syscon_node_to_regmap(pargs.np);
> > +	if (IS_ERR(rom_regmap)) {
> > +		of_node_put(pargs.np);
> > +		dev_err(dev, "regmap lookup for ocrom failed\n");
> > +		return PTR_ERR(rom_regmap);
> > +	}
> > +
> > +	rom_rev_offset = pargs.args[0];
> > +	of_node_put(pargs.np);
> > +
> > +	ret = regmap_read(ocotp_regmap, cfg0_offset, &soc_id1);
> > +	if (ret)
> > +		return -ENODEV;
> > +
> > +	ret = regmap_read(ocotp_regmap, cfg1_offset, &soc_id2);
> > +	if (ret)
> > +		return -ENODEV;
> > +
> > +	soc_id = (u64) soc_id1 << 32 | soc_id2;
> > +	add_device_randomness(&soc_id, sizeof(soc_id));
> > +
> > +	ret = regmap_read(mscm_regmap, MSCM_CPxCOUNT_OFFSET, &cpxcount);
> > +	if (ret)
> > +		return -ENODEV;
> > +
> > +	ret = regmap_read(mscm_regmap, MSCM_CPxCFG1_OFFSET, &cpxcfg1);
> > +	if (ret)
> > +		return -ENODEV;
> > +
> > +	soc_type[0] = cpxcount ? '6' : '5'; /* Dual Core => VF6x0 */
> > +	soc_type[1] = cpxcfg1 ? '1' : '0'; /* L2 Cache => VFx10 */
> > +
> > +	ret = regmap_read(rom_regmap, rom_rev_offset, &rom_rev);
> > +	if (ret)
> > +		return -ENODEV;
> > +
> > +	info->soc_dev_attr = devm_kzalloc(&pdev->dev,
> > +				sizeof(info->soc_dev_attr), GFP_KERNEL);
> > +	if (!info->soc_dev_attr)
> > +		return -ENOMEM;
> > +
> > +	info->soc_dev_attr->machine = devm_kasprintf(&pdev->dev,
> > +				GFP_KERNEL, "Freescale Vybrid");
> > +	info->soc_dev_attr->soc_id = devm_kasprintf(&pdev->dev,
> > +				GFP_KERNEL, "%016llx", soc_id);
> > +	info->soc_dev_attr->family = devm_kasprintf(&pdev->dev,
> > +				GFP_KERNEL, "Freescale Vybrid VF%s",
> > +				soc_type);
> > +	info->soc_dev_attr->revision = devm_kasprintf(&pdev->dev,
> > +				GFP_KERNEL, "%08x", rom_rev);
> > +
> > +	info->soc_dev = soc_device_register(info->soc_dev_attr);
> > +	if (IS_ERR(info->soc_dev))
> > +		return -ENODEV;
> > +
> > +	return 0;
> > +}
> > +
> > +static int vf610_soc_remove(struct platform_device *pdev)
> > +{
> > +	struct vf610_soc *info = platform_get_drvdata(pdev);
> > +
> > +	if (info->soc_dev)
> > +		soc_device_unregister(info->soc_dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id vf610_soc_bus_match[] = {
> > +	{ .compatible = "fsl,vf610-mscm-cpucfg", },
> > +	{ /* sentinel */ }
> > +};
> > +
> > +static struct platform_driver vf610_soc_driver = {
> > +	.probe          = vf610_soc_probe,
> > +	.remove         = vf610_soc_remove,
> > +	.driver         = {
> > +		.name   = DRIVER_NAME,
> > +		.of_match_table = vf610_soc_bus_match,
> > +	},
> > +};
> > +module_platform_driver(vf610_soc_driver);
> 
> The Kconfig symbol is tristate now, but all module specific code is gone
> from this file (ie, MODULE_DEVICE_TABLE, MODULE_DESCRIPTION and
> MODULE_LICENSE). Why's that?

Sorry that this crept in. It is a mistake on my part. Will fix.

Thank you for the feedback.

- Sanchayan.
