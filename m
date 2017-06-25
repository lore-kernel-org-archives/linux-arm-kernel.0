From: yehuday@marvell.com (Yehuda Yitschak)
Date: Sun, 25 Jun 2017 06:47:01 +0000
Subject: [EXT] Re: [PATCH 4/6] irqchip: irq-mvebu-icu: new driver for
 Marvell ICU
In-Reply-To: <20170530140549.6aa5ebc5@free-electrons.com>
References: <1496135772-20694-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1496135772-20694-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <6dffc4f2-aa72-a6ee-cf29-2b92f82b5ee8@arm.com>
 <20170530140549.6aa5ebc5@free-electrons.com>
Message-ID: <fbbb7cb338ab48928692bf131abb6041@IL-EXCH02.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Thomas Petazzoni [mailto:thomas.petazzoni at free-electrons.com]
> Sent: Tuesday, May 30, 2017 15:06
> To: Marc Zyngier
> Cc: Thomas Gleixner; Jason Cooper; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; Rob Herring; Ian Campbell; Pawel Moll; Mark
> Rutland; Kumar Gala; Andrew Lunn; Sebastian Hesselbarth; Gregory
> Clement; linux-arm-kernel at lists.infradead.org; Nadav Haklai; Hanna Hawa;
> Yehuda Yitschak; Antoine Tenart
> Subject: [EXT] Re: [PATCH 4/6] irqchip: irq-mvebu-icu: new driver for Marvell
> ICU
> 
> External Email
> 
> ----------------------------------------------------------------------
> Hello,
> 
> On Tue, 30 May 2017 12:10:29 +0100, Marc Zyngier wrote:
> 
> > Thanks for that, looks pretty interesting. A couple of comments below.
> 
> Thanks again for the review!
> 
> > > +/* GICP registers */
> > > +#define GICP_SETSPI_NSR_OFFSET	0x0
> > > +#define GICP_CLRSPI_NSR_OFFSET	0x8
> >
> > Shouldn't that live in some gicp-specific include file?
> 
> Would drivers/irqchip/irq-mvebu-gicp.h, included by both irq-mvebu-gicp.c
> and irq-mvebu-icu.c be fine for you?
> 
> > > +/* ICU definitions */
> > > +#define ICU_MAX_IRQS		207
> > > +#define IRQS_PER_ICU		64
> > > +#define ICU_MAX_SPI_IRQ_IN_GIC	(2 * IRQS_PER_ICU)
> >
> > What's the relationship between ICU_MAX_IRQS and
> > IRQS_PER_ICU/ICU_MAX_SPI_IRQ_IN_GIC, if any? Is there only a single
> ICU?
> > Or can you have multiple ones?
> 
> There is one ICU per CP. The Armada 7K SoC has one CP, the Armada 8K SoC
> has two CPs. Therefore on Armada 8K, you have two ICUs, one per CP.
> 
> But I see your point: there is in fact no direct relation between the number of
> GICP SPI interrupts reserved and the number of ICUs and interrupts per ICU.
> 
> The number of GICP SPI interrupts (128) should be moved into irq-mvebu-
> gicp.h, together with the GICP register offsets.
> 
> > > +#define ICU_GIC_SPI_BASE0	64
> > > +#define ICU_GIC_SPI_BASE1	288
> >
> > My own gut feeling is that there will be another version of this IP
> > one of these days, with different bases. Should we bite the bullet
> > right away and put those in DT?
> 
> Where should these properties go? Under the gicp DT node, or under the
> ICU DT node?
> 
> > > +static DEFINE_SPINLOCK(icu_lock);
> > > +static DECLARE_BITMAP(icu_irq_alloc, ICU_MAX_SPI_IRQ_IN_GIC);
> > > +
> > > +static unsigned int
> > > +mvebu_icu_icuidx_to_gicspi(unsigned int icuidx) {
> > > +	if (icuidx < ICU_GIC_SPI_BASE0)
> > > +		return ICU_GIC_SPI_BASE0 + icuidx;
> > > +	else
> > > +		return ICU_GIC_SPI_BASE1 + (icuidx - IRQS_PER_ICU);
> >
> > A small comment on how ICU indexes and GIC SPIs map would be good.
> 
> ACK.
> 
> > Correct me if I'm wrong, but it really looks like you're dealing with
> > two devices here, each with their own SPI window.
> 
> We in fact don't really care about how many ICUs we have here. We have
> 128 GICP SPI interrupts available, in ranges:
> 
>  - ICU_GIC_SPI_BASE0 ; ICU_GIC_SPI_BASE0 + 64
> 
>  - ICU_GIC_SPI_BASE1 ; ICU_GIC_SPI_BASE1 + 64
> 
> The icu_irq_alloc bitmap is a global one, which allows to allocate one GICP SPI
> interrupts amongst the available 128 interrupts, and this function simply
> allows to map the index in this bitmap (from 0 to 127) to the corresponding
> GICP SPI interrupt.
> 
> > > +	writel(icu_int, icu->base + ICU_INT_CFG(hwirq));
> >
> > You can use a writel_relaxed here.
> 
> ACK.
> 
> > > +	/*
> > > +	 * The SATA unit has 2 ports, and a dedicated ICU entry per
> > > +	 * port. The ahci sata driver supports only one irq interrupt
> > > +	 * per SATA unit. To solve this conflict, we configure the 2
> > > +	 * SATA wired interrupts in the south bridge into 1 GIC
> > > +	 * interrupt in the north bridge. Even if only a single port
> > > +	 * is enabled, if sata node is enabled, both interrupts are
> > > +	 * configured (regardless of which port is actually in use).
> > > +	 * The ICU index of SATA0 = 107, SATA1 = 109
> >
> > You can drop that last comment about the indexes, the #defines are
> > good enough.
> 
> Agreed.
> 
> > > +	 */
> > > +	if (hwirq == ICU_SATA0_IRQ_INT || hwirq == ICU_SATA1_IRQ_INT) {
> > > +		writel(icu_int, icu->base +
> ICU_INT_CFG(ICU_SATA0_IRQ_INT));
> > > +		writel(icu_int, icu->base +
> ICU_INT_CFG(ICU_SATA1_IRQ_INT));
> > > +	}
> >
> > Aren't you wasting an SPI here?
> 
> No: we allocate a single SPI, icu_int. What we're doing here is that we have
> two different wired interrupts in the CP that are "connected" to the same
> GICP SPI interrupt.
> 
> > If you configure SATA0 first, then SATA1, SATA0's allocated SPI will
> > be wasted (not to mention the corresponding Linux interrupt too).
> > Can't this be worked around at the AHCI level? It is not like we don't
> > have any quirk there already...
> 
> This is something I wanted to look at, but at a follow-up work, as I believe the
> proposed work around is reasonable, and does not affect the DT binding.
> 
> > > +	writel(0, icu->base + ICU_INT_CFG(irqd_to_hwirq(irq)));
> >
> > writel_relaxed (everywhere in this file).
> 
> ACK.
> 
> 
> > > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +	icu->base = devm_ioremap_resource(&pdev->dev, res);
> > > +	if (IS_ERR(icu->base)) {
> > > +		dev_err(&pdev->dev, "Failed to map icu base address.\n");
> > > +		return PTR_ERR(icu->base);
> > > +	}
> >
> > Careful here, you're leaking the memory from kstrdup above. Consider
> > using devm_kstrdup or/and moving all the potential failures (including
> > hooking on GICP) before doign any memory allocation.
> 
> Well spotted, will fix.
> 
> 
> > > +	/* Set Clear/Set ICU SPI message address in AP */
> > > +	writel(upper_32_bits(gicp_res->start + GICP_SETSPI_NSR_OFFSET),
> > > +	       icu->base + ICU_SETSPI_NSR_AH);
> > > +	writel(lower_32_bits(gicp_res->start + GICP_SETSPI_NSR_OFFSET),
> > > +	       icu->base + ICU_SETSPI_NSR_AL);
> > > +	writel(upper_32_bits(gicp_res->start + GICP_CLRSPI_NSR_OFFSET),
> > > +	       icu->base + ICU_CLRSPI_NSR_AH);
> > > +	writel(lower_32_bits(gicp_res->start + GICP_CLRSPI_NSR_OFFSET),
> > > +	       icu->base + ICU_CLRSPI_NSR_AL);
> >
> > I wonder if it wouldn't be better to have a proper function call into
> > the GICP code to retrieve this information.
> 
> I've never been a big fan of random cross function calls between drivers, but
> this can be done.
> 
> > Or move the whole GICP probing in here, because even if it is a
> > separate piece of HW, it serves no real purpose on its own.
> 
> So you suggest to merge the whole irq-mvebu-gicp.c stuff inside irq-mvebu-
> icu.c ?
> 
> > > +	/*
> > > +	 * Clean all ICU interrupts with type SPI_NSR, required to
> > > +	 * avoid unpredictable SPI assignments done by firmware.
> > > +	 */
> > > +	for (i = 0 ; i < ICU_MAX_IRQS ; i++) {
> > > +		icu_int = readl(icu->base + ICU_INT_CFG(i));
> > > +		if ((icu_int >> ICU_GROUP_SHIFT) == ICU_GRP_NSR)
> > > +			writel(0x0, icu->base + ICU_INT_CFG(i));
> >
> > Erm... Does it mean that non-secure can write to the configuration of
> > a secure interrupt? If that's the case, that's pretty... interesting.
> 
> I'll let Hannah and Yehuda answer this question, they know the ICU details
> much better than I do.

In case it's still relevant. The ICU has a limitation where the entire unit can be either secured or non-secured.
If the entire ICU is secured, It's practically useless in Linux. In the non-secure setup, Linux can technically modify configurations made by secure FW.
This means the secure FW can't reliably use the ICU for secure interrupts.
This limitation should be fixed in future revisions to allow secure FW to use the ICU for generating secure interrupts.

Regards

Yehuda 

> 
> Thanks!
> 
> Thomas
> --
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
