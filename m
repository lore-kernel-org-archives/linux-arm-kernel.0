From: timur@tabi.org (Timur Tabi)
Date: Sun, 07 Apr 2013 19:18:50 -0500
Subject: [PATCH v2 05/11] ASoC: fsl-ssi: Add support for imx-pcm-fiq
In-Reply-To: <1365362721-3731-6-git-send-email-mpa@pengutronix.de>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
 <1365362721-3731-6-git-send-email-mpa@pengutronix.de>
Message-ID: <51620CEA.3010703@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Markus Pargmann wrote:
> Add support for non-dma pcm for imx platforms with imx-pcm-fiq support.
> Instead of imx-pcm-audio, in this case imx-pcm-fiq-audio device is added
> and the SIER flags are set differently.

So just to be clear, this is interrupt-driven SSI audio?  So you're 
generating an interrupt every time the transmit FIFO goes below the threshold?

I wonder if it makes sense to enable both FIFOs, so that you take half as 
many interrupts per second.

>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>   sound/soc/fsl/fsl_ssi.c | 70 ++++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 58 insertions(+), 12 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 7decbd9..afb5a23 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -120,10 +120,12 @@ struct fsl_ssi_private {
>
>   	bool new_binding;
>   	bool ssi_on_imx;
> +	bool dma;

Can you rename this to "use_dma" or something like that?

>   	struct clk *clk;
>   	struct platform_device *imx_pcm_pdev;
>   	struct imx_pcm_dma_params dma_params_tx;
>   	struct imx_pcm_dma_params dma_params_rx;
> +	struct imx_pcm_fiq_params fiq_params;
>
>   	struct {
>   		unsigned int rfrc;
> @@ -353,7 +355,8 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
>   		 */
>
>   		/* Enable the interrupts and DMA requests */
> -		write_ssi(SIER_FLAGS, &ssi->sier);
> +		if (ssi_private->dma)
> +			write_ssi(SIER_FLAGS, &ssi->sier);
>
>   		/*
>   		 * Set the watermark for transmit FIFI 0 and receive FIFO 0. We
> @@ -520,6 +523,18 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
>   		return -EINVAL;
>   	}
>
> +	if (!ssi_private->dma) {
> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +			write_ssi(CCSR_SSI_SOR_TX_CLR, &ssi->sor);
> +			write_ssi(CCSR_SSI_SIER_TIE | CCSR_SSI_SIER_TFE0_EN,
> +					&ssi->sier);
> +		} else {
> +			write_ssi(CCSR_SSI_SOR_RX_CLR, &ssi->sor);
> +			write_ssi(CCSR_SSI_SIER_RIE | CCSR_SSI_SIER_RFF0_EN,
> +					&ssi->sier);
> +		}
> +	}
> +
>   	return 0;
>   }
>
> @@ -680,6 +695,8 @@ static int fsl_ssi_probe(struct platform_device *pdev)
>   	       sizeof(fsl_ssi_dai_template));
>   	ssi_private->cpu_dai_drv.name = ssi_private->name;
>
> +	ssi_private->dma = !of_property_read_bool(np, "fsl,imx-fiq");

Instead of looking for the FIQ property, maybe you should just look for 
the absence of a DMA property/node, and then default to interrupts if 
there is no DMA.  That would make it more generic, and even work on 
non-IMX systems.

-- 
Timur Tabi
