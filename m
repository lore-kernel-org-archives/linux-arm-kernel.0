From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Mon, 18 Mar 2013 08:59:24 +0100
Subject: [PATCH 2/2] genirq: move mask_cache into struct irq_chip_type
In-Reply-To: <alpine.LFD.2.02.1303152101080.22263@ionos>
References: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com><1363376175-22312-1-git-send-email-gerlando.falauto@keymile.com>
 <1363376175-22312-3-git-send-email-gerlando.falauto@keymile.com>
 <alpine.LFD.2.02.1303152101080.22263@ionos>
Message-ID: <5146C95C.3000509@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 03/15/2013 09:47 PM, Thomas Gleixner wrote:
> Gerlando,
>
> On Fri, 15 Mar 2013, Gerlando Falauto wrote:

[...]
>
> The patch is correct, but we want a more incremental approach.

OK, will do.

> Otherwise I only have a coding style related request:
>
>> @@ -246,9 +246,21 @@ void irq_setup_generic_chip(struct irq_chip_generic *gc, u32 msk,
>>   	list_add_tail(&gc->list, &gc_list);
>>   	raw_spin_unlock(&gc_lock);
>>
>> -	/* Init mask cache ? */
>> -	if (flags & IRQ_GC_INIT_MASK_CACHE)
>> -		gc->mask_cache = irq_reg_readl(gc->reg_base + ct->regs.mask);
>> +	for (i = 0; i < gc->num_ct; i++) {
>> +		if (flags & IRQ_GC_SEPARATE_MASK_REGISTERS)
>> +			/* Define mask cache pointer */
>> +			ct[i].pmask_cache = &ct[i].mask_cache;
>> +		else
>> +			/* They all point to the same mask cache */
>> +			ct[i].pmask_cache = &ct[0].mask_cache;
>> +
>> +		/* Init mask cache ? */
>> +		if ((flags & IRQ_GC_INIT_MASK_CACHE)
>> +		 && ((flags & IRQ_GC_SEPARATE_MASK_REGISTER)
>> +		  || (i == 0)))
>> +			*ct[i].pmask_cache =
>> +				irq_reg_readl(gc->reg_base + ct[i].regs.mask);
>> +	}
>
> My eyes are burning, my head is spinning and I have a hard time not to
> use swearwords.

You're right... and I appreciate you NOT using such words. :-)

Just one question:

> 	bool mskperct = flags & IRQ_GC_SEPARATE_MASK_REGISTERS;
> 	bool mskinit = flags & IRQ_GC_INIT_MASK_CACHE;
> 	u32 *shmsk = &gc->shared_mask_cache;
>
> 	if (!mskperct && mskinit)
> 	     	*shmsk = irq_reg_readl(gc->reg_base + ct->regs.mask);
>
> 	for (i = 0; i < gc->num_ct: i++, ct++) {
> 	       ct->pmask_cache = mskperct ? &ct->mask_cache : shmsk;

What is wrong with using ct[i] instead? I find it a bit more readable.

> Or something like that, perhaps ?

Totally agree.

Thanks a lot for your patience!
Gerlando
