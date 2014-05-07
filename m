From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 7 May 2014 11:40:06 +0200
Subject: [PATCH v3 02/20] usb: ehci-orion: Add the optional PHY support
In-Reply-To: <20140506133341.GE6503@lunn.ch>
References: <1399335255-589-1-git-send-email-gregory.clement@free-electrons.com>
 <1399335255-589-3-git-send-email-gregory.clement@free-electrons.com>
 <20140506133341.GE6503@lunn.ch>
Message-ID: <20140507114006.466347a0@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Tue, 6 May 2014 15:33:41 +0200, Andrew Lunn wrote:

> > +	priv->phy = devm_phy_get(&pdev->dev, "usb");
> > +	if (!IS_ERR(priv->phy)) {
> > +		err = phy_init(priv->phy);
> > +		if (err)
> > +			goto err2;
> > +
> > +		err = phy_power_on(priv->phy);
> > +		if (err)
> > +			goto err3;
> > +	}
> 
> Hi Gregory
> 
> What about EPROBE_DEFERRED?

In v4 (to be submitted soon), I've changed this to:

	priv->phy = devm_phy_optional_get(&pdev->dev, "usb");
	if (IS_ERR(priv->phy)) {
		err = PTR_ERR(priv->phy);
		goto err_phy_get;
	} else {
		err = phy_init(priv->phy);
		if (err)
			goto err_phy_init;

		err = phy_power_on(priv->phy);
		if (err)
			goto err_phy_power_on;
	}

Thanks to devm_phy_optional_get(), the fact of not having a PHY in the
DT is not considered an error. So on any error from
devm_phy_optional_get() (including -EPROBE_DEFER), we simply bail out.
Does this looks good?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
