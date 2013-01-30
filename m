From: jbe@pengutronix.de (Juergen Beisert)
Date: Wed, 30 Jan 2013 14:44:25 +0100
Subject: Sound/ARM/i.MX/SSI: fix SDMA starvation
In-Reply-To: <201301240956.30641.jbe@pengutronix.de>
References: <201301240956.30641.jbe@pengutronix.de>
Message-ID: <201301301444.25814.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Juergen Beisert wrote:
> In cases when capturing is already running and someone enables also
> playback, the SDMA unit of the i.MX SoC does not see an edge on its TX DMA
> request line. This is due to the TX FIFOs are empty, and this request line
> is active all the time, when the CCSR_SSI_SIER_TDMAE bit is set.
> In this case also the TX FIFO underrun interrupt will flood the system
> forever.
>
> To ensure the first edge happens after enabling the TX side of the SSI unit
> and to trigger the SDMA unit successfully enable the CCSR_SSI_SIER_TDMAE on
> demand only. To be sure, this patch does the same for the
> CCSR_SSI_SIER_RDMAE (RX side) bit.
>
> Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
>
> ---
>  sound/soc/fsl/fsl_ssi.c |   24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>
> Index: linux.git/sound/soc/fsl/fsl_ssi.c
> ===================================================================
> --- linux.git.orig/sound/soc/fsl/fsl_ssi.c
> +++ linux.git/sound/soc/fsl/fsl_ssi.c
> @@ -86,10 +86,9 @@ static inline void write_ssi_mask(u32 __
>  #endif
>
>  /* SIER bitflag of interrupts to enable */
> -#define SIER_FLAGS (CCSR_SSI_SIER_TFRC_EN | CCSR_SSI_SIER_TDMAE | \
> -		    CCSR_SSI_SIER_TIE | CCSR_SSI_SIER_TUE0_EN | \
> -		    CCSR_SSI_SIER_TUE1_EN | CCSR_SSI_SIER_RFRC_EN | \
> -		    CCSR_SSI_SIER_RDMAE | CCSR_SSI_SIER_RIE | \
> +#define SIER_FLAGS (CCSR_SSI_SIER_TFRC_EN | CCSR_SSI_SIER_TIE | \
> +		    CCSR_SSI_SIER_TUE0_EN | CCSR_SSI_SIER_TUE1_EN | \
> +		    CCSR_SSI_SIER_RFRC_EN | CCSR_SSI_SIER_RIE | \
>  		    CCSR_SSI_SIER_ROE0_EN | CCSR_SSI_SIER_ROE1_EN)
>
>  /**
> @@ -489,6 +488,9 @@ static int fsl_ssi_hw_params(struct snd_
>   *
>   * The DMA channel is in external master start and pause mode, which
>   * means the SSI completely controls the flow of data.
> + *
> + * To use the i.MX's SDMA unit it is important to create an edge on the
> + * corresponding request line. Otherwise the request will be ignored!
>   */
>  static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
>  			   struct snd_soc_dai *dai)
> @@ -500,20 +502,26 @@ static int fsl_ssi_trigger(struct snd_pc
>  	switch (cmd) {
>  	case SNDRV_PCM_TRIGGER_START:
>  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> -		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>  			write_ssi_mask(&ssi->scr, 0,
>  				CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE);
> -		else
> +			write_ssi_mask(&ssi->sier, 0, CCSR_SSI_SIER_TDMAE);
> +		} else {
>  			write_ssi_mask(&ssi->scr, 0,
>  				CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_RE);
> +			write_ssi_mask(&ssi->sier, 0, CCSR_SSI_SIER_RDMAE);
> +		}
>  		break;
>
>  	case SNDRV_PCM_TRIGGER_STOP:
>  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> -		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>  			write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_TE, 0);
> -		else
> +			write_ssi_mask(&ssi->sier, CCSR_SSI_SIER_TDMAE, 0);
> +		} else {
>  			write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_RE, 0);
> +			write_ssi_mask(&ssi->sier, CCSR_SSI_SIER_RDMAE, 0);
> +		}
>  		break;
>
>  	default:

Any comments on this patch?

jbe

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-5121-206917-5128 |
Peiner Str. 6-8, 31137 Hildesheim, Germany    | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
