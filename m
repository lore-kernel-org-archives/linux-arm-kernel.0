From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 21 Oct 2014 19:12:02 +0200
Subject: [PATCH 1/2] ARM: pxa: spitz: register spitz-audio device
In-Reply-To: <1413881664-24870-1-git-send-email-dbaryshkov@gmail.com> (Dmitry
 Eremin-Solenikov's message of "Tue, 21 Oct 2014 12:54:23 +0400")
References: <1413881664-24870-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <87d29l1h5p.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

Hi Dmitry,

> Register spitz-audio device to be used by ASoC driver.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  arch/arm/mach-pxa/spitz.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
> index 840c3a4..a9f971f 100644
> --- a/arch/arm/mach-pxa/spitz.c
> +++ b/arch/arm/mach-pxa/spitz.c
> @@ -924,6 +924,23 @@ static inline void spitz_i2c_init(void) {}
>  #endif
>  
>  /******************************************************************************
> + * Audio devices
> + ******************************************************************************/
> +#if defined(CONFIG_SND_PXA2XX_SOC_SPITZ) || defined(SND_PXA2XX_SOC_SPITZ_MODULE)
> +static struct platform_device spitz_audio_device = {
> +	.name	= "spitz-audio",
> +	.id	= -1,
> +};
> +
> +static inline void spitz_audio_init(void)
> +{
> +	platform_device_register(&spitz_audio_device);
> +}
> +#else
> +static inline void spitz_audio_init(void) {}
> +#endif

Couldn't you eliminate the "#if defined" line , and "#else ... #endif" ?

I mean that spitz_audio_init() would always register the spitz_audio_device,
regardless of the config. The config would build or not build the sound soc
platform driver. Would that be alright for all your usecases ?

Cheers.

-- 
Robert
