From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Mon, 24 Aug 2015 22:17:13 +0530
Subject: [PATCH-v6 5/6] mfd: 88pm800: Set default interrupt clear method
In-Reply-To: <20150824155129.GA19409@x1>
References: <1436358392-15449-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1436358392-15449-6-git-send-email-vaibhav.hiremath@linaro.org>
 <20150824135422.GF3237@x1> <55DB3627.2030503@linaro.org>
 <20150824155129.GA19409@x1>
Message-ID: <55DB4A91.9000702@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 24 August 2015 09:21 PM, Lee Jones wrote:
> On Mon, 24 Aug 2015, Vaibhav Hiremath wrote:
>
>>
>>
>> On Monday 24 August 2015 07:24 PM, Lee Jones wrote:
>>> On Wed, 08 Jul 2015, Vaibhav Hiremath wrote:
>>>
>>>> As per the spec, bit 1 (INT_CLEAR_MODE) of reg addr 0xe
>>>> (page 0) controls the method of clearing interrupt
>>>> status of 88pm800 family of devices;
>>>>
>>>>    0: clear on read
>>>>    1: clear on write
>>>>
>>>> If pdata is not coming from board file, then set the
>>>> default irq clear method to "irq clear on write"
>>>>
>>>> Also, as suggested by "Lee Jones" renaming variable field
>>>> to appropriate name and removed unnecessary field
>>>> pm80x_chip.irq_mode, using platform_data.irq_clr_method.
>>>>
>>>> Signed-off-by: Zhao Ye <zhaoy@marvell.com>
>>>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>>>> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>>> ---
>>>>   drivers/mfd/88pm800.c       | 15 ++++++++++-----
>>>>   include/linux/mfd/88pm80x.h |  9 +++++++--
>>>>   2 files changed, 17 insertions(+), 7 deletions(-)
>>>
>>> [...]
>>>
>>>> +#define PM800_WAKEUP2_INT_READ_CLEAR	(0 << 1)
>>>> +#define PM800_WAKEUP2_INT_WRITE_CLEAR	(1 << 1)
>>>
>>> Use BIT().
>>>
>>>> +/* Used by irq_clr_method */
>>>> +#define PM800_IRQ_CLR_ON_READ	0
>>>> +#define PM800_IRQ_CLR_ON_WRITE	1
>>>
>>>> -	int irq_mode;		/* Clear interrupt by read/write(0/1) */
>>>> +	bool irq_clr_method;		/* Clear interrupt by read/write(0/1) */
>>>
>>>> +	irq_clr_mode = pdata->irq_clr_method == PM800_IRQ_CLR_ON_WRITE ?
>>>> +		PM800_WAKEUP2_INT_WRITE_CLEAR : PM800_WAKEUP2_INT_READ_CLEAR;
>>>> +	ret = regmap_update_bits(map, PM800_WAKEUP2, mask, irq_clr_mode);
>>>
>>> This is pretty convoluted.
>>>
>>> For starters you're abusing the 'bool' type here.  Bool is either
>>> 'true' or 'false', so at the very least you should rename
>>> 'irq_clr_method' to 'irq_clr_on_write'.
>>>
>>> Then you can do:
>>>
>>> 	irq_clr_mode = pdata->irq_clr_on_write ?
>>> 		PM800_WAKEUP2_INT_WRITE_CLEAR : PM800_WAKEUP2_INT_READ_CLEAR;
>>>
>>
>> We have discussed on this, and went back-n-forth.
>> I think if I remember correctly, one of the version was using
>> true/false then we decided to rename it to relevant macro.
>>
>> If I am not wrong V4 version of this series is exactly same as what you
>> are referring to.
>
> Right.  I made a few suggestions which vary in usefulness depending on
> how you plan to implement all of this.  Unfortunately this is a bit of
> a bastardised version where some of it make sense and other parts
> could do with some improvement.
>

This so called "basterdised version could have been avoided :)

V2 version itself was clean and ready. It just got dragged into
multiple iterations.

>>> However, what I suggest you really do is share
>>> PM800_WAKEUP2_INT_{READ,WRITE}_CLEAR with platform data and just pass
>>> the value through directly.
>>>
>>
>> I think we discussed about this also, and the reason I recall here is,
>>
>> we may need to control this from DT in the future so we decided to keep
>> it boolean in platform_data and have simple check before writing to
>> register.
>>
>> And I think that was also another reason we introduced
>>
>> /* Used by irq_clr_method */
>> #define PM800_IRQ_CLR_ON_READ   0
>> #define PM800_IRQ_CLR_ON_WRITE  1
>
> I think these are still required.  So it would look like this:
>

NO. I think you are confused here,
We have two different macros playing around here,


+/* Used by irq_clr_method */
+#define PM800_IRQ_CLR_ON_READ	0
+#define PM800_IRQ_CLR_ON_WRITE	1

/* Used to write to register */
+#define PM800_WAKEUP2_INT_READ_CLEAR		(0 << 1)
+#define PM800_WAKEUP2_INT_WRITE_CLEAR		(1 << 1)



> == Platform data ==
>
> struct pdata {
>    bool clear_irq_on_write;
> };
>
> pdata->clear_irq_on_write = PM800_IRQ_CLR_ON_{READ,WRITE};
>
> == Driver ==
>
> irq_clr_mode = pdata->clear_irq_on_write ?
>                   PM800_WAKEUP2_INT_WRITE_CLEAR : PM800_WAKEUP2_INT_READ_CLEAR;
> regmap_update_bits(map, PM800_WAKEUP2, mask, irq_clr_mode);
>

Please check V2, which is exactly same as above.

https://patchwork.kernel.org/patch/6627781/


If you are OK with it, I will spin another version and submit it.

Thanks,
Vaibhav
