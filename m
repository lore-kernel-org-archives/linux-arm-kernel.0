From: mporter@linaro.org (Matt Porter)
Date: Wed, 18 Dec 2013 12:15:35 -0500
Subject: [PATCH v7 8/9] phy: add Broadcom Kona USB2 PHY driver
In-Reply-To: <20131218162554.GF4970@saruman.home>
References: <1387309356-17195-1-git-send-email-mporter@linaro.org>
 <1387309356-17195-9-git-send-email-mporter@linaro.org>
 <20131218162554.GF4970@saruman.home>
Message-ID: <20131218171535.GF15814@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 10:25:54AM -0600, Felipe Balbi wrote:
> On Tue, Dec 17, 2013 at 02:42:35PM -0500, Matt Porter wrote:
> > Add a driver for the internal Broadcom Kona USB 2.0 PHY found
> > on the BCM281xx family of SoCs.
> > 
> > Signed-off-by: Matt Porter <mporter@linaro.org>
> 
> Kishon, are you ok with this driver ?

Kishon did mention he was fine with this if I addressed a couple
comments a couple versions ago, I neglected solicit his ack though.

> > +static int bcm_kona_usb2_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct bcm_kona_usb *phy;
> > +	struct resource *res;
> > +	struct phy *gphy;
> > +	struct phy_provider *phy_provider;
> > +
> > +	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
> > +	if (!phy)
> > +		return -ENOMEM;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	phy->regs = devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(phy->regs))
> > +		return PTR_ERR(phy->regs);
> > +
> > +	platform_set_drvdata(pdev, phy);
> > +
> > +	phy_provider = devm_of_phy_provider_register(dev,
> > +			of_phy_simple_xlate);
> > +	if (IS_ERR(phy_provider))
> > +		return PTR_ERR(phy_provider);
> > +
> > +	gphy = devm_phy_create(dev, &ops, NULL);
> > +	if (IS_ERR(gphy))
> > +		return PTR_ERR(gphy);
> > +
> > +	/* The Kona PHY supports an 8-bit wide UTMI interface */
> > +	phy_set_bus_width(gphy, 8);
> > +
> > +	phy_set_drvdata(gphy, phy);
> 
> I think this set_drvdata() should be done before registering the
> provider, no ?

It seems so, given that we wouldn't want the provider on on the
provider list until the phy has been allocated and configured.

Interestingly, this also needs to be addressed in the four phy
drivers already upstream...they all do the same thing before the
generic phy is created.

-Matt
