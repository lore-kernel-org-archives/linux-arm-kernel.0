From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 28 Aug 2014 11:21:55 +0200
Subject: [PATCH v9 3/5] rtc: max77686: Fail to probe if no RTC regmap
 irqchip is set
In-Reply-To: <1408350877-15921-4-git-send-email-javier.martinez@collabora.co.uk>
References: <1408350877-15921-1-git-send-email-javier.martinez@collabora.co.uk>
 <1408350877-15921-4-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1409217715.20020.7.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On pon, 2014-08-18 at 10:34 +0200, Javier Martinez Canillas wrote:
> The max77686 mfd driver adds a regmap IRQ chip which creates an
> IRQ domain that is used to map the virtual RTC alarm1 interrupt.
> 
> The RTC driver assumes that this will always be true since the
> PMIC IRQ is a required property according to the max77686 DT
> binding doc. If an "interrupts" property is not defined for a
> max77686 PMIC, then the mfd probe function will fail and the
> RTC platform driver will never be probed. But even when it is
> not possible to probe the rtc-max77686 driver without a regmap
> IRQ chip, it's better to explicitly check if the IRQ chip data
> is not NULL and gracefully fail instead of getting an OOPS.

The OOPS was possible only with Bartlomiej's patch because he changed
the MFD driver probe function to skip IRQ setup on lack of interrupts.
In current state the OOPS should not happen so mentioning OOPS in commit
message may be misleading. Maybe just don't put the OOPS here?

Anyway the patch looks good and a check for non-null
regmap_irq_chip_data is still a valid precaution so:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof


> 
> Reported-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
> 
> Fixes the issue reported by Krzystof in: https://lkml.org/lkml/2014/8/8/121
> ---
>  drivers/rtc/rtc-max77686.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
> index 7bb5433..55396bb 100644
> --- a/drivers/rtc/rtc-max77686.c
> +++ b/drivers/rtc/rtc-max77686.c
> @@ -466,6 +466,12 @@ static int max77686_rtc_probe(struct platform_device *pdev)
>  		goto err_rtc;
>  	}
>  
> +	if (!max77686->rtc_irq_data) {
> +		ret = -EINVAL;
> +		dev_err(&pdev->dev, "%s: no RTC regmap IRQ chip\n", __func__);
> +		goto err_rtc;
> +	}
> +
>  	info->virq = regmap_irq_get_virq(max77686->rtc_irq_data,
>  					 MAX77686_RTCIRQ_RTCA1);
>  	if (!info->virq) {
