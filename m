From: damien.riegel@savoirfairelinux.com (Damien Riegel)
Date: Fri, 30 Oct 2015 16:08:13 -0400
Subject: [PATCH v2 2/5] mfd: ts4800-syscon: add driver for TS-4800 syscon
In-Reply-To: <20151030175656.GF4058@x1>
References: <1446150450-22093-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1446150450-22093-3-git-send-email-damien.riegel@savoirfairelinux.com>
 <20151030175656.GF4058@x1>
Message-ID: <20151030200812.GB8666@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 30, 2015 at 05:56:56PM +0000, Lee Jones wrote:
> On Thu, 29 Oct 2015, Damien Riegel wrote:
> 
> > Driver for TS-4800 syscon. These registers belong to a FPGA that is
> > memory mapped and are used for counters, enable various IPs in the FPGA,
> > control LEDs, control IOs, etc.
> > 
> > Currently, only the watchdog is handled.
> 
> Why do you require your own syscon driver?
> 
> What's wrong with the generic one?
> 

The generic one uses a regmap_config with reg_stride set to 4 and val_bits
to 32.

TS-4800 syscon registers are 16-bit wide and must be accessed with 16
bit read and writes:
http://wiki.embeddedarm.com/wiki/TS-4800#Syscon

I will address the other issues in the next version (split commit,
license issue, style, and superfluous remove).

> > Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> > ---
> >  .../devicetree/bindings/mfd/ts4800-syscon.txt      | 12 ++++
> 
> Separate patch please.
> 
> >  drivers/mfd/Kconfig                                |  7 ++
> >  drivers/mfd/Makefile                               |  1 +
> >  drivers/mfd/ts4800-syscon.c                        | 84 ++++++++++++++++++++++
> >  include/linux/mfd/ts4800-syscon.h                  | 24 +++++++
> >  5 files changed, 128 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/ts4800-syscon.txt
> >  create mode 100644 drivers/mfd/ts4800-syscon.c
> >  create mode 100644 include/linux/mfd/ts4800-syscon.h
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/ts4800-syscon.txt b/Documentation/devicetree/bindings/mfd/ts4800-syscon.txt
> > new file mode 100644
> > index 0000000..8dbc12c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/ts4800-syscon.txt
> > @@ -0,0 +1,12 @@
> > +Technologic Systems Syscon
> > +
> > +Required properties:
> > +- compatible : must be "ts,ts4800-syscon"
> > +- reg : physical base address and length of memory mapped region
> > +
> > +Example:
> > +
> > +syscon at b0010000 {
> > +	compatible = "ts,ts4800-syscon";
> > +	reg = <0xb0010000 0x3d>;
> > +};
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 3f68dd2..8f03dce 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1302,6 +1302,13 @@ config MFD_TC6393XB
> >  	help
> >  	  Support for Toshiba Mobile IO Controller TC6393XB
> >  
> > +config MFD_TS4800_SYSCON
> > +	tristate "TS-4800 Syscon Support"
> > +	select REGMAP
> > +	select REGMAP_MMIO
> > +	help
> > +	  Support for TS-4800's FPGA Syscon registers
> > +
> >  config MFD_VX855
> >  	tristate "VIA VX855/VX875 integrated south bridge"
> >  	depends on PCI
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index ea40e07..e2c0f1b 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -181,6 +181,7 @@ obj-$(CONFIG_MFD_HI6421_PMIC)	+= hi6421-pmic-core.o
> >  obj-$(CONFIG_MFD_DLN2)		+= dln2.o
> >  obj-$(CONFIG_MFD_RT5033)	+= rt5033.o
> >  obj-$(CONFIG_MFD_SKY81452)	+= sky81452.o
> > +obj-$(CONFIG_MFD_TS4800_SYSCON)	+= ts4800-syscon.o
> >  
> >  intel-soc-pmic-objs		:= intel_soc_pmic_core.o intel_soc_pmic_crc.o
> >  obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
> > diff --git a/drivers/mfd/ts4800-syscon.c b/drivers/mfd/ts4800-syscon.c
> > new file mode 100644
> > index 0000000..1e42e96
> > --- /dev/null
> > +++ b/drivers/mfd/ts4800-syscon.c
> > @@ -0,0 +1,84 @@
> > +/*
> > + * Device driver for TS-4800 FPGA's syscon
> > + *
> > + * Copyright (c) 2015 - Savoir-faire Linux
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> 
> Why is the MFD v2+ and the Watchdog driver only v2?
> 
> > + * This program is distributed in the hope it will be useful, but WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> > + * more details.
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/mfd/ts4800-syscon.h>
> 
> Alphabetical.
> 
> > +
> > +
> 
> Superfluous '\n'.
> 
> > +static const struct regmap_config ts4800_regmap_config = {
> > +	.reg_bits = 32,
> > +	.reg_stride = 2,
> > +	.val_bits = 16,
> > +};
> > +
> > +static int ts4800_syscon_probe(struct platform_device *pdev)
> > +{
> > +	struct ts4800_syscon *syscon;
> > +	struct resource *res;
> > +	void __iomem *base;
> > +
> > +	syscon = devm_kzalloc(&pdev->dev, sizeof(*syscon), GFP_KERNEL);
> > +	if (!syscon)
> > +		return -ENOMEM;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	base = devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(base))
> > +		return PTR_ERR(base);
> > +
> > +	syscon->regmap = devm_regmap_init_mmio_clk(&pdev->dev, NULL, base,
> > +						   &ts4800_regmap_config);
> > +	if (IS_ERR(syscon->regmap)) {
> > +		dev_err(&pdev->dev,
> > +			"regmap init failed: %ld\n",
> > +			PTR_ERR(syscon->regmap));
> > +		return PTR_ERR(syscon->regmap);
> > +	}
> > +
> > +	platform_set_drvdata(pdev, syscon);
> > +
> > +	return 0;
> > +}
> > +
> > +static int ts4800_syscon_remove(struct platform_device *pdev)
> > +{
> > +	return 0;
> > +}
> 
> If it doesn't do anything, don't provide it.
> 
> > +static const struct of_device_id ts4800_syscon_of_match[] = {
> > +	{ .compatible = "ts,ts4800-syscon", },
> > +	{ },
> > +};
> > +
> > +static struct platform_driver ts4800_syscon_driver = {
> > +	.driver = {
> > +		.name	= "ts4800_syscon",
> > +		.of_match_table = ts4800_syscon_of_match,
> > +	},
> > +	.probe	= ts4800_syscon_probe,
> > +	.remove	= ts4800_syscon_remove,
> > +};
> > +module_platform_driver(ts4800_syscon_driver);
> > +
> > +MODULE_AUTHOR("Damien Riegel <damien.riegel@savoirfairelinux.com>");
> > +MODULE_DESCRIPTION("TS-4800 Syscon driver");
> > +MODULE_LICENSE("GPL v2");
> 
> This does not match the header.
> 
> > diff --git a/include/linux/mfd/ts4800-syscon.h b/include/linux/mfd/ts4800-syscon.h
> > new file mode 100644
> > index 0000000..3d29184
> > --- /dev/null
> > +++ b/include/linux/mfd/ts4800-syscon.h
> > @@ -0,0 +1,24 @@
> > +/*
> > + * Copyright (c) 2015 - Savoir-faire Linux
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope it will be useful, but WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> > + * more details.
> > + */
> > +
> > +#ifndef __LINUX_MFD_TS4800_SYSCON_H
> > +#define __LINUX_MFD_TS4800_SYSCON_H
> > +
> > +#include <linux/regmap.h>
> > +
> > +struct ts4800_syscon {
> > +	struct regmap		*regmap;
> > +};
> > +
> > +#endif /* __LINUX_MFD_TS4800_SYSCON_H */
> 
> -- 
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
