From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 6 Mar 2015 12:25:49 +0100
Subject: [PATCH 3/3] net: macb: remove #if defined(CONFIG_ARCH_AT91)
 sections
In-Reply-To: <20150305194418.GY3989@piout.net>
References: <1425572842-6084-1-git-send-email-boris.brezillon@free-electrons.com>
 <1425572842-6084-4-git-send-email-boris.brezillon@free-electrons.com>
 <20150305194418.GY3989@piout.net>
Message-ID: <20150306122549.314c6439@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 5 Mar 2015 20:44:18 +0100
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> On 05/03/2015 at 17:27:22 +0100, Boris Brezillon wrote :
> > @@ -2388,21 +2392,20 @@ static int macb_probe(struct platform_device *pdev)
> >  		bp->phy_interface = err;
> >  	}
> >  
> > +	config = 0;
> >  	if (bp->phy_interface == PHY_INTERFACE_MODE_RGMII)
> > -		macb_or_gem_writel(bp, USRIO, GEM_BIT(RGMII));
> > -	else if (bp->phy_interface == PHY_INTERFACE_MODE_RMII)
> > -#if defined(CONFIG_ARCH_AT91)
> > -		macb_or_gem_writel(bp, USRIO, (MACB_BIT(RMII) |
> > -					       MACB_BIT(CLKEN)));
> > -#else
> > -		macb_or_gem_writel(bp, USRIO, 0);
> > -#endif
> > -	else
> > -#if defined(CONFIG_ARCH_AT91)
> > -		macb_or_gem_writel(bp, USRIO, MACB_BIT(CLKEN));
> > -#else
> > -		macb_or_gem_writel(bp, USRIO, MACB_BIT(MII));
> > -#endif
> > +		config = GEM_BIT(RGMII);
> > +	else if (bp->phy_interface == PHY_INTERFACE_MODE_RMII &&
> > +		 (bp->caps & MACB_CAPS_USRIO_DEFAULT_IS_MII))
> > +		config = MACB_BIT(RMII);
> > +	else if (bp->phy_interface == PHY_INTERFACE_MODE_MII &&
> 
> I'm not sure you should check for PHY_INTERFACE_MODE_MII here as this
> may change the previous behaviour.

Absolutely (I fixed it in v2).

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
