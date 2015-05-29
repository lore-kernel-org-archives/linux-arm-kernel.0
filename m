From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Sat, 30 May 2015 02:03:29 +0530
Subject: [PATCH 04/12] i2c: pxa: Add support for pxa910/988 & new
 configuration features
In-Reply-To: <874mmvyvzw.fsf@belgarion.home>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>	<1432818224-17070-5-git-send-email-vaibhav.hiremath@linaro.org>
 <874mmvyvzw.fsf@belgarion.home>
Message-ID: <5568CD19.6070202@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Saturday 30 May 2015 01:52 AM, Robert Jarzmik wrote:
> Vaibhav Hiremath <vaibhav.hiremath@linaro.org> writes:
>
>> @@ -167,6 +184,8 @@ struct pxa_i2c {
>>   #define _ICR(i2c)	((i2c)->reg_icr)
>>   #define _ISR(i2c)	((i2c)->reg_isr)
>>   #define _ISAR(i2c)	((i2c)->reg_isar)
>> +#define _ILCR(i2c)	((i2c)->reg_ilcr)
>> +#define _IWCR(i2c)	((i2c)->reg_iwcr)
>>
>>   /*
>>    * I2C Slave mode address
>> @@ -467,11 +486,16 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
>>   	if (i2c->reg_isar)
>>   		writel(i2c->slave_addr, _ISAR(i2c));
>>   #endif
>> -
> Not in this patch.

my bad, missed it.
Will fix it in next version.

>
>>   	/* set control register values */
>>   	writel(I2C_ICR_INIT | (i2c->fast_mode ? ICR_FM : 0), _ICR(i2c));
>>   	writel(readl(_ICR(i2c)) | (i2c->high_mode ? ICR_HS : 0), _ICR(i2c));
>>
>> +	if (i2c->ilcr)
>> +		writel(i2c->ilcr, _ILCR(i2c));
>> +	if (i2c->iwcr)
>> +		writel(i2c->iwcr, _IWCR(i2c));
>> +	udelay(2);
> This is a magical 2us. Where does it come from ?
>

I am afraid it is random number picked, required since we are
configuring mode/speed related bit-fields.

Thanks,
Vaibhav
