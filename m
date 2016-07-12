From: rajesh.bhagat@nxp.com (Rajesh Bhagat)
Date: Tue, 12 Jul 2016 03:59:25 +0000
Subject: [PATCH v2 3/5] drivers: usb: phy: Add qoriq usb 2.0 phy driver
 support
In-Reply-To: <20160711065408.GI31647@shlinux2>
References: <1468038656-10345-1-git-send-email-rajesh.bhagat@nxp.com>
 <1468038656-10345-4-git-send-email-rajesh.bhagat@nxp.com>
 <20160711065408.GI31647@shlinux2>
Message-ID: <HE1PR0401MB233137AA62EA4467BFDDF365E3300@HE1PR0401MB2331.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Peter Chen [mailto:hzpeterchen at gmail.com]
> Sent: Monday, July 11, 2016 12:24 PM
> To: Rajesh Bhagat <rajesh.bhagat@nxp.com>
> Cc: linux-usb at vger.kernel.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; Peter Chen <peter.chen@nxp.com>;
> gregkh at linuxfoundation.org; kishon at ti.com; robh+dt at kernel.org;
> shawnguo at kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v2 3/5] drivers: usb: phy: Add qoriq usb 2.0 phy driver support
> 
> On Sat, Jul 09, 2016 at 10:00:54AM +0530, Rajesh Bhagat wrote:
> > Adds qoriq usb 2.0 phy driver support for LS1021A and LS1012A
> > platform.
> >
> > Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
> > ---
> > Changes in v2:
> >  - Replaced Freescale with QorIQ in comments section
> >  - Changed the compatible string to fsl,qoriq-usb2-phy and added
> > version
> >  - Added dependency on ARCH_MXC/ARCH_LAYERSCAPE and OF in Kconfig
> >  - Dropped CONFIG_ULPI #ifdefs to make code generic
> >  - Removed calls to devm free/release calls
> >
> >  drivers/phy/Kconfig          |   8 ++
> >  drivers/phy/Makefile         |   1 +
> >  drivers/phy/phy-qoriq-usb2.c | 228
> > +++++++++++++++++++++++++++++++++++++++++++
> >  drivers/phy/phy-qoriq-usb2.h |  50 ++++++++++
> >  4 files changed, 287 insertions(+)
> >  create mode 100644 drivers/phy/phy-qoriq-usb2.c  create mode 100644
> > drivers/phy/phy-qoriq-usb2.h
> >
> > diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig index
> > b869b98..cc69299 100644
> > --- a/drivers/phy/Kconfig
> > +++ b/drivers/phy/Kconfig
> > @@ -434,4 +434,12 @@ config PHY_CYGNUS_PCIE
> >
> >  source "drivers/phy/tegra/Kconfig"
> >
> > +config PHY_QORIQ_USB2
> > +	tristate "QorIQ USB 2.0 PHY driver"
> > +	depends on ARCH_MXC || ARCH_LAYERSCAPE
> 

Hello Peter,

> It seems mxc platforms do not use this PHY.
> Besides, if you are using ULPI phy, you need to depend on ULPI bus.
> 

QorIQ platform are having both ULPI and non-ULPI PHY variants, Hence
this PHY driver is targeted for both. And driver takes decision on run time 
which PHY is there according to information passed in DTS files. 


Best Regards,
Rajesh Bhagat 

> Peter
> > +	depends on OF
> > +	select GENERIC_PHY
> > +	help
> > +	  Enable this to support the USB2.0 PHY on the QorIQ SoC.
> > +
> >  endmenu
> > diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile index
> > 9c3e73c..044105a 100644
> > --- a/drivers/phy/Makefile
> > +++ b/drivers/phy/Makefile
> > @@ -53,5 +53,6 @@ obj-$(CONFIG_PHY_TUSB1210)		+= phy-tusb1210.o
> >  obj-$(CONFIG_PHY_BRCM_SATA)		+= phy-brcm-sata.o
> >  obj-$(CONFIG_PHY_PISTACHIO_USB)		+= phy-pistachio-usb.o
> >  obj-$(CONFIG_PHY_CYGNUS_PCIE)		+= phy-bcm-cygnus-pcie.o
> > +obj-$(CONFIG_PHY_QORIQ_USB2)            += phy-qoriq-usb2.o
> >
> >  obj-$(CONFIG_ARCH_TEGRA) += tegra/
> > diff --git a/drivers/phy/phy-qoriq-usb2.c
> > b/drivers/phy/phy-qoriq-usb2.c new file mode 100644 index
> > 0000000..f74d255
> > --- /dev/null
> > +++ b/drivers/phy/phy-qoriq-usb2.c
> > @@ -0,0 +1,228 @@
> > +/*
> > + * QorIQ SoC USB 2.0 PHY driver
> > + *
> > + * Copyright 2016 Freescale Semiconductor, Inc.
> > + * Author: Rajesh Bhagat <rajesh.bhagat@nxp.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > +modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + */
> > +#include <linux/clk.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/io.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/usb/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/phy/phy.h>
> > +#include <linux/usb/phy.h>
> > +#include <linux/usb/ulpi.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include "phy-qoriq-usb2.h"
> > +
> > +static int qoriq_usb2_phy_init(struct phy *_phy) {
> > +	struct qoriq_usb2_phy_ctx *ctx = phy_get_drvdata(_phy);
> > +	struct device *dev = ctx->dev;
> > +
> > +	if (ctx->ulpi_phy) {
> > +		if (usb_phy_init(ctx->ulpi_phy)) {
> > +			dev_err(dev, "unable to init transceiver, probably missing\n");
> > +			return -ENODEV;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int qoriq_usb2_phy_power_on(struct phy *_phy) {
> > +	struct qoriq_usb2_phy_ctx *ctx = phy_get_drvdata(_phy);
> > +	u32 flags;
> > +
> > +	if (ctx->ulpi_phy) {
> > +		flags = usb_phy_io_read(ctx->ulpi_phy, ULPI_OTG_CTRL);
> > +		usb_phy_io_write(ctx->ulpi_phy, flags |
> > +				 (ULPI_OTG_CTRL_DRVVBUS_EXT |
> > +				 ULPI_OTG_CTRL_EXTVBUSIND), ULPI_OTG_CTRL);
> > +		flags = usb_phy_io_read(ctx->ulpi_phy, ULPI_IFC_CTRL);
> > +		usb_phy_io_write(ctx->ulpi_phy, flags |
> > +				 (ULPI_IFC_CTRL_EXTERNAL_VBUS |
> > +				 ULPI_IFC_CTRL_PASSTHRU), ULPI_IFC_CTRL);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int qoriq_usb2_phy_power_off(struct phy *_phy) {
> > +	/* TODO: Add logic to power off phy */
> > +
> > +	return 0;
> > +}
> > +
> > +static int qoriq_usb2_phy_exit(struct phy *_phy) {
> > +	struct qoriq_usb2_phy_ctx *ctx = phy_get_drvdata(_phy);
> > +
> > +	if (ctx->ulpi_phy)
> > +		usb_phy_shutdown(ctx->ulpi_phy);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct phy_ops ops = {
> > +	.init		= qoriq_usb2_phy_init,
> > +	.power_on	= qoriq_usb2_phy_power_on,
> > +	.power_off	= qoriq_usb2_phy_power_off,
> > +	.exit		= qoriq_usb2_phy_exit,
> > +	.owner		= THIS_MODULE,
> > +};
> > +
> > +
> > +static enum qoriq_usb2_phy_ver of_usb_get_phy_version(struct
> > +device_node *np) {
> > +	enum qoriq_usb2_phy_ver phy_version = QORIQ_PHY_UNKNOWN;
> > +
> > +	if (of_device_is_compatible(np, "fsl,qoriq-usb2-phy")) {
> > +		if (of_device_is_compatible(np, "fsl,qoriq-usb2-phy-v1.0"))
> > +			phy_version = QORIQ_PHY_LEGACY;
> > +		else if (of_device_is_compatible(np, "fsl,qoriq-usb2-phy-v2.0"))
> > +			phy_version = QORIQ_PHY_NXP_ISP1508;
> > +	}
> > +	return phy_version;
> > +}
> > +
> > +static int qoriq_usb2_phy_probe(struct platform_device *pdev) {
> > +	int ret;
> > +	struct resource *res;
> > +	struct qoriq_usb2_phy_ctx *ctx;
> > +	struct device *dev = &pdev->dev;
> > +	const struct of_device_id *of_id;
> > +	struct phy_provider *phy_provider;
> > +	struct device_node *np = pdev->dev.of_node;
> > +
> > +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> > +	if (!ctx)
> > +		return -ENOMEM;
> > +
> > +	ctx->dev = dev;
> > +
> > +	of_id = of_match_device(dev->driver->of_match_table, dev);
> > +	if (!of_id) {
> > +		dev_err(dev, "failed to get device match\n");
> > +		ret = -EINVAL;
> > +		goto err_out;
> > +	}
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res) {
> > +		dev_err(dev, "failed to get I/O memory\n");
> > +		ret = -ENOENT;
> > +		goto err_out;
> > +	}
> > +
> > +	ctx->regs = devm_ioremap(dev, res->start, resource_size(res));
> > +	if (!ctx->regs) {
> > +		dev_err(dev, "failed to remap I/O memory\n");
> > +		ret = -ENOMEM;
> > +		goto err_out;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, ctx);
> > +
> > +	ctx->phy = devm_phy_create(ctx->dev, NULL, &ops);
> > +	if (IS_ERR(ctx->phy)) {
> > +		dev_err(dev, "failed to create PHY\n");
> > +		ret = PTR_ERR(ctx->phy);
> > +		goto err_out;
> > +	}
> > +	phy_set_drvdata(ctx->phy, ctx);
> > +
> > +	ctx->phy_version = of_usb_get_phy_version(np);
> > +	if (ctx->phy_version == QORIQ_PHY_UNKNOWN) {
> > +		ret = -EINVAL;
> > +		dev_err(dev, "failed to get PHY version\n");
> > +		goto err_out;
> > +	}
> > +
> > +	ctx->phy_type = of_usb_get_phy_mode(np);
> > +	switch (ctx->phy_type) {
> > +	case USBPHY_INTERFACE_MODE_ULPI:
> > +		switch (ctx->phy_version) {
> > +		case QORIQ_PHY_NXP_ISP1508:
> > +			ctx->ulpi_phy = qoriq_otg_ulpi_create(0);
> > +			if (!ctx->ulpi_phy) {
> > +				dev_err(dev, "qoriq_otg_ulpi_create returned NULL\n");
> > +				ret = -ENOMEM;
> > +				goto err_out;
> > +			}
> > +			ctx->ulpi_phy->io_priv = ctx->regs + ULPI_VIEWPORT;
> > +			break;
> > +		default:
> > +			ctx->ulpi_phy = NULL;
> > +			break;
> > +		}
> > +		break;
> > +	default:
> > +		dev_err(&pdev->dev, "phy_type %d is invalid or unsupported\n",
> > +			ctx->phy_type);
> > +		ret = -EINVAL;
> > +		goto err_out;
> > +	}
> > +
> > +	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> > +	if (IS_ERR(phy_provider)) {
> > +		dev_err(dev, "failed to register phy_provider\n");
> > +		ret = PTR_ERR_OR_ZERO(phy_provider);
> > +		goto err_out;
> > +	}
> > +
> > +	dev_dbg(dev, "initialized\n");
> > +	return 0;
> > +
> > +err_out:
> > +	return ret;
> > +}
> > +
> > +static int qoriq_usb2_phy_remove(struct platform_device *pdev) {
> > +	struct device *dev = &pdev->dev;
> > +	struct qoriq_usb2_phy_ctx *ctx = platform_get_drvdata(pdev);
> > +
> > +	devm_phy_destroy(ctx->dev, ctx->phy);
> > +	devm_iounmap(dev, ctx->regs);
> > +	dev_dbg(dev, "de-initialized\n");
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id qoriq_usb2_phy_dt_ids[] = {
> > +	{ .compatible = "fsl,qoriq-usb2-phy"},
> > +	{}
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, qoriq_usb2_phy_dt_ids);
> > +
> > +static struct platform_driver qoriq_usb2_phy_driver = {
> > +	.probe		= qoriq_usb2_phy_probe,
> > +	.remove		= qoriq_usb2_phy_remove,
> > +	.driver		= {
> > +		.name	= "qoriq_usb2_phy",
> > +		.owner		= THIS_MODULE,
> > +		.of_match_table = of_match_ptr(qoriq_usb2_phy_dt_ids),
> > +	},
> > +};
> > +
> > +module_platform_driver(qoriq_usb2_phy_driver);
> > +
> > +MODULE_ALIAS("platform:qoriq-usb2-phy");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("QorIQ SoC USB PHY driver"); MODULE_AUTHOR("Rajesh
> > +Bhagat <rajesh.bhagat@nxp.com>");
> > diff --git a/drivers/phy/phy-qoriq-usb2.h
> > b/drivers/phy/phy-qoriq-usb2.h new file mode 100644 index
> > 0000000..47c37a5
> > --- /dev/null
> > +++ b/drivers/phy/phy-qoriq-usb2.h
> > @@ -0,0 +1,50 @@
> > +/*
> > + * Freescale SoC USB 2.0 PHY driver
> > + *
> > + * Copyright 2016 Freescale Semiconductor, Inc.
> > + * Author: Rajesh Bhagat <rajesh.bhagat@nxp.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > +modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + */
> > +#ifndef _PHY_QORIQ_USB2_H
> > +#define _PHY_QORIQ_USB2_H
> > +
> > +#include <linux/clk.h>
> > +#include <linux/phy/phy.h>
> > +#include <linux/device.h>
> > +#include <linux/regmap.h>
> > +
> > +#define ULPI_VIEWPORT           0x170
> > +
> > +enum qoriq_usb2_phy_ver {
> > +	QORIQ_PHY_LEGACY,
> > +	QORIQ_PHY_NXP_ISP1508,
> > +	QORIQ_PHY_UNKNOWN,
> > +};
> > +
> > +struct qoriq_usb2_phy_ctx {
> > +	struct phy *phy;
> > +	struct clk *clk;
> > +	struct device *dev;
> > +	void __iomem *regs;
> > +	struct usb_phy *ulpi_phy;
> > +	enum usb_phy_interface phy_type;
> > +	enum qoriq_usb2_phy_ver phy_version; };
> > +
> > +#ifdef CONFIG_USB_ULPI_VIEWPORT
> > +static inline struct usb_phy *qoriq_otg_ulpi_create(unsigned int
> > +flags) {
> > +	return otg_ulpi_create(&ulpi_viewport_access_ops, flags); } #else
> > +static inline struct usb_phy *qoriq_otg_ulpi_create(unsigned int
> > +flags) {
> > +	return NULL;
> > +}
> > +#endif
> > +
> > +#endif
> > --
> > 2.6.2.198.g614a2ac
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-usb"
> > in the body of a message to majordomo at vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> 
> Best Regards,
> Peter Chen
