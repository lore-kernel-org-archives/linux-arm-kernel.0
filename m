From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 02 Dec 2013 19:13:03 +0100
Subject: [alsa-devel] [PATCH 2/3] ASoC: ux500_pcm: Differentiate between
 pdata and DT initialisation
In-Reply-To: <1386007222-10081-2-git-send-email-lee.jones@linaro.org>
References: <1386007222-10081-1-git-send-email-lee.jones@linaro.org>
 <1386007222-10081-2-git-send-email-lee.jones@linaro.org>
Message-ID: <529CCDAF.7050205@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2013 07:00 PM, Lee Jones wrote:
> If booting with full DT support (i.e. DMA too, the last piece of the
> puzzle), then we don't need to use the compatible request channel call
> back. We also require slightly different flags to inform the core that
> we are booting with DT.

I don't think you need differentiate between DT and non-DT here.
If the SND_DMAENGINE_PCM_FLAG_COMPAT is set and the
SND_DMAENGINE_PCM_FLAG_NO_DT is not set it will first try to request the
channels from the DT if that fails it will fallback to the compat path. So
all this patch needs to do is remove the SND_DMAENGINE_PCM_FLAG_NO_DT, that
should be it.

> 
> Cc: alsa-devel at alsa-project.org
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  sound/soc/ux500/ux500_pcm.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pcm.c
> index 2f1bdb7..00cdd7b 100644
> --- a/sound/soc/ux500/ux500_pcm.c
> +++ b/sound/soc/ux500/ux500_pcm.c
> @@ -134,15 +134,31 @@ static const struct snd_dmaengine_pcm_config ux500_dmaengine_pcm_config = {
>  	.prepare_slave_config = ux500_pcm_prepare_slave_config,
>  };
>  
> +static const struct snd_dmaengine_pcm_config ux500_dmaengine_of_pcm_config = {
> +	.prepare_slave_config = ux500_pcm_prepare_slave_config,
> +};
> +
>  int ux500_pcm_register_platform(struct platform_device *pdev)
>  {
> +	const struct snd_dmaengine_pcm_config *pcm_config;
> +	struct device_node *np = pdev->dev.of_node;
> +	unsigned int pcm_flags;
>  	int ret;
>  
> -	ret = snd_dmaengine_pcm_register(&pdev->dev,
> -			&ux500_dmaengine_pcm_config,
> -			SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
> -			SND_DMAENGINE_PCM_FLAG_COMPAT |
> -			SND_DMAENGINE_PCM_FLAG_NO_DT);
> +	if (np) {
> +		pcm_config = &ux500_dmaengine_of_pcm_config;
> +
> +		pcm_flags = SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
> +			SND_DMAENGINE_PCM_FLAG_COMPAT;
> +	} else {
> +		pcm_config = &ux500_dmaengine_pcm_config;
> +
> +		pcm_flags = SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
> +			SND_DMAENGINE_PCM_FLAG_NO_DT |
> +			SND_DMAENGINE_PCM_FLAG_COMPAT;
> +	}
> +
> +	ret = snd_dmaengine_pcm_register(&pdev->dev, pcm_config, pcm_flags);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev,
>  			"%s: ERROR: Failed to register platform '%s' (%d)!\n",
> 
