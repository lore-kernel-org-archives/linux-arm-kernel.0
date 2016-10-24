From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 24 Oct 2016 22:54:14 +0200 (CEST)
Subject: [PATCH] arm64: SMMU-v2: Workaround for Cavium ThunderX erratum
 28168
In-Reply-To: <fbc51a32-aaba-0ee6-c0bd-07a02fb2a6b4@arm.com>
References: <1> <1477112061-12868-1-git-send-email-gakula@caviumnetworks.com>
 <fbc51a32-aaba-0ee6-c0bd-07a02fb2a6b4@arm.com>
Message-ID: <alpine.DEB.2.20.1610242242320.4815@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 24 Oct 2016, Marc Zyngier wrote:
> On 22/10/16 05:54, Geetha sowjanya wrote:
> > diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> > index be3c34e..6add8da 100644
> > --- a/kernel/irq/chip.c
> > +++ b/kernel/irq/chip.c
> > @@ -585,6 +585,10 @@ void handle_fasteoi_irq(struct irq_desc *desc)
> >  		goto out;
> >  	}
> >  
> > +#ifdef CONFIG_CAVIUM_ERRATUM_28168
> > +	if (chip->irq_ack)
> > +		chip->irq_ack(&desc->irq_data);
> > +#endif
> >  	kstat_incr_irqs_this_cpu(desc);
> >  	if (desc->istate & IRQS_ONESHOT)
> >  		mask_irq(desc);
> > 
> 
> Overall, this workaround is not acceptable as it is.

Aside of being not acceptable this thing is completely broken. 

If that erratum is enabled then a interrupt chip which implements both EOI
and ACK callbacks will issue irq_ack when using the fasteoi handler. While
this might work on that cavium trainwreck, it will just make other
platforms pretty unhappy.

Platform specific hacks have no place in the core code at all. We have
enough options to handle oddball hardware, you just have to use them.

Thanks,

	tglx
