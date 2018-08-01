From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Aug 2018 19:46:59 +0100
Subject: [PATCH v3 7/8] net: phy: Add support to configure clock in
 Broadcom iProc mdio mux
In-Reply-To: <0cc6db4f-7008-0ad3-58d7-9e93060f152f@gmail.com>
References: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
 <1533146186-8374-8-git-send-email-arun.parameswaran@broadcom.com>
 <0cc6db4f-7008-0ad3-58d7-9e93060f152f@gmail.com>
Message-ID: <20180801184659.GG30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 01, 2018 at 11:40:33AM -0700, Florian Fainelli wrote:
> On 08/01/2018 10:56 AM, Arun Parameswaran wrote:
> >  static int iproc_mdio_wait_for_idle(void __iomem *base, bool result)
> > @@ -204,6 +225,20 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
> >  		return -ENOMEM;
> >  	}
> >  
> > +	md->core_clk = devm_clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(md->core_clk)) {
> > +		if (PTR_ERR(md->core_clk) == -EPROBE_DEFER)
> > +			return -EPROBE_DEFER;
> > +
> > +		md->core_clk = NULL;
> 
> I would simplify this a bit:
> 
> 	if (IS_ERR(md->core_clk) && PTR_ERR(md->core_clk) == -EPROBE_DEFER)

Even better is:

	if (md->core_clk == ERR_PTR(-EPROBE_DEFER))

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
