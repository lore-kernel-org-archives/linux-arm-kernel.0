From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Tue, 25 Aug 2015 20:43:36 +0000
Subject: [PATCH v9 1/1] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
 sources
In-Reply-To: <alpine.DEB.2.11.1508252213220.15006@nanos>
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
 <CY1PR0301MB08430902E0E46A43D00317C283610@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <alpine.DEB.2.11.1508252213220.15006@nanos>
Message-ID: <CY1PR0301MB08439BB31108FD3DDC234EDA83610@CY1PR0301MB0843.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx at linutronix.de]
> Sent: 2015?8?25? 15:16
> To: Wang Shenwei-B38339
> Cc: Sudeep Holla; shawn.guo at linaro.org; jason at lakedaemon.net; Huang
> Yongcai-B20788; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCH v9 1/1] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
> sources
> 
> On Tue, 25 Aug 2015, Shenwei Wang wrote:
> > > From: Thomas Gleixner [mailto:tglx at linutronix.de]
> > > > IRQCHIP_MASK_ON_SUSPEND flag is for the hardware that has no
> > > > wakeup source capability.  This GPCv2 block is designed to manage
> > > > the wakeup source, so the flag does not make any sense.
> > >
> > > You have no seperate wakeup source mechanism. All you do is to mask
> > > all non wakeup sources and keep the wakeup sources unmask.
> > >
> > > That's what happens in gpcv2_wakeup_source_save()
> > >
> > >        writel_relaxed(cd->wakeup_sources[i], reg);
> > >
> > > So it's the same as letting the core mask all non wakeup sources and
> > > leave the wakeup sources unmask.
> >
> > Does it mean an unexpected interrupt may activate the system, and the
> > core will let the system go into suspend again if the core determines
> > it not a wakeup source? The current design is to ignore all the
> > unexpected interrupts in the hardware level. Only the presetting
> > wakeup sources can activate the platform. Here power consumption is
> > more important.
> 
> Did you actually read, what I wrote?
> 
> The core does in case of MASK_ON_SUSPEND
> 
>     for_each_irq() {
> 	if (!irq->wakeupsource)
> 	   mask(irq)
>     }
> 
> That's identical to what you are doing. You just do it differently by saving the
> active wakeup sources in your own data structure and then write that info to the
> mask register, which leaves only the wakeup sources unmasked.

Sorry. I just took a study on the two flags: MASK_ON_SUSPEND and IRQCHIP_SKIP_SET_WAKE.
MASK_ON_SUSPEND flag does simply the implementation. 
IRQCHIP_SKIP_SET_WAKE flag can't be used here because the wakeup sources are required for power management.
I will send out a subsequent patch to simply the implementation by using this idea.

Thank you Sudeep for the insightful review!

Thanks,
Shenwei



> Thanks,
> 
> 	tglx
