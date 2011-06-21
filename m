From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 21 Jun 2011 11:43:57 +0100
Subject: [PATCH v2 1/5] Samsung SoC ADC: use regulator (VDD for ADC).
In-Reply-To: <1308621527-2457-2-git-send-email-myungjoo.ham@samsung.com>
References: <20110620101737.GA31864@opensource.wolfsonmicro.com>
	<1308621527-2457-1-git-send-email-myungjoo.ham@samsung.com>
	<1308621527-2457-2-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <20110621104357.GE22177@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 10:58:43AM +0900, MyungJoo Ham wrote:

> +	ret = regulator_enable(adc->vdd);
> +	if (!ret)
> +		goto err_ioremap;
> +

This test looks the wrong way round?  regulator_enable() should return 0
on success but this will treat that as an error.

>  static int s3c_adc_resume(struct platform_device *pdev)
>  {
>  	struct adc_device *adc = platform_get_drvdata(pdev);
> +	int ret;
>  
> +	ret = regulator_enable(adc->vdd);
>  	clk_enable(adc->clk);
>  	enable_irq(adc->irq);
>  
>  	writel(adc->prescale | S3C2410_ADCCON_PRSCEN,
>  	       adc->regs + S3C2410_ADCCON);
>  
> -	return 0;
> +	return ret;

Seems better to return as soon as we notice the error, no point in
starting anything else up if we don't have power.
