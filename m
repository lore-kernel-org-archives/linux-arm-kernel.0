From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Sat, 30 Sep 2017 14:17:53 +0800
Subject: [PATCH v2] mmc: sdhci-xenon: Fix clock resource by adding an
 optional bus clock
In-Reply-To: <20170930080710.119c0258@windsurf>
References: <20170929130435.6805-1-gregory.clement@free-electrons.com>
 <20170930104109.60853202@xhacker.debian>
 <20170930080710.119c0258@windsurf>
Message-ID: <20170930141753.7c4e34ea@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Sat, 30 Sep 2017 08:07:10 +0200 Thomas Petazzoni wrote:

> Hello,
> 
> On Sat, 30 Sep 2017 10:41:09 +0800, Jisheng Zhang wrote:
> 
> > > +	priv->axi_clk = devm_clk_get(&pdev->dev, "axi");
> > > +	if (IS_ERR(priv->axi_clk)) {
> > > +		err = PTR_ERR(priv->axi_clk);
> > > +		if (err == -EPROBE_DEFER)
> > > +			goto err_clk;
> > > +		priv->axi_clk = NULL;    
> > 
> > IMHO, this assignment could be removed. What do you think?  
> 
> No, because if the clock is not present in the Device Tree,
> priv->axi_clk will contain an error code encoded as a pointer, so
> priv->axi_clk will not be NULL. Hence the rest of the code that will

FWICT, the clk_disable_unprepare() could also check whether the clk
is err, am I wrong?

> operate on this clock will believe there is a valid clock pointed by
> priv->axi_clk. So we really want to reset it to NULL when there was an
> error getting the clock.
> 
> Best regards,
> 
> Thomas
