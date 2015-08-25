From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Tue, 25 Aug 2015 19:58:50 +0000
Subject: [PATCH v9 1/1] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
 sources
In-Reply-To: <alpine.DEB.2.11.1508252126360.15006@nanos>
References: <1440443055-7291-1-git-send-email-shenwei.wang@freescale.com>
 <55DC3452.3070205@arm.com>
 <CY1PR0301MB08439B6C5F841AFFD152DFD883610@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <55DC738D.8000302@arm.com>
 <CY1PR0301MB0843AE566996617D855CC00683610@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <55DC7FA4.7040902@arm.com>
 <CY1PR0301MB08433A2659C75028821F0AE783610@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <55DC96BA.2020905@arm.com>
 <CY1PR0301MB0843388CA3BB07493BC2907183610@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <alpine.DEB.2.11.1508252126360.15006@nanos>
Message-ID: <CY1PR0301MB08430902E0E46A43D00317C283610@CY1PR0301MB0843.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx at linutronix.de]
> Sent: 2015?8?25? 14:30
> To: Wang Shenwei-B38339
> Cc: Sudeep Holla; shawn.guo at linaro.org; jason at lakedaemon.net; Huang
> Yongcai-B20788; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCH v9 1/1] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
> sources
> 
> On Tue, 25 Aug 2015, Shenwei Wang wrote:
> > > From: Sudeep Holla [mailto:sudeep.holla at arm.com] All fine, what I am
> > > saying is let irq-core know that you want to mask the 2 non-wakeup
> > > irqs you have using MASK_ON_SUSPEND. So when suspend_device_irqs is
> > > called in suspend path, that's done for you automatically and the
> > > cpu2wakeup will have just 1 wakeup enabled which is what you are
> > > doing in suspend callback, right ?
> >
> > 	/*
> > 	 * Hardware which has no wakeup source configuration facility
> > 	 * requires that the non wakeup interrupts are masked at the
> > 	 * chip level. The chip implementation indicates that with
> > 	 * IRQCHIP_MASK_ON_SUSPEND.
> > 	 */
> > 	if (irq_desc_get_chip(desc)->flags & IRQCHIP_MASK_ON_SUSPEND)
> > 		mask_irq(desc);
> >
> > IRQCHIP_MASK_ON_SUSPEND flag is for the hardware that has no wakeup
> > source capability.  This GPCv2 block is designed to manage the wakeup
> > source, so the flag does not make any sense.
> 
> You have no seperate wakeup source mechanism. All you do is to mask all non
> wakeup sources and keep the wakeup sources unmask.
> 
> That's what happens in gpcv2_wakeup_source_save()
> 
>        writel_relaxed(cd->wakeup_sources[i], reg);
> 
> So it's the same as letting the core mask all non wakeup sources and leave the
> wakeup sources unmask.

Does it mean an unexpected interrupt may activate the system, and the core will let
the system go into suspend again if the core determines it not a wakeup source? The current design
is to ignore all the unexpected interrupts in the hardware level. Only the presetting 
wakeup sources can activate the platform. Here power consumption is more 
important.

> > > Now that it's already done for you, you need not do anything extra
> > > and hence just set SKIP_SET_WAKE to do nothing.
> >
> > static int set_irq_wake_real(unsigned int irq, unsigned int on) {
> > 	struct irq_desc *desc = irq_to_desc(irq);
> > 	int ret = -ENXIO;
> >
> > 	if (irq_desc_get_chip(desc)->flags &  IRQCHIP_SKIP_SET_WAKE)
> > 		return 0;
> >
> > 	if (desc->irq_data.chip->irq_set_wake)
> > 		ret = desc->irq_data.chip->irq_set_wake(&desc->irq_data, on);
> >
> > 	return ret;
> > }
> > From the codes above, if a irqchip can not handle the wakeup sources,
> > it can set SKIP flag.  This driver is intended to manage the wakeup
> > sources, what's the reason to skip here?
> 
> To reduce code. Everything the core can do for you is something you don't have to
> implement.

Same as above.

Thanks,
Shenwei

> Thanks,
> 
> 	tglx
