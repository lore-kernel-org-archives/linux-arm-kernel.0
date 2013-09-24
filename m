From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 24 Sep 2013 21:24:15 +0200
Subject: [PATCH] ASoC: kirkwood: simplify clock handling
In-Reply-To: <20130924190534.GJ12758@n2100.arm.linux.org.uk>
References: <1379951159-8294-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1380046355-7920-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130924210442.6f617798@armhf>
 <20130924190534.GJ12758@n2100.arm.linux.org.uk>
Message-ID: <20130924192415.GD16106@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 24, 2013 at 08:05:34PM +0100, Russell King - ARM Linux wrote:
> On Tue, Sep 24, 2013 at 09:04:42PM +0200, Jean-Francois Moine wrote:
> > So, the probe code should be:
> > 
> > 	/* check first if an external clock is declared */
> > 	priv->extclk = devm_clk_get(&pdev->dev, "extclk");
> > 	if (!IS_ERR(priv->extclk)) {
> > 		... use the external clock ...
> > 	} else {
> > 
> > 		/* get the first clock which must be the dco */
> > 		priv->clk = devm_clk_get(&pdev->dev, NULL);
> > 		if (IS_ERR(priv->clk))
> > 			.. error, no clock ..
> > 		.. use the internal dco ...
> > 	}
> 
> Actually no - we need to get and enable the internal clock so that we can
> access the registers - the Dove locks solid if you access the audio block
> registers without its internal clock to the audio block enabled.
So what is the plan here? Apply Russell's patch and then just drop the
devm_clk_put? Do you have a pointer to that patch? Then I'd follow up
with a patch for devm_clk_put.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
