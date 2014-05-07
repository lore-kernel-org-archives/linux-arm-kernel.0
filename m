From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 7 May 2014 15:21:50 +0200
Subject: [PATCH v3 02/20] usb: ehci-orion: Add the optional PHY support
In-Reply-To: <20140507114006.466347a0@free-electrons.com>
References: <1399335255-589-1-git-send-email-gregory.clement@free-electrons.com>
 <1399335255-589-3-git-send-email-gregory.clement@free-electrons.com>
 <20140506133341.GE6503@lunn.ch>
 <20140507114006.466347a0@free-electrons.com>
Message-ID: <20140507132150.GA23936@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 07, 2014 at 11:40:06AM +0200, Thomas Petazzoni wrote:
> Dear Andrew Lunn,
> 
> On Tue, 6 May 2014 15:33:41 +0200, Andrew Lunn wrote:
> 
> > > +	priv->phy = devm_phy_get(&pdev->dev, "usb");
> > > +	if (!IS_ERR(priv->phy)) {
> > > +		err = phy_init(priv->phy);
> > > +		if (err)
> > > +			goto err2;
> > > +
> > > +		err = phy_power_on(priv->phy);
> > > +		if (err)
> > > +			goto err3;
> > > +	}
> > 
> > Hi Gregory
> > 
> > What about EPROBE_DEFERRED?
> 
> In v4 (to be submitted soon), I've changed this to:
> 
> 	priv->phy = devm_phy_optional_get(&pdev->dev, "usb");
> 	if (IS_ERR(priv->phy)) {
> 		err = PTR_ERR(priv->phy);
> 		goto err_phy_get;
> 	} else {
> 		err = phy_init(priv->phy);
> 		if (err)
> 			goto err_phy_init;
> 
> 		err = phy_power_on(priv->phy);
> 		if (err)
> 			goto err_phy_power_on;
> 	}
> 
> Thanks to devm_phy_optional_get(), the fact of not having a PHY in the
> DT is not considered an error. So on any error from
> devm_phy_optional_get() (including -EPROBE_DEFER), we simply bail out.
> Does this looks good?

Hi Thomas

That looks good.

To avoid the SATA phy problems we had last time, i would like to test
this on a few systems. Please could you let me know what branch v4 is
in when it is ready.

   Thanks
	Andrew
