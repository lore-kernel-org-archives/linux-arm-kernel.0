From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon, 06 Aug 2012 13:08:25 +0300
Subject: [PATCH 1/2] GPIO: gpio-pxa: simplify pxa_gpio_to_irq() and
 pxa_irq_to_chip()
In-Reply-To: <501E5F5D.5070901@gmail.com>
References: <1343230539-7196-1-git-send-email-zonque@gmail.com>
 <501E2F6C.4050507@compulab.co.il> <501E5F5D.5070901@gmail.com>
Message-ID: <501F9799.5020400@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/12 14:56, Daniel Mack wrote:
> On 05.08.2012 10:31, Igor Grinberg wrote:
>> Hi Daniel,
>>
>> On 07/25/12 18:35, Daniel Mack wrote:
>>> Simplify the code in gpio-pxa.c and make them based on irq_base.
>>> When not probed from devicetree, initialize irq_base from
>>> PXA_GPIO_TO_IRQ() or MMP_GPIO_TO_IRQ(), respectively, so the non-DT case
>>> still works.
>>>
>>> Only tested on PXA3xx.
>>>
>>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>>> ---
>>>  drivers/gpio/gpio-pxa.c |   70 +++++++++++------------------------------------
>>>  1 file changed, 16 insertions(+), 54 deletions(-)
>>>
>>> diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
>>> index 58a6a63..6d0cb9d 100644
>>> --- a/drivers/gpio/gpio-pxa.c
>>> +++ b/drivers/gpio/gpio-pxa.c
>>
>> [...]
>>
>>> @@ -564,10 +516,20 @@ static int __devinit pxa_gpio_probe(struct platform_device *pdev)
>>>  	int irq0 = 0, irq1 = 0, irq_mux, gpio_offset = 0;
>>>  
>>>  	ret = pxa_gpio_probe_dt(pdev);
>>> -	if (ret < 0)
>>> +	if (ret < 0) {
>>>  		pxa_last_gpio = pxa_gpio_nums();
>>> -	else
>>> +#ifdef CONFIG_ARCH_PXA
>>> +		if (gpio_is_pxa_type(gpio_type))
>>> +			irq_base = PXA_GPIO_TO_IRQ(0);
>>> +#endif
>>> +#ifdef CONFIG_ARCH_MMP
>>> +		if (gpio_is_mmp_type(gpio_type))
>>> +			irq_base = MMP_GPIO_TO_IRQ(0);
>>> +#endif
>>
>> The ifdes above do not look essential.
> 
> But they are. In case of !CONFIG_ARCH_MMP, MMP_GPIO_TO_IRQ is undefined.
> Same problem for !CONFIG_ARC_PXA.

I see. Ok then. I'm not a huge fan of having the #ifdes inside
the code (functions) and thinking of moving those outside of the function,
I get pretty much the same solution it was before your patch.

I really think that PXA|MMP_GPIO_TO_IRQ should be moved to some common
location (say arch/arm/plat-pxa/) so both are available regardless
of CONFIG_ARCH_MMP|PXA. That will simplify the code even more.
But probably it is too much to ask for that simple patch...
So, I'm fine with the patch.

Thanks

> 
>> Can't we drop them and just have else if ... else if?
> 
> We can't do that either, as we might have a hybrid kernel that works on
> both PXA and MMP platforms, and then the condition is a runtime thing.

Well, that is exactly what I mean...
I mean, the if ... else ... if ... else without the #ifdefs...
But again, it requires some more changes.

-- 
Regards,
Igor.
