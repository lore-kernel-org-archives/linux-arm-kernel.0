From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Oct 2011 22:42:57 +0200
Subject: [PATCH v3 6/7] ARM: pxa: move gpio-pxa.h into include directory
In-Reply-To: <CAKnu2Mr3cWfo3SJYkBU2cXeKELhmVOv+Qes=SCWRBaSB-Sue3g@mail.gmail.com>
References: <1318339051-19096-1-git-send-email-haojian.zhuang@marvell.com>
	<1318339051-19096-7-git-send-email-haojian.zhuang@marvell.com>
	<CAKnu2Mr3cWfo3SJYkBU2cXeKELhmVOv+Qes=SCWRBaSB-Sue3g@mail.gmail.com>
Message-ID: <3002440.xxjcQDzptB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 October 2011 21:51:28 Linus Walleij wrote:
> 2011/10/11 Haojian Zhuang <haojian.zhuang@marvell.com>:
> 
> > Merge the gpio-pxa.h in arch-pxa and arch-mmp. Move the new gpio-pxa.h
> > into include directory.
> (...)
> >  arch/arm/plat-pxa/include/plat/gpio-pxa.h  |   80 ---------------------------
> >  drivers/gpio/gpio-pxa.c                    |   42 ++++++++++++++-
> >  include/linux/gpio-pxa.h                   |   81 ++++++++++++++++++++++++++++
> 
> This seems like a fully valid merge of common pxa GPIO include
> files. And I guess if both are not using plat-pxa it cannot reside
> in <plat/gpio-pxa.h>?
> 
> Grant: shall this be <linux/gpio-pxa.h> or <linux/gpio/pxa.h> or so?

Hmm, more fundamentally, does this even need to be a header file?

Most of the header file looks like it should not be visible in the entire
kernel, so better move as much as possible into the gpio-pxa.c file.
I'm not sure how much remains in the end, but that should probably
determine the location (drivers/gpio/gpio-pxa.h, asm/gpio-pxa.h
or linux/gpio-pxa.h). In general, everything should be as local
as possible.

One more thing regarding the contents of the header:

> +/* GPIO Pin Level Registers */
> +#define PXA_GPLR(x)	(*(volatile u32 *)(pxa_gpio_regs.gplr	\
> +			+ PXA_BANK_OFF((x >> 5))))
> +/* GPIO Pin Direction Registers */
> +#define PXA_GPDR(x)	(*(volatile u32 *)(pxa_gpio_regs.gpdr	\
> +			+ PXA_BANK_OFF((x >> 5))))

When these get moved into the driver itself, it's probably a good
idea to turn these into proper accessors, something like

enum pxa_gpio_reg {
	GPLR,
	GPDR,
	GPSR,
	GPCR,
	GRER,
	GFER,
	GEDR,
};
static void __iomem *pxa_gpio_reg_base;
static inline u32 pxa_gpio_read(unsigned int bank, enum pxa_gpio_reg reg)
{
	unsigned offset = (bank < 3) ? bank << 2 : 0x100 + ((bank - 3) << 2);
	return readl_relaxed(pxa_gpio_reg_base + offset + 12 * reg);
}
static inline void pxa_gpio_write(unsigned int bank, unsigned int reg, u32 val)
{
	unsigned offset = (bank < 3) ? bank << 2 : 0x100 + ((bank - 3) << 2);
	return writel_relaxed(val, pxa_gpio_reg_base + offset + 12 * reg);
}

That should let you get rid of most of the macros and the incorrect
'volatile' access.

	Arnd
