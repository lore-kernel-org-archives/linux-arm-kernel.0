From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Sep 2013 20:05:34 +0100
Subject: [PATCH] ASoC: kirkwood: simplify clock handling
In-Reply-To: <20130924210442.6f617798@armhf>
References: <1379951159-8294-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1380046355-7920-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130924210442.6f617798@armhf>
Message-ID: <20130924190534.GJ12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 24, 2013 at 09:04:42PM +0200, Jean-Francois Moine wrote:
> So, the probe code should be:
> 
> 	/* check first if an external clock is declared */
> 	priv->extclk = devm_clk_get(&pdev->dev, "extclk");
> 	if (!IS_ERR(priv->extclk)) {
> 		... use the external clock ...
> 	} else {
> 
> 		/* get the first clock which must be the dco */
> 		priv->clk = devm_clk_get(&pdev->dev, NULL);
> 		if (IS_ERR(priv->clk))
> 			.. error, no clock ..
> 		.. use the internal dco ...
> 	}

Actually no - we need to get and enable the internal clock so that we can
access the registers - the Dove locks solid if you access the audio block
registers without its internal clock to the audio block enabled.
