From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Tue, 25 Aug 2015 19:24:28 +0000
Subject: [PATCH v9 1/1] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
 sources
In-Reply-To: <55DC96BA.2020905@arm.com>
References: <1440443055-7291-1-git-send-email-shenwei.wang@freescale.com>
 <55DC3452.3070205@arm.com>
 <CY1PR0301MB08439B6C5F841AFFD152DFD883610@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <55DC738D.8000302@arm.com>
 <CY1PR0301MB0843AE566996617D855CC00683610@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <55DC7FA4.7040902@arm.com>
 <CY1PR0301MB08433A2659C75028821F0AE783610@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <55DC96BA.2020905@arm.com>
Message-ID: <CY1PR0301MB0843388CA3BB07493BC2907183610@CY1PR0301MB0843.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla at arm.com]
> Sent: 2015?8?25? 11:24
> To: Wang Shenwei-B38339
> Cc: Sudeep Holla; shawn.guo at linaro.org; tglx at linutronix.de;
> jason at lakedaemon.net; Huang Yongcai-B20788; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v9 1/1] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
> >
> > You don't really understand what happens after a driver calls
> > enable_irq_wake. In suspend state, even the interrupt controller
> > itself is powered off. How can you get the system up again  by just
> > using a SKIP_SET_WAKE.
> >
> 
> Sorry for that, let me try to understand aloud. So you have irq_{un,}mask function
> that are called when interrupts are enabled and disabled. So suppose you have 3
> irqs that are enabled and only one of then is set as wakeup source.
> 
> Now you call enable_irq_wake, you save that in wakeup_sources, fine.
> Later when you enter suspend, you save all the 3 active irqs in saved_irq_mask
> and over-write cpu2wakeup with wakeup_sources, right?
> 
> All fine, what I am saying is let irq-core know that you want to mask the 2
> non-wakeup irqs you have using MASK_ON_SUSPEND. So when
> suspend_device_irqs is called in suspend path, that's done for you automatically
> and the cpu2wakeup will have just 1 wakeup enabled which is what you are doing
> in suspend callback, right ?

	/*
	 * Hardware which has no wakeup source configuration facility
	 * requires that the non wakeup interrupts are masked at the
	 * chip level. The chip implementation indicates that with
	 * IRQCHIP_MASK_ON_SUSPEND.
	 */
	if (irq_desc_get_chip(desc)->flags & IRQCHIP_MASK_ON_SUSPEND)
		mask_irq(desc);

IRQCHIP_MASK_ON_SUSPEND flag is for the hardware that has no wakeup source capability.
This GPCv2 block is designed to manage the wakeup source, so the flag does not make any sense.

> Now that it's already done for you, you need not do anything extra and hence just
> set SKIP_SET_WAKE to do nothing.

static int set_irq_wake_real(unsigned int irq, unsigned int on)
{
	struct irq_desc *desc = irq_to_desc(irq);
	int ret = -ENXIO;

	if (irq_desc_get_chip(desc)->flags &  IRQCHIP_SKIP_SET_WAKE)
		return 0;

	if (desc->irq_data.chip->irq_set_wake)
		ret = desc->irq_data.chip->irq_set_wake(&desc->irq_data, on);

	return ret;
}
>From the codes above, if a irqchip can not handle the wakeup sources, it can set SKIP flag.
This driver is intended to manage the wakeup sources, what's the reason to skip here?

Regards,
Shenwei


> Hope this clarifies, sorry if I am still missing to understand something here, but I
> don't see anything. Let me know.
> 
> Regards,
> Sudeep
