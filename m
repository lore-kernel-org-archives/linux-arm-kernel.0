From: zhanzhenbo@gmail.com (steve.zhan)
Date: Fri, 11 Jan 2013 11:52:44 -0000
Subject: Question:add Iirq mask method in irq disable call.
Message-ID: <CAKvkGKfG-3Y=azedkPyLwYffZKOE0sYH6LjMCfuMAgMKMBYWGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resend Email because MUTT email send error.

2013/1/11 Steve zhan <zhanzhenbo@gmail.com>:
> All:
>         I have find that arm gic driver have not register irq_disable
> method, as below:
> static struct irq_chip gic_chip = {
>         .name                   = "GIC",
>         .irq_mask               = gic_mask_irq,
>         .irq_unmask             = gic_unmask_irq,
>         .irq_eoi                = gic_eoi_irq,
>         .irq_set_type           = gic_set_type,
>         .irq_retrigger          = gic_retrigger,
> #ifdef CONFIG_SMP
>         .irq_set_affinity       = gic_set_affinity,
> #endif
>         .irq_set_wake           = gic_set_wake,
> };
>
> Question is:
>         When some drivers want to disable irq, maybe it will call
> linux standard inerface: irq_disable() that defined in include\
> linux\interrupt.h, this function will call
> void irq_disable(struct irq_desc *desc)
> {
>         irq_state_set_disabled(desc);
>         if (desc->irq_data.chip->irq_disable) {
>                 desc->irq_data.chip->irq_disable(&desc->irq_data);
>                 irq_state_set_masked(desc);
>         }
> }
>
> Because gic have not register irq_diable method, so the interrupt can
> not disable immediately, it is enable until the interrupt come next time,
> then disalbed by mask because irq_state_set_disable(desc);
>
> I have checked irq_enable method:
> void irq_enable(struct irq_desc *desc)
> {
>         irq_state_clr_disabled(desc);
>         if (desc->irq_data.chip->irq_enable)
>                 desc->irq_data.chip->irq_enable(&desc->irq_data);
>         else
>                 desc->irq_data.chip->irq_unmask(&desc->irq_data);
>         irq_state_clr_masked(desc);
> }
> This method have do unmask when irq_enable method is not exist.
>
> Is it a good idea to add irq_mask call in irq_disable()?
>
>
> Regards,
> Steve
>



-- 
Steve Zhan
