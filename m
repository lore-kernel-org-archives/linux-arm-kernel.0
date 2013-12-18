From: tj@kernel.org (Tejun Heo)
Date: Wed, 18 Dec 2013 07:13:13 -0500
Subject: [PATCH 3/4] SATA: MV: Add support for the optional PHYs
In-Reply-To: <52B140F2.8070900@ti.com>
References: <1387311713-1926-1-git-send-email-andrew@lunn.ch>
 <1387311713-1926-3-git-send-email-andrew@lunn.ch>
 <52B140F2.8070900@ti.com>
Message-ID: <20131218121313.GC4324@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Dec 18, 2013 at 12:00:10PM +0530, Kishon Vijay Abraham I wrote:
> > @@ -4097,6 +4109,10 @@ static int mv_platform_probe(struct platform_device *pdev)
> >  		hpriv->port_clks[port] = clk_get(&pdev->dev, port_number);
> >  		if (!IS_ERR(hpriv->port_clks[port]))
> >  			clk_prepare_enable(hpriv->port_clks[port]);
> > +		sprintf(port_number, "port%d", port);
> > +		hpriv->port_phys[port] = devm_phy_get(&pdev->dev, port_number);
> > +		if (!IS_ERR(hpriv->port_phys[port]))
> > +			phy_power_on(hpriv->port_phys[port]);

Shouldn't it distinguish between failures and at least produce
warning?  ie. phy not available and phy init failed due to memory
pressure or whatnot shouldn't be handled the same.

> > @@ -4132,6 +4148,8 @@ err:
> >  			clk_disable_unprepare(hpriv->port_clks[port]);
> >  			clk_put(hpriv->port_clks[port]);
> >  		}
> > +		if (!IS_ERR(hpriv->port_phys[port]))
> > +			phy_power_off(hpriv->port_phys[port]);

And I'd much prefer the array holds either NULL or valid pointer.

Thanks.

-- 
tejun
