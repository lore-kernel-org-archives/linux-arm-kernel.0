From: broonie@kernel.org (Mark Brown)
Date: Fri, 2 May 2014 10:24:52 -0700
Subject: [PATCH 13/15] ASoC: SND_S3C_DMA_LEGACY needs S3C24XX_DMA
In-Reply-To: <7071653.m3UbztQEJc@wuerfel>
References: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
 <1398770316-19715-14-git-send-email-kaixu.xia@linaro.org>
 <20140501191125.GB3245@sirena.org.uk> <7071653.m3UbztQEJc@wuerfel>
Message-ID: <20140502172452.GT3245@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 02, 2014 at 12:35:21AM +0200, Arnd Bergmann wrote:
> On Thursday 01 May 2014 12:11:25 Mark Brown wrote:

> > Why is the fix for this not to ensure that s3c24xx always enables the
> > DMA controller - how likely is it that it would be sane to build a
> > kernel without DMA after all?

> S3C24XX_DMA is only needed for ASoC and for s3cmci. The latter
> uses 'depends on S3C24XX_DMA'. arch/arm/configs/tct_hammer_defconfig
> is an example of a configuration that does not include DMA because
> it uses neither of the two drivers.

I'm having a hard time caring about that, the arch code can always do an
"if whatever".  If that board is what I think it actually does have
audio on it, either the defconfig was never updated or the driver wasn't
merged into mainline.

> How about the patch below?

I guess (modulo the issues below).  Killing the wrapper and making the
existing selection of DMA support actually select DMA support does avoid
the redundancy.

> diff --git a/sound/soc/samsung/ac97.c b/sound/soc/samsung/ac97.c
> index 76b072b..28fe097 100644
> --- a/sound/soc/samsung/ac97.c
> +++ b/sound/soc/samsung/ac97.c
> @@ -253,10 +253,7 @@ static int s3c_ac97_trigger(struct snd_pcm_substream *substream, int cmd,
>  
>  	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
>  
> -	if (!dma_data->ops)
> -		dma_data->ops = samsung_dma_get_ops();
> -
> -	dma_data->ops->started(dma_data->channel);
> +	s3c2410_dma_ctrl(dma_data->channel, S3C2410_DMAOP_STARTED);
>  
>  	return 0;
>  }

This code is broken in general - at least s3c64xx has AC'97.  That's
broken anyway though.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140502/70519974/attachment.sig>
