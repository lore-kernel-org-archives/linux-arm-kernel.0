From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 25 Aug 2015 22:15:59 +0200 (CEST)
Subject: [PATCH v9 1/1] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
 sources
In-Reply-To: <CY1PR0301MB08430902E0E46A43D00317C283610@CY1PR0301MB0843.namprd03.prod.outlook.com>
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
Message-ID: <alpine.DEB.2.11.1508252213220.15006@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Aug 2015, Shenwei Wang wrote:
> > From: Thomas Gleixner [mailto:tglx at linutronix.de]
> > > IRQCHIP_MASK_ON_SUSPEND flag is for the hardware that has no wakeup
> > > source capability.  This GPCv2 block is designed to manage the wakeup
> > > source, so the flag does not make any sense.
> > 
> > You have no seperate wakeup source mechanism. All you do is to mask all non
> > wakeup sources and keep the wakeup sources unmask.
> > 
> > That's what happens in gpcv2_wakeup_source_save()
> > 
> >        writel_relaxed(cd->wakeup_sources[i], reg);
> > 
> > So it's the same as letting the core mask all non wakeup sources and leave the
> > wakeup sources unmask.
> 
> Does it mean an unexpected interrupt may activate the system, and
> the core will let the system go into suspend again if the core
> determines it not a wakeup source? The current design is to ignore
> all the unexpected interrupts in the hardware level. Only the
> presetting wakeup sources can activate the platform. Here power
> consumption is more important.

Did you actually read, what I wrote?

The core does in case of MASK_ON_SUSPEND

    for_each_irq() {
	if (!irq->wakeupsource)
	   mask(irq)
    }

That's identical to what you are doing. You just do it differently by
saving the active wakeup sources in your own data structure and then
write that info to the mask register, which leaves only the wakeup
sources unmasked.

Thanks,

	tglx
