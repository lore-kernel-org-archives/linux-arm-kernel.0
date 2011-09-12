From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 12 Sep 2011 09:56:04 +0200 (CEST)
Subject: [PATCH 13/25] OMAP4: PM: Add WakeupGen module as OMAP
	gic_arch_extn
In-Reply-To: <4E69D6ED.4080409@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-14-git-send-email-santosh.shilimkar@ti.com>
	<878vpyhotu.fsf@ti.com> <4E69961D.40700@ti.com>
	<alpine.LFD.2.02.1109090912130.2723@ionos>
	<4E69C957.5070708@ti.com>
	<alpine.LFD.2.02.1109091017300.2723@ionos> <4E69D6ED.4080409@ti.com>
Message-ID: <alpine.LFD.2.02.1109120955300.2723@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Sep 2011, Santosh wrote:

> On Friday 09 September 2011 01:48 PM, Thomas Gleixner wrote:
> > On Fri, 9 Sep 2011, Santosh wrote:
> > > On Friday 09 September 2011 12:49 PM, Thomas Gleixner wrote:
> > > > 
> > > > The flag says: MASK ON SUSPEND and it does not imply that you don't
> > > > need a wake function. There might be cases where you want to setup
> > > > stuff in that function in order to have the wakeup happen on that
> > > > interrupt line despite of the mask on suspend.
> > > > 
> > > I see your point.
> > > 
> > > > We either need a separate flag or a global dummy set_wake function in
> > > > the core to avoid empty copies all over the place.
> > > > 
> > > A flag is probably better since you mentioned that on some arch, there
> > > might be need to have actual set_wake() handler. Or if the global
> > > dummy can be over-ridden by platform, that's fine too.
> > 
> > Global dummy would mean:
> > 
> > int irq_set_wake_dummy(...)
> > {
> > 	return 0;
> > }
> > 
> > And you just add it to your chip, but either way I don't care whether
> > it's a dummy function or a flag.
> > 
> Will below patch work for you then ?
> Attaching the same in case mailer damages it.

It does :)
 
> Regards,
> Santosh
> 
> From d63d4347dc8fb144b19f4d4e7c0621397cccea94 Mon Sep 17 00:00:00 2001
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Date: Fri, 9 Sep 2011 13:59:35 +0530
> Subject: [PATCH] irq: Add IRQCHIP_SKIP_SET_WAKE flag to avoid need of dummy
> set_wake() handler.
> 
> Certain IRQCHIP's may not need to install the irq_set_wake() handler if
> the IRQCHIP_MASK_ON_SUSPEND flag is set. But but if it's not implemented,
> enable_irq_wake() will return an error.  That needs the IRQCHIP to install
> an empty set_wake handler.
> 
> Add an 'IRQCHIP_SKIP_SET_WAKE' flag so that IRQCHIP can inform the core
> irq code that irq_set_wake() handler is not necessary.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>

Queued to irq/core for 3.2

Thanks,

	tglx
