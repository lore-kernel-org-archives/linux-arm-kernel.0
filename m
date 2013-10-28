From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 28 Oct 2013 07:48:49 +0100
Subject: [alsa-devel] [PATCH v2 2/6] ASoC: sirf: add I2S CPU DAI driver
In-Reply-To: <1382913424-28626-1-git-send-email-Baohua.Song@csr.com>
References: <1382913424-28626-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <526E08D1.4040009@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2013 11:37 PM, Barry Song wrote:
> +struct snd_soc_dai_ops sirfsoc_i2s_dai_ops = {

static const

Building your driver with sparse (`make C=2 ...`) will tell you these things.

> +	.startup	= sirf_i2s_startup,
> +	.shutdown	= sirf_i2s_shutdown,
> +	.trigger	= sirf_i2s_trigger,
> +	.hw_params	= sirf_i2s_hw_params,
> +	.set_fmt	= sirf_i2s_set_dai_fmt,
> +	.set_clkdiv	= sirf_i2s_set_clkdiv,
> +};
> +
[...]
> +
> +static int sirf_i2s_probe(struct platform_device *pdev)
> +{
> +	struct sirf_i2s *si2s;
> +	u32 rx_dma_ch, tx_dma_ch;
> +	int ret;
> +	struct resource mem_res;
> +
> +	si2s = devm_kzalloc(&pdev->dev, sizeof(struct sirf_i2s),
> +			GFP_KERNEL);
> +	if (!si2s)
> +		return -ENOMEM;
> +
> +	si2s->sirf_pcm_pdev = platform_device_register_simple("sirf-pcm-audio",
> +			0, NULL, 0);
> +	if (IS_ERR(si2s->sirf_pcm_pdev))
> +		return PTR_ERR(si2s->sirf_pcm_pdev);
> +
> +	platform_set_drvdata(pdev, si2s);
> +
> +	spin_lock_init(&si2s->lock);
> +
> +	ret = of_property_read_u32(pdev->dev.of_node,
> +			"sirf,i2s-dma-rx-channel", &rx_dma_ch);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Unable to USP0 rx dma channel\n");
> +		return ret;
> +	}
> +	ret = of_property_read_u32(pdev->dev.of_node,
> +			"sirf,i2s-dma-tx-channel", &tx_dma_ch);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Unable to USP0 tx dma channel\n");
> +		return ret;
> +	}
> +
> +	dma_data[0].filter_data = (void *)tx_dma_ch;
> +	dma_data[1].filter_data = (void *)rx_dma_ch;

This should be using the standard DMA OF bindings. This combind with the
recent changes to the generic dmaengine PCM driver, which added support for
querying certain parameters (like max period length) from the dmaengine
driver, will allow you to completely remove your custom PCM code. You'd
basically just need to call "snd_dmaengine_pcm_register(&pdev->dev, NULL)"
here in the I2S driver.

This will require some changes to your dmaengine driver though. You need to
implement the of_xlate callback for the generic DMA bindings and the
device_slave_caps API for being able to query the capabilities from the driver.
