From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 28 Jul 2014 20:20:13 +0900
Subject: [PATCH 2/2] iio: adc: exynos_adc: Add support for S3C24xx ADC
In-Reply-To: <5200888.DXoC06U953@wuerfel>
References: <1405995074-3271-1-git-send-email-cw00.choi@samsung.com>
 <1405995074-3271-3-git-send-email-cw00.choi@samsung.com>
 <5200888.DXoC06U953@wuerfel>
Message-ID: <53D631ED.40803@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2014 05:39 PM, Arnd Bergmann wrote:
> On Tuesday 22 July 2014 11:11:14 Chanwoo Choi wrote:
>> This patch add support for s3c2410/s3c2416/s3c2440/s3c2443 ADC. The s3c24xx
>> is alomost same as ADCv1. But, There are a little difference as following:
>> - ADCMUX register address to select channel
>> - ADCDAT mask (10bit or 12bit ADC resolution according to SoC version)
> 
> Very good, thanks for doing this patch!
> 
> (adding Heiko to Cc, he's probably interested in seeing this as well.
> 
> One comment:
>  
>> @@ -101,12 +107,14 @@ struct exynos_adc {
>>  	struct completion	completion;
>>  
>>  	u32			value;
>> +	u32			value2;
>>  	unsigned int            version;
>>  };
>> ...
>> @@ -365,7 +448,7 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
>>  		ret = -ETIMEDOUT;
>>  	} else {
>>  		*val = info->value;
>> -		*val2 = 0;
>> +		*val2 = info->value2;
>>  		ret = IIO_VAL_INT;
>>  	}
>>  
>> @@ -377,9 +460,11 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
>>  static irqreturn_t exynos_adc_isr(int irq, void *dev_id)
>>  {
>>  	struct exynos_adc *info = (struct exynos_adc *)dev_id;
>> +	u32 mask = info->data->mask;
>>  
>>  	/* Read value */
>> -	info->value = readl(ADC_V1_DATX(info->regs)) & ADC_DATX_MASK;
>> +	info->value = readl(ADC_V1_DATX(info->regs)) & mask;
>> +	info->value2 = readl(ADC_V1_DATY(info->regs)) & mask;
>>  
>>  	/* clear irq */
>>  	if (info->data->clear_irq)
> 
> If I understand it right, this would only be necessary if we want
> to do the touchscreen driver as a separate iio client using the
> in-kernel interfaces. As Jonathan Cameron commented, we probably
> don't want to do that though. Even if we do, it should be a separate
> patch and not mixed in with the s3c24xx support.

OK, I'll drop this sentence which reading DATY register.

Best Regards,
Chanwoo Choi

> 
> Aside from this:
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> 	Arnd
> 
