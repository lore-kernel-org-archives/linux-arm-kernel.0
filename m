From: balbi@ti.com (Felipe Balbi)
Date: Mon, 25 Nov 2013 14:39:56 -0600
Subject: [PATCH 1/3] usb: dwc3: Add Keystone specific glue layer
In-Reply-To: <1385410581-12148-2-git-send-email-w-kwok2@ti.com>
References: <1385410581-12148-1-git-send-email-w-kwok2@ti.com>
 <1385410581-12148-2-git-send-email-w-kwok2@ti.com>
Message-ID: <20131125203956.GI18046@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 25, 2013 at 03:16:19PM -0500, WingMan Kwok wrote:
> diff --git a/drivers/usb/dwc3/dwc3-keystone.c b/drivers/usb/dwc3/dwc3-keystone.c
> new file mode 100644
> index 0000000..a4c9cbc
> --- /dev/null
> +++ b/drivers/usb/dwc3/dwc3-keystone.c
> @@ -0,0 +1,272 @@
> +/**
> + * dwc3-keystone.c - Keystone Specific Glue layer
> + *
> + * Copyright (C) 2010-2013 Texas Instruments Incorporated - http://www.ti.com
> + *
> + * Authors: WingMan Kwok <w-kwok2@ti.com>

singular -> Author :-) there's only a single one.

> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2  of
> + * the License as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>
> +#include <linux/spinlock.h>
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/ioport.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/usb/usb_phy_gen_xceiv.h>
> +
> +
> +#define BITS(n)			(BIT(n) - 1)

looks like unnecessary obfuscation.

> +#define BITFIELD(x, s, n)	(((x) & BITS(n)) << (s))

likewise.

> +#define MASK			0xffffffff

huh ? You probably want a better name here.

> +#define PHY_REF_SSP_EN(x)	BITFIELD(x, 29, 1)

hmm, should be part of a PHY driver (drivers/phy/)

> +static u64 kdwc3_dma_mask;
> +
> +struct kdwc3_phy_ctrl_regs {
> +	u32	phy_utmi;
> +	u32	phy_pipe;
> +	u32	phy_param_ctrl_1;
> +	u32	phy_param_ctrl_2;
> +	u32	phy_clock;
> +	u32	phy_pll;
> +};

should be part of a PHY driver. Sorry, but I'll be very pedantic.

> +struct kdwc3_irq_regs {
> +	u32		revision;
> +	u32		_rsvd0[3];
> +	u32		sysconfig;
> +	u32		_rsvd1[1];
> +	u32		irq_eoi;
> +	u32		_rsvd2[1];
> +	struct {
> +		u32	raw_status;
> +		u32	status;
> +		u32	enable_set;
> +		u32	enable_clr;
> +	} irqs[16];
> +};

please use #define macros instead.

> +struct dwc3_keystone {
> +	spinlock_t				lock;
> +	struct device				*dev;
> +	struct clk				*clk;
> +	int					irqn;
> +
> +	struct kdwc3_phy_ctrl_regs __iomem	*phy_ctrl;

not part of this driver.

> +	struct kdwc3_irq_regs __iomem		*usbss;
> +};
> +
> +static void kdwc3_enable_irqs(struct dwc3_keystone *kdwc)
> +{
> +	writel(1, &kdwc->usbss->irqs[kdwc->irqn].enable_set);

I would like to have a define here, no magic constants.

> +}
> +
> +static void kdwc3_disable_irqs(struct dwc3_keystone *kdwc)
> +{
> +	writel(0, &kdwc->usbss->irqs[kdwc->irqn].enable_set);
> +}

you want these two functions to be more generic, along the lines of:

static void kdwc3_writel(void __iomem *base, u32 offset, u32 val)
{
	writel(val, base + offset);
}

static u32 kdwc3_readl(void __iomem *base, u32 offset)
{
	return readl(base + offset);
}

then you can add:

static void kdwc3_enable_irqs(struct dwc3_keystone *kdwc)
{
	u32 reg;

	reg = kdwc3_readl(kdwc->base, KEYSTONE_DWC3_IRQ);
	reg |= KEYSTONE_DWC3_IRQ_ENABLE;
	kdwc3_writel(kdwc->base, KEYSTONE_DWC3_IRQ, reg);
}

static void kdwc3_disable_irqs(struct dwc3_keystone *kdwc)
{
	u32 reg;

	reg = kdwc3_readl(kdwc->base, KEYSTONE_DWC3_IRQ);
	reg &= ~KEYSTONE_DWC3_IRQ_ENABLE;
	kdwc3_writel(kdwc->base, KEYSTONE_DWC3_IRQ, reg);
}

this will be much more "future-safe".

> +static int kdwc3_enable(struct dwc3_keystone *kdwc)
> +{
> +	int error;
> +	u32 val;
> +
> +	kdwc->clk = devm_clk_get(kdwc->dev, "usb");
> +	if (IS_ERR_OR_NULL(kdwc->clk)) {
> +		dev_err(kdwc->dev, "unable to get kdwc usb clock\n");
> +		return -ENODEV;
> +	}
> +
> +	val  = readl(&kdwc->phy_ctrl->phy_clock);

no PHY registers will ever be accessed from a glue layer ;-) This should
all be part of a phy driver (drivers/phy/phy-keystone.c) and dwc3.ko
will take care of the rest.

> +	writel(val | PHY_REF_SSP_EN(1), &kdwc->phy_ctrl->phy_clock);
> +	udelay(20);
> +
> +	error = clk_prepare_enable(kdwc->clk);
> +	if (error < 0) {
> +		dev_dbg(kdwc->dev, "unable to enable usb clock, err %d\n",
> +			error);
> +		writel(val, &kdwc->phy_ctrl->phy_clock);
> +		return error;
> +	}
> +
> +	/* soft reset usbss */
> +	writel(1, &kdwc->usbss->sysconfig);

shoul we access sysconfig registers from drivers ? How about using a
reset driver ? (drivers/reset/).

> +	while (readl(&kdwc->usbss->sysconfig) & 1)
> +		;

infinite loop ? Never, please add a timeout.

> +	val = readl(&kdwc->usbss->revision);
> +	dev_info(kdwc->dev, "usbss revision %x\n", val);

unnecessary dev_info(). You're not even decoding the revision
information.

> +	return 0;
> +}
> +
> +static void kdwc3_disable(struct dwc3_keystone *kdwc)
> +{
> +	u32 val;
> +
> +	clk_disable_unprepare(kdwc->clk);
> +
> +	val  = readl(&kdwc->phy_ctrl->phy_clock);
> +	val &= ~PHY_REF_SSP_EN(MASK);
> +	writel(val, &kdwc->phy_ctrl->phy_clock);

should not be done here.

> +}
> +
> +static irqreturn_t dwc3_keystone_interrupt(int irq, void *_kdwc)
> +{
> +	struct dwc3_keystone	*kdwc = _kdwc;
> +	int			irqn = kdwc->irqn;

why ? the irq argument should already be the correct IRQ number, right ?

> +	spin_lock(&kdwc->lock);
> +	writel(1, &kdwc->usbss->irqs[irqn].enable_clr);
> +	writel(1, &kdwc->usbss->irqs[irqn].status);
> +	writel(1, &kdwc->usbss->irqs[irqn].enable_set);

no magic constants...

> +	writel(BIT(irqn), &kdwc->usbss->irq_eoi);
> +	spin_unlock(&kdwc->lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int kdwc3_probe(struct platform_device *pdev)
> +{
> +	struct device_node	*node = pdev->dev.of_node;
> +	struct device		*dev = &pdev->dev;
> +	struct dwc3_keystone	*kdwc;
> +	struct resource		*res;
> +	int			error, irq;
> +
> +	if (!node) {
> +		dev_err(dev, "device node not found\n");
> +		return -EINVAL;
> +	}

if this will only be used on DT-based boot, node *must* be true. If it's
not, we're dealing with a pretty critical bug, in which case we want a
Kernel Oops to happen so we catch that bug, please drop this check.

> +
> +	kdwc = devm_kzalloc(dev, sizeof(*kdwc), GFP_KERNEL);
> +	if (!kdwc)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, kdwc);
> +
> +	spin_lock_init(&kdwc->lock);
> +	kdwc->dev = dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(dev, "missing usbss resource\n");
> +		return -EINVAL;
> +	}
> +
> +	kdwc->usbss = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(kdwc->usbss)) {
> +		dev_err(dev, "ioremap failed on usbss region\n");

no need to print anything, devm_ioremap_resource() already prints
sensible messages.

> +		return PTR_ERR(kdwc->usbss);
> +	}
> +
> +	dev_dbg(dev, "usbss control start=%08x size=%d mapped=%08x\n",
> +		(u32)(res->start), (int)resource_size(res),
> +		(u32)(kdwc->usbss));

this is really unnecessary, if you really want to have it, move it to
dev_vdbg().

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!res) {
> +		dev_err(dev, "missing usb phy resource\n");
> +		return -EINVAL;
> +	}
> +
> +	kdwc->phy_ctrl = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(kdwc->phy_ctrl)) {
> +		dev_err(dev, "ioremap failed on usb phy region\n");
> +		return PTR_ERR(kdwc->phy_ctrl);
> +	}

second resource should be part of the PHY driver. This is even more
important considering you're using DT, we don't want to allow broken DTS
data to be accepted.

> +	dev_dbg(dev, "phy control start=%08x size=%d mapped=%08x\n",
> +		(u32)(res->start), (int)resource_size(res),
> +		(u32)(kdwc->phy_ctrl));

unnecessary.

> +	kdwc3_dma_mask = dma_get_mask(dev);
> +	dev->dma_mask = &kdwc3_dma_mask;
> +
> +	error = kdwc3_enable(kdwc);

I would drop this function and just add your clk_prepare() here, then
move clk_enable()/clk_disable() to ->runtime_resume/->runtime_suspend()
respectively. Then you could just call pm_runtime_get_sync() when you
need to access your registers and pm_runtime_put() when you want to drop
the clock reference.

this will even make PM implementation a lot easier for you going
forward.

> +	if (error)
> +		return error;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "missing irq\n");
> +		goto err_irq;
> +	}
> +
> +	error = devm_request_irq(dev, irq, dwc3_keystone_interrupt, IRQF_SHARED,
> +			"keystone-dwc3", kdwc);

dev_name(dev) ?? If you happen to have multiple instances of a dwc3
core, it'll give it better names.

> +	if (error) {
> +		dev_err(dev, "failed to request IRQ #%d --> %d\n",
> +				irq, error);
> +		goto err_irq;
> +	}
> +
> +	kdwc->irqn = 0;

wait, what ? Can you describe how this part works ? Why do you even need
this if it's alway zero ?

> +	kdwc3_enable_irqs(kdwc);
> +
> +	error = of_platform_populate(node, NULL, NULL, dev);
> +	if (error) {
> +		dev_err(&pdev->dev, "failed to create dwc3 core\n");
> +		goto err_core;
> +	}
> +
> +	return 0;
> +
> +err_core:
> +	kdwc3_disable_irqs(kdwc);
> +err_irq:
> +	kdwc3_disable(kdwc);
> +
> +	return error;
> +}
> +
> +static int kdwc3_remove(struct platform_device *pdev)
> +{
> +	struct dwc3_keystone *kdwc = platform_get_drvdata(pdev);
> +
> +	if (kdwc) {

kdwc will never be true, you can drop this check.

> +		kdwc3_disable_irqs(kdwc);
> +		kdwc3_disable(kdwc);
> +		platform_set_drvdata(pdev, NULL);
> +	}
> +	return 0;
> +}
> +
> +static const struct of_device_id kdwc3_of_match[] = {
> +	{ .compatible = "ti,keystone-dwc3", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, kdwc3_of_match);
> +
> +static struct platform_driver kdwc3_driver = {
> +	.probe		= kdwc3_probe,
> +	.remove		= kdwc3_remove,
> +	.driver		= {
> +		.name	= "keystone-dwc3",
> +		.owner	        = THIS_MODULE,
> +		.of_match_table	= kdwc3_of_match,
> +	},
> +};
> +
> +module_platform_driver(kdwc3_driver);
> +
> +MODULE_ALIAS("platform:keystone-dwc3");
> +MODULE_AUTHOR("WingMan Kwok <w-kwok2@ti.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("DesignWare USB3 KEYSTONE Glue Layer");
> -- 
> 1.7.9.5
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131125/355dad57/attachment.sig>
