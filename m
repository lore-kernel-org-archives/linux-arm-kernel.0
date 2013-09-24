From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 24 Sep 2013 21:04:42 +0200
Subject: [PATCH] ASoC: kirkwood: simplify clock handling
In-Reply-To: <1380046355-7920-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1379951159-8294-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1380046355-7920-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20130924210442.6f617798@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Sep 2013 20:12:35 +0200
Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:

> There is no need to not use extclk if it is identical to the main clk.
> The main motivation for this patch is dropping devm_clk_put which is
> used in a wrong way by all other users.
> 
> While at it also extend the comments.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> there might be some further optimisations possible. I only note them
> here because I don't have the hardware to test:
> 
>  - only enable extclk if it a clock rate used that makes use of the
>    external clock. Not sure if that works; hardware docs reading
>    necessary.
>  - only provide extclk if it's != the internal clock.
>  - The code uses:
> 
> 	priv->clk = devm_clk_get(&pdev->dev, np ? "internal" : NULL);
> 
>    i.e. provides a con_id in the dt-case. I think that using NULL
>    unconditionally should also work, i.e. return the first clk
>    associated to the device. OTOH the current code might make things
>    clearer because it's more explicit.
	[snip]

Uwe,

The code around line 104 in kirkwood-i2s.c is not what it should be
(the patch from Russell is lost somewhere in the mailing-list).
Instead of:

	if (rate == 44100 || rate == 48000 || rate == 96000) {
		/* use internal dco for the supported rates
		 * defined in kirkwood_i2s_dai */

it should be:

	if (IS_ERR(priv->extclk)) {	/* no external clock */
		/* use internal dco - the supported rates are
		 * defined in kirkwood_i2s_dai */

That is: if there is an external clock, use it.

In fact, the internal dco is used for two audio devices. When both
devices are used at the same time, at least one of them must always use
an external clock, otherwise, there is a clock rate conflict.

As only one clock is used, there is no need to declare 2 clocks in the
DT, but the driver must know if it uses the internal or external clock
(to set the right clock input and also because their rates are not set
the same way)

So, the probe code should be:

	/* check first if an external clock is declared */
	priv->extclk = devm_clk_get(&pdev->dev, "extclk");
	if (!IS_ERR(priv->extclk)) {
		... use the external clock ...
	} else {

		/* get the first clock which must be the dco */
		priv->clk = devm_clk_get(&pdev->dev, NULL);
		if (IS_ERR(priv->clk))
			.. error, no clock ..
		.. use the internal dco ...
	}

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
