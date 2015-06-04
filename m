From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 04 Jun 2015 11:16:09 +0530
Subject: [PATCH 04/12] i2c: pxa: Add support for pxa910/988 & new
 configuration features
In-Reply-To: <20150604023146.GF6696@yizhang>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1432818224-17070-5-git-send-email-vaibhav.hiremath@linaro.org>
 <874mmvyvzw.fsf@belgarion.home> <20150604023146.GF6696@yizhang>
Message-ID: <556FE621.8060502@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 04 June 2015 08:01 AM, Yi Zhang wrote:
> On Fri, May 29, 2015 at 10:22:27PM +0200, Robert Jarzmik wrote:
>> Vaibhav Hiremath <vaibhav.hiremath@linaro.org> writes:
>>
>>> @@ -167,6 +184,8 @@ struct pxa_i2c {
>>>   #define _ICR(i2c)	((i2c)->reg_icr)
>>>   #define _ISR(i2c)	((i2c)->reg_isr)
>>>   #define _ISAR(i2c)	((i2c)->reg_isar)
>>> +#define _ILCR(i2c)	((i2c)->reg_ilcr)
>>> +#define _IWCR(i2c)	((i2c)->reg_iwcr)
>>>
>>>   /*
>>>    * I2C Slave mode address
>>> @@ -467,11 +486,16 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
>>>   	if (i2c->reg_isar)
>>>   		writel(i2c->slave_addr, _ISAR(i2c));
>>>   #endif
>>> -
>> Not in this patch.
>>
>>>   	/* set control register values */
>>>   	writel(I2C_ICR_INIT | (i2c->fast_mode ? ICR_FM : 0), _ICR(i2c));
>>>   	writel(readl(_ICR(i2c)) | (i2c->high_mode ? ICR_HS : 0), _ICR(i2c));
>>>
>>> +	if (i2c->ilcr)
>>> +		writel(i2c->ilcr, _ILCR(i2c));
>>> +	if (i2c->iwcr)
>>> +		writel(i2c->iwcr, _IWCR(i2c));
>>> +	udelay(2);
>> This is a magical 2us. Where does it come from ?
>
>    This delay can be removed, if writing LCR and WCR before enabling this
>    i2c controller, it's safe enough; and they should not be changed when
>    there is bus activity.

I have already removed it in my next version.

Thanks,
Vaibhav
