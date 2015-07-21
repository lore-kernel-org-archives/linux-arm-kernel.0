From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Tue, 21 Jul 2015 18:41:44 +0000
Subject: [PATCH V5 1/2] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
 sources
In-Reply-To: <alpine.DEB.2.11.1507211827150.18576@nanos>
References: <1437150300-8134-1-git-send-email-shenwei.wang@freescale.com>
 <1437150300-8134-2-git-send-email-shenwei.wang@freescale.com>
 <alpine.DEB.2.11.1507172253520.18576@nanos>
 <BL2PR03MB370B72098E511CFE551588B83840@BL2PR03MB370.namprd03.prod.outlook.com>
 <alpine.DEB.2.11.1507211827150.18576@nanos>
Message-ID: <BL2PR03MB370168620C55576F4A7750683840@BL2PR03MB370.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx at linutronix.de]
> Sent: 2015?7?21? 11:52
> To: Wang Shenwei-B38339
> Cc: shawn.guo at linaro.org; jason at lakedaemon.net;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: RE: [PATCH V5 1/2] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
> sources
> 
> On Tue, 21 Jul 2015, Shenwei Wang wrote:
> > > On Fri, 17 Jul 2015, Shenwei Wang wrote:
> > > > +static struct imx_irq_gpcv2 *gpcv2_get_chip_data(void) {
> > > > +	struct irq_data *data;
> > > > +	int virq;
> > > > +
> > > > +	/* Since GPCv2 is the default IRQ domain, its private data can
> > > > +	 * be gotten from any irq descriptor. Here we use interrupt #19
> > > > +	 * which is for snvs-rtc.
> > > > +	 */
> > >
> > > Yuck. What kind of logic is that?
> > >
> > > Use some random hardcoded number to find something which has been
> > > set by this driver?
> > >
> > > > +	virq = irq_find_mapping(0, 19);
> > > > +
> > > > +	for (data = irq_get_irq_data(virq); data;
> > > > +	     data = data->parent_data) {
> > > > +		if (!data->domain)
> > > > +			continue;
> > > > +
> > > > +		if (!strcmp(data->domain->name, "GPCv2"))
> > >
> > > So you are relying on internal knowledge of the irq domain code
> > > which sets the domain name to the chip name if the domain name is
> > > not initialized by other means.
> > >
> > > Brilliant, NOT!
> > >
> > > In other words you are interested in the irq chip associated with
> > > that domain and not with the domain itself.
> > >
> > > Care to explain what you are trying to do and why you think there
> > > are no better ways to figure that out?
> > >
> > When I wrote the driver, there were two options to let other modules
> > like suspend and cpuidle drivers to access this instance of imx_irq_gpcv2:
> > Option #1 is to use the private data pointer of the irqdomain.
> > Option #2 is to export a global variable here.
> > I selected option #1 because it could decouple this irq driver from
> > those who may use this instance.
> 
> I do not see how that discouples anything. It makes stuff obscure.
> 
> > But option #2 is more direct and simple.
> 
> Well you don't have to export a global variable. All stuff referencing this is in the
> driver itself.
> 
> I assume there is a single instance of that IP block in the chip. I can't see how
> multiple instances would work.
> 
> So instead of doing a completely backwards lookup, you can simply have a static
> variable visible to all functions in the driver:
> 
> static struct imx_irq_gpcv2 *imx_irq_gpcv2;
> 
> You store the pointer to your allocated data structure at the end of your init
> function.
> 
Your example is what I called option #2.
If you prefer to use this variable, I am also fine.

> > > > +	for (i = 0; i < IMR_NUM; i++) {
> > >
> > > Why is IMR_NUM a hard coded constant and not provided by DT?
> > >
> > It can be provided by DT. However, as it is a fixed number and will
> > never change once the Chip is produced I selected to hard code it.
> 
> Fair enough.
> 
> > > > +static int imx_gpcv2_irq_set_wake(struct irq_data *d, unsigned
> > > > +int
> > > > +on) {
> > > > +	unsigned int idx = d->hwirq / 32;
> > > > +	struct imx_irq_gpcv2 *cd = d->chip_data;
> > > > +	u32 mask, val;
> > > > +	unsigned long flags;
> > > > +	void __iomem *reg;
> > >
> > > Can you come up with an even less readable way to arrange those
> declarations?
> > >
> > Will change the declarations like following:
> > 	u32 mask, val;
> > 	unsigned long flags;
> > 	void __iomem *reg;
> >
> > 	unsigned int idx = d->hwirq / 32;
> > 	struct imx_irq_gpcv2 *cd = d->chip_data;
> 
> My preferred way would be:
> 
>  	struct imx_irq_gpcv2 *cd = d->chip_data;
>  	unsigned int idx = d->hwirq / 32;
>  	unsigned long flags;
>  	void __iomem *reg;
>  	u32 mask, val;
> 
Your style is much neater. I will adopt it.

> but I dont insist as long as the style is consistent in all functions.
> 
> > > > +enum gpcv2_slot {
> > >
> > > What is this enum for?
> > >
> > It defined all the power domains that are controlled by GPCv2 block.
> 
> So it wants a proper documentation, right?
> 
I will add the following comments above the enum declaration. Do you think it
is enough? 
"
GPCv2 has the following power domains, and each domain can be power-up
/power-down via GPC settings.

Core 0 of A7 power domain
Core1 of A7 power domain
SCU/L2 cache RAM of A7 power domain
Fastmix and megamix power domain
USB OTG1 PHY power domain
USB OTG2 PHY power domain
PCIE PHY power domain
USB HSIC PHY power domain
"

> > > > +	CORE0_A7,
> > > > +	CORE1_A7,
> > > > +	SCU_A7,
> > > > +	FAST_MEGA_MIX,
> > > > +	MIPI_PHY,
> > > > +	PCIE_PHY,
> > > > +	USB_OTG1_PHY,
> > > > +	USB_OTG2_PHY,
> > > > +	USB_HSIC_PHY,
> > > > +	CORE0_M4,
> > >
> > > Namespace?
> > >
> > > > +};
> > >
> > > > +struct imx_irq_gpcv2 {
> > > > +	spinlock_t lock;
> > >
> > >   raw_spinlock_t
> > >
> > > > +	void __iomem *gpc_base;
> > > > +	struct regmap *anatop;
> > > > +	struct regmap *imx_src;
> > > > +	u32 wakeup_sources[IMR_NUM];
> > > > +	u32 enabled_irqs[IMR_NUM];
> > > > +	u32 mfmix_mask[IMR_NUM];
> > > > +	u32 wakeupmix_mask[IMR_NUM];
> > > > +	u32 lpsrmix_mask[IMR_NUM];
> > > > +	u32 cpu2wakeup;
> > > > +	void (*lpm_env_setup)(struct imx_irq_gpcv2 *);
> > > > +	void (*lpm_env_clean)(struct imx_irq_gpcv2 *);
> > > > +	void (*lpm_cpu_power_gate)(struct imx_irq_gpcv2 *, u32, bool);
> > > > +	void (*lpm_plat_power_gate)(struct imx_irq_gpcv2 *, bool);
> > > > +	void (*set_mode)(struct imx_irq_gpcv2 *, enum gpcv2_mode mode);
> > > > +	void (*standby)(struct imx_irq_gpcv2 *);
> > > > +	void (*suspend)(struct imx_irq_gpcv2 *);
> > > > +	void (*set_slot)(struct imx_irq_gpcv2 *cd, u32 index,
> > > > +			enum gpcv2_slot m_core, bool mode, bool ack);
> > > > +	void (*clear_slots)(struct imx_irq_gpcv2 *);
> > > > +	void (*lpm_enable_core)(struct imx_irq_gpcv2 *,
> > > > +			bool enable, u32 offset);
> > > > +
> > > > +
> > > > +	void (*suspend_fn_in_ocram)(void __iomem *ocram_vbase);
> > > > +	void __iomem *ocram_vbase;
> > >
> > > How many of these struct members are actually relevant to this
> > > driver and what is the purpose of those? A proper KernelDoc comment
> > > would shed some light on it.
> > >
> 
> > This struct defines the properties and functions that GPCv2 block
> > provides. Since GPCv2 has two key functions: Irq wakeup source
> > management and power management, the intention of the struct is to
> > share data and methods among irqchip, suspend, and cpuidle drivers.
> 
> I don't think this is a good idea. The cpuidle driver has nothing to know about the
> internals of the irq driver and vice versa. Neither does the suspend code.
> 
> If you failed to split that proper then your design is wrong.
> 
The implementation has already been spitted totally. The question is if we use
the same structure among those drivers or not, since they do share some common data
like gpc_base address, enabled_irq, and mfmix_mask. The suspend and cpuidle driver
will use those data to decide the hardware power modes and the relating power down
sequence of the power domains. The structure is the abstract of the GPCv2 hardware, 
and the current struct declaration matches the low level hardware well. Although it is 
possible and easy to split it into two, it may introduce either redundant definition
for the common properties or have to create a global variable to enable them visible to
both the irqchip and the suspend codes.

Thanks,
Shenwei

> Thanks,
> 
> 	tglx
> 
> 
