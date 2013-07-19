From: lars@metafoo.de (Lars-Peter Clausen)
Date: Fri, 19 Jul 2013 17:08:12 +0200
Subject: [alsa-devel] [PATCH 1/6] ASoC: sirf: add sirf platform driver
 which provides DMA
In-Reply-To: <1374232042-26088-2-git-send-email-Baohua.Song@csr.com>
References: <1374232042-26088-1-git-send-email-Baohua.Song@csr.com>
 <1374232042-26088-2-git-send-email-Baohua.Song@csr.com>
Message-ID: <51E9565C.8020308@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/19/2013 01:07 PM, Barry Song wrote:
> From: Rongjun Ying <Rongjun.Ying@csr.com>
> 
> this driver uses dmaengine APIs and provides DMA to the CPU DAIs
> of I2S, USP and SiRF-soc-inner.
> SiRFSoC has 3 audio DAIs: I2S, USP(Universal Serial Ports) and DAI
> connected to soc-inner-codec, all of them will use the same DMA
> driver here.
> 

I think the bulk of the code here can be replaced by using the generic
dmaengine PCM driver. Have a look at e.g. mxs to see how that is done.

[...]
> +
> +static int sirf_pcm_open(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct sirf_pcm_dma_data *dma_data;
> +	substream->runtime->hw = sirf_pcm_hardware;
> +	snd_soc_set_runtime_hwparams(substream, &sirf_pcm_hardware);
> +
> +	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
> +
> +	return snd_dmaengine_pcm_open_request_chan(substream,
> +			(dma_filter_fn)sirfsoc_dma_filter_id,
> +			(void *)(dma_data->dma_req));

Since you are using devicetree on this platform use the devicetree to get a
handle to the DMA channel.

> +}
> +
> +static int sirf_pcm_hw_params(struct snd_pcm_substream *substream,
> +		struct snd_pcm_hw_params *params)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct sirf_pcm_dma_data *dma_data;
> +	struct dma_slave_config config;
> +	struct dma_chan *chan;
> +	int err = 0;
> +
> +	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
> +
> +	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
> +	runtime->dma_bytes = params_buffer_bytes(params);
> +
> +	chan = snd_dmaengine_pcm_get_chan(substream);
> +	if (!chan)
> +		return -EINVAL;
> +
> +	/* fills in addr_width and direction */
> +	err = snd_hwparams_to_dma_slave_config(substream, params, &config);
> +	if (err)
> +		return err;
> +
> +	config.dst_addr_width = DMA_SLAVE_BUSWIDTH_8_BYTES;
> +	config.src_addr_width = DMA_SLAVE_BUSWIDTH_8_BYTES;
> +
> +	config.src_addr = runtime->dma_addr;
> +	config.dst_addr = runtime->dma_addr;
> +	config.src_maxburst = DMA_SLAVE_BUSWIDTH_8_BYTES;
> +	config.dst_maxburst = DMA_SLAVE_BUSWIDTH_8_BYTES;
> +
> +	return dmaengine_slave_config(chan, &config);


Nothing special in here, just use the generic
snd_dmaengine_pcm_prepare_slave_config().

> +}
> +
[...]

static const struct of_device_id sirf_pcm_of_match[] = {
> +	{ .compatible = "sirf,pcm-audio", },
> +	{}
> +};

Since this is not a separate piece of hardware, but just the glue logic
between the DMA controller and the audio DAI it should not have it's own
devicetree node. Usually the the PCM device is registered by the DAI driver.
Again take at other platforms using the generic dmaengine PCM driver for
examples.

> +MODULE_DEVICE_TABLE(of, sirf_pcm_of_match);
> +
> +static struct platform_driver sirf_pcm_driver = {
> +	.driver = {
> +		.name = "sirf-pcm-audio",
> +		.owner = THIS_MODULE,
> +		.of_match_table = sirf_pcm_of_match,
> +	},
> +	.probe = sirf_pcm_probe,
> +	.remove = sirf_pcm_remove,
> +};
> +module_platform_driver(sirf_pcm_driver);
[...]
