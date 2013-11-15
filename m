From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Nov 2013 12:21:08 +0000
Subject: [PATCH 2/2] ASoC: fsl_ssi: Add monaural audio support for
 non-ac97 interface
In-Reply-To: <1384427230-979-3-git-send-email-b42378@freescale.com>
References: <1384427230-979-1-git-send-email-b42378@freescale.com>
 <1384427230-979-3-git-send-email-b42378@freescale.com>
Message-ID: <20131115122107.GK16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 07:07:10PM +0800, Nicolin Chen wrote:
> The normal mode of SSI allows it to send/receive data to/from the first
> slot of each period. So we can use this normal mode to trick I2S signal
> by puting/getting data to/from the first slot only (the left channel)
> so as to support monaural audio playback and recording.
> 
> Signed-off-by: Nicolin Chen <b42378@freescale.com>
> ---
>  sound/soc/fsl/fsl_ssi.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index f43be6d..ccf1d38 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -517,10 +517,12 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
>  {
>  	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
>  	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
> +	unsigned int channels = params_channels(hw_params);
>  	unsigned int sample_size =
>  		snd_pcm_format_width(params_format(hw_params));
>  	u32 wl = CCSR_SSI_SxCCR_WL(sample_size);
>  	int enabled = read_ssi(&ssi->scr) & CCSR_SSI_SCR_SSIEN;
> +	static u8 i2s_mode;

Throwing a static variable into the middle of a driver with none is a
really horrid thing to do and is very bad programming practice.  What
if some freescale device decides to have to of these interfaces?  Both
will try to use this same static variable.

This is extremely bad programming practice.

>  
>  	/*
>  	 * If we're in synchronous mode, and the SSI is already enabled,
> @@ -546,6 +548,21 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
>  	else
>  		write_ssi_mask(&ssi->srccr, CCSR_SSI_SxCCR_WL_MASK, wl);
>  
> +	if (ssi_private->imx_ac97)
> +		return 0;
> +
> +	/* Save i2s mode configuration so that we can restore it later */
> +	switch (read_ssi(&ssi->scr) & CCSR_SSI_SCR_I2S_MODE_MASK) {
> +	case CCSR_SSI_SCR_I2S_MODE_SLAVE:
> +	case CCSR_SSI_SCR_I2S_MODE_MASTER:
> +		i2s_mode = read_ssi(&ssi->scr) & CCSR_SSI_SCR_I2S_MODE_MASK;
> +	default:
> +		break;
> +	}

So all you're doing is saving the mode only if it specifies master or
slave mode, but not if it's normal mode (== 0).  This just looks like
it's complicated just for the sake of being complicated.

Since we know what mode this is in when we run fsl_ssi_setup(), can we
not save that value into the fsl_ssi_private structure and re-use it
here?
