From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 May 2017 15:17:55 +0200
Subject: [PATCH 4/6] irqchip: irq-mvebu-icu: new driver for Marvell ICU
In-Reply-To: <aeb3ad3b-e7a2-6439-2cd7-3dde1bdc5974@arm.com>
References: <1496135772-20694-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1496135772-20694-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <6dffc4f2-aa72-a6ee-cf29-2b92f82b5ee8@arm.com>
 <20170530140549.6aa5ebc5@free-electrons.com>
 <aeb3ad3b-e7a2-6439-2cd7-3dde1bdc5974@arm.com>
Message-ID: <20170530151755.12d0d5e3@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 30 May 2017 14:06:52 +0100, Marc Zyngier wrote:

> > Would drivers/irqchip/irq-mvebu-gicp.h, included by both
> > irq-mvebu-gicp.c and irq-mvebu-icu.c be fine for you?  
> 
> Sure, that'd be fine, assuming that it is necessary (see below).

Right, if we merge everything into one file, then it's simpler :)

> >> What's the relationship between ICU_MAX_IRQS and
> >> IRQS_PER_ICU/ICU_MAX_SPI_IRQ_IN_GIC, if any? Is there only a single ICU?
> >> Or can you have multiple ones?  
> > 
> > There is one ICU per CP. The Armada 7K SoC has one CP, the Armada 8K
> > SoC has two CPs. Therefore on Armada 8K, you have two ICUs, one per CP.  
> 
> OK. Is there any restriction on which SPI an ICU can generate?

Not that I'm aware of. Even though the fact that there are two ranges
of SPI interrupts, which might make one think there is one range per
ICU, this is not the case: any ICU can trigger any SPI within those
ranges. Which is why the ICU driver handles the 128 available SPIs
through a single global bitmap rather than a per-ICU bitmap.

> > But I see your point: there is in fact no direct relation between the
> > number of GICP SPI interrupts reserved and the number of ICUs and
> > interrupts per ICU.  
> 
> Indeed. And maybe we should have an instance of the ICU device per CP.

Not sure what you mean here: we already have one instance of the ICU
device per CP.

armada-cp110-master.dtsi describes the ICU in the master CP,
armada-cp110-slave.dtsi describes the ICU in the slave CP. So in the
patch series I have posted, on an Armada 8K that has two CPs, the
->probe() of irq-mvebu-icu.c gets called twice, once per ICU, and we
have one instance of the ICU per CP, as expected.

Am I missing something?

> >>> +#define ICU_GIC_SPI_BASE0	64
> >>> +#define ICU_GIC_SPI_BASE1	288    
> >>
> >> My own gut feeling is that there will be another version of this IP one
> >> of these days, with different bases. Should we bite the bullet right
> >> away and put those in DT?  
> > 
> > Where should these properties go? Under the gicp DT node, or under the
> > ICU DT node?  
> 
> If the ICU has no knowledge of the SPI it can generate, I'd rather put
> that in the GICP node.

Something like:

	marvell,spi-ranges = <64 64>, <288 64>;

And then the ICU ->probe() routine walks the marvell,gicp phandle, find
the gicp node and parses this information?

> > We in fact don't really care about how many ICUs we have here. We have
> > 128 GICP SPI interrupts available, in ranges:
> > 
> >  - ICU_GIC_SPI_BASE0 ; ICU_GIC_SPI_BASE0 + 64
> > 
> >  - ICU_GIC_SPI_BASE1 ; ICU_GIC_SPI_BASE1 + 64
> > 
> > The icu_irq_alloc bitmap is a global one, which allows to allocate one
> > GICP SPI interrupts amongst the available 128 interrupts, and this
> > function simply allows to map the index in this bitmap (from 0 to 127)
> > to the corresponding GICP SPI interrupt.  
> 
> That makes a lot more sense now, thanks.

I should probably add a comment explaining this in the driver.

> >>> +	 */
> >>> +	if (hwirq == ICU_SATA0_IRQ_INT || hwirq == ICU_SATA1_IRQ_INT) {
> >>> +		writel(icu_int, icu->base + ICU_INT_CFG(ICU_SATA0_IRQ_INT));
> >>> +		writel(icu_int, icu->base + ICU_INT_CFG(ICU_SATA1_IRQ_INT));
> >>> +	}    
> >>
> >> Aren't you wasting an SPI here?  
> > 
> > No: we allocate a single SPI, icu_int. What we're doing here is that we
> > have two different wired interrupts in the CP that are "connected" to
> > the same GICP SPI interrupt.  
> 
> But if both ports are enabled, you're going to allocate one SPI per call
> to this function, and the last one wins (you never "remember" that you
> have configured one port already, and always allocate a new interrupt).

Yes, but no, because the DT only declares one of the two interrupts
currently:

 			cpm_sata0: sata at 540000 {
 				compatible = "marvell,armada-8k-ahci",
 					     "generic-ahci";
 				reg = <0x540000 0x30000>;
-				interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <ICU_GRP_NSR 107 IRQ_TYPE_LEVEL_HIGH>;

Yes, needs to be fixed, with proper changes to the AHCI driver, but
that's a separate matter.

> > So you suggest to merge the whole irq-mvebu-gicp.c stuff inside
> > irq-mvebu-icu.c ?  
> 
> Given how small that code is, it wouldn't be a big deal.

OK.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
