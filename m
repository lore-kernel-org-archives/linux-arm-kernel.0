From: broonie@kernel.org (Mark Brown)
Date: Wed, 18 Dec 2013 18:27:31 +0000
Subject: [PATCHv3 1/7] ALSA: Add SAI SoC Digital Audio Interface driver.
In-Reply-To: <1387250684-23406-2-git-send-email-Li.Xiubo@freescale.com>
References: <1387250684-23406-1-git-send-email-Li.Xiubo@freescale.com>
 <1387250684-23406-2-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <20131218182731.GE31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 11:24:38AM +0800, Xiubo Li wrote:

> This adds Freescale SAI ASoC Audio support.
> This implementation is only compatible with device tree definition.

This is mostly good, there are two small issues below but I've applied it
since they don't really affect the driver as a whole.  Please send
followup patches to fix the issues below.

> +static int fsl_sai_dai_probe(struct snd_soc_dai *cpu_dai)
> +{
> +	struct fsl_sai *sai = dev_get_drvdata(cpu_dai->dev);
> +
> +	cpu_dai->playback_dma_data = &sai->dma_params_tx;
> +	cpu_dai->capture_dma_data = &sai->dma_params_rx;

You should use snd_soc_dai_init_dma_data() for this.

> +static int fsl_sai_dai_remove(struct snd_soc_dai *cpu_dai)
> +{
> +	cpu_dai->playback_dma_data = NULL;
> +	cpu_dai->capture_dma_data = NULL;
> +
> +	snd_soc_dai_set_drvdata(cpu_dai, NULL);
> +
> +	return 0;
> +}

This is all unneeded and this function should be removed entirely.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131218/0ba92578/attachment-0001.sig>
