From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 13 Mar 2014 11:28:05 +0100
Subject: [alsa-devel] [PATCH 14/18] ASoC: davinci: Add edma dmaengine
 platform driver
In-Reply-To: <1394702320-21743-15-git-send-email-peter.ujfalusi@ti.com>
References: <1394702320-21743-1-git-send-email-peter.ujfalusi@ti.com>
 <1394702320-21743-15-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <53218835.3080909@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2014 10:18 AM, Peter Ujfalusi wrote:
[...]
> +static const struct snd_pcm_hardware edma_pcm_hardware = {
> +	.info			= SNDRV_PCM_INFO_MMAP |
> +				  SNDRV_PCM_INFO_MMAP_VALID |
> +				  SNDRV_PCM_INFO_BATCH |
> +				  SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME |
> +				  SNDRV_PCM_INFO_INTERLEAVED,
> +	.buffer_bytes_max	= 128 * 1024,
> +	.period_bytes_min	= 32,
> +	.period_bytes_max	= 64 * 1024,
> +	.periods_min		= 2,
> +	.periods_max		= 19, /* Limit by edma dmaengine driver */
> +};

The idea is that we can auto-discover all the things using the 
dma_slave_caps API. Too bad we removed the possibility to specify the 
maximum number of segments from the API. Maybe we need to add it back. Is 
the 19 a hard-limit or could it be worked around by software in the 
dmaengine driver?

> +
> +static const struct snd_dmaengine_pcm_config edma_dmaengine_pcm_config = {
> +	.pcm_hardware = &edma_pcm_hardware,
> +	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
> +	.prealloc_buffer_size = 128 * 1024,

Unless there is a very good reason for exactly this size, just leave it 0 
and let the generic dmaengine driver use the default.

> +};
> +
> +static const struct snd_dmaengine_pcm_config edma_compat_dmaengine_pcm_config = {
> +	.pcm_hardware = &edma_pcm_hardware,
> +	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
> +	.compat_filter_fn = edma_filter_fn,
> +	.prealloc_buffer_size = 128 * 1024,
> +};

There is no need for different configs for DT and non-DT.

> +
> +int edma_pcm_platform_register(struct device *dev)
> +{
> +	if (dev->of_node)
> +		return snd_dmaengine_pcm_register(dev,
> +					&edma_dmaengine_pcm_config,
> +					SND_DMAENGINE_PCM_FLAG_NO_RESIDUE);

Since the edma dmaengine driver implements the slave cap API there is no 
need to manually specify SND_DMAENGINE_PCM_FLAG_NO_RESIDUE manually. But 
since the edma driver sets the granularity to 
DMA_RESIDUE_GRANULARITY_DESCRIPTOR in this case the generic dmaengine will 
not set SND_DMAENGINE_PCM_FLAG_NO_RESIDUE automatically since it assumes 
that the dmaengine driver is capable of properly reporting the DMA position.

> +	else
> +		return snd_dmaengine_pcm_register(dev,
> +					&edma_compat_dmaengine_pcm_config,
> +					SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
> +					SND_DMAENGINE_PCM_FLAG_NO_DT |
> +					SND_DMAENGINE_PCM_FLAG_COMPAT);


If you set the flags to just SND_DMAENGINE_PCM_FLAG_COMPAT it will do the 
right thing in the generic dmaengine driver depending on whether 
dev->of_node is set or not.


There is also a devm_ version of snd_dmaengine_pcm_register() it probably 
makes sense to use it here.
