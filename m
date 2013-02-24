From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 24 Feb 2013 14:39:45 +0100 (CET)
Subject: question about arch/arm/mach-s3c24xx/irq.c
In-Reply-To: <20130224123849.GH17833@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.02.1302241241440.1943@hadrien>
 <20130224123849.GH17833@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.02.1302241437360.1943@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Adding the person who introduced the code]

On Sun, 24 Feb 2013, Russell King - ARM Linux wrote:

> On Sun, Feb 24, 2013 at 12:45:11PM +0100, Julia Lawall wrote:
> > The function s3c24xx_irq_map in arch/arm/mach-s3c24xx/irq.c contains the
> > code:
> >
> >                 parent_irq_data = &parent_intc->irqs[irq_data->parent_irq];
> > 		if (!irq_data) {
> >                         pr_err("irq-s3c24xx: no irq data found for hwirq %lu\n",
> >                                hw);
> >                         goto err;
> > 		}
> >
> > At this point irq_data has already been tested, so the null test on
> > irq_data does not look correct.  But I wonder if parent_irq_data could
> > ever be null here?
>
> That would be really obscure - because that would require parent_intc to
> be a "negative" pointer (to counter-act the indexing by
> irq_data->parent_irq).  So it looks to me like the above is redundant.

Even at its original definition irq_data seems unlikely to be NULL:

        struct s3c_irq_intc *intc = h->host_data;
	struct s3c_irq_data *irq_data = &intc->irqs[hw];
	...
	if (!irq_data) {
                pr_err("irq-s3c24xx: no irq data found for hwirq %lu\n", hw);
                return -EINVAL;
        }

That is, it could be an invalid value, but whether it actually hits 0
would seem to depend on the value hw?

Heiko, is NULL really a possibility?

thanks,
julia
