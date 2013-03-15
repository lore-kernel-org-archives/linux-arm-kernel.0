From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Fri, 15 Mar 2013 17:26:42 +0100
Subject: [PATCH] genirq: allow an alternative setup for the mask cache
In-Reply-To: <20130314174559.GO21620@kw.sim.vm.gnt>
References: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com>
 <20130314174559.GO21620@kw.sim.vm.gnt>
Message-ID: <51434BC2.70105@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On 03/14/2013 06:45 PM, Simon Guinot wrote:
> On Thu, Mar 14, 2013 at 05:10:30PM +0100, Holger Brunck wrote:
>> @@ -243,9 +243,12 @@ void irq_setup_generic_chip(struct irq_chip_generic *gc, u32 msk,
>>   	list_add_tail(&gc->list, &gc_list);
>>   	raw_spin_unlock(&gc_lock);
>>
>> +	/* Setup pointer to mask_cache */
>> +	gc->pmask_cache = &gc->mask_cache;
>
> You need a flag here to choose between gc->mask_cache and
> ct->mask_cache.

I'm sorry, I don't understand...
Shouldn't pmask_cache be a pointer within ct, so that the pointers for 
all instances could either be the same (in case of a single register) or 
all different (in case of multiple registers)?
I already have a patch which seems to work, but I'm afraid I've come to 
YAM (Yet Another Misunderstanding (R) ) in regards to Thomas' suggestion.

>> +
>>   	/* Init mask cache ? */
>>   	if (flags & IRQ_GC_INIT_MASK_CACHE)
>> -		gc->mask_cache = irq_reg_readl(gc->reg_base + ct->regs.mask);
>> +		*gc->pmask_cache = irq_reg_readl(gc->reg_base + ct->regs.mask);
>>
>>   	for (i = gc->irq_base; msk; msk >>= 1, i++) {
>>   		if (!(msk & 0x01))
>> @@ -275,6 +278,8 @@ int irq_setup_alt_chip(struct irq_data *d, unsigned int type)
>>   	struct irq_chip_type *ct = gc->chip_types;
>>   	unsigned int i;
>>
>> +	/* Setup pointer to the mask_cache */
>> +	gc->pmask_cache = &ct->mask_cache;
>
> You also need to check the flag here, to know if you need to switch
> pmask_cache on ct->mask_cache.
>
>>   	for (i = 0; i < gc->num_ct; i++, ct++) {
>>   		if (ct->type & type) {
>>   			d->chip = &ct->chip;
>
> Additionally, you need to update drivers/gpio/gpio-mvebu.c which use
> gc->mask_cache. The gpio-mvebu driver is also impacted by the bug.

I understand gpio-mvebu.c is a new driver for all three variants of 
Marvell Chips (Orion, MV78200, ArmadaXP).
Which ones are affected by this bug (i.e. have separate mask registers)? 
Definitely Orion, but what about the other two?

Thanks a lot,
Gerlando
