From: will.deacon@arm.com (Will Deacon)
Date: Mon, 28 Feb 2011 18:09:24 -0000
Subject: [PATCH 6/6] ARM: nmk: update GPIO chained IRQ handler to use	EOI
	in parent chip
In-Reply-To: <20110228140327.GA1937@n2100.arm.linux.org.uk>
References: <1298900022-21516-1-git-send-email-will.deacon@arm.com>
	<1298900022-21516-7-git-send-email-will.deacon@arm.com>
	<20110228140327.GA1937@n2100.arm.linux.org.uk>
Message-ID: <001401cbd772$a1f93ae0$e5ebb0a0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> On Mon, Feb 28, 2011 at 01:33:42PM +0000, Will Deacon wrote:
> > The chained GPIO IRQ handler for the nomadik platform can be called
> > with the GIC as its host chip on the mach-ux500 machines.
> >
> > This patch updates the code to use ->irq_eoi when it is available.
> >
> > Cc: Rabin Vincent <rabin@rab.in>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm/plat-nomadik/gpio.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
> > index 1e88ecb..51cc71b 100644
> > --- a/arch/arm/plat-nomadik/gpio.c
> > +++ b/arch/arm/plat-nomadik/gpio.c
> > @@ -538,6 +538,8 @@ static void nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
> >  	}
> >
> >  	host_chip->irq_unmask(&desc->irq_data);
> > +	if (host_chip->irq_eoi)
> > +		host_chip->irq_eoi(&desc->irq_data);
> 
> I notice in some you delete the irq_unmask, others you leave it.  Shouldn't
> they all be similar?

It depends on whether or not the parent chip is always the GIC. In some cases
it can be a different IRQ chip, so we need to call the functions conditionally.
 
> Maybe we do something like:
> 
> static inline void chained_irq_exit(struct irq_chip *chip, struct irq_desc *desc)
> {
> 	if (chip->irq_eoi)
> 		chip->irq_eoi(&desc->irq_data);
> 	else
> 		chip->irq_unmask(&desc->irq_data);
> }
> 
> to cover these exit paths in a common way?

Yes, that is cleaner and potentially less confusing. We'll also need an entry
function which will do something like:

	if (!chip->irq_eoi)
		chip->irq_mask(&desc->irq_data);

which does look pretty odd, so factoring it out (with a comment) will
make it a little clearer.

I'll see if I get any feedback about nomadik and msm and then post a v3
with the entry/exit functions.

Will
