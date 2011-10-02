From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 2 Oct 2011 13:18:41 +0200
Subject: [PATCH 2/7] s3c-adc: describe features via quirk constants
In-Reply-To: <001a01cc80d6$40bf7e70$c23e7b50$%kim@samsung.com>
References: <201109182241.48858.heiko@sntech.de>
	<201109211504.03287.heiko@sntech.de>
	<001a01cc80d6$40bf7e70$c23e7b50$%kim@samsung.com>
Message-ID: <201110021318.42131.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kgene,

Am Sonntag 02 Oktober 2011, 09:38:18 schrieb Kukjin Kim:
> How about following? I think following is also not bad...
ok, I don't claim to have the right solution, so if keeping the TYPE_xxx enum 
is better, I will do a rework of the series according to your solution and 
resend it.

Could I meanwhile interest you in the patches for the S3C2416 armclk and hsmmc  
(from 28 Sep 2011) :-) ?

Thanks
Heiko


> diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
> index ee8deef..f5c6703 100644
> --- a/arch/arm/plat-samsung/adc.c
> +++ b/arch/arm/plat-samsung/adc.c
> @@ -41,6 +41,8 @@
> 
>  enum s3c_cpu_type {
>  	TYPE_ADCV1, /* S3C24XX */
> +	TYPE_ADCV11, /* S3C2416 */
> +	TYPE_ADCV12, /* S3C2443 */
>  	TYPE_ADCV2, /* S3C64XX, S5P64X0, S5PC100 */
>  	TYPE_ADCV3, /* S5PV210, S5PC110, EXYNOS4210 */
>  };
> @@ -98,13 +100,17 @@ static inline void s3c_adc_select(struct adc_device
> *adc,
> 
>  	client->select_cb(client, 1);
> 
> -	con &= ~S3C2410_ADCCON_MUXMASK;
> +	if (cpu == TYPE_ADCV1 || cpu == TYPE_ADCV2)
> +		con &= ~S3C2410_ADCCON_MUXMASK;
>  	con &= ~S3C2410_ADCCON_STDBM;
>  	con &= ~S3C2410_ADCCON_STARTMASK;
> 
>  	if (!client->is_ts) {
>  		if (cpu == TYPE_ADCV3)
>  			writel(client->channel & 0xf, adc->regs +
> S5P_ADCMUX);
> +		elif (cpu == TYPE_ADCV12)
> +			writel(client->channel & 0xf,
> +				adc->regs + S3C2443_ADCMUX);
>  		else
>  			con |= S3C2410_ADCCON_SELMUX(client->channel);
>  	}
> @@ -293,13 +299,13 @@ static irqreturn_t s3c_adc_irq(int irq, void *pw)
> 
>  	client->nr_samples--;
> 
> -	if (cpu != TYPE_ADCV1) {
> -		/* S3C64XX/S5P ADC resolution is 12-bit */
> -		data0 &= 0xfff;
> -		data1 &= 0xfff;
> -	} else {
> +	if (cpu == TYPE_ADCV1 || cpu == TYPE_ADCV12) {
>  		data0 &= 0x3ff;
>  		data1 &= 0x3ff;
> +	} else {
> +		/* S3C2416, S3C64XX/S5P ADC resolution is 12-bit */
> +		data0 &= 0xfff;
> +		data1 &= 0xfff;
>  	}
> 
>  	if (client->convert_cb)
> @@ -320,7 +326,7 @@ static irqreturn_t s3c_adc_irq(int irq, void *pw)
>  	}
> 
>  exit:
> -	if (cpu != TYPE_ADCV1) {
> +	if (cpu == TYPE_ADCV2 || cpu == TYPE_ADCV3) {
>  		/* Clear ADC interrupt */
>  		writel(0, adc->regs + S3C64XX_ADCCLRINT);
>  	}
> @@ -332,6 +338,7 @@ static int s3c_adc_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct adc_device *adc;
>  	struct resource *regs;
> +	enum s3c_cpu_type cpu = platform_get_device_id(pdev)->driver_data;
>  	int ret;
>  	unsigned tmp;
> 
> @@ -394,10 +401,13 @@ static int s3c_adc_probe(struct platform_device
> *pdev) clk_enable(adc->clk);
> 
>  	tmp = adc->prescale | S3C2410_ADCCON_PRSCEN;
> -	if (platform_get_device_id(pdev)->driver_data != TYPE_ADCV1) {
> -		/* Enable 12-bit ADC resolution */
> +
> +	/* Enable 12-bit ADC resolution */
> +	if (cpu == TYPE_ADCV11)
> +		tmp |= S3C2416_ADCCON_RESSEL;
> +	if (cpu == TYPE_ADCV2 || cpu == TYPE_ADCV3)
>  		tmp |= S3C64XX_ADCCON_RESSEL;
> -	}
> +
>  	writel(tmp, adc->regs + S3C2410_ADCCON);
> 
>  	dev_info(dev, "attached adc driver\n");
> @@ -464,6 +474,7 @@ static int s3c_adc_resume(struct device *dev)
>  	struct platform_device *pdev = container_of(dev,
>  			struct platform_device, dev);
>  	struct adc_device *adc = platform_get_drvdata(pdev);
> +	enum s3c_cpu_type cpu = platform_get_device_id(pdev)->driver_data;
>  	int ret;
>  	unsigned long tmp;
> 
> @@ -474,9 +485,13 @@ static int s3c_adc_resume(struct device *dev)
>  	enable_irq(adc->irq);
> 
>  	tmp = adc->prescale | S3C2410_ADCCON_PRSCEN;
> +
>  	/* Enable 12-bit ADC resolution */
> -	if (platform_get_device_id(pdev)->driver_data != TYPE_ADCV1)
> +	if (cpu == TYPE_ADCV11)
> +		tmp |= S3C2416_ADCCON_RESSEL;
> +	if (cpu == TYPE_ADCV2 || cpu == TYPE_ADCV3)
>  		tmp |= S3C64XX_ADCCON_RESSEL;
> +
>  	writel(tmp, adc->regs + S3C2410_ADCCON);
> 
>  	return 0;
> @@ -492,6 +507,12 @@ static struct platform_device_id s3c_adc_driver_ids[]
> = {
>  		.name           = "s3c24xx-adc",
>  		.driver_data    = TYPE_ADCV1,
>  	}, {
> +		.name		= "s3c2416-adc",
> +		.driver_data	= TYPE_ADCV11
> +	}, {
> +		.name		= "s3c2443-adc",
> +		.driver_data	= TYPE_ADCV12
> +	}, {
>  		.name           = "s3c64xx-adc",
>  		.driver_data    = TYPE_ADCV2,
>  	}, {
> 
> Thanks.
> 
> Best regards,
> Kgene.
