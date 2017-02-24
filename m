From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 24 Feb 2017 14:09:36 +0100
Subject: [PATCH 2/3] drm/vc4: Add HDMI audio support
In-Reply-To: <20170207210703.7082-2-eric@anholt.net>
References: <20170207210703.7082-1-eric@anholt.net>
 <20170207210703.7082-2-eric@anholt.net>
Message-ID: <20170224140936.4b4b8bd5@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Tue,  7 Feb 2017 13:07:02 -0800
Eric Anholt <eric@anholt.net> wrote:

> +static int vc4_hdmi_audio_init(struct vc4_hdmi *hdmi)
> +{
> +	struct snd_soc_dai_link *dai_link = &hdmi->audio.link;
> +	struct snd_soc_card *card = &hdmi->audio.card;
> +	struct device *dev = &hdmi->pdev->dev;
> +	const __be32 *addr;
> +	int ret;
> +
> +	if (!of_find_property(dev->of_node, "dmas", NULL)) {
> +		dev_warn(dev,
> +			 "'dmas' DT property is missing, no HDMI audio\n");
> +		return 0;
> +	}
> +
> +	/*
> +	 * Get the physical address of VC4_HD_MAI_DATA. We need to retrieve
> +	 * the bus address specified in the DT, because the physical address
> +	 * (the one returned by platform_get_resource()) is not appropriate
> +	 * for DMA transfers.
> +	 * This VC/MMU should probably be exposed to avoid this kind of hacks.
> +	 */
> +	addr = of_get_address(dev->of_node, 1, NULL, NULL);
> +	hdmi->audio.dma_data.addr = be32_to_cpup(addr) + VC4_HD_MAI_DATA;
> +	hdmi->audio.dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	hdmi->audio.dma_data.maxburst = 2;
> +
> +	ret = devm_snd_dmaengine_pcm_register(dev, &pcm_conf, 0);
> +	if (ret) {
> +		dev_err(dev, "Could not register PCM component: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_snd_soc_register_component(dev, &vc4_hdmi_audio_cpu_dai_comp,
> +					      &vc4_hdmi_audio_cpu_dai_drv, 1);
> +	if (ret) {
> +		dev_err(dev, "Could not register CPU DAI: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* register codec and codec dai */
> +	ret = snd_soc_register_codec(dev, &vc4_hdmi_audio_codec_drv,
> +				     &vc4_hdmi_audio_codec_dai_drv, 1);
> +	if (ret) {
> +		dev_err(dev, "Could not register codec: %d\n", ret);
> +		return ret;
> +	}
> +
> +	dai_link->name = "MAI";
> +	dai_link->stream_name = "MAI PCM";
> +	dai_link->codec_dai_name = vc4_hdmi_audio_codec_dai_drv.name;
> +	dai_link->cpu_dai_name = dev_name(dev);
> +	dai_link->codec_name = dev_name(dev);
> +	dai_link->platform_name = dev_name(dev);
> +
> +	card->dai_link = dai_link;
> +	card->num_links = 1;
> +	card->name = "vc4-hdmi-audio";

I know I'm the one who chose this name, but maybe we should just change
it for "vc4-hdmi", since audio is kind of implied here ;-).
