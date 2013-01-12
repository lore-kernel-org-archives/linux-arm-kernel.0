From: zhanzhenbo@gmail.com (steve.zhan)
Date: Sat, 12 Jan 2013 12:59:11 +0800
Subject: Question:add Iirq mask method in irq disable call.
In-Reply-To: <alpine.LFD.2.02.1301111652100.7475@ionos>
References: <CAKvkGKfG-3Y=azedkPyLwYffZKOE0sYH6LjMCfuMAgMKMBYWGA@mail.gmail.com>
 <alpine.LFD.2.02.1301111652100.7475@ionos>
Message-ID: <CAKvkGKfcXweF4652S5t4pEaVfVfjD-JiTU4-hOStGcyj87sj_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/1/11 Thomas Gleixner <tglx@linutronix.de>:
> On Fri, 11 Jan 2013, steve.zhan wrote:
>> Resend Email because MUTT email send error.
>>
>> 2013/1/11 Steve zhan <zhanzhenbo@gmail.com>:
>> > All:
>> >         I have find that arm gic driver have not register irq_disable
>> > method, as below:
>> > static struct irq_chip gic_chip = {
>> >         .name                   = "GIC",
>> >         .irq_mask               = gic_mask_irq,
>> >         .irq_unmask             = gic_unmask_irq,
>> >         .irq_eoi                = gic_eoi_irq,
>> >         .irq_set_type           = gic_set_type,
>> >         .irq_retrigger          = gic_retrigger,
>> > #ifdef CONFIG_SMP
>> >         .irq_set_affinity       = gic_set_affinity,
>> > #endif
>> >         .irq_set_wake           = gic_set_wake,
>> > };
>> >
>> > Question is:
>> >         When some drivers want to disable irq, maybe it will call
>> > linux standard inerface: irq_disable() that defined in include\
>> > linux\interrupt.h, this function will call
>> > void irq_disable(struct irq_desc *desc)
>> > {
>> >         irq_state_set_disabled(desc);
>> >         if (desc->irq_data.chip->irq_disable) {
>> >                 desc->irq_data.chip->irq_disable(&desc->irq_data);
>> >                 irq_state_set_masked(desc);
>> >         }
>> > }
>> >
>> > Because gic have not register irq_diable method, so the interrupt can
>> > not disable immediately, it is enable until the interrupt come next time,
>> > then disalbed by mask because irq_state_set_disable(desc);
>> >
>> > I have checked irq_enable method:
>> > void irq_enable(struct irq_desc *desc)
>> > {
>> >         irq_state_clr_disabled(desc);
>> >         if (desc->irq_data.chip->irq_enable)
>> >                 desc->irq_data.chip->irq_enable(&desc->irq_data);
>> >         else
>> >                 desc->irq_data.chip->irq_unmask(&desc->irq_data);
>> >         irq_state_clr_masked(desc);
>> > }
>> > This method have do unmask when irq_enable method is not exist.
>> >
>> > Is it a good idea to add irq_mask call in irq_disable()?
>
> No. It's a very bad idea. We intentionally disable interrupts lazy.
>
> Thanks,
>
>         tglx

Thanks,

    I think this is lazy disable interrupts also.  Could you give me
some guides about
how advantage about this?
But we can only lazy mask when that irq_data.chip have irq_diable()
and irq_mask(). If some
SOCs only have mask method, why not simply add irq_mask ? That is
simple and can reduce process time in future(Or If some rough drivers
havenot call diable wakeup then system deepsleep, because irq is
enable(if irq is enalbe, that have wakeup capacity), that could
unnecessary cause wakeup system).
   If irq_disable only set flag, why irq_enable don't  irq_unmask only
when irq flag is enable? That let the intc driver is unmatch invoked.

-- 
Steve Zhan
