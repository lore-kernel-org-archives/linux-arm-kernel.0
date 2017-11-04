From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 4 Nov 2017 20:37:31 +0100
Subject: [PATCH 07/12] hwrng: bcm2835-rng: Manage an optional clock
In-Reply-To: <547786283.132202.1509819754396@email.1und1.de>
References: <20171102010408.27736-1-f.fainelli@gmail.com>
 <20171102010408.27736-8-f.fainelli@gmail.com>
 <944505791.223880.1509803454887@email.1und1.de>
 <e12063f9-86e4-e9ce-2a7f-f85fe2ce352f@gmail.com>
 <547786283.132202.1509819754396@email.1und1.de>
Message-ID: <20171104193731.GA751@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian

> > >> +	/* Clock is optional on most platforms */
> > >> +	priv->clk = devm_clk_get(dev, NULL);
> > >> +	if (IS_ERR(priv->clk))
> > >> +		priv->clk = NULL;
> > > 
> > > at least in case of EPROBE_DEFERED this isn't the expected behavior. Maybe we should better trigger on non-existing clock?
> > 
> > Good point, so more like:
> > 
> > if (IS_ERR(priv->clk) && PTR_ERR(priv->clk) == -ENODEV)?
> 

> Unfortunately we need to return the error in all other cases. Please
> take a look at devm_usb_get_phy in dwc2 [1]. AFAIK we don't need to
> take care of ENXIO in our case.

A few subsystems have a get_optional() call, e.g.
devm_phy_optional_get(). It does not return an error when the phy is
not supposed to exist, but in all other cases, it does.

Maybe consider adding devm_clk_get_optional()?

      Andrew
