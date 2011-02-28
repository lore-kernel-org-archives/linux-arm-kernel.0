From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 28 Feb 2011 20:16:25 +0100 (CET)
Subject: [PATCH 6/6] ARM: nmk: update GPIO chained IRQ handler to use
	EOI in parent chip
In-Reply-To: <001401cbd772$a1f93ae0$e5ebb0a0$@deacon@arm.com>
References: <1298900022-21516-1-git-send-email-will.deacon@arm.com>
	<1298900022-21516-7-git-send-email-will.deacon@arm.com>
	<20110228140327.GA1937@n2100.arm.linux.org.uk>
	<001401cbd772$a1f93ae0$e5ebb0a0$@deacon@arm.com>
Message-ID: <alpine.LFD.2.00.1102281949050.2701@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Feb 2011, Will Deacon wrote:
> > On Mon, Feb 28, 2011 at 01:33:42PM +0000, Will Deacon wrote:
> > > The chained GPIO IRQ handler for the nomadik platform can be called
> > > with the GIC as its host chip on the mach-ux500 machines.
> > >
> > > This patch updates the code to use ->irq_eoi when it is available.
> > >
> > > Cc: Rabin Vincent <rabin@rab.in>
> > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > > ---
> > >  arch/arm/plat-nomadik/gpio.c |    2 ++
> > >  1 files changed, 2 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
> > > index 1e88ecb..51cc71b 100644
> > > --- a/arch/arm/plat-nomadik/gpio.c
> > > +++ b/arch/arm/plat-nomadik/gpio.c
> > > @@ -538,6 +538,8 @@ static void nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
> > >  	}
> > >
> > >  	host_chip->irq_unmask(&desc->irq_data);
> > > +	if (host_chip->irq_eoi)
> > > +		host_chip->irq_eoi(&desc->irq_data);
> > 
> > I notice in some you delete the irq_unmask, others you leave it.  Shouldn't
> > they all be similar?
> 
> It depends on whether or not the parent chip is always the GIC. In some cases
> it can be a different IRQ chip, so we need to call the functions conditionally.
>  
> > Maybe we do something like:
> > 
> > static inline void chained_irq_exit(struct irq_chip *chip, struct irq_desc *desc)
> > {
> > 	if (chip->irq_eoi)
> > 		chip->irq_eoi(&desc->irq_data);
> > 	else
> > 		chip->irq_unmask(&desc->irq_data);
> > }
> > 
> > to cover these exit paths in a common way?
> 
> Yes, that is cleaner and potentially less confusing. We'll also need an entry
> function which will do something like:
> 
> 	if (!chip->irq_eoi)
> 		chip->irq_mask(&desc->irq_data);
> 
> which does look pretty odd, so factoring it out (with a comment) will
> make it a little clearer.

And that's the whole mess I was ranting about in the first place. A
chained handler is tied to the underlying primary chip and not a half
arsed flow handler which handles magically the availability or the
absence of irq chip functions. That's just doomed.

And for those cases I really want a reasonable explanation why the
chained handler can't be implemented as a bog standard interrupt
handler which relies on the underlying irq chip implementation to
select the proper flow handler in the first place.

Really folks, count the number of instructions which a normal flow
handler adds. We talk about what? Not more than 100 instructions.

So what's the gain of a barebone chained handler over a regular
interrupt:

 - 100 instructions less
 - lack of statistics
 - lack of affinity setting via standard interfaces
 - making the chained handler aware of the underlying hardware

While a bog standard interrupt handler which is installed via
request/setup_irq() has only the 100 instructions more downside.
There is no other difference.

So please think about whether the 100 instructions are worth the
trouble or not.

Thanks,

	tglx
