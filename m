From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Tue, 25 Aug 2015 14:14:58 +0000
Subject: [PATCH v9 1/1] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
 sources
In-Reply-To: <55DC738D.8000302@arm.com>
References: <1440443055-7291-1-git-send-email-shenwei.wang@freescale.com>
 <55DC3452.3070205@arm.com>
 <CY1PR0301MB08439B6C5F841AFFD152DFD883610@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <55DC738D.8000302@arm.com>
Message-ID: <CY1PR0301MB0843AE566996617D855CC00683610@CY1PR0301MB0843.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla at arm.com]
> >>> IMX7D contains a new version of GPC IP block (GPCv2). It has two
> >>> major
> >>> functions: power management and wakeup source management.
> >>> This patch adds a new irqchip driver to manage the interrupt wakeup
> >>> sources on IMX7D.
> >>
> >> Interesting, you mention that this IP block has mainly power
> >> management and it itself requires save/restore. Is it not in always on
> domain ?
> >
> > Yes, it is in always on domain.
> >
> 
> Hmm, then why do you need to save and restore the mask ?

The save/restore is used to handle the two different low power states: one is
WFI in cpu idle, and the other case is suspend. This has nothing to do with this
IP block itself.

> >>> When the system is in WFI (wait for interrupt) mode, this GPC block
> >>> will be the first block on the platform to be activated and signaled.
> >>> Under normal wait mode during cpu idle, the system can be woke up by
> >>> +static void gpcv2_wakeup_source_restore(void) {
> >>> +	struct gpcv2_irqchip_data *cd;
> >>> +	void __iomem *reg;
> >>> +	int i;
> >>> +
> >>> +	cd = imx_gpcv2_instance;
> >>> +	if (!cd)
> >>> +		return;
> >>> +
> >>> +	for (i = 0; i < IMR_NUM; i++) {
> >>> +		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
> >>> +		writel_relaxed(cd->saved_irq_mask[i], reg);
> >>
> >> Instead of saving all the non-wakeup sources, can't you use raw
> >> save/restore of these registers and mask all the non-wakeup sources
> >> by setting MASK_ON_SUSPEND ?
> >
> > I can't catch what you mean. Can you show me an example?
> >
> 
> What I meant is instead of you tracking all the enabled irqs(both wakeup and
> non-wakeup) in saved_irq_mask, just set MASK_ON_SUSPEND flag where all the
> non-wakeup interrupts are masked on suspend and unmasked on resume by the
> irq core. You can then just save and restore the wakeup irq mask, but as I asked
> above do you have to do that as you are saying it's in always on domain ?
> 
> >> Also your interrupt controller seems like has no special way to
> >> configure wakeups, you are just leaving them enabled. i.e. I see
> >> cpu2wakeup used for both {un,}masking and wakeup enable. So you can just
> use IRQCHIP_SKIP_SET_WAKE.
> >> Correct me if my understanding is wrong.
> >
> > In this driver, the Core0 is configured to be the default core to be
> > woke up, not both. You can configure it to Core1 by changing the
> > cpu2wakeup value. I don't see any reason to use IRQCHIP_SKIP_SET_WAKE flag.
> >
> 
> I don't see this driver doing anything extra apart from keeping the wakeup irqs
> enabled. i.e. You use the same cpu*wake register to mask/unmask the interrupt
> as well as set the wakeup source. Since the wakeup interrupt will be enabled by
> the driver, you just need to mark it as wake-up source and nothing extra in the
> controller right ?
> If so, you need to set IRQCHIP_SKIP_SET_WAKE as you are just leaving that irq
> enabled and not doing any extra configuration to enable it as wakeup source.
> Please correct if that wrong, but from the code that's what I could infer.

There is no special for this driver. We just use the IRQCHIP driver framework to
manage the wakeup sources. Why did you propose to set IRQCHIP_SKIP_SET_WAKE
flag here? If you don't need the wakeup feature, you should just not enable this
driver in the configuration.

Thanks,
Shenwei

> Regards,
> Sudeep
