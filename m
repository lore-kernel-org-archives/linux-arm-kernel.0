From: broonie@kernel.org (Mark Brown)
Date: Sat, 9 Nov 2013 18:48:47 +0000
Subject: [RFC] ASoC: Add support for BCM2835
In-Reply-To: <527D5013.7080508@koalo.de>
References: <527D5013.7080508@koalo.de>
Message-ID: <20131109184847.GV2493@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 08, 2013 at 09:56:51PM +0100, Florian Meier wrote:

This all looks pretty good, a few comments belown but nothing terribly
substantial.

>  source "sound/soc/atmel/Kconfig"
>  source "sound/soc/au1x/Kconfig"
> +source "sound/soc/bcm2835/Kconfig"

Is this really only used on this one SoC - I'd expect a more generic
name for the directory?

> +	/*
> +	 * Clear both FIFOs if the one that should be started
> +	 * is not empty at the moment. This should only happen
> +	 * after overrun. Otherwise, hw_params would have cleared
> +	 * the FIFO.
> +	 */
> +	regmap_read(dev->i2s_regmap, BCM2835_I2S_CS_A_REG, &cs_reg);
> +
> +	switch (substream->stream) {
> +	case SNDRV_PCM_STREAM_PLAYBACK:
> +		if (cs_reg & BCM2835_I2S_TXE)
> +			break;
> +	case SNDRV_PCM_STREAM_CAPTURE:
> +		if (!(cs_reg & BCM2835_I2S_RXD))
> +			break;
> +
> +		bcm2835_i2s_clear_fifos(dev);
> +	}

This is a bit confusing to me - the switch statement with fallthroughs
is a fairly unusual idiom and the placement of the clear is a bit
peculiar.  Writing it out with ifs would probably make it clearer what
the intent is.  It's also not clear why we're doing this or that it's
safe, won't this have a destructive effect on the other stream?

> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
> +		regmap_update_bits(dev->i2s_regmap, BCM2835_I2S_CS_A_REG,
> +				BCM2835_I2S_RXON, 0);
> +	} else {
> +		regmap_update_bits(dev->i2s_regmap, BCM2835_I2S_CS_A_REG,
> +				BCM2835_I2S_TXON, 0);
> +	}
> +

No { } for single statement if conditions.

> +static int bcm2835_i2s_dai_probe(struct snd_soc_dai *dai)
> +{
> +	struct bcm2835_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
> +
> +	/* Set the appropriate DMA parameters */
> +	dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK].addr =
> +		(dma_addr_t)BCM2835_I2S_FIFO_PHYSICAL_ADDR;
> +	dev->dma_data[SNDRV_PCM_STREAM_CAPTURE].addr =
> +		(dma_addr_t)BCM2835_I2S_FIFO_PHYSICAL_ADDR;

DT?

> +static bool bcm2835_clk_precious_reg(struct device *dev, unsigned int reg)
> +{
> +	return false;
> +}

Just omit this, it's the default.

> +static const struct regmap_config bcm2835_i2s_regmap_config = {
> +};

There should be something in here.

> +		ioarea = devm_request_mem_region(&pdev->dev, mem->start,
> +					   resource_size(mem),
> +					   pdev->name);
> +		if (!ioarea) {
> +			dev_err(&pdev->dev, "I2S probe: Memory region already claimed.\n");
> +			return -EBUSY;
> +		}
> +
> +		base = devm_ioremap(&pdev->dev, mem->start,
> +				resource_size(mem));

devm_ioremap_resource().  Thinking about this we should probably have a
regmap MMIO constructor that takes a resource...

> +static const struct snd_pcm_hardware bcm2835_pcm_hardware = {
> +	.info			= SNDRV_PCM_INFO_MMAP |
> +				  SNDRV_PCM_INFO_MMAP_VALID |
> +				  SNDRV_PCM_INFO_INTERLEAVED |
> +				  SNDRV_PCM_INFO_JOINT_DUPLEX,
> +	.formats		= SNDRV_PCM_FMTBIT_S16_LE |
> +				  SNDRV_PCM_FMTBIT_S32_LE,
> +	.period_bytes_min	= 32,
> +	.period_bytes_max	= 64 * PAGE_SIZE,
> +	.periods_min		= 2,
> +	.periods_max		= 255,
> +	.buffer_bytes_max	= 128 * PAGE_SIZE,

The dmaengine code recently acquired the ability to work out most of
this automatically by querying the DMA controller, you should use that
as much as possible.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131109/fca763a6/attachment.sig>
