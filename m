From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 24 Aug 2015 19:37:00 +0200 (CEST)
Subject: [PATCH v8 1/2] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
 sources
In-Reply-To: <CY1PR0301MB084328829F8128A8FBFA6A9283620@CY1PR0301MB0843.namprd03.prod.outlook.com>
References: <1438378439-11569-1-git-send-email-shenwei.wang@freescale.com>
 <1438378439-11569-2-git-send-email-shenwei.wang@freescale.com>
 <alpine.DEB.2.11.1508231251040.3873@nanos>
 <CY1PR0301MB084328829F8128A8FBFA6A9283620@CY1PR0301MB0843.namprd03.prod.outlook.com>
Message-ID: <alpine.DEB.2.11.1508241933150.3873@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 24 Aug 2015, Shenwei Wang wrote:
> > > +static int gpcv2_wakeup_source_save(void) {
> > > +	struct gpcv2_irqchip_data *cd;
> > > +	void __iomem *reg;
> > > +	int i;
> > > +
> > > +	cd = imx_gpcv2_instance;
> > > +	if (!cd)
> > > +		return 0;
> > > +
> > > +	for (i = 0; i < IMR_NUM; i++) {
> > > +		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
> > > +		cd->enabled_irqs[i] = readl_relaxed(reg);
> > 
> > You read the full state of the register and restore the full state. So why
> > enabled_irqs?
> 
> There are two user scenarios: 
> In CPU Idle state, the system need to be woke up by any enabled
> irqs, not just the ones that marked as wakeup sources.
> In Suspend State, they system will only be woke up by the one that
> marked as a wakeup source.  Enabled_irqs are used to save the values
> before suspend, and restore them after resume.

That's what you want achieve. Still you save the full content of the
registers and restore the full content. That saves/restores the
enabled and disabled interrupts. So enabled_irqs is a misnomer as you
save the full state.

> > > +		writel_relaxed(cd->wakeup_sources[i], reg);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void gpcv2_wakeup_source_restore(void) {
> > > +	struct gpcv2_irqchip_data *cd;
> > > +	void __iomem *reg;
> > > +	int i;
> > > +
> > > +	cd = imx_gpcv2_instance;
> > > +	if (!cd)
> > > +		return;
> > > +
> > > +	for (i = 0; i < IMR_NUM; i++) {
> > > +		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
> > > +		writel_relaxed(cd->enabled_irqs[i], reg);
> > > +		cd->wakeup_sources[i] = ~0;
> > 
> > Why are you clearing that info on resume? Drivers will clear that via
> > set_wake() or leave it when they want to have resume functionality?
> > 
> Each time system goes into the suspend state, it will call set_wake
> (ON) again to configure the wakeup sources. Clearing wakeup_sources
> here can make sure the system work as expected no matter that a
> driver calls set_wake (OFF) during resume stage.

We rather make sure that the drivers call set_wake(OFF) as they are
supposed to, because if they do not then the set_wake(ON) logic in the
core code will see the counter != 0 and not invoke the irq callback.

Thanks,

	tglx
