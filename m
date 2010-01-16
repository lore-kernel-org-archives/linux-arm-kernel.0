From: tony@atomide.com (Tony Lindgren)
Date: Sat, 16 Jan 2010 11:12:44 -0800
Subject: [PATCH 4/4] omap: Make get_irqnr_and_base common for
	mach-omap2 multiboot
In-Reply-To: <20100116115503.GA15904@n2100.arm.linux.org.uk>
References: <20100116013205.10065.95921.stgit@baageli.muru.com>
	<20100116013520.10065.17921.stgit@baageli.muru.com>
	<20100116115503.GA15904@n2100.arm.linux.org.uk>
Message-ID: <20100116191244.GH10318@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100116 03:53]:
> On Fri, Jan 15, 2010 at 05:35:20PM -0800, Tony Lindgren wrote:
> > -#ifndef CONFIG_ARCH_OMAP4
> > +#if defined(CONFIG_ARCH_OMAP2420) || defined(CONFIG_ARCH_OMAP2430) || \
> > +	defined(CONFIG_ARCH_OMAP34XX)
> > +
> > +#define INTCPS_SIR_IRQ_OFFSET	0x0040		/* Active interrupt offset */
> > +#define	ACTIVEIRQ_MASK		0x7f		/* Active interrupt bits */
> > +
> > +omap_irq_base:	.word	0x0
> 
> You have no idea where this word will be placed - it could be in the middle
> of a read only section, which might really be read only.  It might also be
> out of reach of the "ldr \base, [pc, #offset]" instructions you're using
> below - which is what an "ldr \base, address" instruction really is.

OK
 
> > +
> >  		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
> > -		ldr	\base, =OMAP2_VA_IC_BASE
> > -		ldr	\irqnr, [\base, #0x98] /* IRQ pending reg 1 */
> > +		ldr	\base, omap_irq_base
> > +		cmp	\base, #0		@ is irq base configured?
> > +		bne	9998f			@ already configured
> 
> First thing, why not use get_irqnr_preamble to load the base address?
> That means you only do all this computation once per group of IRQs
> processed.

Thanks for the tip, will do.
 
> Secondly, is this really worth the overhead, or can't you move
> omap_irq_base into the data section, and have your IRQ initialization
> function set the pointer?

Sounds like a good plan. We can have optimized versions for non-multiomap
configurations.
 
> You then don't have to make these two tests every time you check for
> an interrupt/enter to process interrupts.

Great, that will make things much nicer.

Tony
