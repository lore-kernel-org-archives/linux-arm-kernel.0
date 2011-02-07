From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Feb 2011 10:14:46 +0000
Subject: [PATCH] RFC: ux500: add PMU resources
In-Reply-To: <000201cbc6ae$f14aee60$d3e0cb20$@deacon@arm.com>
References: <1295391579-9166-1-git-send-email-linus.walleij@stericsson.com>
	<-2131964397930844736@unknownmsgid>
	<AANLkTimYwi4P=nGTQsibvxe9e1weYS9TLCCUg2BidbRx@mail.gmail.com>
	<000201cbc6ae$f14aee60$d3e0cb20$@deacon@arm.com>
Message-ID: <20110207101446.GA31929@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 07, 2011 at 10:08:18AM -0000, Will Deacon wrote:
> > +static irqreturn_t armpmu_bounce_interrupt(int irq, void *dev)
> > +{
> > +	irqreturn_t ret = armpmu->handle_irq(irq, dev);
> > +
> > +	if (ret == IRQ_NONE) {
> > +		int other = !smp_processor_id();
> > +		irq_set_affinity(irq, cpumask_of(other));
> > +	}
> 
> Will this work for edge-triggered IRQs? I don't think it will and I'd
> rather this code lived in some SoC-specific place than in the general
> ARM code. Maybe you could pass an IRQ callback in the platform data?

Especially as it assumes the presence of only one other CPU, which is
not always the case.
