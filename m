From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 Jun 2012 09:01:37 +0100
Subject: [PATCH 08/14] mfd: Add IRQ domain support for the AB8500
In-Reply-To: <CACRpkdaZ1OZdaqo=_YvQpyYazpcmhLT8QF4jz1WUQMSAsTM8Sw@mail.gmail.com>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-9-git-send-email-lee.jones@linaro.org>
 <CACRpkdaZ1OZdaqo=_YvQpyYazpcmhLT8QF4jz1WUQMSAsTM8Sw@mail.gmail.com>
Message-ID: <4FD6F761.6010305@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/12 22:33, Linus Walleij wrote:
> On Mon, Jun 11, 2012 at 5:25 PM, Lee Jones<lee.jones@linaro.org>  wrote:
>
>> As the AB8500 is an IRQ controller in its own right, here we provide
>> the AB8500 driver with IRQ domain support. This is required if we wish
>> to reference any of its IRQs from a platform's Device Tree.
>
> OK..
>
>> diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
> (...)
>> -static int ab8500_irq_init(struct ab8500 *ab8500)
>> +/**
>> + * ab8500_irq_get_virq(): Map an interrupt on a chip to a virtual IRQ
>> + *
>> + * Useful for drivers to request their own IRQs.
>
> Check style against Documentation/kernel-doc-nano-HOWTO.txt
> verbos explanation follows argument documentation.

Ah, good to know.

I just followed other examples in this case. I'll swap them over.

>> + *
>> + * @ab8500: ab8500_irq controller to operate on.
>> + * @irq: index of the interrupt requested in the chip IRQs
>> + */
>> +int ab8500_irq_get_virq(struct ab8500 *ab8500, int irq)
>>   {
>> -       int base = ab8500->irq_base;
>> -       int irq;
>> -       int num_irqs;
>> +       if (!ab8500)
>> +               return -EINVAL;
>>
>> -       if (is_ab9540(ab8500))
>> -               num_irqs = AB9540_NR_IRQS;
>> -       else if (is_ab8505(ab8500))
>> -               num_irqs = AB8505_NR_IRQS;
>> -       else
>> -               num_irqs = AB8500_NR_IRQS;
>> +       return irq_create_mapping(ab8500->domain, irq);
>> +}
>> +EXPORT_SYMBOL_GPL(ab8500_irq_get_virq);
> (...)
>> @@ -1233,11 +1256,9 @@ static int __devinit ab8500_probe(struct platform_device *pdev)
>>
>>         if (plat)
>>                 ab8500->irq_base = plat->irq_base;
>> -       else if (np)
>> -               ret = of_property_read_u32(np, "stericsson,irq-base",&ab8500->irq_base);
>
> So if we're not using the irq base thing anymore, should you also
> delete it from the binding document too? (If there is no binding
> doc something is wrong and you need to create it I guess...)

No. A document is not required now, as we are using standard bindings.

>> diff --git a/include/linux/mfd/abx500/ab8500.h b/include/linux/mfd/abx500/ab8500.h
>> index 91dd3ef..48f126c 100644
>> --- a/include/linux/mfd/abx500/ab8500.h
>> +++ b/include/linux/mfd/abx500/ab8500.h
>> @@ -227,6 +227,7 @@ enum ab8500_version {
>>   * @irq_lock: genirq bus lock
>>   * @transfer_ongoing: 0 if no transfer ongoing
>>   * @irq: irq line
>> + * @irq_domain: irq domain
>>   * @version: chip version id (e.g. ab8500 or ab9540)
>>   * @chip_id: chip revision id
>>   * @write: register write
>> @@ -247,6 +248,7 @@ struct ab8500 {
>>         atomic_t        transfer_ongoing;
>>         int             irq_base;
>>         int             irq;
>> +       struct irq_domain  *domain;
>
> Don't you need to forward-declare struct irq_domain?
> I think you're just lucky to have it compiling... (Something
> else included<linux/irqdomain.h>  on the way here.)

You're right. I'll make the changes and resubmit.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
