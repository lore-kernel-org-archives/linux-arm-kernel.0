From: balbi@ti.com (Felipe Balbi)
Date: Tue, 22 Jul 2014 09:57:11 -0500
Subject: [PATCH v2 1/3] usb: dwc3: add ST dwc3 glue layer to manage dwc3 HC
In-Reply-To: <20140722091800.GB8233@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1404541530-27856-1-git-send-email-peter.griffin@linaro.org>
 <1404541530-27856-2-git-send-email-peter.griffin@linaro.org>
 <20140707124627.GG6407@lee--X1>
 <20140722091800.GB8233@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20140722145711.GC20588@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 22, 2014 at 10:18:00AM +0100, Peter Griffin wrote:
> > > +static inline u32 st_dwc3_readl(void __iomem *base, u32 offset)
> > > +{
> > > +	return readl_relaxed(base + offset);
> > > +}
> > > +
> > > +static inline void st_dwc3_writel(void __iomem *base, u32 offset, u32 value)
> > > +{
> > > +	writel_relaxed(value, base + offset);
> > > +}
> > 
> > Why are these being abstracted?
> > 
> > Just use {read,write}l_relaxed() directly.
> 
> Ok, unabstracted in v3

no, no... all other glues add their own local helpers for register
access. This is good for tracing, it's very easy to add a tracepoint to
this sort of function and get very low overhead tracing of every
register access.

> > > +	if (dwc3_data->drd_device_conf)
> > > +		val |= USB_SET_PORT_DEVICE;
> > > +	else
> > > +		val &= USB_HOST_DEFAULT_MASK;
> > > +
> > > +	return regmap_write(dwc3_data->regmap, dwc3_data->syscfg_reg_off, val);
> > > +}
> > > +
> > > +/**
> > > + * st_dwc3_init: init the controller via glue logic
> > > + * @dwc3_data: driver private structure
> > > + */
> > > +static void st_dwc3_init(struct st_dwc3 *dwc3_data)
> > > +{
> > > +	u32 reg = st_dwc3_readl(dwc3_data->glue_base, USB2_CLKRST_CTRL);
> > > +
> > > +	reg |= aux_clk_en(1) | ext_cfg_reset_n(1) | xhci_revision(1);
> > > +	reg &= ~sw_pipew_reset_n(1);
> > 
> > 1?  Better to add defines for these magic numbers.  What is 1 anyway?
> 
> They are just bit setting macros, I've converted them over to use BIT macro now,
> so it no longer takes a parameter.

the macros are better, but make them upper case as everybody else.

> > > +	st_dwc3_writel(dwc3_data->glue_base, USB2_CLKRST_CTRL, reg);
> > > +
> > > +	reg = st_dwc3_readl(dwc3_data->glue_base, USB2_VBUS_MNGMNT_SEL1);
> > > +	reg |= SEL_OVERRIDE_VBUSVALID(1) | SEL_OVERRIDE_POWERPRESENT(1) |
> > > +	    SEL_OVERRIDE_BVALID(1);
> > > +	st_dwc3_writel(dwc3_data->glue_base, USB2_VBUS_MNGMNT_SEL1, reg);
> > > +	udelay(100);
> > 
> > Why 100?
> 
> I've asked ST how this value was derirved and why. It came from validation. 
> The docs don't mention that it is necessary, and removing it
> seems to have no ill effects. So I've removed this udelay in v3.

make sure to test with many, many iterations just to make sure.

> > > +	reg = st_dwc3_readl(dwc3_data->glue_base, USB2_CLKRST_CTRL);
> > > +	reg |= sw_pipew_reset_n(1);
> > > +	st_dwc3_writel(dwc3_data->glue_base, USB2_CLKRST_CTRL, reg);
> > > +}
> > > +
> > > +static void st_dwc3_dt_get_pdata(struct platform_device *pdev,
> > > +				 struct st_dwc3 *dwc3_data)
> > > +{
> > > +	struct device_node *np = pdev->dev.of_node;
> > > +
> > > +	dwc3_data->drd_device_conf =
> > > +	    of_property_read_bool(np, "st,dwc3-drd-device");
> > 
> > This requires a DT Ack.
> 
> Ok. Do the DT folks have any comment on this?

look at the child's dr-mode property instead of adding your own.

> > > +	dwc3_data->glue_base = devm_request_and_ioremap(dev, res);

use devm_ioremap_resource()

> > > +	regmap = syscon_regmap_lookup_by_phandle(node, "st,syscfg");
> > > +	if (IS_ERR(regmap))
> > > +		return PTR_ERR(regmap);
> > > +
> > > +	dwc3 = platform_device_alloc("st-dwc3", PLATFORM_DEVID_AUTO);
> > > +	if (!dwc3) {
> > > +		dev_err(&pdev->dev, "couldn't allocate dwc3 device\n");
> > > +		return -ENOMEM;
> > > +	}
> > 
> > I'm confused.  What is this doing?  Isn't this the DWC3 driver, which
> > already had a platform device structure associated to it?  Perhaps a
> > small ASCII diagram describing the layers might be useful.
> 
> Your right, this was wrong. It was some legacy code which is
> unnecessary and I've removed this in v3.

if you're going for DT, why don't you create the parent and the child
from DT as omap/exynos/qcom are doing ?

> > > +	dma_set_coherent_mask(&dwc3->dev, dev->coherent_dma_mask);
> > > +
> > > +	dwc3->dev.parent = &pdev->dev;
> > > +	dwc3->dev.dma_mask = pdev->dev.dma_mask;
> > > +	dwc3->dev.dma_parms = pdev->dev.dma_parms;

stick to DT device creation. Look into dwc3-omap.c

> > > +static int st_dwc3_remove(struct platform_device *pdev)
> > > +{
> > > +	struct st_dwc3 *dwc3_data = platform_get_drvdata(pdev);
> > > +
> > > +	platform_device_unregister(dwc3_data->dwc3);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +#ifdef CONFIG_PM_SLEEP
> > > +static int st_dwc3_suspend(struct device *dev)
> > > +{
> > > +	struct st_dwc3 *dwc3_data = dev_get_drvdata(dev);
> > > +
> > > +	reset_control_assert(dwc3_data->rstc_pwrdn);
> > > +
> > > +	pinctrl_pm_select_sleep_state(dev);

pinctrl will select sleep and default states automatically for you.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140722/9f43e8df/attachment.sig>
