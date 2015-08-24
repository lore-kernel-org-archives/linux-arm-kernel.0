From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Mon, 24 Aug 2015 16:09:09 +0000
Subject: [PATCH v8 1/2] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
 sources
In-Reply-To: <alpine.DEB.2.11.1508231251040.3873@nanos>
References: <1438378439-11569-1-git-send-email-shenwei.wang@freescale.com>
 <1438378439-11569-2-git-send-email-shenwei.wang@freescale.com>
 <alpine.DEB.2.11.1508231251040.3873@nanos>
Message-ID: <CY1PR0301MB084328829F8128A8FBFA6A9283620@CY1PR0301MB0843.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx at linutronix.de]
> Sent: 2015?8?23? 5:58
> To: Wang Shenwei-B38339
> Cc: shawn.guo at linaro.org; jason at lakedaemon.net;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Huang
> Yongcai-B20788
> Subject: Re: [PATCH v8 1/2] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
> sources
> 
> On Fri, 31 Jul 2015, Shenwei Wang wrote:
> > +struct gpcv2_irqchip_data {
> > +	struct raw_spinlock rlock;
> > +	void __iomem *gpc_base;
> > +	u32 wakeup_sources[IMR_NUM];
> > +	u32 enabled_irqs[IMR_NUM];
> > +	u32 cpu2wakeup;
> 
> Can you please format that in a readable way?
> 
>       struct raw_spinlock    rlock;
>       void __iomem	     *gpc_base;
>       ....

I did try to be careful about the format, but did not notice this one. Will change it in the new version.:)
 
> > +};
> > +
> > +static struct gpcv2_irqchip_data *imx_gpcv2_instance;
> > +
> > +u32 imx_gpcv2_get_wakeup_source(u32 **sources) {
> > +	if (!imx_gpcv2_instance)
> > +		return 0;
> > +
> > +	if (sources)
> > +		*sources = imx_gpcv2_instance->wakeup_sources;
> > +
> > +	return IMR_NUM;
> > +}
> > +
> > +static int gpcv2_wakeup_source_save(void) {
> > +	struct gpcv2_irqchip_data *cd;
> > +	void __iomem *reg;
> > +	int i;
> > +
> > +	cd = imx_gpcv2_instance;
> > +	if (!cd)
> > +		return 0;
> > +
> > +	for (i = 0; i < IMR_NUM; i++) {
> > +		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
> > +		cd->enabled_irqs[i] = readl_relaxed(reg);
> 
> You read the full state of the register and restore the full state. So why
> enabled_irqs?

There are two user scenarios: 
In CPU Idle state, the system need to be woke up by any enabled irqs, not just the ones that marked as wakeup sources.
In Suspend State, they system will only be woke up by the one that marked as a wakeup source. 
Enabled_irqs are used to save the values before suspend, and restore them after resume.

> > +		writel_relaxed(cd->wakeup_sources[i], reg);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
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
> > +		writel_relaxed(cd->enabled_irqs[i], reg);
> > +		cd->wakeup_sources[i] = ~0;
> 
> Why are you clearing that info on resume? Drivers will clear that via
> set_wake() or leave it when they want to have resume functionality?
> 
Each time system goes into the suspend state, it will call set_wake (ON) again to configure
the wakeup sources. Clearing wakeup_sources here can make sure the system work as
expected no matter that a driver calls set_wake (OFF) during resume stage.

> > +static int __init imx_gpcv2_irqchip_init(struct device_node *node,
> > +			       struct device_node *parent) {
> > +	struct irq_domain *parent_domain, *domain;
> > +	struct gpcv2_irqchip_data *cd;
> > +	int i;
> > +
> > +	if (!parent) {
> > +		pr_err("%s: no parent, giving up\n", node->full_name);
> > +		return -ENODEV;
> > +	}
> > +
> > +	parent_domain = irq_find_host(parent);
> > +	if (!parent_domain) {
> > +		pr_err("%s: unable to get parent domain\n", node->full_name);
> > +		return -ENXIO;
> > +	}
> > +
> > +	cd = kzalloc(sizeof(struct gpcv2_irqchip_data), GFP_KERNEL);
> > +	BUG_ON(!cd);
> 
> You return an error code for all other failures. Why BUG here?

Good point. To be consistent, I will change it to return an error code.

Thanks,
Shenwei
> 
> Otherwise this looks very clean now. Can you please resend ASAP with these
> minor points addressed?
> 
> Thanks,
> 
> 	tglx
> 
