From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 8 Aug 2012 08:57:24 +0200
Subject: [PATCH 4/9] ASoC: imx: Don't use {en,dis}able_fiq() calls
In-Reply-To: <1344207819-3415-4-git-send-email-anton.vorontsov@linaro.org>
References: <20120805230238.GA1663@lizard>
 <1344207819-3415-4-git-send-email-anton.vorontsov@linaro.org>
Message-ID: <20120808065724.GK1451@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 05, 2012 at 04:03:34PM -0700, Anton Vorontsov wrote:
> The driver uses platform-specific mxc_set_irq_fiq() with the VIRQ cookie
> passed to it, so it's pretty clear that the driver is absolutely sure
> that the FIQ is routed via platform-specific IC, and that the cookie can
> be used to mask/unmask FIQs. So, let's switch to the genirq routines,
> since we're about to remove FIQ-specific variants.
> 
> Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

> ---
>  sound/soc/fsl/imx-pcm-fiq.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
> index ee27ba3..993e37d 100644
> --- a/sound/soc/fsl/imx-pcm-fiq.c
> +++ b/sound/soc/fsl/imx-pcm-fiq.c
> @@ -139,7 +139,7 @@ static int snd_imx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
>  		hrtimer_start(&iprtd->hrt, ns_to_ktime(iprtd->poll_time_ns),
>  		      HRTIMER_MODE_REL);
>  		if (++fiq_enable == 1)
> -			enable_fiq(imx_pcm_fiq);
> +			enable_irq(imx_pcm_fiq);
>  
>  		break;
>  
> @@ -149,7 +149,7 @@ static int snd_imx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
>  		atomic_set(&iprtd->running, 0);
>  
>  		if (--fiq_enable == 0)
> -			disable_fiq(imx_pcm_fiq);
> +			disable_irq(imx_pcm_fiq);
>  
>  		break;
>  	default:
> -- 
> 1.7.10.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
