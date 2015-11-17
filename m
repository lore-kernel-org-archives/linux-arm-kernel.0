From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 17 Nov 2015 10:36:46 +0900
Subject: [PATCH 2/3] ASoC: s3c24xx-i2s: pass DMA channels as platform data
In-Reply-To: <4171669.Y8FyLG5WLL@wuerfel>
References: <5466463.9HBcuLFGQf@wuerfel> <4171669.Y8FyLG5WLL@wuerfel>
Message-ID: <564A84AE.2000502@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.11.2015 02:23, Arnd Bergmann wrote:
> This is a minor cleanup to make the s3c2412-i2s and s3c24xx-i2s
> drivers independent of the mach/dma.h header file and to allow
> removing the dependency on the specific dmaengine driver in the
> next patch.
> 
> As a side not, only the s3c24xx-i2s driver seems to still be
> used, while the definition of the s3c2412-i2s platform device was
> removed in commit 6d259a25b56d ("ARM: SAMSUNG: use static
> declaration when it is not used in other files") after it had
> never been referenced since its introduction in f0fba2ad1b6b
> ("ASoC: multi-component - ASoC Multi-Component Support").
> 
> Apparently it should have been used by mach-jive.c, but that
> never happened. My patch at this point leaves the current state
> unchanged, we can decide whether to fix or delete the jive
> driver and s3c2412-i2s another time.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
> index 3ce234f4c872..e5e91669dd2b 100644
> --- a/arch/arm/plat-samsung/devs.c
> +++ b/arch/arm/plat-samsung/devs.c
> @@ -571,6 +571,11 @@ static struct resource s3c_iis_resource[] = {
>  	[0] = DEFINE_RES_MEM(S3C24XX_PA_IIS, S3C24XX_SZ_IIS),
>  };
>  
> +static struct s3c_audio_pdata s3c_iis_platdata = {
> +	.dma_playback = (void *)DMACH_I2S_OUT,
> +	.dma_capture = (void *)DMACH_I2S_IN,

Why casting? Is it needed?

> +};
> +
>  struct platform_device s3c_device_iis = {
>  	.name		= "s3c24xx-iis",
>  	.id		= -1,
> @@ -579,6 +584,7 @@ struct platform_device s3c_device_iis = {
>  	.dev		= {
>  		.dma_mask		= &samsung_device_dma_mask,
>  		.coherent_dma_mask	= DMA_BIT_MASK(32),
> +		.platform_data		= &s3c_iis_platdata,
>  	}
>  };
>  #endif /* CONFIG_PLAT_S3C24XX */
> diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
> index 77d27c85a32a..455a0be2278e 100644
> --- a/sound/soc/samsung/s3c2412-i2s.c
> +++ b/sound/soc/samsung/s3c2412-i2s.c
> @@ -33,14 +33,14 @@
>  #include "regs-i2s-v2.h"
>  #include "s3c2412-i2s.h"
>  
> +#include <linux/platform_data/asoc-s3c.h.h>
> +
>  static struct s3c_dma_params s3c2412_i2s_pcm_stereo_out = {
> -	.slave		= (void *)(uintptr_t)DMACH_I2S_OUT,
>  	.ch_name	= "tx",
>  	.dma_size	= 4,
>  };
>  
>  static struct s3c_dma_params s3c2412_i2s_pcm_stereo_in = {
> -	.slave		= (void *)(uintptr_t)DMACH_I2S_IN,
>  	.ch_name	= "rx",
>  	.dma_size	= 4,
>  };
> @@ -152,6 +152,7 @@ static int s3c2412_iis_dev_probe(struct platform_device *pdev)
>  {
>  	int ret = 0;
>  	struct resource *res;
> +	struct s3c_audio_pdata *pdata = dev_get_platdata(&pdev->dev);
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	s3c2412_i2s.regs = devm_ioremap_resource(&pdev->dev, res);
> @@ -159,7 +160,9 @@ static int s3c2412_iis_dev_probe(struct platform_device *pdev)
>  		return PTR_ERR(s3c2412_i2s.regs);
>  
>  	s3c2412_i2s_pcm_stereo_out.dma_addr = res->start + S3C2412_IISTXD;
> +	s3c2412_i2s_pcm_stereo_out.slave = pdata->dma_playback;
>  	s3c2412_i2s_pcm_stereo_in.dma_addr = res->start + S3C2412_IISRXD;
> +	s3c2412_i2s_pcm_stereo_in.slave = pdata->dma_capture;
>  
>  	ret = s3c_i2sv2_register_component(&pdev->dev, -1,
>  					   &s3c2412_i2s_component,
> diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
> index 9da3a77ea2c7..807dcc0d7421 100644
> --- a/sound/soc/samsung/s3c24xx-i2s.c
> +++ b/sound/soc/samsung/s3c24xx-i2s.c
> @@ -31,14 +31,14 @@
>  #include "dma.h"
>  #include "s3c24xx-i2s.h"
>  
> +#include <linux/platform_data/asoc-s3c.h>
> +
>  static struct s3c_dma_params s3c24xx_i2s_pcm_stereo_out = {
> -	.slave		= (void *)(uintptr_t)DMACH_I2S_OUT,
>  	.ch_name	= "tx",
>  	.dma_size	= 2,
>  };
>  
>  static struct s3c_dma_params s3c24xx_i2s_pcm_stereo_in = {
> -	.slave		= (void *)(uintptr_t)DMACH_I2S_IN,
>  	.ch_name	= "rx",
>  	.dma_size	= 2,
>  };
> @@ -454,6 +454,7 @@ static int s3c24xx_iis_dev_probe(struct platform_device *pdev)
>  {
>  	int ret = 0;
>  	struct resource *res;
> +	struct s3c_audio_pdata *pdata = dev_get_platdata(&pdev->dev);

Maybe:
if (!pdata) {
	pr_err("bla bla bla");
	return -EINVAL;
}

Best regards,
Krzysztof

>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res) {
> @@ -465,7 +466,9 @@ static int s3c24xx_iis_dev_probe(struct platform_device *pdev)
>  		return PTR_ERR(s3c24xx_i2s.regs);
>  
>  	s3c24xx_i2s_pcm_stereo_out.dma_addr = res->start + S3C2410_IISFIFO;
> +	s3c24xx_i2s_pcm_stereo_out.slave = pdata->dma_playback;
>  	s3c24xx_i2s_pcm_stereo_in.dma_addr = res->start + S3C2410_IISFIFO;
> +	s3c24xx_i2s_pcm_stereo_in.slave = pdata->dma_capture;
>  
>  	ret = devm_snd_soc_register_component(&pdev->dev,
>  			&s3c24xx_i2s_component, &s3c24xx_i2s_dai, 1);
> 
> 
