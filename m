From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 02 May 2013 21:05:38 +0200
Subject: [PATCH] irqchip: add support for Marvell Orion SoCs
In-Reply-To: <20130502185322.GA29333@obsidianresearch.com>
References: <1367519104-19677-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130502185322.GA29333@obsidianresearch.com>
Message-ID: <5182B902.7040908@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/02/13 20:53, Jason Gunthorpe wrote:
> On Thu, May 02, 2013 at 08:25:04PM +0200, Sebastian Hesselbarth wrote:
>> +
>> +static void __iomem *orion_irq_base[ORION_MAX_IRQREG];
>> +static unsigned int orion_irq_regs;
>> +static struct irq_domain *orion_irq_domain;
>> +
>> +asmlinkage void __exception_irq_entry orion_handle_irq(struct
>> pt_regs *regs)
>
> This can be static?

True, corresponds with the left-over #include in linux/irqchip/orion.h.

>> +static int __init orion_of_init(struct device_node *np,
>> +				struct device_node *parent)
>> +{
>> +	int n;
>> +
>> +	for (n = 0; n < ORION_MAX_IRQREG; n++) {
>> +		orion_irq_base[n] = of_iomap(np, n);
>
> Is it possible to also reserve the resources for these registers at
> this point in the boot sequence?

I see what I can do.

>> +static struct of_device_id orion_irq_dt_ids[] __initconst = {
>> +	{ .compatible = "marvell,orion-mpic", .data = orion_of_init },
>> +	{ }
>
> Is there a strong reason to change the compatible string? Looks to me
> like either the new driver or the old driver will bind depending on
> what is in the machine description. No need for a new string?

The reason for a new compatible string is, that we will also need an
secondary irq controller for bridge irqs. That could be called
marvell,orion-spic. Dove is again a little bit different than the
others and this will require timer and especially rtc not to share
bridge irqs here. RTC irq is located in PMU regs on Dove instead of
bridge regs.

But I don't have a strong opinion here and we can also reuse
marvell,orion-intc for the irqchip driver.

>> +};
>> +
>> +void __init orion_init_irq(void)
>> +{
>> +	of_irq_init(orion_irq_dt_ids);
>> +}
>
> Shouldn't this use the new IRQCHIP_DECLARE mechanism?

I didn't follow irqchip discussion lately, but will catch up.

>
>> diff --git a/include/linux/irqchip/orion.h b/include/linux/irqchip/orion.h
>
>> +extern void orion_init_irq(void);
>
> .. which lets this go away, use the generic irqchip_init instead of
> orion_init_irq.

Same as above.

Thanks for the review,
   Sebastian
