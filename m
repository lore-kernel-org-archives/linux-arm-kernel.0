From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 29 Sep 2017 11:15:50 +0200
Subject: [PATCH] mmc: sdhci-xenon: Fix clock resource by adding an
 optional bus clock
In-Reply-To: <87fub5hnqb.fsf@free-electrons.com>
References: <20170928150520.27616-1-gregory.clement@free-electrons.com>
 <20170929103943.3a6f2509@xhacker.debian>
 <87fub5hnqb.fsf@free-electrons.com>
Message-ID: <20170929111550.065e7948@windsurf.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 29 Sep 2017 11:13:00 +0200, Gregory CLEMENT wrote:

> >>  - clock-names:
> >>    Array of names corresponding to clocks property.
> >>    The input clock for Xenon IP core should be named as "core".
> >> +  The input clock for the AXI bus must be named as "axi".  
> >
> > Is "bus" more suitable?  
> 
> I find bus too vague.

Actually no, I believe "bus" is more common. Indeed, you could have the
same IP, attached to a different interconnect I guess.

> >>  	/*
> >>  	 * Link Xenon specific mmc_host_ops function,
> >> @@ -491,9 +493,20 @@ static int xenon_probe(struct platform_device *pdev)
> >>  	if (err)
> >>  		goto free_pltfm;
> >>  
> >> +	priv->axi_clk = devm_clk_get(&pdev->dev, "axi");
> >> +	if (IS_ERR(priv->axi_clk)) {

-EPROBE_DEFER handling ?

> >> +		err = PTR_ERR(priv->axi_clk);
> >> +		dev_err(&pdev->dev, "Failed to setup axi clk: %d\n", err);  
> >
> > Since the bus clock is optional, can we remove this err msg?  
> 
> I will change it in dev_info.

This clock is optional (in order to keep DT backward compatibility), so
there shouldn't be any error message, be it dev_err() or dev_info().

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
