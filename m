From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 28 Jul 2014 21:08:28 +0900
Subject: [PATCH 2/2] iio: adc: exynos_adc: Add support for S3C24xx ADC
In-Reply-To: <175757227.TPQdXAQiJt@diego>
References: <1405995074-3271-1-git-send-email-cw00.choi@samsung.com>
 <1405995074-3271-3-git-send-email-cw00.choi@samsung.com>
 <5200888.DXoC06U953@wuerfel> <175757227.TPQdXAQiJt@diego>
Message-ID: <53D63D3C.7000401@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2014 07:44 PM, Heiko St?bner wrote:
> Am Dienstag, 22. Juli 2014, 10:39:38 schrieb Arnd Bergmann:
>> On Tuesday 22 July 2014 11:11:14 Chanwoo Choi wrote:
>>> This patch add support for s3c2410/s3c2416/s3c2440/s3c2443 ADC. The
>>> s3c24xx
>>> is alomost same as ADCv1. But, There are a little difference as following:
>>> - ADCMUX register address to select channel
>>> - ADCDAT mask (10bit or 12bit ADC resolution according to SoC version)
>>
>> Very good, thanks for doing this patch!
>>
>> (adding Heiko to Cc, he's probably interested in seeing this as well.
> 
> indeed. Thanks for implementing this.
> 
> While trying to build a test setup for this, I noticed two points:
> 
> (1) I'm not sure what the second register (a "phy enable register" according
> to the binding) is supposed to be.
> According to binding and adc code it is mandatory, but I didn't find any
> lone adc register in the s3c2416 manual.

You're right. I don't find ADC_PHY_CONTROL register on s3c2410 datasheet.
So, if 'needs_adc_phy' field is true, exynos-adc would only get 'phy enable register'
from dt node.

-       mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-       info->enable_reg = devm_ioremap_resource(&pdev->dev, mem);
-       if (IS_ERR(info->enable_reg))
-               return PTR_ERR(info->enable_reg);
+
+       if (info->data->needs_adc_phy) {
+               mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+               info->enable_reg = devm_ioremap_resource(&pdev->dev, mem);
+               if (IS_ERR(info->enable_reg))
+                       return PTR_ERR(info->enable_reg);
+       }


> 
> 
> (2) You might need something along the lines of:
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 11b048a..088c99a 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -129,7 +129,7 @@ config AT91_ADC
>  
>  config EXYNOS_ADC
>         tristate "Exynos ADC driver support"
> -       depends on ARCH_EXYNOS || (OF && COMPILE_TEST)
> +       depends on ARCH_EXYNOS || ARCH_S3C24XX || ARCH_S3C64XX || (OF && COMPILE_TEST)
>         help
>           Core support for the ADC block found in the Samsung EXYNOS series
>           of SoCs for drivers such as the touchscreen and hwmon to use to share

OK, I'll modify it as your comment.

Best Regards,
Chanwoo Choi
