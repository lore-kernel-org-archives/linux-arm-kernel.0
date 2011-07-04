From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 4 Jul 2011 10:03:03 -0700
Subject: [PATCH 7/7] ASoC: Samsung: Update DMA interface
In-Reply-To: <1309781915-31549-8-git-send-email-kgene.kim@samsung.com>
References: <1309781915-31549-1-git-send-email-kgene.kim@samsung.com>
	<1309781915-31549-8-git-send-email-kgene.kim@samsung.com>
Message-ID: <20110704170259.GC28726@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 09:18:35PM +0900, Kukjin Kim wrote:

> +static void audio_buffdone(void *data)
> +{
> +	struct snd_pcm_substream *substream = data;
> +	struct runtime_data *prtd;
> +	struct dma_chan *chan;
> +
> +	prtd = substream->runtime->private_data;
> +
> +	chan = prtd->params->chan;
> +	prtd->params->desc =
> +		chan->device->device_prep_dma_cyclic(
> +		chan, prtd->dma_pos, prtd->dma_period, prtd->dma_period,
> +		substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
> +		DMA_TO_DEVICE : DMA_FROM_DEVICE);
> +	if (!prtd->params->desc)
> +		dev_err(&chan->dev->device, "cannot prepare cyclic dma\n");
> +
> +	prtd->params->desc->callback = audio_buffdone;
> +	prtd->params->desc->callback_param = substream;
> +	dmaengine_submit(prtd->params->desc);
> +
> +	prtd->dma_pos += prtd->dma_period;
> +	if (prtd->dma_pos >= prtd->dma_end)
> +		prtd->dma_pos = prtd->dma_start;
> +
> +	if (substream)
> +		snd_pcm_period_elapsed(substream);
> +}

Two questions here:

- It looks like a lot of this code can be shared between all the drivers
  using the dmaengine API.  Is there any reason not to factor it out?
- Should this not be adding a new driver for dmaengine based Samsung
  CPUs?  The ifdefs are very big.
