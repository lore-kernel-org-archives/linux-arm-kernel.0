From: santosh.shilimkar@ti.com (Santosh)
Date: Fri, 26 Aug 2011 19:41:18 +0530
Subject: [PATCH v5 03/22] gpio/omap: make gpio_context part of gpio_bank
	structure
In-Reply-To: <87sjop5jfq.fsf@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>	<1312455893-14922-4-git-send-email-tarun.kanti@ti.com>	<4E53A0EE.5000703@ti.com>
	<87sjop5jfq.fsf@ti.com>
Message-ID: <4E57A986.5030800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 August 2011 01:53 AM, Kevin Hilman wrote:
> Santosh<santosh.shilimkar@ti.com>  writes:
>
>> On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
>>> From: Charulatha V<charu@ti.com>
>>>
>>> Currently gpio_context array used to save gpio bank's context, is used only for
>>> OMAP3 architecture. Move gpio_context as part of gpio_bank structure so that it
>>> can be specific to each gpio bank and can be used for any OMAP architecture
>>>
>>> Signed-off-by: Charulatha V<charu@ti.com>
>>> ---
>> Few comments.
>>
>
> [...]
>
>>> @@ -1494,33 +1490,31 @@ void omap2_gpio_resume_after_idle(void)
>>>    void omap_gpio_save_context(void)
>>>    {
>>>    	struct gpio_bank *bank;
>>> -	int i = 0;
>>>
>>>    	list_for_each_entry(bank,&omap_gpio_list, node) {
>>> -		i++;
>>>
>>>    		if (!bank->loses_context)
>>>    			continue;
>>>
>>> -		gpio_context[i].irqenable1 =
>>> +		bank->context.irqenable1 =
>>>    			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE1);
>>> -		gpio_context[i].irqenable2 =
>>> +		bank->context.irqenable2 =
>>>    			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE2);
>>
>> The context restore procedure should be done carefully. For instance
>> IRQ enabled register should be restored last to avoid any spurious
>> interrupts.
>
> For the sake of clean, easy-to-review patches, this kind of functional
> change should be a separate patch.
>
> The goal of $SUBJECT patch is simply to move the context struct into the
> bank struct, not change the order of the save restore.
>
> Any changing of the order of save/restore should be in a dedicated patch
> with a descriptive changelog since that is changing behavior of the code.
>
Agree.

Regards
Santosh
