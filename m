From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 19 Oct 2013 10:28:09 +0200
Subject: [PATCH v3 2/2] ASoC: kirkwood: fix loss of external clock at
 probe time
In-Reply-To: <20131018191259.GF10079@pengutronix.de>
References: <20131018203555.4d974251@armhf>
 <20131018191259.GF10079@pengutronix.de>
Message-ID: <20131019102809.180dc4ff@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Oct 2013 21:12:59 +0200
Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:

> > +	if (IS_ERR(priv->extclk)) {
> > +		if (PTR_ERR(priv->extclk) == -EPROBE_DEFER)
> > +			return -EPROBE_DEFER;  
> Maybe the better logic here is:
> 		if (!PTR_ERR(priv->extclk) == -ENOENT)
> 			return PTR_ERR(priv->extclk);
> 
> ?

No. This patch is associated with an other one which returns
-EPROBE_DEFER when the external clock is declared in the DT and when
the clock driver is not yet initialized. Then, the kirkwood modules
must be probed later.

For any other error, the external clock is not used, and it is not easy
to know if the error is due to the absence of external clock in the DT
or to a DT parsing error or to anything else.

> > +	} else {
> > +		dev_info(&pdev->dev, "found external clock\n");
> > +		clk_prepare_enable(priv->extclk);
> > +		soc_dai = kirkwood_i2s_dai_extclk;  
> Another todo (that is already in the patched code) is that you should
> check the return value of clk_prepare_enable.

You are right, but an error at this level should not often occur...

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
