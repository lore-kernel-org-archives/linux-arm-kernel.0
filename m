From: s.neumann@raumfeld.com (Sven Neumann)
Date: Tue, 18 Jan 2011 09:16:01 +0100
Subject: resume regression in 2.6.37
In-Reply-To: <4D349FBC.6050606@metafoo.de>
References: <1294933492.2535.23.camel@sven>
	<alpine.LFD.2.00.1101131720350.2678@localhost6.localdomain6>
	<1294938961.10740.24.camel@sven>
	<alpine.LFD.2.00.1101131827080.2678@localhost6.localdomain6>
	<1295260580.2060.29.camel@sven>
	<alpine.LFD.2.00.1101171142380.2678@localhost6.localdomain6>
	<4D349787.80201@metafoo.de>  <4D349FBC.6050606@metafoo.de>
Message-ID: <1295338561.2003.3.camel@sven>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 2011-01-17 at 20:59 +0100, Lars-Peter Clausen wrote:

> > If you take a look at the pxa gpio irq handling you'll see that it sets the
> > "set_wake" field of it's irq_chip after calling set_irq_chip for all of the irqs, so
> > the compat handler gets never installed.
> > 
> > So I guess the following patch fixes it:
> > 
> > diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
> > --- a/arch/arm/mach-pxa/irq.c
> > +++ b/arch/arm/mach-pxa/irq.c
> > @@ -111,13 +111,13 @@ static void __init pxa_init_low_gpio_irq(set_wake_t fn)
> >  	GRER0 &= ~0x3;
> >  	GEDR0 = 0x3;
> > 
> > +	pxa_low_gpio_chip.set_wake = fn;
> > +
> >  	for (irq = IRQ_GPIO0; irq <= IRQ_GPIO1; irq++) {
> >  		set_irq_chip(irq, &pxa_low_gpio_chip);
> >  		set_irq_handler(irq, handle_edge_irq);
> >  		set_irq_flags(irq, IRQF_VALID);
> >  	}
> > -
> > -	pxa_low_gpio_chip.set_wake = fn;
> >  }
> > 
> >  void __init pxa_init_irq(int irq_nr, set_wake_t fn)
> > @@ -142,13 +142,14 @@ void __init pxa_init_irq(int irq_nr, set_wake_t fn)
> >  	/* only unmasked interrupts kick us out of idle */
> >  	ICCR = 1;
> > 
> > +	pxa_internal_irq_chip.set_wake = fn;
> > +
> >  	for (irq = PXA_IRQ(0); irq < PXA_IRQ(irq_nr); irq++) {
> >  		set_irq_chip(irq, &pxa_internal_irq_chip);
> >  		set_irq_handler(irq, handle_level_irq);
> >  		set_irq_flags(irq, IRQF_VALID);
> >  	}
> > 
> > -	pxa_internal_irq_chip.set_wake = fn;
> >  	pxa_init_low_gpio_irq(fn);
> >  }
> > 
> and
> 
> diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
> index d1c747c..6fc8281 100644
> - --- a/arch/arm/mach-pxa/pxa3xx.c
> +++ b/arch/arm/mach-pxa/pxa3xx.c
> @@ -558,13 +558,13 @@ static void __init pxa_init_ext_wakeup_irq(set_wake_t fn)
>  {
>  	int irq;
> 
> +	pxa_ext_wakeup_chip.set_wake = fn;
> +
>  	for (irq = IRQ_WAKEUP0; irq <= IRQ_WAKEUP1; irq++) {
>  		set_irq_chip(irq, &pxa_ext_wakeup_chip);
>  		set_irq_handler(irq, handle_edge_irq);
>  		set_irq_flags(irq, IRQF_VALID);
>  	}
> - -
> - -	pxa_ext_wakeup_chip.set_wake = fn;
>  }
> 
>  void __init pxa3xx_init_irq(void)

Indeed, that does fix it. It doesn't fix all my problems, but at least
the device shows the same behavior now as with commit 2f7e99bb9be
reverted. It powers up again and then outputs gibberish to the console.
I will try another bisect to find out what else is broken.

I will send another mail with your two patches combined into a single
commit. Please consider to sign-off that patch and send it upstream and
to stable.


Thanks a lot for your help,
Sven
