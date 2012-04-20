From: Hong.Xu@atmel.com (Xu, Hong)
Date: Fri, 20 Apr 2012 09:13:06 +0000
Subject: [PATCH v4 1/2] MTD: atmel_nand: Update driver to support
 Programmable HW ECC controller
In-Reply-To: <20120420082533.GX16641@game.jcrosoft.org>
References: <1334906788-18704-1-git-send-email-hong.xu@atmel.com>
 <20120420082533.GX16641@game.jcrosoft.org>
Message-ID: <A92DB5DF46DBC241980A99BFD8A00AEE0F62D642@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi JC,

> -----Original Message-----
> From: Jean-Christophe PLAGNIOL-VILLARD [mailto:plagnioj at jcrosoft.com]
> Sent: Friday, April 20, 2012 4:26 PM
> To: Xu, Hong
> Cc: linux-mtd at lists.infradead.org; linux-arm-kernel at lists.infradead.org;
> dedekind1 at gmail.com; Ferre, Nicolas
> Subject: Re: [PATCH v4 1/2] MTD: atmel_nand: Update driver to support
> Programmable HW ECC controller
> 
> On 15:26 Fri 20 Apr     , Hong Xu wrote:
> > The Programmable Hardware ECC (PMECC) controller is a programmable binary
> > BCH(Bose, Chaudhuri and Hocquenghem) encoder and decoder. This controller
> > can be used to support both SLC and MLC NAND Flash devices. It supports to
> > generate ECC to correct 2, 4, 8, 12 or 24 bits of error per sector of data.
> >
> > To use this driver, the user needs to pass in the correction capability and
> > the sector size.
> >
> > This driver has been tested on AT91SAM9X5-EK and AT91SAM9N12-EK with JFFS2,
> > YAFFS2, UBIFS and mtd-utils.
> >
> > Signed-off-by: Hong Xu <hong.xu@atmel.com>
> what is the status on the other soc?

So far, PMECC appears on SAM9X5 and SAM9N12 (PMECC will be available on the SoCs in the future). And the test is done on the two platforms.

> > ---
> > Changes since v3,
> > 	Rebased on AT91 Nand fixes and DT
> >
> >  drivers/mtd/nand/atmel_nand.c     |  955
> ++++++++++++++++++++++++++++++++++---
> >  drivers/mtd/nand/atmel_nand_ecc.h |  123 ++++-
> >  2 files changed, 998 insertions(+), 80 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
> > index 2165576..7d494c8 100644
> > --- a/drivers/mtd/nand/atmel_nand.c
> > +++ b/drivers/mtd/nand/atmel_nand.c
> > @@ -15,6 +15,8 @@
> >   *     		(u-boot-1.1.5/board/atmel/at91sam9263ek/nand.c)
> >   *     (C) Copyright 2006 ATMEL Rousset, Lacressonniere Nicolas
> >   *
> > + *  Add Programmable Hardware ECC support for various AT91 SoC
> > + *     (C) Copyright 2012 ATMEL, Hong Xu
> the comment is wrong the hw ecc is already implemented

Well, original code is Hamming based ECC. New one is based on BCH. But anyway, these two lines can be removed.

> >   *
> >   * This program is free software; you can redistribute it and/or modify
> >   * it under the terms of the GNU General Public License version 2 as
> > @@ -42,19 +44,50 @@
> >
> >  #include <mach/cpu.h>
> >
> > +/* Hardware ECC registers */
> > +#include "atmel_nand_ecc.h"
> > +
> >  static int use_dma = 1;
> >  module_param(use_dma, int, 0);
> >
> >  static int on_flash_bbt = 0;
> >  module_param(on_flash_bbt, int, 0);
> >

[...]

> > +
> > +static int cpu_has_pmecc(void)
> > +{
> > +	if (cpu_is_at91sam9x5())
> > +		return 1;
> this must be pass via DT do not use cpu_is

Well, I agreed we could add something in the DT of the SoC. But when can we use cpu_is_xxx in the context of DT?

> > +
> > +	return 0;
> > +}
> > +
> > +static int pmecc_get_clkctrl(void)
> > +{
> > +	/* See datasheet about PMECC Clock Control Register */
> > +	if (cpu_is_at91sam9x5())
> > +		return 2;
> > +
> > +	return 0;
> > +}
> > +
> > +static void pmecc_config_ecc_layout(struct nand_ecclayout *layout, int
> oobsize,
[...]
> > +	 */
> > +	si = host->si;
> > +
> > +	for (i = 1; i < 2 * AT_NB_ERROR_MAX; i++)
> > +		si[i] = 0;
> > +
> > +	/* Computation 2t syndromes based on S(x) */
> > +	/* Odd syndromes */
> > +	for (i = 1; i <= 2 * host->cap - 1; i = i + 2) {
> i += 2
> < without the -1

I'd keep it as it is. We could find similar lines in datasheet or internal tested code.

> > +		si[i] = 0;
> > +		for (j = 0; j < host->degree; j++) {
> > +			if (partial_syn[i] & ((unsigned short)0x1 << j))
> > +				si[i] = __raw_readw(alpha_to + i * j) ^ si[i];
> use relaxed read/write

OK, I'll have a look.

> > +		}
> > +	}
> > +	/* Even syndrome = (Odd syndrome) ** 2 */
> > +	for (i = 2; i <= 2 * host->cap; i = i + 2) {
> > +		j = i / 2;
> > +		if (si[j] == 0)
> > +			si[i] = 0;
> > +		else {
> > +			int16_t tmp;
> please check your patch with checkpath

I've done it before submitting. BTW with checkpatch instead of checkpath.

> > +			tmp = __raw_readw(index_of + si[j]);
> > +			tmp = (tmp * 2) % host->cw_len;
> > +			si[i] = __raw_readw(alpha_to + tmp);
> > +		}
> > +	}
> > +
> > +	return;
> > +}
> > +
> > +static void pmecc_get_sigma(struct mtd_info *mtd)
> > +{
> > +	int			i, j, k;
> > +	struct nand_chip	*nand_chip = mtd->priv;
> > +	struct atmel_nand_host	*host = nand_chip->priv;
> > +
> > +	uint32_t		dmu_0_count, tmp;
> > +	int16_t			*lmu = host->lmu;
> > +	int16_t			*si = host->si;
> > +	int16_t			cap = host->cap;
> > +	int16_t __iomem		*index_of = host->index_of;
> > +	int16_t __iomem		*alpha_to = host->alpha_to;
> > +
> > +	/* mu */
> > +	int mu[AT_NB_ERROR_MAX + 1];
> > +
> > +	/* discrepancy */
> > +	int dmu[AT_NB_ERROR_MAX + 1];
> > +
> > +	/* delta order */
> > +	int delta[AT_NB_ERROR_MAX + 1];
> allocate these

OK.

> > +
> > +	/* index of largest delta */
> > +	int ro;
> > +	int largest;
> > +	int diff;
> > +
> > +	dmu_0_count = 0;
> > +
> > +	/* First Row */
> > +
> > +	/* Mu */
> > +	mu[0] = -1;
> > +
> > +	for (i = 0; i < 2 * AT_NB_ERROR_MAX + 1; i++)
> > +		host->smu[0][i] = 0;
> use memeset

A big deal? Or I'd keep this as found in datasheet.

BR
Eric

> 
> 
> Best Regards,
> J.
