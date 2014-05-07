From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 7 May 2014 14:55:36 +0200
Subject: [PATCH v3 17/20] phy: Add support for USB cluster on the Armada
 375 SoC
In-Reply-To: <20140506205330.GA27308@arch.cereza>
References: <1399335255-589-1-git-send-email-gregory.clement@free-electrons.com>
 <1399335255-589-18-git-send-email-gregory.clement@free-electrons.com>
 <20140506205330.GA27308@arch.cereza>
Message-ID: <20140507145536.29003dfa@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Tue, 6 May 2014 17:53:30 -0300, Ezequiel Garcia wrote:

> > +#define USB2_PHY_CONFIG_ENABLE BIT(0) /* active low */
> > +
> 
> I still think it's more readable to use USB2_PHY_CONFIG_DISABLE.
> It's just a nitpick, though.

Yes, fixed.

> > +static int armada375_usb_phy_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct phy *phy;
> > +	struct device_node *np = dev->of_node;
> > +	struct phy_provider *phy_provider;
> > +	void __iomem *usb_cluster_base;
> > +	struct device_node *xhci_node;
> > +	int i;
> > +
> > +	usb_cluster_base = of_iomap(np, 0);
> > +	BUG_ON(!usb_cluster_base);
> > +
> 
> Isn't a bit extreme to call BUG_ON (and thus bring down the whole system)
> in a phy driver?

Indeed, fixed by a more normal error return.

> > +	for (i = 0; i < NB_PHY; i++) {
> > +		phy = devm_phy_create(dev, &armada375_usb_phy_ops, NULL);
> > +		if (IS_ERR(phy))
> > +			dev_err(dev, "failed to create PHY n%d\n", i);
> > +
> 
> I think you're missing a continue/break here.

Indeed, fixed, I just do a return from the ->probe() function if
creating the PHY fails.

> > +MODULE_DESCRIPTION("Armada 375 USB cluster driver");
> > +MODULE_AUTHOR("Gregory CLEMENT <gregory.clement@free-electrons.com>");
> > +MODULE_LICENSE("GPL");
> 
> GPL v2 ?

Well, using just "GPL" seems to be the more common usage through the
kernel:

linux/drivers $ git grep MODULE_LICENSE | grep "\"GPL\"" | wc -l
4276
linux/drivers $ git grep MODULE_LICENSE | grep "\"GPLv2\"" | wc -l
5
linux/drivers $ git grep MODULE_LICENSE | grep "\"GPL v2\"" | wc -l
841

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
