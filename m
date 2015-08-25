From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Tue, 25 Aug 2015 13:38:28 +0000
Subject: [PATCH v9 1/1] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
 sources
In-Reply-To: <55DC3452.3070205@arm.com>
References: <1440443055-7291-1-git-send-email-shenwei.wang@freescale.com>
 <55DC3452.3070205@arm.com>
Message-ID: <CY1PR0301MB08439B6C5F841AFFD152DFD883610@CY1PR0301MB0843.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla at arm.com]
> Sent: 2015?8?25? 4:25
> To: Wang Shenwei-B38339
> Cc: shawn.guo at linaro.org; tglx at linutronix.de; jason at lakedaemon.net; Sudeep
> Holla; Huang Yongcai-B20788; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v9 1/1] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
> sources
> 
> 
> 
> On 24/08/15 20:04, Shenwei Wang wrote:
> > IMX7D contains a new version of GPC IP block (GPCv2). It has two major
> > functions: power management and wakeup source management.
> > This patch adds a new irqchip driver to manage the interrupt wakeup
> > sources on IMX7D.
> 
> Interesting, you mention that this IP block has mainly power management and it
> itself requires save/restore. Is it not in always on domain ?

Yes, it is in always on domain.

> > When the system is in WFI (wait for interrupt) mode, this GPC block
> > will be the first block on the platform to be activated and signaled.
> > Under normal wait mode during cpu idle, the system can be woke up by
> > +static void gpcv2_wakeup_source_restore(void) {
> > +	struct gpcv2_irqchip_data *cd;
> > +	void __iomem *reg;
> > +	int i;
> > +
> > +	cd = imx_gpcv2_instance;
> > +	if (!cd)
> > +		return;
> > +
> > +	for (i = 0; i < IMR_NUM; i++) {
> > +		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
> > +		writel_relaxed(cd->saved_irq_mask[i], reg);
> 
> Instead of saving all the non-wakeup sources, can't you use raw save/restore of
> these registers and mask all the non-wakeup sources by setting
> MASK_ON_SUSPEND ?

I can't catch what you mean. Can you show me an example?

> Also your interrupt controller seems like has no special way to configure wakeups,
> you are just leaving them enabled. i.e. I see cpu2wakeup used for both
> {un,}masking and wakeup enable. So you can just use IRQCHIP_SKIP_SET_WAKE.
> Correct me if my understanding is wrong.

In this driver, the Core0 is configured to be the default core to be woke up, not both. You can
configure it to Core1 by changing the cpu2wakeup value. I don't see any reason to
use IRQCHIP_SKIP_SET_WAKE flag.

Thanks,
Shenwei
 


> Regards,
> Sudeep
