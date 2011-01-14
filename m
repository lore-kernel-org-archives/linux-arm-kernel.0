From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Jan 2011 16:17:59 +0000
Subject: [GIT PULL v2] pxa: patches for v2.6.37-rc
In-Reply-To: <20110114155229.GF15996@n2100.arm.linux.org.uk>
References: <AANLkTin_LK7MtJiz7e417k4XCumOBq+dnTgLBCe8HYj1@mail.gmail.com>
	<20110114155229.GF15996@n2100.arm.linux.org.uk>
Message-ID: <20110114161759.GG15996@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 14, 2011 at 03:52:29PM +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 14, 2011 at 08:37:13AM -0600, Eric Miao wrote:
> > Didn't realize that some of the fixing patches are in my devel branch, sorry
> > for the noise. Please pull again and let know if there's any issue.
> > 
> > The following changes since commit 581548db3b3c0f6e25b500329eb02e3c72e7acbe:
> > 
> >   Merge branch 'release' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux-2.6
> > (2011-01-13 11:02:55 -0800)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git devel
> 
> Thanks.  I'll wait until just before sending the pull request as this
> commit is based on something beyond 9e9bc973, which is what I'm using
> internally as the basis for anything I'm doing (as that is the last
> commit where the kernels I care about are buildable.)

I just tried merging this on my devel-stable branch (which is where
Lennert's irq work was merged) and the result was some nasty conflicts.
I wouldn't like to guess what the right solution for this is:

diff --cc arch/arm/mach-pxa/irq.c
index 3f7f5bf,6107253..0000000
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@@ -53,12 -53,23 +53,27 @@@ static inline int cpu_has_ipr(void
  	return !cpu_is_pxa25x();
  }
  
++<<<<<<< HEAD:arch/arm/mach-pxa/irq.c
 +static void pxa_mask_irq(struct irq_data *d)
++=======
+ static inline void __iomem *irq_base(int i)
+ {
+ 	static unsigned long phys_base[] = {
+ 		0x40d00000,
+ 		0x40d0009c,
+ 		0x40d00130,
+ 	};
+ 
+ 	return (void __iomem *)io_p2v(phys_base[i]);
+ }
+ 
+ static void pxa_mask_irq(unsigned int irq)
++>>>>>>> 9c39c4df81fb0e8ec410714b689dbb6af9c70b54:arch/arm/mach-pxa/irq.c
  {
 -	void __iomem *base = get_irq_chip_data(irq);
 +	void __iomem *base = irq_data_get_irq_chip_data(d);
  	uint32_t icmr = __raw_readl(base + ICMR);
  
 -	icmr &= ~(1 << IRQ_BIT(irq));
 +	icmr &= ~(1 << IRQ_BIT(d->irq));
  	__raw_writel(icmr, base + ICMR);
  }
  
@@@ -103,31 -114,17 +118,40 @@@ static int pxa_set_low_gpio_type(struc
  	return 0;
  }
  
 -static void pxa_ack_low_gpio(unsigned int irq)
 +static void pxa_ack_low_gpio(struct irq_data *d)
 +{
 +	GEDR0 = (1 << (d->irq - IRQ_GPIO0));
 +}
 +
++<<<<<<< HEAD:arch/arm/mach-pxa/irq.c
 +static void pxa_mask_low_gpio(struct irq_data *d)
 +{
 +	struct irq_desc *desc = irq_to_desc(d->irq);
 +
 +	desc->irq_data.chip->irq_mask(d);
 +}
 +
 +static void pxa_unmask_low_gpio(struct irq_data *d)
  {
 -	GEDR0 = (1 << (irq - IRQ_GPIO0));
 +	struct irq_desc *desc = irq_to_desc(d->irq);
 +
 +	desc->irq_data.chip->irq_unmask(d);
  }
  
  static struct irq_chip pxa_low_gpio_chip = {
  	.name		= "GPIO-l",
 +	.irq_ack	= pxa_ack_low_gpio,
 +	.irq_mask	= pxa_mask_low_gpio,
 +	.irq_unmask	= pxa_unmask_low_gpio,
 +	.irq_set_type	= pxa_set_low_gpio_type,
++=======
++static struct irq_chip pxa_low_gpio_chip = {
++	.name		= "GPIO-l",
+ 	.ack		= pxa_ack_low_gpio,
+ 	.mask		= pxa_mask_irq,
+ 	.unmask		= pxa_unmask_irq,
+ 	.set_type	= pxa_set_low_gpio_type,
++>>>>>>> 9c39c4df81fb0e8ec410714b689dbb6af9c70b54:arch/arm/mach-pxa/irq.c
  };
  
  static void __init pxa_init_low_gpio_irq(set_wake_t fn)
@@@ -145,20 -143,9 +170,9 @@@
  		set_irq_flags(irq, IRQF_VALID);
  	}
  
 -	pxa_low_gpio_chip.set_wake = fn;
 +	pxa_low_gpio_chip.irq_set_wake = fn;
  }
  
- static inline void __iomem *irq_base(int i)
- {
- 	static unsigned long phys_base[] = {
- 		0x40d00000,
- 		0x40d0009c,
- 		0x40d00130,
- 	};
- 
- 	return (void __iomem *)io_p2v(phys_base[i >> 5]);
- }
- 
  void __init pxa_init_irq(int irq_nr, set_wake_t fn)
  {
  	int irq, i, n;
