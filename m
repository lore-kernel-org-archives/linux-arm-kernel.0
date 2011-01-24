From: khilman@ti.com (Kevin Hilman)
Date: Mon, 24 Jan 2011 15:09:48 -0800
Subject: [PATCH v2] davinci: da8xx/omap-l1x: add platform device for
	davinci-pcm-audio
In-Reply-To: <1295624586-24636-1-git-send-email-sudhakar.raj@ti.com> (Sudhakar
	Rajashekhara's message of "Fri, 21 Jan 2011 21:13:06 +0530")
References: <1295624586-24636-1-git-send-email-sudhakar.raj@ti.com>
Message-ID: <87mxmp526b.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Rajashekhara, Sudhakar" <sudhakar.raj@ti.com> writes:

> After the multi-component commit f0fba2ad (ASoC: multi-component - ASoC
> Multi-Component Support) for ASoC, we need to register the platform
> device for davinci-pcm-audio.
>
> This patch and patch at [1] are required for audio to work on
> DA850/OMAP-L138.
>
> [1] https://patchwork.kernel.org/patch/495211/
>
> Signed-off-by: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>
> ---
> Since v1, removed davinci_init_pcm() function and called
> platform_device_register() from within da8xx_register_mcasp().

Thanks, queuing as a fix for 2.6.38-rc cycle.

Kevin

>  arch/arm/mach-davinci/devices-da8xx.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
> index 9eec630..beda8a4 100644
> --- a/arch/arm/mach-davinci/devices-da8xx.c
> +++ b/arch/arm/mach-davinci/devices-da8xx.c
> @@ -480,8 +480,15 @@ static struct platform_device da850_mcasp_device = {
>  	.resource	= da850_mcasp_resources,
>  };
>  
> +struct platform_device davinci_pcm_device = {
> +	.name	= "davinci-pcm-audio",
> +	.id	= -1,
> +};
> +
>  void __init da8xx_register_mcasp(int id, struct snd_platform_data *pdata)
>  {
> +	platform_device_register(&davinci_pcm_device);
> +
>  	/* DA830/OMAP-L137 has 3 instances of McASP */
>  	if (cpu_is_davinci_da830() && id == 1) {
>  		da830_mcasp1_device.dev.platform_data = pdata;
