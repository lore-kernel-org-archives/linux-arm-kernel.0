From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Tue, 13 May 2014 14:11:15 +0200
Subject: [PATCH v2 1/6] phy: add a driver for the Berlin SATA PHY
In-Reply-To: <5370C2B6.8030908@ti.com>
References: <1399886217-20474-1-git-send-email-antoine.tenart@free-electrons.com>
 <1399886217-20474-2-git-send-email-antoine.tenart@free-electrons.com>
 <5370C2B6.8030908@ti.com>
Message-ID: <20140513121115.GB3213@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, May 12, 2014 at 06:16:46PM +0530, Kishon Vijay Abraham I wrote:
> On Monday 12 May 2014 02:46 PM, Antoine T?nart wrote:

[?]

> > +struct phy_desc {
> 
> to be consistent, lets name it phy_berlin_desc.
> > +	struct phy	*phy;
> > +	u32		val;
> > +	unsigned	index;
> > +};

Sure.

[?]

> > +static int phy_berlin_sata_probe(struct platform_device *pdev)
> > +{
> > +	struct phy *phy;
> > +	struct phy_provider *phy_provider;
> > +	struct priv *priv;
> > +	struct resource *res;
> > +	int i;
> > +
> > +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	priv->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> > +	if (IS_ERR(priv->base))
> > +		return PTR_ERR(priv->base);
> > +
> > +	phy = devm_phy_create(&pdev->dev, &phy_berlin_sata_ops, NULL);
> > +	if (IS_ERR(phy))
> > +		return PTR_ERR(phy);
> > +
> > +	dev_set_drvdata(&pdev->dev, priv);
> > +	spin_lock_init(&priv->lock);
> > +
> > +	for (i = 0; i < BERLIN_SATA_PHY_NB; i++) {
> 
> huh.. this should come from dt data. For devices which have multiple PHYs, each
> PHY should be modelled as the sub-node of the *PHY provider* device node.

I'll update, with the bindings suggested by Sebastian.

Thanks for the review!

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
