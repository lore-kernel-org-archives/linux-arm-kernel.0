From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 9 Jun 2014 16:26:31 +0800
Subject: [PATCH 4/9] usb: phy: add the Berlin USB PHY driver
In-Reply-To: <53919DCE.1050708@gmail.com>
References: <1401983326-19205-1-git-send-email-antoine.tenart@free-electrons.com>
 <1401983326-19205-5-git-send-email-antoine.tenart@free-electrons.com>
 <53919DCE.1050708@gmail.com>
Message-ID: <20140609162631.76bd2ad7@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian and Antoine,

On Fri, 6 Jun 2014 03:54:06 -0700
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> > +
> > +#define to_berlin_phy_priv(p)	container_of((p), struct
> > berlin_phy_priv, phy) +
> > +struct berlin_phy_priv {
> > +	void __iomem		*base;
> > +	struct usb_phy		phy;
> > +	struct reset_control	*rst_ctrl;
> > +	int			pwr_gpio;
> 
> Is the GPIO used for USB power? If so, we should not rely on

The GPIO is used for vbus. Sorry for using the confusing "pwr". Do we still
need to use regulator API?

> GPIO at all but use regulator API. Thinking of Chromecast which
> is externally powered over USB, there will be no regulator nor
> GPIO at all.
> 
> > +};
> > +
> > +static int berlin_phy_init(struct usb_phy *phy)
> > +{
> > +	struct berlin_phy_priv *priv = to_berlin_phy_priv(phy);
> > +	int ret;
> > +
> > +	reset_control_reset(priv->rst_ctrl);
> > +
> > +	writel(CLK_REF_DIV(0xc) | FEEDBACK_CLK_DIV(0x54),
> > +	       priv->base + USB_PHY_PLL);
> 
> @Jisheng: IIRC the dividers above are different for BG2? Can you please
> evaluate?

Yes, BG2 uses different refdiv and fbdiv. Is there any suggestions about how to
handle this difference? The value is chosen after carefully tunning

> 
> > +	writel(CLK_STABLE | PLL_CTRL_REG | PHASE_OFF_TOL_250 |
> > KVC0_REG_CTRL |
> > +	       CLK_BLK_EN, priv->base + USB_PHY_PLL_CONTROL);
> > +	writel(V2I_VCO_RATIO(0x5) | R_ROTATE_0 | ANA_TEST_DC_CTRL(0x5),
> > +	       priv->base + USB_PHY_ANALOG);
> > +	writel(PHASE_FREEZE_DLY_4_CL | ACK_LENGTH_16_CL | SQ_LENGTH_12 |
> > +	       DISCON_THRESHOLD_260 | SQ_THRESHOLD(0xa) | LPF_COEF(0x2) |
> > +	       INTPL_CUR_30, priv->base + USB_PHY_RX_CTRL);
> > +
> > +	writel(TX_VDD12_13 | TX_OUT_AMP(0x3), priv->base +
> > USB_PHY_TX_CTRL1);
> > +	writel(EXT_HS_RCAL_EN | IMPCAL_VTH_DIV(0x3) |
> > EXT_RS_RCAL_DIV(0x4),
> > +	       priv->base + USB_PHY_TX_CTRL0);
> > +
> > +	writel(EXT_HS_RCAL_EN | IMPCAL_VTH_DIV(0x3) |
> > EXT_RS_RCAL_DIV(0x4) |
> > +	       EXT_FS_RCAL_DIV(0x2), priv->base + USB_PHY_TX_CTRL0);
> > +
> > +	writel(EXT_HS_RCAL_EN | IMPCAL_VTH_DIV(0x3) |
> > EXT_RS_RCAL_DIV(0x4),
> > +	       priv->base + USB_PHY_TX_CTRL0);
> > +	writel(TX_CHAN_CTRL_REG(0xf) | DRV_SLEWRATE(0x3) |
> > IMP_CAL_FS_HS_DLY_3 |
> > +	       FS_DRV_EN_MASK(0xd), priv->base + USB_PHY_TX_CTRL2);
> > +
> > +	ret = gpio_direction_output(priv->pwr_gpio, 0);
> 
> As mentioned above, this should be using regulator API. And also, if
> there is no dummy regulator allowed, it should be optional.
> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	gpio_set_value(priv->pwr_gpio, 1);
> > +
> > +	return 0;
> > +}
> > +
> > +static void berlin_phy_shutdown(struct usb_phy *phy)
> > +{
> > +	struct berlin_phy_priv *priv = to_berlin_phy_priv(phy);
> > +
> > +	gpio_set_value(priv->pwr_gpio, 0);
> > +}
> > +
> > +static int berlin_phy_probe(struct platform_device *pdev)
> > +{
> > +	struct device_node *np = pdev->dev.of_node;
> > +	struct berlin_phy_priv *priv;
> > +	struct resource *res;
> > +	int ret, gpio;
> > +
> > +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	priv->base = devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(priv->base))
> > +		return PTR_ERR(priv->base);
> > +
> > +	priv->rst_ctrl = devm_reset_control_get(&pdev->dev, NULL);
> > +	if (IS_ERR(priv->rst_ctrl)) {
> > +		ret = PTR_ERR(priv->rst_ctrl);
> > +		dev_err(&pdev->dev, "cannot get reset controller: %d\n",
> > ret);
> 
> Hmm, considering a non arch_init call registered reset driver, it does
> also spit out an error for -EPROBE_DEFER, does it?
> 
> > +		return ret;
> > +	}
> > +
> > +	gpio = of_get_named_gpio(np, "power-gpio", 0);
> > +	if (!gpio_is_valid(gpio))
> > +		return gpio;

Some BG2Q boards hardwired the vbus to be always powered on, we should continue
the probe if vbus gpio is missing.

Thanks,
Jisheng
