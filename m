From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 17 Oct 2013 19:43:12 +0200
Subject: [alsa-devel] [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio
 Interface driver.
In-Reply-To: <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <526021B0.6050206@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/2013 11:01 AM, Xiubo Li wrote:
[...]
> +static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
> +		struct snd_pcm_hw_params *params,
> +		struct snd_soc_dai *cpu_dai)
> +{
> +	int ret;
> +
> +	ret = fsl_sai_hw_params_tr(substream, params, cpu_dai,
> +				FSL_FMT_TRANSMITTER);
> +	if (ret) {
> +		dev_err(cpu_dai->dev,
> +				"Cannot set sai transmitter hw params: %d\n",
> +				ret);
> +		return ret;
> +	}
> +
> +	ret = fsl_sai_hw_params_tr(substream, params, cpu_dai,
> +				FSL_FMT_RECEIVER);
> +	if (ret) {
> +		dev_err(cpu_dai->dev,
> +				"Cannot set sai's receiver hw params: %d\n",
> +				ret);
> +		return ret;
> +	}

Shouldn't, depending on the substream direction, either transmit or receiver
be configured, instead of always configuring both?

> +
> +	return 0;
> +}
> +
> +static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
> +		struct snd_soc_dai *dai)
> +{
> +	struct fsl_sai *sai = snd_soc_dai_get_drvdata(dai);
> +	unsigned int tcsr, rcsr;
> +
> +	tcsr = readl(sai->base + SAI_TCSR);
> +	rcsr = readl(sai->base + SAI_RCSR);
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		rcsr |= SAI_CSR_TERE | SAI_CSR_FRDE;
> +		tcsr |= SAI_CSR_TERE | SAI_CSR_FRDE;
> +		writel(rcsr, sai->base + SAI_RCSR);
> +		udelay(10);
> +		writel(tcsr, sai->base + SAI_TCSR);
> +		break;
> +
> +	case SNDRV_PCM_TRIGGER_STOP:
> +	case SNDRV_PCM_TRIGGER_SUSPEND:
> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +		tcsr &= ~(SAI_CSR_TERE | SAI_CSR_FRDE);
> +		rcsr &= ~(SAI_CSR_TERE | SAI_CSR_FRDE);
> +		writel(tcsr, sai->base + SAI_TCSR);
> +		udelay(10);
> +		writel(rcsr, sai->base + SAI_RCSR);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +

Same here, shouldn't tx and rx be started independently depending on the
substream direction?

> +	return 0;
> +}
> +
> +static struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {

const

> +	.set_sysclk	= fsl_sai_set_dai_sysclk,
> +	.set_clkdiv	= fsl_sai_set_dai_clkdiv,
> +	.set_fmt	= fsl_sai_set_dai_fmt,
> +	.set_tdm_slot	= fsl_sai_set_dai_tdm_slot,
> +	.hw_params	= fsl_sai_hw_params,
> +	.trigger	= fsl_sai_trigger,
> +};
[...]
> +static const struct snd_soc_component_driver fsl_component = {
> +	.name           = "fsl-sai",
> +};
> +
> +static int fsl_sai_probe(struct platform_device *pdev)
> +{
[...]
> +
> +	sai->dma_params_rx.addr = res->start + SAI_RDR;
> +	sai->dma_params_rx.maxburst = 6;
> +	index = of_property_match_string(np, "dma-names", "rx");
> +	ret = of_parse_phandle_with_args(np, "dmas", "#dma-cells", index,
> +				&dma_args);
> +	if (ret)
> +		return ret;
> +	sai->dma_params_rx.slave_id = dma_args.args[1];
> +
> +	sai->dma_params_tx.addr = res->start + SAI_TDR;
> +	sai->dma_params_tx.maxburst = 6;
> +	index = of_property_match_string(np, "dma-names", "tx");
> +	ret = of_parse_phandle_with_args(np, "dmas", "#dma-cells", index,
> +				&dma_args);
> +	if (ret)
> +		return ret;
> +	sai->dma_params_tx.slave_id = dma_args.args[1];

The driver should not have to manually parse the dma devicetree properties,
this is something that should be handled by the dma engine driver.

> +
> +	ret = snd_soc_register_component(&pdev->dev, &fsl_component,
> +			&fsl_sai_dai, 1);
> +	if (ret)
> +		return ret;
> +
> +	ret = fsl_pcm_dma_init(pdev);
> +	if (ret)
> +		goto out;
> +
> +	platform_set_drvdata(pdev, sai);
> +
> +	return 0;
> +
> +out:
> +	snd_soc_unregister_component(&pdev->dev);
> +	return ret;
> +}
