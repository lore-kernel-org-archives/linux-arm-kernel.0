From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 11 Nov 2013 19:37:30 +0100
Subject: [alsa-devel] [RFC] ASoC: Add support for BCM2835
In-Reply-To: <527D5013.7080508@koalo.de>
References: <527D5013.7080508@koalo.de>
Message-ID: <528123EA.6090609@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/2013 09:56 PM, Florian Meier wrote:

Is the I2S clock part of a generic clocking module? If yes it might be
better to implement this as a clock chip driver.

[...]
> +static void bcm2835_i2s_stop(struct bcm2835_i2s_dev *dev,
> +		struct snd_pcm_substream *substream)
> +{
> +	unsigned int still_running;
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
> +		regmap_update_bits(dev->i2s_regmap, BCM2835_I2S_CS_A_REG,
> +				BCM2835_I2S_RXON, 0);
> +	} else {
> +		regmap_update_bits(dev->i2s_regmap, BCM2835_I2S_CS_A_REG,
> +				BCM2835_I2S_TXON, 0);
> +	}
> +
> +	regmap_read(dev->i2s_regmap, BCM2835_I2S_CS_A_REG, &still_running);
> +	still_running &= BCM2835_I2S_TXON | BCM2835_I2S_RXON;
> +

still_running can be replaced with dai->active, I think

> +	/* Stop also the clock when not SND_SOC_DAIFMT_CONT */
> +	if (!still_running && !(dev->fmt & SND_SOC_DAIFMT_CONT))
> +		bcm2835_i2s_stop_clock(dev);
> +
> +}
> +
> +static int bcm2835_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
> +			       struct snd_soc_dai *dai)
> +{
> +	struct bcm2835_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		bcm2835_i2s_start_clock(dev);
> +
> +		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
> +			regmap_update_bits(dev->i2s_regmap,
> +					BCM2835_I2S_CS_A_REG,
> +					BCM2835_I2S_RXON, BCM2835_I2S_RXON);
> +		} else {
> +			regmap_update_bits(dev->i2s_regmap,
> +					BCM2835_I2S_CS_A_REG,
> +					BCM2835_I2S_TXON, BCM2835_I2S_TXON);
> +		}

Doing something like

		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
			mask = BCM2835_I2S_RXON;
		else
			mask = BCM2835_I2S_TXON;

		regmap_update_bits(dev->i2s_regmap,
			BCM2835_I2S_CS_A_REG, mask, mask);

makes the code a bit shorter. Same for bcm2835_i2s_stop().
> +		break;
> +
> +	case SNDRV_PCM_TRIGGER_STOP:
> +	case SNDRV_PCM_TRIGGER_SUSPEND:
> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +		bcm2835_i2s_stop(dev, substream);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bcm2835_i2s_startup(struct snd_pcm_substream *substream,
> +			       struct snd_soc_dai *dai)
> +{
> +	struct bcm2835_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
> +
> +	if (!dev->first_stream) {
> +		dev->first_stream = substream;
> +

Since you use first_stream and second_stream for anything else I think you
can just use dai->active here instead.

> +		/* should this still be running stop it */
> +		bcm2835_i2s_stop_clock(dev);
> +
> +		/* enable PCM block */
> +		regmap_update_bits(dev->i2s_regmap, BCM2835_I2S_CS_A_REG,
> +				BCM2835_I2S_EN, -1);
> +
> +		/*
> +		 * Disable STBY
> +		 * Requires at least 4 PCM clock cycles to take effect
> +		 */
> +		regmap_update_bits(dev->i2s_regmap, BCM2835_I2S_CS_A_REG,
> +				BCM2835_I2S_STBY, -1);
> +
> +	} else {
> +		dev->second_stream = substream;
> +	}
> +
> +	return 0;
> +}
> +
[...]
> +static int bcm2835_i2s_dai_probe(struct snd_soc_dai *dai)
> +{
> +	struct bcm2835_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
> +
> +	/* Set the appropriate DMA parameters */
> +	dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK].addr =
> +		(dma_addr_t)BCM2835_I2S_FIFO_PHYSICAL_ADDR;
> +	dev->dma_data[SNDRV_PCM_STREAM_CAPTURE].addr =
> +		(dma_addr_t)BCM2835_I2S_FIFO_PHYSICAL_ADDR;

The dma address for the FIFO should not be hardcoded but rather use an
offset to the resource that get's pass to the driver.

	dma_data->addr = mem->start + BCM2835_I2S_FIFO_A_REG;

I think it should be fine to initialize dma_data already in the driver
probe() function.

> +
> +	dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK].slave_id =
> +		BCM2835_DMA_DREQ_PCM_TX;
> +	dev->dma_data[SNDRV_PCM_STREAM_CAPTURE].slave_id =
> +		BCM2835_DMA_DREQ_PCM_RX;
> +
> +	dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK].addr_width =
> +		DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	dev->dma_data[SNDRV_PCM_STREAM_CAPTURE].addr_width =
> +		DMA_SLAVE_BUSWIDTH_4_BYTES;
> +
> +	/* TODO other burst parameters possible? */
> +	dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK].maxburst = 2;
> +	dev->dma_data[SNDRV_PCM_STREAM_CAPTURE].maxburst = 2;
> +
> +	dai->playback_dma_data = &dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK];
> +	dai->capture_dma_data = &dev->dma_data[SNDRV_PCM_STREAM_CAPTURE];
> +
> +	return 0;
> +}
> +
[...]
> +
> +static bool bcm2835_i2s_wr_rd_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case BCM2835_I2S_CS_A_REG:
> +	case BCM2835_I2S_FIFO_A_REG:
> +	case BCM2835_I2S_MODE_A_REG:
> +	case BCM2835_I2S_RXC_A_REG:
> +	case BCM2835_I2S_TXC_A_REG:
> +	case BCM2835_I2S_DREQ_A_REG:
> +	case BCM2835_I2S_INTEN_A_REG:
> +	case BCM2835_I2S_INTSTC_A_REG:
> +	case BCM2835_I2S_GRAY_REG:
> +		return true;
> +	default:
> +		return false;
> +	};
> +}

I think you use the default implementation of the here, which is basically
(reg >= 0 && reg <= config->max_register). Just leave the writeable_reg and
readable_reg fields of your config NULL.

[...]
> +
> +static const struct regmap_config bcm2835_i2s_regmap_config = {
> +};

This one seems to be unused.
