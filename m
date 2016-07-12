From: rajesh.bhagat@nxp.com (Rajesh Bhagat)
Date: Tue, 12 Jul 2016 03:59:07 +0000
Subject: [PATCH v2 1/5] drivers: usb: chipidea: Add qoriq platform driver
In-Reply-To: <20160711064358.GG31647@shlinux2>
References: <1468038656-10345-1-git-send-email-rajesh.bhagat@nxp.com>
 <1468038656-10345-2-git-send-email-rajesh.bhagat@nxp.com>
 <20160711064358.GG31647@shlinux2>
Message-ID: <HE1PR0401MB2331ED4FB7F699A8A1BA0BE6E3300@HE1PR0401MB2331.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Peter Chen [mailto:hzpeterchen at gmail.com]
> Sent: Monday, July 11, 2016 12:14 PM
> To: Rajesh Bhagat <rajesh.bhagat@nxp.com>
> Cc: linux-usb at vger.kernel.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; Peter Chen <peter.chen@nxp.com>;
> gregkh at linuxfoundation.org; kishon at ti.com; robh+dt at kernel.org;
> shawnguo at kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v2 1/5] drivers: usb: chipidea: Add qoriq platform driver
> 
> On Sat, Jul 09, 2016 at 10:00:52AM +0530, Rajesh Bhagat wrote:
> > Adds qoriq platform driver for chipidea controller, verfied on LS1021A
> > and LS1012A platforms.
> >
> > Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
> > ---
> > Changes in v2:
> >  - Replaced Freescale with QorIQ in comments section
> >  - Added macros to remove hardcoding while programming registers
> >  - Changed the compatible string to fsl,ci-qoriq-usb2 and added
> > version
> >  - Removed calls to devm free/release calls
> >
> >  drivers/usb/chipidea/Makefile        |   2 +
> >  drivers/usb/chipidea/ci_hdrc_qoriq.c | 237
> > +++++++++++++++++++++++++++++++++++
> >  drivers/usb/chipidea/ci_hdrc_qoriq.h |  65 ++++++++++
> >  3 files changed, 304 insertions(+)
> >  create mode 100644 drivers/usb/chipidea/ci_hdrc_qoriq.c
> >  create mode 100644 drivers/usb/chipidea/ci_hdrc_qoriq.h
> >
> > diff --git a/drivers/usb/chipidea/Makefile
> > b/drivers/usb/chipidea/Makefile index 518e445..3122b86b 100644
> > --- a/drivers/usb/chipidea/Makefile
> > +++ b/drivers/usb/chipidea/Makefile
> > @@ -14,3 +14,5 @@ obj-$(CONFIG_USB_CHIPIDEA)	+= ci_hdrc_zevio.o
> >  obj-$(CONFIG_USB_CHIPIDEA_PCI)	+= ci_hdrc_pci.o
> >
> >  obj-$(CONFIG_USB_CHIPIDEA_OF)	+= usbmisc_imx.o ci_hdrc_imx.o
> > +
> > +obj-$(CONFIG_USB_CHIPIDEA)      += ci_hdrc_qoriq.o
> > diff --git a/drivers/usb/chipidea/ci_hdrc_qoriq.c
> > b/drivers/usb/chipidea/ci_hdrc_qoriq.c
> > new file mode 100644
> > index 0000000..3f478c6
> > --- /dev/null
> > +++ b/drivers/usb/chipidea/ci_hdrc_qoriq.c
> > @@ -0,0 +1,237 @@
> > +/*
> > + * QorIQ SoC USB 2.0 Controller driver
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
> > +#include <linux/module.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/of_gpio.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/usb/of.h>
> > +#include <linux/usb/chipidea.h>
> > +#include <linux/clk.h>
> > +
> > +#include "ci.h"
> > +#include "ci_hdrc_qoriq.h"
> > +
> > +struct ci_hdrc_qoriq_data {
> > +	struct phy *phy;
> > +	struct clk *clk;
> > +	void __iomem *qoriq_regs;
> > +	struct platform_device *ci_pdev;
> > +	enum usb_phy_interface phy_mode;
> > +};
> > +
> > +/*
> > + * clock helper functions
> > + */
> > +static int ci_hdrc_qoriq_get_clks(struct platform_device *pdev) {
> > +	int ret;
> > +	struct device *dev = &pdev->dev;
> > +	struct ci_hdrc_qoriq_data *data = platform_get_drvdata(pdev);
> > +
> > +	data->clk = devm_clk_get(dev, "usb2-clock");
> > +	if (IS_ERR(data->clk)) {
> > +		dev_err(dev, "failed to get clk, err=%ld\n",
> > +					PTR_ERR(data->clk));
> > +			return ret;

Hello Peter, 

> 
> return PTR_ERR(data->clk), and delete ret.
> 

Will take care in v3. 

> > +	}
> > +	return 0;
> > +}
> > +
> > +static int ci_hdrc_qoriq_prepare_enable_clks(struct platform_device
> > +*pdev) {
> > +	int ret;
> > +	struct device *dev = &pdev->dev;
> > +	struct ci_hdrc_qoriq_data *data = platform_get_drvdata(pdev);
> > +
> > +	ret = clk_prepare_enable(data->clk);
> > +	if (ret) {
> > +		dev_err(dev, "failed to prepare/enable clk, err=%d\n", ret);
> > +		return ret;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static void ci_hdrc_qoriq_disable_unprepare_clks(struct
> > +platform_device *pdev) {
> > +	struct ci_hdrc_qoriq_data *data = platform_get_drvdata(pdev);
> > +
> > +	clk_disable_unprepare(data->clk);
> > +}
> > +
> > +static int ci_hdrc_qoriq_usb_setup(struct platform_device *pdev) {
> > +	u32 reg;
> > +	struct resource *res;
> > +	struct device *dev = &pdev->dev;
> > +	struct ci_hdrc_qoriq_data *data = platform_get_drvdata(pdev);
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res) {
> > +		dev_err(dev, "failed to get I/O memory\n");
> > +		return -ENOENT;
> > +	}
> > +
> > +	dev_dbg(dev, "res->start %llx, resource_size(res) %llx\n", res->start,
> > +		resource_size(res));
> 
> Delete above debug message please.
> 

Will take care in v3. 

> > +	data->qoriq_regs = devm_ioremap(dev, res->start, resource_size(res));
> > +	if (IS_ERR(data->qoriq_regs)) {
> > +		dev_err(dev, "failed to remap I/O memory\n");
> > +		return -ENOMEM;
> > +	}
> > +
> 
> This mapping will be freed soon, using ioremap instead.
> 

Correct. It is not required afterwards. Will use ioremap instead of 
devm_ioremap in v3. 

> > +	data->phy_mode = of_usb_get_phy_mode(pdev->dev.of_node);
> > +	dev_dbg(dev, "phy_mode %d\n", data->phy_mode);
> 
> Delete above debug message please.
> 

Will take care in v3. 

> > +
> > +	reg = ioread32be(data->qoriq_regs + QORIQ_SOC_USB_CTRL);
> > +	switch (data->phy_mode) {
> > +	case USBPHY_INTERFACE_MODE_ULPI:
> > +		iowrite32be(reg | ~UTMI_PHY_EN,
> > +			    data->qoriq_regs + QORIQ_SOC_USB_CTRL);
> > +		reg = ioread32be(data->qoriq_regs + QORIQ_SOC_USB_CTRL);
> > +		iowrite32be(reg | USB_CTRL_USB_EN,
> > +			    data->qoriq_regs + QORIQ_SOC_USB_CTRL);
> > +		break;
> > +	default:
> > +		dev_err(dev, "unsupported phy_mode %d\n", data->phy_mode);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Setup Snooping for all the 4GB space */
> > +	/* SNOOP1 starts from 0x0, size 2G */
> > +	iowrite32be(SNOOP_SIZE_2GB, data->qoriq_regs +
> QORIQ_SOC_USB_SNOOP1);
> > +	/* SNOOP2 starts from 0x80000000, size 2G */
> > +	iowrite32be(SNOOP_SIZE_2GB | 0x80000000,
> > +		data->qoriq_regs + QORIQ_SOC_USB_SNOOP2);
> 
> What does this snoop mean?
> 

Snoop here refers to the cache coherency capability of Soc. 

> > +
> > +	iowrite32be(PRICTRL_PRI_LVL, data->qoriq_regs +
> QORIQ_SOC_USB_PRICTRL);
> > +	iowrite32be(AGECNTTHRSH_THRESHOLD, data->qoriq_regs +
> > +		    QORIQ_SOC_USB_AGECNTTHRSH);
> > +	iowrite32be(SICTRL_RD_PREFETCH_32_BYTE, data->qoriq_regs +
> > +		    QORIQ_SOC_USB_SICTRL);
> > +
> > +	devm_iounmap(dev, data->qoriq_regs);
> 
> iounmap.

Will take care in v3. 

> 
> > +	return 0;
> > +}
> > +
> > +static int ci_hdrc_qoriq_probe(struct platform_device *pdev) {
> > +	int ret;
> > +	struct device *dev = &pdev->dev;
> > +	struct ci_hdrc_qoriq_data *data;
> > +	struct ci_hdrc_platform_data pdata = {
> > +		.name		= dev_name(dev),
> > +		.capoffset	= DEF_CAPOFFSET,
> > +		.flags		= CI_HDRC_DISABLE_STREAMING,
> > +	};
> > +
> > +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> > +	if (!data)
> > +		return -ENOMEM;
> > +
> > +	platform_set_drvdata(pdev, data);
> > +
> > +	ret = ci_hdrc_qoriq_get_clks(pdev);
> > +	if (ret)
> > +		goto err_out;
> > +
> > +	ret = ci_hdrc_qoriq_prepare_enable_clks(pdev);
> > +	if (ret)
> > +		goto err_out;
> 
> Why not return directly?
> 

Okay. Will return directly from here in v3. 

> > +
> > +	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
> > +	if (ret) {
> > +		dev_err(dev, "failed to set coherent dma mask, err=%d\n", ret);
> > +		goto err_clks;
> > +	}
> 
> This dma setting does not be needed, the device tree will set it when the device is
> created.
> 

Okay, will drop dma_coerce_mask_and_coherent usage in v3. 

> > +
> > +	ret = ci_hdrc_qoriq_usb_setup(pdev);
> > +	if (ret) {
> > +		dev_err(dev, "failed to perform qoriq_usb2 setup, err=%d\n",
> > +			ret);
> > +		goto err_clks;
> > +	}
> > +
> > +	data->phy = devm_phy_get(dev, "usb2-phy");
> > +	if (IS_ERR(data->phy)) {
> > +		ret = PTR_ERR(data->phy);
> > +		/* Return -EINVAL if no usbphy is available */
> > +		if (ret == -ENODEV)
> > +			ret = -EINVAL;
> > +		dev_err(dev, "failed get phy device, err=%d\n", ret);
> > +		goto err_clks;
> > +	}
> > +	pdata.phy = data->phy;
> 
> The chipidea core will do that.
> 

Okay, I checked now drivers/usb/chipidea/core.c is calling devm_phy_get
with "usb-phy", will remove above code and rename from "usb2-phy" to 
"usb-phy" in dts in v3. 

> > +
> > +	data->ci_pdev = ci_hdrc_add_device(dev,
> > +				pdev->resource, pdev->num_resources,
> > +				&pdata);
> > +	if (IS_ERR(data->ci_pdev)) {
> > +		ret = PTR_ERR(data->ci_pdev);
> > +		dev_err(dev,
> > +			"failed to register ci_hdrc platform device, err=%d\n",
> > +			ret);
> > +		goto err_clks;
> > +	}
> > +
> > +	pm_runtime_no_callbacks(dev);
> > +	pm_runtime_enable(dev);
> > +
> > +	dev_dbg(dev, "initialized\n");
> > +	return 0;
> > +
> > +err_clks:
> > +	ci_hdrc_qoriq_disable_unprepare_clks(pdev);
> 
> If you have only one clock, it is unnecessary to use dedicated APIs for clock operation.
> 

We do have multiple clocks, but currently one is integrated in code. Hence created 
the APIs for future use. 

> > +err_out:
> > +	return ret;
> > +}
> > +
> > +static int ci_hdrc_qoriq_remove(struct platform_device *pdev) {
> > +	struct device *dev = &pdev->dev;
> > +	struct ci_hdrc_qoriq_data *data = platform_get_drvdata(pdev);
> > +
> > +	pm_runtime_disable(dev);
> > +	ci_hdrc_remove_device(data->ci_pdev);
> > +	ci_hdrc_qoriq_disable_unprepare_clks(pdev);
> > +	dev_dbg(dev, "de-initialized\n");
> > +	return 0;
> > +}
> > +
> > +static void ci_hdrc_qoriq_shutdown(struct platform_device *pdev) {
> > +	ci_hdrc_qoriq_remove(pdev);
> > +}
> > +
> > +static const struct of_device_id ci_hdrc_qoriq_dt_ids[] = {
> > +	{ .compatible = "fsl,ci-qoriq-usb2"},
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, ci_hdrc_qoriq_dt_ids);
> > +
> > +static struct platform_driver ci_hdrc_qoriq_driver = {
> > +	.probe = ci_hdrc_qoriq_probe,
> > +	.remove = ci_hdrc_qoriq_remove,
> > +	.shutdown = ci_hdrc_qoriq_shutdown,
> > +	.driver = {
> > +		.name = "ci_qoriq_usb2",
> > +		.of_match_table = ci_hdrc_qoriq_dt_ids,
> > +	 },
> > +};
> > +
> > +module_platform_driver(ci_hdrc_qoriq_driver);
> > +
> > +MODULE_ALIAS("platform:ci-qoriq-usb2");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("CI HDRC QORIQ USB binding");
> > +MODULE_AUTHOR("Rajesh Bhagat <rajesh.bhagat@nxp.com>");
> > diff --git a/drivers/usb/chipidea/ci_hdrc_qoriq.h
> > b/drivers/usb/chipidea/ci_hdrc_qoriq.h
> > new file mode 100644
> > index 0000000..afd29442
> > --- /dev/null
> > +++ b/drivers/usb/chipidea/ci_hdrc_qoriq.h
> > @@ -0,0 +1,65 @@
> > +/*
> > + * QorIQ SoC USB 2.0 Controller driver
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
> > +#ifndef __DRIVER_USB_CHIPIDEA_CI_HDRC_QORIQ_H
> > +#define __DRIVER_USB_CHIPIDEA_CI_HDRC_QORIQ_H
> > +
> > +/* offsets for the non-ehci registers in the QORIQ SOC USB controller */
> > +#define QORIQ_SOC_USB_SBUSCFG	0x90
> > +#define SBUSCFG_INCR8		0x02	/* INCR8, specified */
> > +#define QORIQ_SOC_USB_ULPIVP	0x170
> > +#define QORIQ_SOC_USB_PORTSC1	0x184
> > +#define PORT_PTS_MSK		(3<<30)
> > +#define PORT_PTS_UTMI		(0<<30)
> > +#define PORT_PTS_ULPI		(2<<30)
> > +#define	PORT_PTS_SERIAL		(3<<30)
> > +#define PORT_PTS_PTW		(1<<28)
> > +#define QORIQ_SOC_USB_PORTSC2	0x188
> > +#define QORIQ_SOC_USB_USBMODE	0x1a8
> > +#define USBMODE_CM_MASK		(3 << 0)	/* controller mode mask
> */
> > +#define USBMODE_CM_HOST		(3 << 0)	/* controller mode: host */
> > +#define USBMODE_ES		(1 << 2)	/* (Big) Endian Select */
> > +
> > +#define QORIQ_SOC_USB_USBGENCTRL	0x200
> > +#define USBGENCTRL_PPP		(1 << 3)
> > +#define USBGENCTRL_PFP		(1 << 2)
> > +#define QORIQ_SOC_USB_ISIPHYCTRL	0x204
> > +#define ISIPHYCTRL_PXE		(1)
> > +#define ISIPHYCTRL_PHYE		(1 << 4)
> > +
> > +#define QORIQ_SOC_USB_SNOOP1		0x400	/* NOTE: big-endian */
> > +#define QORIQ_SOC_USB_SNOOP2		0x404	/* NOTE: big-endian */
> > +#define QORIQ_SOC_USB_AGECNTTHRSH	0x408	/* NOTE: big-endian */
> > +#define AGECNTTHRSH_THRESHOLD		0x40
> > +#define QORIQ_SOC_USB_PRICTRL		0x40c	/* NOTE: big-endian */
> > +#define PRICTRL_PRI_LVL			0xc
> > +#define QORIQ_SOC_USB_SICTRL		0x410	/* NOTE: big-endian */
> > +#define SICTRL_RD_PREFETCH_32_BYTE	(0x1)
> > +#define SICTRL_RD_PREFETCH_64_BYTE	(0x0)
> > +#define QORIQ_SOC_USB_CTRL		0x500	/* NOTE: big-endian */
> > +#define CTRL_UTMI_PHY_EN		(1 << 9)
> > +#define CTRL_PHY_CLK_VALID		(1 << 17)
> > +#define SNOOP_SIZE_2GB			0x1e
> > +
> > +/* control Register Bit Masks */
> > +#define CONTROL_REGISTER_W1C_MASK       0x00020000  /* W1C:
> PHY_CLK_VALID */
> > +#define ULPI_INT_EN             (1<<0)
> > +#define WU_INT_EN               (1<<1)
> > +#define USB_CTRL_USB_EN         (1<<2)
> > +#define LINE_STATE_FILTER__EN   (1<<3)
> > +#define KEEP_OTG_ON             (1<<4)
> > +#define OTG_PORT                (1<<5)
> > +#define PLL_RESET               (1<<8)
> > +#define UTMI_PHY_EN             (1<<9)
> > +#define ULPI_PHY_CLK_SEL        (1<<10)
> > +#define PHY_CLK_VALID		(1<<17)
> > +
> 
> Move necessary definitions to source file, and delete this header file please, this
> header file is only used by ci_hdrc_qoriq.c.
> 

Okay, will take care in v3. 


Best Regards,
Rajesh Bhagat 

> --
> 
> Best Regards,
> Peter Chen
