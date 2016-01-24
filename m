From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 24 Jan 2016 18:39:12 +0100
Subject: [PATCH 2/2] ASoC: simple-card: don't fail if sysclk setting is
 not supported
In-Reply-To: <1453588600-14831-3-git-send-email-aaro.koskinen@iki.fi>
References: <1453588600-14831-1-git-send-email-aaro.koskinen@iki.fi>
 <1453588600-14831-3-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <20160124173912.GV3880@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 24, 2016 at 12:36:40AM +0200, Aaro Koskinen wrote:
> Commit e22579713ae1 ("ASoC: simple card: set cpu-dai sysclk
> with mclk-fs") added sysclk / SND_SOC_CLOCK_OUT setting, that makes
> asoc_simple_card_hw_params fail if the operation is not supported,
> although the intention clearly was to ignore ENOTSUPP. Fix it.
> 
> The patch fixes audio playback on Kirkwood / OpenRD client,
> where the following errors are seen:
> 
> 	asoc-simple-card sound: ASoC: machine hw_params failed: -524
> 	alsa-lib: /alsa-lib-1.0.28/src/pcm/pcm_hw.c:327:(snd_pcm_hw_hw_params) SNDRV_PCM_IOCTL_HW_PARAMS failed (-524): Unknown error 524
> 
> Fixes: e22579713ae1 ("ASoC: simple card: set cpu-dai sysclk with mclk-fs")
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

	     Andrew

> ---
>  sound/soc/generic/simple-card.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
> index 54c3320..ff6fcd9 100644
> --- a/sound/soc/generic/simple-card.c
> +++ b/sound/soc/generic/simple-card.c
> @@ -100,7 +100,7 @@ static int asoc_simple_card_hw_params(struct snd_pcm_substream *substream,
>  		if (ret && ret != -ENOTSUPP)
>  			goto err;
>  	}
> -
> +	return 0;
>  err:
>  	return ret;
>  }
> -- 
> 2.4.0
> 
