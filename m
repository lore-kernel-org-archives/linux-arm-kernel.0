From: broonie@kernel.org (Mark Brown)
Date: Tue, 14 Feb 2017 17:45:34 +0000
Subject: [RFC v2 5/7] ASoC: stm32: add DFSDM DAI support
In-Reply-To: <1487003909-11710-6-git-send-email-arnaud.pouliquen@st.com>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-6-git-send-email-arnaud.pouliquen@st.com>
Message-ID: <20170214174534.35ytbpax75mxcayg@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2017 at 05:38:27PM +0100, Arnaud Pouliquen wrote:

This looks basically fine as a system specific driver but as some of the
comments in here say there's bits of it could perhaps be genericised but
I'm not sure we need to do that right now.  I'm not sure the abstraction
is exactly comfortable but having another bit of hardware doing a bridge
to IIO might be the best way to figure out something better.

> +	.period_bytes_min = 40, /* 8 khz 5 ms */
> +	.period_bytes_max = 4 * PAGE_SIZE,
> +	.buffer_bytes_max = 16 * PAGE_SIZE

What's the physical minimum period limit?  The comment makes this sound
like it's just made up.

> +	unsigned int shift = 24 -priv->max_scaling;
> +	

Missing space after -.

> +	dev_dbg(dai->dev, "%s: enter\n", __func__);
> +	return 0;
> +	return snd_pcm_hw_constraint_list(substream->runtime, 0,
> +					  SNDRV_PCM_HW_PARAM_RATE,
> +					  &priv->rates_const);

Looks like debug changes got left in?

> +static int stm32_adfsdm_set_sysclk(struct snd_soc_dai *dai, int clk_id,
> +				   unsigned int freq, int dir)
> +{
> +	struct stm32_adfsdm_priv *priv = snd_soc_dai_get_drvdata(dai);
> +	struct stm32_adfsdm_pdata *pdata = priv->pdata;
> +
> +	dev_dbg(dai->dev, "%s: enter for dai %d\n", __func__, dai->id);
> +	if (dir == SND_SOC_CLOCK_IN) {
> +		pdata->ops->set_sysclk(pdata->adc, freq);
> +		priv->dmic_clk = freq;
> +	}
> +
> +	/* Determine supported rate which depends on SPI/manchester clock */
> +	return stm32_adfsdm_get_supported_rates(dai, &priv->rates_const.mask);

Since the DAI is unidirectional it doesn't matter but obviously if it
weren't then the fact that getting the supported rates involves setting
the hwparams means this could become disruptive.  If we're going to
genericise this to be a more general IIO/ASoC bridge that could matter.

> +static int stm32_adfsdm_dai_remove(struct snd_soc_dai *dai)
> +{
> +	dev_dbg(dai->dev, "%s: enter for dai %d\n", __func__, dai->id);
> +
> +	return 0;
> +}

Remove empty functions, though in this case I think you want to add
something to disconnect the XRUN callback just in order to be sure it
can't be mistakenly called.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170214/934596be/attachment.sig>
