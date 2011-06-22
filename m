From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Wed, 22 Jun 2011 11:40:46 +0900
Subject: [PATCH v2 1/5] Samsung SoC ADC: use regulator (VDD for ADC).
In-Reply-To: <20110621104357.GE22177@opensource.wolfsonmicro.com>
References: <20110620101737.GA31864@opensource.wolfsonmicro.com>
	<1308621527-2457-1-git-send-email-myungjoo.ham@samsung.com>
	<1308621527-2457-2-git-send-email-myungjoo.ham@samsung.com>
	<20110621104357.GE22177@opensource.wolfsonmicro.com>
Message-ID: <BANLkTinQYV8FJsy+5_sU8sTBhYPC7AQPow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 7:43 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Jun 21, 2011 at 10:58:43AM +0900, MyungJoo Ham wrote:
>
>> + ? ? ret = regulator_enable(adc->vdd);
>> + ? ? if (!ret)
>> + ? ? ? ? ? ? goto err_ioremap;
>> +
>
> This test looks the wrong way round? ?regulator_enable() should return 0
> on success but this will treat that as an error.

Whoops.. thanks for pointing that out!

>
>> ?static int s3c_adc_resume(struct platform_device *pdev)
>> ?{
>> ? ? ? struct adc_device *adc = platform_get_drvdata(pdev);
>> + ? ? int ret;
>>
>> + ? ? ret = regulator_enable(adc->vdd);
>> ? ? ? clk_enable(adc->clk);
>> ? ? ? enable_irq(adc->irq);
>>
>> ? ? ? writel(adc->prescale | S3C2410_ADCCON_PRSCEN,
>> ? ? ? ? ? ? ?adc->regs + S3C2410_ADCCON);
>>
>> - ? ? return 0;
>> + ? ? return ret;
>
> Seems better to return as soon as we notice the error, no point in
> starting anything else up if we don't have power.
>

Ok. I see.



-- 
MyungJoo Ham (???), Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
