From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 26 May 2010 22:13:10 -0400
Subject: [RFC PATCH v2 1/3] ep93xx i2s audio driver
In-Reply-To: <1274850588-30460-2-git-send-email-ryan@bluewatersys.com>
References: <1274850588-30460-1-git-send-email-ryan@bluewatersys.com>
	<1274850588-30460-2-git-send-email-ryan@bluewatersys.com>
Message-ID: <20100527021306.GA21697@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 26, 2010 at 05:09:46PM +1200, Ryan Mallon wrote:

> +	/* 
> +	 * Calculate the sdiv (bit clock) and lrdiv (left/right clock) values. 
> +	 * If the lrclk is pulse length is larger than the word size, then the
> +	 * bit clock will be gated for the unused bits.
> +	 */
> +	div = (clk_get_rate(info->mclk) / params_rate(params)) * 
> +		params_channels(params);
> +	for (sdiv = 2; !found && sdiv <= 4; sdiv += 2)
> +		for (lrdiv = 32; !found && lrdiv <= 128; lrdiv <<= 1)
> +			if (sdiv * lrdiv == div)
> +				found = 1;
> +	if (!found)
> +		return -EINVAL;

This suggests that the device has a single LRCLK for both TX and RX and
therefore the DAI should have symmetric_rates set so that applications
are told about this restriction and the upper layers prevent them from
setting asymmetric rates (which would result in the first direction
ending up running at the wrong rate when the second direction starts).

> +	err = snd_soc_register_dai(&ep93xx_i2s_dai);
> +	if (err)
> +		goto fail_free_info;

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		err = -ENODEV;
> +		goto fail_unregister_dai;
> +	}
> +		

The DAI registration is happening at the wrong place - you're telling
ASoC the DAI is ready before you've finished acquiring the resources it
needs to run, meaning that there's a race condition where something may
try to start audio up while the probe is still running.  Generally DAI
registration should be the last thing your driver does.

> +static int __devexit ep93xx_i2s_remove(struct platform_device *pdev)
> +{
> +	struct ep93xx_i2s_info *info = ep93xx_i2s_dai.private_data;
> +	
> +	clk_put(info->lrclk);
> +	clk_put(info->sclk);
> +	clk_put(info->mclk);
> +	iounmap(info->regs);
> +	release_mem_region(info->mem->start, resource_size(info->mem));
> +	snd_soc_unregister_dai(&ep93xx_i2s_dai);
> +	kfree(info);
> +	return 0;
> +}

Here you should free the DAI before anything else for the same reason as
above.

> +/*
> + * These are the offsets for the LRDIV and SDIV fields in the syscon i2sclkdiv
> + * register.
> + */
> +#define EP93XX_I2S_LRDIV	17
> +#define EP93XX_I2S_SDIV		16

Most of the other defines are in the driver - should these be there (or
removed)?

> +static int ep93xx_pcm_prepare(struct snd_pcm_substream *substream)
> +{
> +	return 0;
> +}

Remove this if no code is needed.
