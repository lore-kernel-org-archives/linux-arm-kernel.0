From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Wed, 24 Jan 2018 21:52:28 +0900
Subject: [PATCH 2/4] usb: dwc3: add dwc3 glue layer for UniPhier SoCs
In-Reply-To: <87o9lklnwb.fsf@linux.intel.com>
References: <1516712454-2915-3-git-send-email-hayashi.kunihiko@socionext.com>
 <87o9lklnwb.fsf@linux.intel.com>
Message-ID: <20180124215228.ED43.4A936039@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Felipe,

Thank you for your comments.

On Tue, 23 Jan 2018 15:12:36 +0200 <balbi@kernel.org> wrote:

> 
> Hi,
> 
> Kunihiko Hayashi <hayashi.kunihiko@socionext.com> writes:
> > Add a specific glue layer for UniPhier SoC platform to support
> > USB host mode. It manages hardware operating sequences to enable multiple
> > clock gates and assert resets, and to prepare to use dwc3 controller
> > on the SoC.
> >
> > This patch also handles the physical layer that has same register space
> > as the glue layer, because it needs to integrate initialziation sequence
> > between glue and phy.
> >
> > In case of some SoCs, since some initialization values for PHY are
> > included in nvmem, this patch includes the way to get the values from nvmem.
> >
> > It supports PXs2 and LD20 SoCs.
> >
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > Signed-off-by: Motoya Tanigawa <tanigawa.motoya@socionext.com>
> > Signed-off-by: Masami Hiramatsu <masami.hiramatsu@linaro.org>
> > ---
> >  drivers/usb/dwc3/Kconfig         |   9 +
> >  drivers/usb/dwc3/Makefile        |   1 +
> >  drivers/usb/dwc3/dwc3-uniphier.c | 554 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 564 insertions(+)
> >  create mode 100644 drivers/usb/dwc3/dwc3-uniphier.c

...snip...

> > +
> > +static void dwc3u_ssphy_testio_write(struct dwc3u_priv *priv, int port,
> > +				     u32 data)
> 
> anything with sshphy or hsphy in the name should probably be part of a
> PHY driver using drivers/phy/ framework.

I can try to separate phy control from this driver.
However, phy registers belongs to "dwc3-glue" IO map area (65b00000),
and this area also contains a reset bit for "dwc3-core" hardware.

Although the phy driver is called from dwc3-core driver,
we need to deassert the reset bit before probing dwc3-core driver.

As shown later, I think that it's difficut to determine the order of
initializing the registers in this area.

> > +static void dwc3u_vbus_disable(struct dwc3u_priv *priv)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < priv->nvbus; i++) {
> > +		dwc3u_maskwrite(priv, VBUS_CONTROL(i),
> > +				DRVVBUS_REG_EN | DRVVBUS_REG,
> > +				DRVVBUS_REG_EN | 0);
> > +	}
> > +}
> 
> drivers/regulator maybe?

VBUS_CONTROL register is used for determing whether "dwc3-glue" hardware
enables vbus connected with "regulator" hardware.

The regulator driver should manage "regulator" hardware, and
I don't think that the driver should manage this register.

> > +static void dwc3u_reset_init(struct dwc3u_priv *priv)
> > +{
> > +	dwc3u_maskwrite(priv, RESET_CTL, LINK_RESET, 0);
> > +	usleep_range(1000, 2000);
> > +	dwc3u_maskwrite(priv, RESET_CTL, LINK_RESET, LINK_RESET);
> > +}
> > +
> > +static void dwc3u_reset_clear(struct dwc3u_priv *priv)
> > +{
> > +	dwc3u_maskwrite(priv, RESET_CTL, LINK_RESET, 0);
> > +}
> 
> drivers/reset ?

The reset driver manages "sysctrl" IO map area in our SoC.

RESET_CTL register belongs to "dwc3-glue" IO map area,
and the kernel can't access this area until enabling usb clocks and
deasserting usb resets in "sysctrl".

I think that "dwc3-glue" register control should be separated from
"sysctrl".

> > +static int dwc3u_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct device_node *node;
> > +	struct dwc3u_priv *priv;
> > +	struct resource	*res;
> > +	struct clk *clk;
> > +	int i, nr_clks;
> > +	int ret = 0;
> > +
> > +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->data = of_device_get_match_data(dev);
> > +	if (WARN_ON(!priv->data))
> > +		return -EINVAL;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	priv->base = devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(priv->base))
> > +		return PTR_ERR(priv->base);
> > +
> > +	priv->dev = dev;
> > +
> > +	node = dev->of_node;
> > +	nr_clks = of_clk_get_parent_count(node);
> > +	if (!nr_clks) {
> > +		dev_err(dev, "failed to get clock property\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	priv->clks = devm_kcalloc(priv->dev, nr_clks, sizeof(struct clk *),
> > +				  GFP_KERNEL);
> > +	if (!priv->clks)
> > +		return -ENOMEM;
> > +
> > +	for (i = 0; i < nr_clks; i++) {
> > +		clk = of_clk_get(node, i);
> > +		if (IS_ERR(clk)) {
> > +			ret = PTR_ERR(clk);
> > +			goto out_clk_disable;
> > +		}
> > +		ret = clk_prepare_enable(clk);
> > +		if (ret < 0) {
> > +			clk_put(clk);
> > +			goto out_clk_disable;
> > +		}
> > +		priv->clks[i] = clk;
> > +		priv->nclks = i;
> > +	}
> > +
> > +	priv->rst = devm_reset_control_array_get_optional_shared(priv->dev);
> > +	if (IS_ERR(priv->rst)) {
> > +		ret = PTR_ERR(priv->rst);
> > +		goto out_clk_disable;
> > +	}
> > +	ret = reset_control_deassert(priv->rst);
> > +	if (ret)
> > +		goto out_clk_disable;
> > +
> > +	ret = dwc3u_init(priv);
> > +	if (ret)
> > +		goto out_rst_assert;
> > +
> > +	platform_set_drvdata(pdev, priv);
> > +
> > +	ret = of_platform_populate(node, NULL, NULL, priv->dev);
> > +	if (ret)
> > +		goto out_exit;
> 
> with the stuff that should be using generic frameworks removed, this
> looks like dwc3-of-simple.c, which you should be using.

Before probing dwc3-core driver and accessing "dwc3-core" register,
we need to do the following items in order:

- enable clock and deassert resets in "sysctrl" with calling the
  clock/reset driver, so that the kernel can access "dwc3-glue"
  IO map area.

- enable vbus and setup phy with the "dwc3-glue" register.

- deassert "dwc3-core" reset with the "dwc3-glue" register,
  so that the kernel can access "dwc3-core" IO map area.

The dwc3-of-simple driver only enables the clock driver before
probing dwc3-core driver, and it seems that the driver have no ways
to deassert the reset driver and manage "dwc3-glue" IO map area.

Are there any ways to manage them before probing dwc3-core driver?

Thank you,

---
Best Regards,
Kunihiko Hayashi
