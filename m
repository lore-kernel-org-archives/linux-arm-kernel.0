From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 25 Apr 2016 15:54:18 +0200
Subject: [PATCH 3/3] ASoC: bcm2835: Register also as PCM device
In-Reply-To: <1461591580-7565-3-git-send-email-kernel@martin.sperl.org>
References: <1461591580-7565-1-git-send-email-kernel@martin.sperl.org>
 <1461591580-7565-3-git-send-email-kernel@martin.sperl.org>
Message-ID: <571E218A.7050508@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2016 03:39 PM, kernel at martin.sperl.org wrote:
> From: Matthias Reichl <hias@horus.com>
> 
> Register i2s also as pcm device.

This is not really what this patch does.

> 
> Code ported from bcm2708-i2s driver in Raspberry Pi tree.
>
> Signed-off-by: Florian Meier <florian.meier@koalo.de>
> Signed-off-by: Matthias Reichl <hias@horus.com>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> ---
>  sound/soc/bcm/bcm2835-i2s.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
> index a0026e2..8e93295 100644
> --- a/sound/soc/bcm/bcm2835-i2s.c
> +++ b/sound/soc/bcm/bcm2835-i2s.c
> @@ -632,6 +632,27 @@ static const struct snd_soc_component_driver bcm2835_i2s_component = {
>  	.name		= "bcm2835-i2s-comp",
>  };
>  
> +static const struct snd_pcm_hardware bcm2835_pcm_hardware = {
> +	.info			= SNDRV_PCM_INFO_INTERLEAVED |
> +				  SNDRV_PCM_INFO_JOINT_DUPLEX |
> +				  SNDRV_PCM_INFO_MMAP |
> +				  SNDRV_PCM_INFO_MMAP_VALID,
> +	.formats		= SNDRV_PCM_FMTBIT_S16_LE |
> +				  SNDRV_PCM_FMTBIT_S24_LE |
> +				  SNDRV_PCM_FMTBIT_S32_LE,
> +	.period_bytes_min	= 32,
> +	.period_bytes_max	= 64 * PAGE_SIZE,
> +	.periods_min		= 2,
> +	.periods_max		= 255,
> +	.buffer_bytes_max	= 128 * PAGE_SIZE,
> +};
> +
> +static const struct snd_dmaengine_pcm_config bcm2835_dmaengine_pcm_config = {
> +	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
> +	.pcm_hardware = &bcm2835_pcm_hardware,
> +	.prealloc_buffer_size = 256 * PAGE_SIZE,
> +};

The generic dmaengine PCM driver auto-discovers these things, no need to
provide them. The code is OK as it is.

> +
>  static int bcm2835_i2s_probe(struct platform_device *pdev)
>  {
>  	struct bcm2835_i2s_dev *dev;
> @@ -704,7 +725,9 @@ static int bcm2835_i2s_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
> +	ret = devm_snd_dmaengine_pcm_register(
> +		&pdev->dev, &bcm2835_dmaengine_pcm_config,
> +		SND_DMAENGINE_PCM_FLAG_COMPAT);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Could not register PCM: %d\n", ret);
>  		return ret;
> 
