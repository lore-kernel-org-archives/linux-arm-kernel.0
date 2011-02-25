From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 25 Feb 2011 10:00:10 +0100
Subject: [PATCH 2/5] ARM: Samsung: cleanup S5P gpio interrupt code
In-Reply-To: <01f201cbd342$8e6001f0$ab2005d0$%kim@samsung.com>
References: <1297927527-1338-1-git-send-email-m.szyprowski@samsung.com>
	<1297927527-1338-3-git-send-email-m.szyprowski@samsung.com>
	<01f201cbd342$8e6001f0$ab2005d0$%kim@samsung.com>
Message-ID: <000001cbd4ca$6a7d25e0$3f7771a0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wednesday, February 23, 2011 11:15 AM Kukjin Kim wrote:

> Marek Szyprowski wrote:
> >
> > This patch performs a global cleanup in s5p gpio interrupt support code.
> > The code is prepared for upcoming support for gpio interrupts on S5PC210
> > platform, which has 2 gpio banks (regions) instead of one (like on
> > S5PC110 and S5PC100).
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  arch/arm/plat-s5p/irq-gpioint.c |  106
> +++++++++++++++++--------------------
> > --
> >  1 files changed, 46 insertions(+), 60 deletions(-)
> >
> > diff --git a/arch/arm/plat-s5p/irq-gpioint.c b/arch/arm/plat-s5p/irq-
> > gpioint.c
> > index 3b6bf89..af10328 100644
> > --- a/arch/arm/plat-s5p/irq-gpioint.c
> > +++ b/arch/arm/plat-s5p/irq-gpioint.c
> > @@ -22,77 +22,64 @@
> >  #include <plat/gpio-core.h>
> >  #include <plat/gpio-cfg.h>
> >
> > -#define S5P_GPIOREG(x)			(S5P_VA_GPIO + (x))
> > +#define GPIO_BASE(chip)		(((unsigned long)(chip)->base) &
> > ~(SZ_4K - 1))
> >
> 
> Need SZ_4K here instead of 0xFFFFF000?

No problem, I can change it to 0xFFFFF000

> 
> > -#define GPIOINT_CON_OFFSET		0x700
> > -#define GPIOINT_MASK_OFFSET		0x900
> > -#define GPIOINT_PEND_OFFSET		0xA00
> > +#define CON_OFFSET		0x700
> > +#define MASK_OFFSET		0x900
> > +#define PEND_OFFSET		0xA00
> 
> I don't know why need to change above definitions...

I've shortened them to make the code the uses them to fit 80 characters
per line... They are just a local defines that imho don't need to be
prefixed with GPIOINT_

> > +#define REG_OFFSET(x)		((x) << 2)
> >
> Actually, this is used instead of "group << 2" in this file.
> So how about "GPIOINT_REG_OFFSET(x)" like others?

Ok.

> >  static void s5p_gpioint_ack(struct irq_data *data)
> >  {
> > +	struct s3c_gpio_chip *chip = irq_data_get_irq_data(data);
> >  	int group, offset, pend_offset;
> >  	unsigned int value;
> >
> > -	group = s5p_gpioint_get_group(data);
> > +	group = chip->group;
> >  	offset = s5p_gpioint_get_offset(data);
> > -	pend_offset = group << 2;
> > +	pend_offset = REG_OFFSET(group);
> >
> > -	value = __raw_readl(S5P_GPIOREG(GPIOINT_PEND_OFFSET) + pend_offset);
> > -	value |= 1 << offset;
> > -	__raw_writel(value, S5P_GPIOREG(GPIOINT_PEND_OFFSET) + pend_offset);
> > +	value = __raw_readl(GPIO_BASE(chip) + PEND_OFFSET + pend_offset);
> > +	value |= BIT(offset);
> 
> No need inclusion <linux/bitops.h>?

It has been included indirectly, because the code compiled fine.

snip

> >  static void s5p_gpioint_handler(unsigned int irq, struct irq_desc *desc)
> >  {
> > -	int group, offset, pend_offset, mask_offset;
> > -	int real_irq;
> > +	int group, pend_offset, mask_offset;
> >  	unsigned int pend, mask;
> >
> >  	for (group = 0; group < S5P_GPIOINT_GROUP_MAXNR; group++) {
> > -		pend_offset = group << 2;
> > -		pend = __raw_readl(S5P_GPIOREG(GPIOINT_PEND_OFFSET) +
> > -				pend_offset);
> > +		struct s3c_gpio_chip *chip = irq_chips[group];
> > +		if (!chip)
> > +			continue;
> > +
> > +		pend_offset = REG_OFFSET(group);
> > +		pend = __raw_readl(GPIO_BASE(chip) + PEND_OFFSET +
> > pend_offset);
> >  		if (!pend)
> >  			continue;
> >
> > -		mask_offset = group << 2;
> > -		mask = __raw_readl(S5P_GPIOREG(GPIOINT_MASK_OFFSET) +
> > -				mask_offset);
> > +		mask_offset = REG_OFFSET(group);
> > +		mask = __raw_readl(GPIO_BASE(chip) + MASK_OFFSET +
> > mask_offset);
> >  		pend &= ~mask;
> >
> > -		for (offset = 0; offset < 8; offset++) {
> > -			if (pend & (1 << offset)) {
> > -				struct s3c_gpio_chip *chip =
> irq_chips[group];
> > -				if (chip) {
> > -					real_irq = chip->irq_base + offset;
> > -					generic_handle_irq(real_irq);
> > -				}
> > -			}
> > +		while (pend) {
> > +			int offset = fls(pend) - 1;
> 
> __ffs?

I don't see much difference between ffs and fls here...

> And hmm...do we really need while loop here?

Yes, because more than one gpio pin in a group can issue an interrupt at the
same time. The previous version used for() loop here.

> 
> > +			int real_irq = chip->irq_base + offset;
> > +			generic_handle_irq(real_irq);
> > +			pend &= ~BIT(offset);
> >  		}
> >  	}
> >  }
> > @@ -202,7 +188,7 @@ static __init int s5p_gpioint_add(struct s3c_gpio_chip
> > *chip)
> >  	for (i = 0; i < chip->chip.ngpio; i++) {
> >  		irq = chip->irq_base + i;
> >  		set_irq_chip(irq, &s5p_gpioint);
> > -		set_irq_data(irq, &chip->chip);
> > +		set_irq_data(irq, chip);
> 
> ?

This simplifies all the functions that use get_irq_data. Now they get s3c_gpio_chip
directly and don't need to extract it with contrainer_of().

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
