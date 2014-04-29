From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 29 Apr 2014 12:57:24 +0200
Subject: [alsa-devel] [PATCH] ASoC: fsl: select SND_SOC_IMX_PCM_DMA where
 needed
In-Reply-To: <4270904.84oGcCXL4B@wuerfel>
References: <6606961.lAGLvkNsEj@wuerfel> <6285923.UQqcZVikjI@wuerfel>
 <1398740853.880576398@f238.i.mail.ru> <4270904.84oGcCXL4B@wuerfel>
Message-ID: <535F8594.40609@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/29/2014 12:37 PM, Arnd Bergmann wrote:
> On Tuesday 29 April 2014 07:07:33 Alexander Shiyan wrote:
>> Mon, 28 Apr 2014 23:12:14 +0200 ?? Arnd Bergmann <arnd@arndb.de>:
>>> On Tuesday 29 April 2014 00:35:41 Alexander Shiyan wrote:
>>>>
>>>> So, I don't understand why this error happen, as well as I can not
>>>> reproduce this...
>>>
>>> It's probably CONFIG_SND_SOC_IMX_PCM_DMA=m and CONFIG_SND_SOC_FSL_SSI=y then.
>>> What is the intended behavior in this case? Should CONFIG_SND_SOC_FSL_SSI
>>> be forced to be a module as well?
>>
>> Hmm, yes...
>> I thought that I had already solved a similar problem for the earlier
>> version of the patch ...
>
> How about this?

Having FSL_SSI/FSL_SPDIF, but not SND_SOC_IMX_PCM_DMA does not make sense on 
iMX.
So how about:

	select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC

and remove all the other 'select SND_SOC_IMX_PCM_DMA' statements. That's in 
my opinion much nicer.

- Lars


>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> index fb26345..af0bb92 100644
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -9,6 +9,7 @@ config SND_SOC_FSL_SAI
>
>   config SND_SOC_FSL_SSI
>   	tristate "Synchronous Serial Interface module support"
> +	depends on m || SND_SOC_IMX_PCM_DMA != m
>   	help
>   	  Say Y if you want to add Synchronous Serial Interface (SSI)
>   	  support for the Freescale CPUs.
> @@ -18,6 +19,7 @@ config SND_SOC_FSL_SSI
>   config SND_SOC_FSL_SPDIF
>   	tristate "Sony/Philips Digital Interface module support"
>   	select REGMAP_MMIO
> +	depends on m || SND_SOC_IMX_PCM_DMA != m
>   	help
>   	  Say Y if you want to add Sony/Philips Digital Interface (SPDIF)
>   	  support for the Freescale CPUs.
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel at alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
