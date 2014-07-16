From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 16 Jul 2014 13:54:50 +0100
Subject: [PATCH v8 0/4] arm: KGDB NMI/FIQ support
In-Reply-To: <201407152045.06517.marex@denx.de>
References: <1404118391-3850-1-git-send-email-daniel.thompson@linaro.org>
 <CAB5oZtCk5NwBJF+dBESKGhYabti=EWWtF2jJYK7HdyNHM46nTw@mail.gmail.com>
 <53C4F745.3070701@linaro.org> <201407152045.06517.marex@denx.de>
Message-ID: <53C6761A.9090002@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/07/14 19:45, Marek Vasut wrote:
>>> I can reduce the number of occurrences (not prevent it) by adding the
>>> following hack to irq-gic.c
>>> @@ -297,10 +309,12 @@ static asmlinkage void __exception_irq_entry
>>> gic_handle_irq(struct pt_regs *regs
>>>
>>>   u32 irqstat, irqnr;
>>>   struct gic_chip_data *gic = &gic_data[0];
>>>   void __iomem *cpu_base = gic_data_cpu_base(gic);
>>>   
>>>   do {
>>>
>>> + while(readl_relaxed(gic_data_dist_base(gic) + GIC_DIST_PENDING_SET)
>>> & (1 << 30))
>>> +   printk(KERN_ERR "TEMP: gic_handle_irq: wait for FIQ exception\n");
>>>
>>>   irqstat = readl_relaxed(cpu_base + GIC_CPU_INTACK);
>>>   irqnr = irqstat & ~0x1c00;
>>
>> I've made a more complete attempt to fix this. Could you test the
>> following? (and be prepared to fuzz the line numbers)
> 
> There's also another workaround, look at [1], but it's really a perverse hack 
> thus far (blush). What I did there is I got hinted that an L1 page table can 
> have this NS bit set. If this bit is set for a mapping, all accesses to memory 
> area via that mapping will be non-secure. And then, in turn, by doing a non-
> secure read of the INTACK register, it will not ever happen that the FIQ number 
> will pop up in the INTACK. I only do a non-secure read of the INTACK register,
> all other registers of the GICv1 are read via regular secure-mode accesses.

I'll be looking into this approach.

It is technically a better approach than mine since it prevents the IRQ
handler from ever reading a group 0 interrupt from INTACK.

Unfortunately the tentacles of this workaround reach pretty deep in the
memory management code (rather than being concentrated in the GIC
driver) but the improved runtime behaviour might be worth it.
