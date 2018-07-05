From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 5 Jul 2018 09:19:24 +0100
Subject: [PATCH v3 09/17] irqchip/irq-mvebu-icu: support ICU subnodes
In-Reply-To: <20180704171622.2df87519@xps13>
References: <20180622151432.1566-1-miquel.raynal@bootlin.com>
 <20180622151432.1566-10-miquel.raynal@bootlin.com>
 <61ff2e4f-55b6-cf70-5f04-32cd197c35f8@arm.com>
 <20180704110917.65557d0a@xps13>
 <f4d1d42c-98b9-a485-0baf-2248114f8c8a@arm.com>
 <20180704171622.2df87519@xps13>
Message-ID: <1caaca86-aafc-c006-f2df-e42daf9f866b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/18 16:16, Miquel Raynal wrote:
> Hi Marc,
> 
> Marc Zyngier <marc.zyngier@arm.com> wrote on Wed, 4 Jul 2018 13:43:58
> +0100:
> 
>> On 04/07/18 10:09, Miquel Raynal wrote:
>>> Hi Marc,
>>>
>>> Marc Zyngier <marc.zyngier@arm.com> wrote on Thu, 28 Jun 2018 13:45:09
>>> +0100:
>>>   
>>>> On 22/06/18 16:14, Miquel Raynal wrote:  
>>>>> The ICU can handle several type of interrupt, each of them being handled
>>>>> differently on AP side. On CP side, the ICU should be able to make the
>>>>> distinction between each interrupt group by pointing to the right parent.
>>>>>
>>>>> This is done through the introduction of new bindings, presenting the ICU
>>>>> node as the parent of multiple ICU sub-nodes, each of them being an
>>>>> interrupt type with a different interrupt parent. ICU interrupt 'clients'
>>>>> now directly point to the right sub-node, avoiding the need for the extra
>>>>> ICU_GRP_* parameter.
>>>>>
>>>>> ICU subnodes are probed automatically with devm_platform_populate(). If
>>>>> the node as no child, the probe function for NSRs will still be called
>>>>> 'manually' in order to preserve backward compatibility with DT using the
>>>>> old binding.
>>>>>
>>>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>>>> ---
>>>>>  drivers/irqchip/irq-mvebu-icu.c | 88 ++++++++++++++++++++++++++++++++++-------
>>>>>  1 file changed, 74 insertions(+), 14 deletions(-)
>>>>>
>>>>> diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
>>>>> index 24d45186eb6b..f7c2ede9c222 100644
>>>>> --- a/drivers/irqchip/irq-mvebu-icu.c
>>>>> +++ b/drivers/irqchip/irq-mvebu-icu.c
>>>>> @@ -43,6 +43,7 @@ struct mvebu_icu {
>>>>>  	struct regmap *regmap;
>>>>>  	struct device *dev;
>>>>>  	atomic_t initialized;
>>>>> +	bool legacy_bindings;
>>>>>  };
>>>>>  
>>>>>  struct mvebu_icu_irq_data {
>>>>> @@ -51,6 +52,30 @@ struct mvebu_icu_irq_data {
>>>>>  	unsigned int type;
>>>>>  };
>>>>>  
>>>>> +static struct mvebu_icu *mvebu_icu_dev_get_drvdata(struct platform_device *pdev)
>>>>> +{
>>>>> +	struct mvebu_icu *icu;
>>>>> +
>>>>> +	/*
>>>>> +	 * Device data being populated means we should be using legacy bindings.
>>>>> +	 * Using the _parent_ device data means we should be using new bindings.
>>>>> +	 */
>>>>> +	icu = dev_get_drvdata(&pdev->dev);
>>>>> +	if (icu) {
>>>>> +		if (!icu->legacy_bindings)
>>>>> +			return ERR_PTR(-EINVAL);
>>>>> +	} else {
>>>>> +		icu = dev_get_drvdata(pdev->dev.parent);
>>>>> +		if (!icu)
>>>>> +			return ERR_PTR(-ENODEV);
>>>>> +
>>>>> +		if (icu->legacy_bindings)
>>>>> +			return ERR_PTR(-EINVAL);
>>>>> +	}    
>>>>
>>>> Doesn't this make legacy_bindings completely redundant? Either the
>>>> pointer is !NULL in the device, and this is using a legacy binging, or
>>>> it is stored in the parent, and this is a new binding. You could even
>>>> have a helper for that:
>>>>
>>>> static bool is_legacy(struct platform_device *pdev)
>>>> {
>>>> 	return !dev_get_drvdata(&pdev->dev);
>>>> }
>>>>
>>>> The driver really doesn't need to be defending against itself, if
>>>> anything, and it would save you quite a bit of error handling in the
>>>> callers of this function.  
>>>
>>> I simplified the sanity checks but I had to keep an icu->is_legacy
>>> boolean because the above function would not have worked, for instance,
>>> in the *_translate() hook. As this hook does not receive a struct
>>> device * (or platform_device) as parameter, I tried to use icu->dev
>>> instead. This cannot work as it always points to the device having the
>>> driver data attached.  
>>
>> You could still have the pdev as part of the domain host_data, right?
>> Isn't that just a matter of having a pointer to the pdev as part of the
>> icu data structure?
> 
> There is already a 'struct device *dev' pointer in the ICU data
> structure. This pointer is set to "&pdev->dev" in the main probe
> function.
> 
> Legacy: dev is the unique ICU device, the driver data is attached to it.
> Now: dev is the 'host' ICU device that is the parent of two other
> devices, ICU NSR controller and SEI NSR controller. The driver data is
> also attached to this device.
> 
> So in both situations checking dev_get_drvdata(icu->dev) would return a
> valid pointer.
> 
> Does this answer your question?

I think I need to see the full picture again. Post the updated series,
and we'll see what we can do.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
