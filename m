From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 4 May 2010 06:15:19 +0100
Subject: [PATCH 2/2] ARM: S5PV210: Add EINT and EINT Group Support
In-Reply-To: <1272948686-19216-1-git-send-email-kgene.kim@samsung.com>
References: <1272948686-19216-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100504051519.GO2589@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 04, 2010 at 01:51:26PM +0900, Kukjin Kim wrote:
> From: Jongpill Lee <boyko.lee@samsung.com>
> 
> Add EINT for Samsung S5P SoCs and EINT Group for S5PV210
> 
> Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-s5pv210/Makefile            |    2 +-
>  arch/arm/mach-s5pv210/include/mach/irqs.h |    8 +-
>  arch/arm/mach-s5pv210/irq-eint-group.c    |  521 +++++++++++++++++++++++++++++
>  arch/arm/plat-s5p/Makefile                |    2 +-
>  arch/arm/plat-s5p/irq-eint.c              |  229 +++++++++++++
>  5 files changed, 759 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/mach-s5pv210/irq-eint-group.c
>  create mode 100644 arch/arm/plat-s5p/irq-eint.c
> 
> diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
> index cb959ea..f1772ed 100644
> --- a/arch/arm/mach-s5pv210/Makefile
> +++ b/arch/arm/mach-s5pv210/Makefile
> @@ -12,7 +12,7 @@ obj-				:=
>  
>  # Core support for S5PV210 system
>  
> -obj-$(CONFIG_CPU_S5PV210)	+= cpu.o init.o clock.o gpio.o
> +obj-$(CONFIG_CPU_S5PV210)	+= cpu.o init.o clock.o gpio.o irq-eint-group.o
>  
>  # machine support
>  
> diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-s5pv210/include/mach/irqs.h
> index e8e43db..85c140b 100644
> --- a/arch/arm/mach-s5pv210/include/mach/irqs.h
> +++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
> @@ -134,11 +134,17 @@
>  #define IRQ_MDNIE3		S5P_IRQ_VIC3(8)
>  #define IRQ_VIC_END		S5P_IRQ_VIC3(31)
>  
> -#define S5P_IRQ_EINT_BASE	(IRQ_VIC_END + 1)
> +/* EINT */
>  
> +#define S5P_IRQ_EINT_BASE	(IRQ_VIC_END + 1)
>  #define S5P_EINT(x)		((x) + S5P_IRQ_EINT_BASE)
>  #define IRQ_EINT(x)		S5P_EINT(x)
>  
> +#define S5P_EINT_SET0(x)	S5PV210_GPH0(x)
> +#define S5P_EINT_SET1(x)	S5PV210_GPH1(x)
> +#define S5P_EINT_SET2(x)	S5PV210_GPH2(x)
> +#define S5P_EINT_SET3(x)	S5PV210_GPH3(x)
> +
>  /* Next the external interrupt groups. These are similar to the IRQ_EINT(x)
>   * that they are sourced from the GPIO pins but with a different scheme for
>   * priority and source indication.
> diff --git a/arch/arm/mach-s5pv210/irq-eint-group.c b/arch/arm/mach-s5pv210/irq-eint-group.c
> new file mode 100644
> index 0000000..4a5c3cd
> --- /dev/null
> +++ b/arch/arm/mach-s5pv210/irq-eint-group.c
> @@ -0,0 +1,521 @@
> +/* linux/arch/arm/mach-s5pv210/irq-eint-group.c
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * S5PV210 - IRQ EINT Group support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/kernel.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/io.h>
> +
> +#include <plat/regs-irqtype.h>
> +
> +#include <mach/map.h>
> +#include <plat/cpu.h>
> +
> +#include <mach/gpio.h>
> +#include <plat/gpio-cfg.h>
> +#include <mach/regs-gpio.h>
> +
> +#define S5PV210_EINT_MAX_SOURCES	8
> +
> +struct s5pv210_eint_group_t {

  not a _t, please remove the _t.

> +	int		sources;
> +	int		base;
> +	void __iomem	*cont_reg;
> +	void __iomem	*mask_reg;
> +	void __iomem	*pend_reg;
> +	int		mask_ofs;
> +	int		pend_ofs;
> +
> +	/* start offset in control register for each source */
> +	int		cont_map[S5PV210_EINT_MAX_SOURCES];
> +};

some documentation of this would have been very helpful to try and
work out what is going on.

> +static struct s5pv210_eint_group_t eint_groups[] = {
> +	[0] = {
> +		.sources	= 0,
> +		.base		= 0,
> +		.cont_reg	= 0x0,
> +		.mask_reg	= 0x0,
> +		.pend_reg	= 0x0,
> +		.mask_ofs	= 0,
> +		.pend_ofs	= 0,

no need to initialise items to 0 or 0x0

this liooks like it would be better off remvoed and some error
handling added to the code.

> +		.cont_map	= {
> +			-1, -1, -1, -1, -1, -1, -1, -1,
> +		},
> +	},
> +	[1] = {
> +		.sources	= IRQ_EINT_GROUP1_NR,
> +		.base		= IRQ_EINT_GROUP1_BASE,
> +		.cont_reg	= S5PV210_GPA0_INT_CON,
> +		.mask_reg	= S5PV210_GPA0_INT_MASK,
> +		.pend_reg	= S5PV210_GPA0_INT_PEND,
> +		.mask_ofs	= 0,
> +		.pend_ofs	= 0,
> +		.cont_map	= {
> +			0, 4, 8, 12, 16, 20, 24, 28,
> +		},
> +	},
> +	[2] = {
> +		.sources	= IRQ_EINT_GROUP2_NR,
> +		.base		= IRQ_EINT_GROUP2_BASE,
> +		.cont_reg	= S5PV210_GPA1_INT_CON,
> +		.mask_reg	= S5PV210_GPA1_INT_MASK,
> +		.pend_reg	= S5PV210_GPA1_INT_PEND,
> +		.mask_ofs	= 0,
> +		.pend_ofs	= 0,
> +		.cont_map	= {
> +			0, 4, 8, 12, -1, -1, -1, -1,
> +		},
> +	},
> +	[3] = {
> +		.sources	= IRQ_EINT_GROUP3_NR,
> +		.base		= IRQ_EINT_GROUP3_BASE,
> +		.cont_reg	= S5PV210_GPB_INT_CON,
> +		.mask_reg	= S5PV210_GPB_INT_MASK,
> +		.pend_reg	= S5PV210_GPB_INT_PEND,
> +		.mask_ofs	= 0,
> +		.pend_ofs	= 0,
> +		.cont_map	= {
> +			0, 4, 8, 12, 16, 20, 24, 28,
> +		},
> +	},
> +	[4] = {
> +		.sources	= IRQ_EINT_GROUP4_NR,
> +		.base		= IRQ_EINT_GROUP4_BASE,
> +		.cont_reg	= S5PV210_GPC0_INT_CON,
> +		.mask_reg	= S5PV210_GPC0_INT_MASK,
> +		.pend_reg	= S5PV210_GPC0_INT_PEND,
> +		.mask_ofs	= 0,
> +		.pend_ofs	= 0,
> +		.cont_map	= {
> +			0, 4, 8, 12, 16, -1, -1, -1,
> +		},
> +	},
> +	[5] = {
> +		.sources	= IRQ_EINT_GROUP5_NR,
> +		.base		= IRQ_EINT_GROUP5_BASE,
> +		.cont_reg	= S5PV210_GPC1_INT_CON,
> +		.mask_reg	= S5PV210_GPC1_INT_MASK,
> +		.pend_reg	= S5PV210_GPC1_INT_PEND,
> +		.mask_ofs	= 0,
> +		.pend_ofs	= 0,
> +		.cont_map	= {
> +			0, 4, 8, 12, 16, -1, -1, -1,
> +		},
> +	},
> +	[6] = {
> +		.sources	= IRQ_EINT_GROUP6_NR,
> +		.base		= IRQ_EINT_GROUP6_BASE,
> +		.cont_reg	= S5PV210_GPD0_INT_CON,
> +		.mask_reg	= S5PV210_GPD0_INT_MASK,
> +		.pend_reg	= S5PV210_GPD0_INT_PEND,
> +		.mask_ofs	= 0,
> +		.pend_ofs	= 0,
> +		.cont_map	= {
> +			0, 4, 8, 12, -1, -1, -1, -1,
> +		},
> +	},
> +	[7] = {
> +		.sources	= IRQ_EINT_GROUP7_NR,
> +		.base		= IRQ_EINT_GROUP7_BASE,
> +		.cont_reg	= S5PV210_GPD1_INT_CON,
> +		.mask_reg	= S5PV210_GPD1_INT_MASK,
> +		.pend_reg	= S5PV210_GPD1_INT_PEND,
> +		.mask_ofs	= 0,
> +		.pend_ofs	= 0,
> +		.cont_map	= {
> +			0, 4, 8, 12, 16, 20, -1, -1,
> +		},
> +	},
> +	[8] = {
> +		.sources	= IRQ_EINT_GROUP8_NR,
> +		.base		= IRQ_EINT_GROUP8_BASE,
> +		.cont_reg	= S5PV210_GPE0_INT_CON,
> +		.mask_reg	= S5PV210_GPE0_INT_MASK,
> +		.pend_reg	= S5PV210_GPE0_INT_PEND,
> +		.mask_ofs	= 0,
> +		.pend_ofs	= 0,
> +		.cont_map	= {
> +			0, 4, 8, 12, 16, 20, 24, 28,
> +		},
> +	},
> +	[9] = {
> +		.sources	= IRQ_EINT_GROUP9_NR,
> +		.base		= IRQ_EINT_GROUP9_BASE,
> +		.cont_reg	= S5PV210_GPE1_INT_CON,
> +		.mask_reg	= S5PV210_GPE1_INT_MASK,
> +		.pend_reg	= S5PV210_GPE1_INT_PEND,
> +		.mask_ofs	= 0,
> +		.pend_ofs	= 0,
> +		.cont_map	= {
> +			0, 4, 8, 12, 16, -1, -1, -1,
> +		},
> +	},
> +	[10] = {
> +		.sources	= IRQ_EINT_GROUP10_NR,
> +		.base		= IRQ_EINT_GROUP10_BASE,
> +		.cont_reg	= S5PV210_GPF0_INT_CON,
> +		.mask_reg	= S5PV210_GPF0_INT_MASK,
> +		.pend_reg	= S5PV210_GPF0_INT_PEND,
> +		.mask_ofs	= 0,
> +		.pend_ofs	= 0,
> +		.cont_map	= {
> +			0, 4, 8, 12, 16, 20, 24, 28,
> +		},
> +	},
> +	[11] = {
> +		.sources	= IRQ_EINT_GROUP11_NR,
> +		.base		= IRQ_EINT_GROUP11_BASE,
> +		.cont_reg	= S5PV210_GPF1_INT_CON,
> +		.mask_reg	= S5PV210_GPF1_INT_MASK,
> +		.pend_reg	= S5PV210_GPF1_INT_PEND,
> +		.mask_ofs	= 0,
> +		.pend_ofs	= 0,
> +		.cont_map	= {
> +			0, 4, 8, 12, 16, 20, 24, 28,
> +		},
> +	},
> +	[12] = {
> +		.sources	= IRQ_EINT_GROUP12_NR,
> +		.base		= IRQ_EINT_GROUP12_BASE,
> +		.cont_reg	= S5PV210_GPF2_INT_CON,
> +		.mask_reg	= S5PV210_GPF2_INT_MASK,
> +		.pend_reg	= S5PV210_GPF2_INT_PEND,
> +		.mask_ofs	= 0,
> +		.pend_ofs	= 0,
> +		.cont_map	= {
> +			0, 4, 8, 12, 16, 20, 24, 28,
> +		},
> +	},
> +	[13] = {
> +		.sources	= IRQ_EINT_GROUP13_NR,
> +		.base		= IRQ_EINT_GROUP13_BASE,
> +		.cont_reg	= S5PV210_GPF3_INT_CON,
> +		.mask_reg	= S5PV210_GPF3_INT_MASK,
> +		.pend_reg	= S5PV210_GPF3_INT_PEND,
> +		.mask_ofs	= 0,
> +		.pend_ofs	= 0,
> +		.cont_map	= {
> +			0, 4, 8, 12, 16, 20, -1, -1,
> +		},
> +	},
> +	[14] = {
> +		.sources	= IRQ_EINT_GROUP14_NR,
> +		.base		= IRQ_EINT_GROUP14_BASE,
> +		.cont_reg	= S5PV210_GPG0_INT_CON,
> +		.mask_reg	= S5PV210_GPG0_INT_MASK,
> +		.pend_reg	= S5PV210_GPG0_INT_PEND,
> +		.mask_ofs	= 0,
> +		.pend_ofs	= 0,
> +		.cont_map	= {
> +			0, 4, 8, 12, 16, 20, 24, -1,

couldnt' cont_map be calculated from the offset into the irq?

> +		},
> +	},
> +	[15] = {
> +		.sources	= IRQ_EINT_GROUP15_NR,
> +		.base		= IRQ_EINT_GROUP15_BASE,
> +		.cont_reg	= S5PV210_GPG1_INT_CON,
> +		.mask_reg	= S5PV210_GPG1_INT_MASK,
> +		.pend_reg	= S5PV210_GPG1_INT_PEND,
> +		.mask_ofs	= 0,
> +		.pend_ofs	= 0,
> +		.cont_map	= {
> +			0, 4, 8, 12, 16, 20, 24, -1,
> +		},
> +	},
> +	[16] = {
> +		.sources	= IRQ_EINT_GROUP16_NR,
> +		.base		= IRQ_EINT_GROUP16_BASE,
> +		.cont_reg	= S5PV210_GPG2_INT_CON,
> +		.mask_reg	= S5PV210_GPG2_INT_MASK,
> +		.pend_reg	= S5PV210_GPG2_INT_PEND,
> +		.mask_ofs	= 0,
> +		.pend_ofs	= 0,
> +		.cont_map	= {
> +			0, 4, 8, 12, 16, 20, 24, -1,
> +		},
> +	},
> +	[17] = {
> +		.sources	= IRQ_EINT_GROUP17_NR,
> +		.base		= IRQ_EINT_GROUP17_BASE,
> +		.cont_reg	= S5PV210_GPG3_INT_CON,
> +		.mask_reg	= S5PV210_GPG3_INT_MASK,
> +		.pend_reg	= S5PV210_GPG3_INT_PEND,
> +		.mask_ofs	= 0,
> +		.pend_ofs	= 0,
> +		.cont_map	= {
> +			0, 4, 8, 12, 16, 20, 24, -1,
> +		},
> +	},
> +	[18] = {
> +		.sources	= IRQ_EINT_GROUP18_NR,
> +		.base		= IRQ_EINT_GROUP18_BASE,
> +		.cont_reg	= S5PV210_GPJ0_INT_CON,
> +		.mask_reg	= S5PV210_GPJ0_INT_MASK,
> +		.pend_reg	= S5PV210_GPJ0_INT_PEND,

if the cont, mask and pend regs are all consistent offset from a base
then it would probably be better to just store the base address.

see also comments on the previous include headers.

> +		.mask_ofs	= 0,
> +		.pend_ofs	= 0,
> +		.cont_map	= {
> +			0, 4, 8, 12, 16, 20, 24, 28,
> +		},
> +	},
> +	[19] = {
> +		.sources	= IRQ_EINT_GROUP19_NR,
> +		.base		= IRQ_EINT_GROUP19_BASE,
> +		.cont_reg	= S5PV210_GPJ1_INT_CON,
> +		.mask_reg	= S5PV210_GPJ1_INT_MASK,
> +		.pend_reg	= S5PV210_GPJ1_INT_PEND,
> +		.mask_ofs	= 0,
> +		.pend_ofs	= 0,
> +		.cont_map	= {
> +			0, 4, 8, 12, 16, 20, -1, -1,
> +		},
> +	},
> +	[20] = {
> +		.sources	= IRQ_EINT_GROUP20_NR,
> +		.base		= IRQ_EINT_GROUP20_BASE,
> +		.cont_reg	= S5PV210_GPJ2_INT_CON,
> +		.mask_reg	= S5PV210_GPJ2_INT_MASK,
> +		.pend_reg	= S5PV210_GPJ2_INT_PEND,
> +		.mask_ofs	= 0,
> +		.pend_ofs	= 0,
> +		.cont_map	= {
> +			0, 4, 8, 12, 16, 20, 24, 28,
> +		},
> +	},
> +	[21] = {
> +		.sources	= IRQ_EINT_GROUP21_NR,
> +		.base		= IRQ_EINT_GROUP21_BASE,
> +		.cont_reg	= S5PV210_GPJ3_INT_CON,
> +		.mask_reg	= S5PV210_GPJ3_INT_MASK,
> +		.pend_reg	= S5PV210_GPJ3_INT_PEND,
> +		.mask_ofs	= 0,
> +		.pend_ofs	= 0,
> +		.cont_map	= {
> +			0, 4, 8, 12, 16, 20, 24, 28,
> +		},
> +	},
> +	[22] = {
> +		.sources	= IRQ_EINT_GROUP22_NR,
> +		.base		= IRQ_EINT_GROUP22_BASE,
> +		.cont_reg	= S5PV210_GPJ4_INT_CON,
> +		.mask_reg	= S5PV210_GPJ4_INT_MASK,
> +		.pend_reg	= S5PV210_GPJ4_INT_PEND,
> +		.mask_ofs	= 0,
> +		.pend_ofs	= 0,
> +		.cont_map	= {
> +			0, 4, 8, 12, 16, -1, -1, -1,
> +		},
> +	},
> +};
> +
> +#define S5PV210_EINT_GROUPS	(sizeof(eint_groups) / sizeof(eint_groups[0]))

how about S5PV210_EINT_NR_GROUPS

> +static int to_group_number(unsigned int irq)
> +{
> +	int grp, found;
> +
> +	for (grp = 1; grp < S5PV210_EINT_GROUPS; grp++) {
> +		if (irq >= eint_groups[grp].base + eint_groups[grp].sources)
> +			continue;
> +		else {
> +			found = 1;
> +			break;
> +		}
> +OB	}
> +
> +	if (!found) {
> +		printk(KERN_ERR "failed to find out the eint group number\n");
> +		grp = 0;
> +	}

do you really want to be printing an erro here? how about returning an
error code and passing that up to the caller? or even returning a pointer
to the group you found?

> +	return grp;
> +}
> +
> +static inline int to_irq_number(int grp, unsigned int irq)
> +{
> +	return irq - eint_groups[grp].base;
> +}
> +
> +static inline int to_bit_offset(int grp, unsigned int irq)
> +{
> +	int offset;
> +
> +	offset = eint_groups[grp].cont_map[to_irq_number(grp, irq)];
> +
> +	if (offset == -1) {
> +		printk(KERN_ERR "invalid bit offset\n");
> +		offset = 0;
> +	}
> +
> +	return offset;
> +}

how about keeping a pointer ot hte eint_group[x] and passing that
around? see also comments about calculating it from the data we've got

think invalid offset can be calculated from the size field you've got
in the structure.

> +static inline void s5pv210_irq_eint_group_mask(unsigned int irq)
> +{
> +	struct s5pv210_eint_group_t *group;
> +	int grp;
> +	u32 mask;
> +
> +	grp = to_group_number(irq);
> +	group = &eint_groups[grp];
> +
> +	mask = __raw_readl(group->mask_reg);
> +	mask |= (1 << (group->mask_ofs + to_irq_number(grp, irq)));
> +
> +	__raw_writel(mask, group->mask_reg);
> +}
> +
> +static void s5pv210_irq_eint_group_unmask(unsigned int irq)
> +{
> +	struct s5pv210_eint_group_t *group;
> +	int grp;
> +	u32 mask;
> +
> +	grp = to_group_number(irq);
> +	group = &eint_groups[grp];
> +
> +	mask = __raw_readl(group->mask_reg);
> +	mask &= ~(1 << (group->mask_ofs + to_irq_number(grp, irq)));
> +
> +	__raw_writel(mask, group->mask_reg);
> +}
> +
> +static inline void s5pv210_irq_eint_group_ack(unsigned int irq)
> +{
> +	struct s5pv210_eint_group_t *group;
> +	int grp;
> +	u32 pend;
> +
> +	grp = to_group_number(irq);
> +	group = &eint_groups[grp];
> +
> +	pend = (1 << (group->pend_ofs + to_irq_number(grp, irq)));
> +
> +	__raw_writel(pend, group->pend_reg);
> +}
> +
> +static void s5pv210_irq_eint_group_maskack(unsigned int irq)
> +{
> +	/* compiler should in-line these */
> +	s5pv210_irq_eint_group_mask(irq);
> +	s5pv210_irq_eint_group_ack(irq);
> +}
> +
> +static int s5pv210_irq_eint_group_set_type(unsigned int irq, unsigned int type)
> +{
> +	struct s5pv210_eint_group_t *group;
> +	int grp, shift;
> +	u32 ctrl, mask, newvalue = 0;
> +
> +	grp = to_group_number(irq);
> +	group = &eint_groups[grp];
> +
> +	switch (type) {
> +	case IRQ_TYPE_NONE:
> +		printk(KERN_WARNING "No edge setting!\n");
> +		break;
> +
> +	case IRQ_TYPE_EDGE_RISING:
> +		newvalue = S5P_EXTINT_RISEEDGE;
> +		break;
> +
> +	case IRQ_TYPE_EDGE_FALLING:
> +		newvalue = S5P_EXTINT_FALLEDGE;
> +		break;
> +
> +	case IRQ_TYPE_EDGE_BOTH:
> +		newvalue = S5P_EXTINT_BOTHEDGE;
> +		break;
> +
> +	case IRQ_TYPE_LEVEL_LOW:
> +		newvalue = S5P_EXTINT_LOWLEV;
> +		break;
> +
> +	case IRQ_TYPE_LEVEL_HIGH:
> +		newvalue = S5P_EXTINT_HILEV;
> +		break;
> +
> +	default:
> +		printk(KERN_ERR "No such irq type %d", type);
> +		return -1;
> +	}
> +
> +	shift = to_bit_offset(grp, irq);
> +	mask = 0x7 << shift;
> +
> +	ctrl = __raw_readl(group->cont_reg);
> +	ctrl &= ~mask;
> +	ctrl |= newvalue << shift;
> +	__raw_writel(ctrl, group->cont_reg);
> +
> +	return 0;
> +}
> +
> +static struct irq_chip s5pv210_irq_eint_group = {
> +	.name		= "s5pv210-eint-group",
> +	.mask		= s5pv210_irq_eint_group_mask,
> +	.unmask		= s5pv210_irq_eint_group_unmask,
> +	.mask_ack	= s5pv210_irq_eint_group_maskack,
> +	.ack		= s5pv210_irq_eint_group_ack,
> +	.set_type	= s5pv210_irq_eint_group_set_type,
> +};
> +
> +/*
> + * s5p_irq_demux_eint_group
> +*/
> +static inline void s5pv210_irq_demux_eint_group(unsigned int irq,
> +					    struct irq_desc *desc)
> +{
> +	struct s5pv210_eint_group_t *group;
> +	u32 status, mask, newirq;
> +	int grp, src;
> +
> +	for (grp = 1; grp < S5PV210_EINT_GROUPS; grp++) {
> +		group = &eint_groups[grp];

you might find setting 'group = eint_groups' at the start of the loop
and incrementing it in the for() statemnt makes the code more efficient.

> +		status = __raw_readl(group->pend_reg);
> +		mask = __raw_readl(group->mask_reg);
> +
> +		status &= ~mask;
> +		status >>= group->pend_ofs;
> +		status &= 0xff;			/* MAX IRQ in a group is 8 */
> +
> +		if (!status)
> +			continue;

> +		for (src = 0; src < S5PV210_EINT_MAX_SOURCES; src++) {
> +			if (status & 1) {
> +				newirq = group->base + src;
> +				generic_handle_irq(newirq);
> +			}
> +
> +			status >>= 1;
> +		}

  you might want to try fls() on this, it may well be a win on these newer
  cpus.


> +	}
> +}
> +
> +int __init s5pv210_init_irq_eint_group(void)
> +{
> +	int irq;
> +
> +	for (irq = IRQ_EINT_GROUP_BASE; irq < NR_IRQS; irq++) {
> +		set_irq_chip(irq, &s5pv210_irq_eint_group);
> +		set_irq_handler(irq, handle_level_irq);
> +		set_irq_flags(irq, IRQF_VALID);

you could have registered the group pointer with the set_irq_data() and
then you'd not need to go lookuing up so much stuff each time you mask/unmask
the interrupt.

> +	}
> +
> +	set_irq_chained_handler(IRQ_GPIOINT, s5pv210_irq_demux_eint_group);
> +
> +	return 0;
> +}
> +
> +arch_initcall(s5pv210_init_irq_eint_group);
> diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
> index 2046cfc..00a7966 100644
> --- a/arch/arm/plat-s5p/Makefile
> +++ b/arch/arm/plat-s5p/Makefile
> @@ -15,5 +15,5 @@ obj-				:=
>  obj-y				+= dev-uart.o
>  obj-y				+= cpu.o
>  obj-y				+= clock.o
> -obj-y				+= irq.o
> +obj-y				+= irq.o irq-eint.o
>  obj-y				+= setup-i2c0.o
> diff --git a/arch/arm/plat-s5p/irq-eint.c b/arch/arm/plat-s5p/irq-eint.c
> new file mode 100644
> index 0000000..a49ea29
> --- /dev/null
> +++ b/arch/arm/plat-s5p/irq-eint.c
> @@ -0,0 +1,229 @@
> +/* linux/arch/arm/plat-s5p/irq-eint.c
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * S5P - IRQ EINT support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/kernel.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/io.h>
> +#include <linux/sysdev.h>
> +
> +#include <asm/hardware/vic.h>
> +
> +#include <plat/regs-irqtype.h>
> +
> +#include <mach/map.h>
> +#include <plat/cpu.h>
> +#include <plat/pm.h>
> +
> +#include <mach/gpio.h>
> +#include <plat/gpio-cfg.h>
> +#include <mach/regs-gpio.h>
> +
> +static inline void s5p_irq_eint_mask(unsigned int irq)
> +{
> +	u32 mask;
> +
> +	mask = __raw_readl(S5P_EINT_MASK(eint_mask_reg(irq)));
> +	mask |= eint_irq_to_bit(irq);
> +	__raw_writel(mask, S5P_EINT_MASK(eint_mask_reg(irq)));
> +}
> +
> +static void s5p_irq_eint_unmask(unsigned int irq)
> +{
> +	u32 mask;
> +
> +	mask = __raw_readl(S5P_EINT_MASK(eint_mask_reg(irq)));
> +	mask &= ~(eint_irq_to_bit(irq));
> +	__raw_writel(mask, S5P_EINT_MASK(eint_mask_reg(irq)));
> +}
> +
> +static inline void s5p_irq_eint_ack(unsigned int irq)
> +{
> +	__raw_writel(eint_irq_to_bit(irq), S5P_EINT_PEND(eint_pend_reg(irq)));
> +}
> +
> +static void s5p_irq_eint_maskack(unsigned int irq)
> +{
> +	/* compiler should in-line these */
> +	s5p_irq_eint_mask(irq);
> +	s5p_irq_eint_ack(irq);
> +}
> +
> +static int s5p_irq_eint_set_type(unsigned int irq, unsigned int type)
> +{
> +	int offs = eint_offset(irq);
> +	int shift;
> +	u32 ctrl, mask;
> +	u32 newvalue = 0;
> +
> +	switch (type) {
> +	case IRQ_TYPE_NONE:
> +		printk(KERN_WARNING "No edge setting!\n");
> +		break;
> +
> +	case IRQ_TYPE_EDGE_RISING:
> +		newvalue = S5P_EXTINT_RISEEDGE;
> +		break;
> +
> +	case IRQ_TYPE_EDGE_FALLING:
> +		newvalue = S5P_EXTINT_RISEEDGE;
> +		break;
> +
> +	case IRQ_TYPE_EDGE_BOTH:
> +		newvalue = S5P_EXTINT_BOTHEDGE;
> +		break;
> +
> +	case IRQ_TYPE_LEVEL_LOW:
> +		newvalue = S5P_EXTINT_LOWLEV;
> +		break;
> +
> +	case IRQ_TYPE_LEVEL_HIGH:
> +		newvalue = S5P_EXTINT_HILEV;
> +		break;
> +
> +	default:
> +		printk(KERN_ERR "No such irq type %d", type);
> +		return -1;
> +	}
> +
> +	shift = (offs & 0x7) * 4;
> +	mask = 0x7 << shift;
> +
> +	ctrl = __raw_readl(S5P_EINT_CON(eint_conf_reg(irq)));
> +	ctrl &= ~mask;
> +	ctrl |= newvalue << shift;
> +	__raw_writel(ctrl, S5P_EINT_CON(eint_conf_reg(irq)));
> +
> +	if ((0 <= offs) && (offs < 8))
> +		s3c_gpio_cfgpin(S5P_EINT_SET0(offs&0x7), 0xf<<((offs&0x7)*4));
> +
> +	else if ((8 <= offs) && (offs < 16))
> +		s3c_gpio_cfgpin(S5P_EINT_SET1(offs&0x7), 0xf<<((offs&0x7)*4));
> +
> +	else if ((16 <= offs) && (offs < 24))
> +		s3c_gpio_cfgpin(S5P_EINT_SET2(offs&0x7), 0xf<<((offs&0x7)*4));
> +
> +	else if ((24 <= offs) && (offs < 32))
> +		s3c_gpio_cfgpin(S5P_EINT_SET3(offs&0x7), 0xf<<((offs&0x7)*4));
> +
> +	else
> +		printk(KERN_ERR "No such irq number %d", offs);
> +
> +	return 0;
> +}
> +
> +static struct irq_chip s5p_irq_eint = {
> +	.name		= "s5p-eint",
> +	.mask		= s5p_irq_eint_mask,
> +	.unmask		= s5p_irq_eint_unmask,
> +	.mask_ack	= s5p_irq_eint_maskack,
> +	.ack		= s5p_irq_eint_ack,
> +	.set_type	= s5p_irq_eint_set_type,
> +#ifdef CONFIG_PM
> +	.set_wake	= s3c_irqext_wake,
> +#endif
> +};
> +
> +/* s5p_irq_demux_eint
> + *
> + * This function demuxes the IRQ from the group0 external interrupts,
> + * from IRQ_EINT(16) to IRQ_EINT(31). It is designed to be inlined into
> + * the specific handlers s5p_irq_demux_eintX_Y.
> + */
> +static inline void s5p_irq_demux_eint(unsigned int start, unsigned int end)
> +{
> +	u32 status = __raw_readl(S5P_EINT_PEND((start >> 3)));
> +	u32 mask = __raw_readl(S5P_EINT_MASK((start >> 3)));
> +	unsigned int irq;
> +
> +	status &= ~mask;
> +	status &= (1 << (end - start + 1)) - 1;
> +
> +	for (irq = IRQ_EINT(start); irq <= IRQ_EINT(end); irq++) {
> +		if (status & 1)
> +			generic_handle_irq(irq);
> +
> +		status >>= 1;
> +	}
> +}
> +
> +static void s5p_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
> +{
> +	s5p_irq_demux_eint(16, 23);
> +	s5p_irq_demux_eint(24, 31);
> +}
> +
> +/* EINT0 ~ EINT15 */
> +
> +static void s5p_irq_vic_eint_mask(unsigned int irq)
> +{
> +	void __iomem *base = get_irq_chip_data(irq);
> +
> +	s5p_irq_eint_mask(irq);
> +
> +	irq &= 31;
> +	writel(1 << irq, base + VIC_INT_ENABLE_CLEAR);
> +}
> +
> +static void s5p_irq_vic_eint_unmask(unsigned int irq)
> +{
> +	void __iomem *base = get_irq_chip_data(irq);
> +
> +	s5p_irq_eint_unmask(irq);
> +
> +	irq &= 31;
> +	writel(1 << irq, base + VIC_INT_ENABLE);
> +}
> +
> +static inline void s5p_irq_vic_eint_ack(unsigned int irq)
> +{
> +	__raw_writel(eint_irq_to_bit(irq), S5P_EINT_PEND(eint_pend_reg(irq)));
> +}
> +
> +static void s5p_irq_vic_eint_maskack(unsigned int irq)
> +{
> +	/* compiler should in-line these */
> +	s5p_irq_vic_eint_mask(irq);
> +	s5p_irq_vic_eint_ack(irq);
> +}
> +
> +static struct irq_chip s5p_irq_vic_eint = {
> +	.name		= "s5p_vic_eint",
> +	.mask		= s5p_irq_vic_eint_mask,
> +	.unmask		= s5p_irq_vic_eint_unmask,
> +	.mask_ack	= s5p_irq_vic_eint_maskack,
> +	.ack		= s5p_irq_vic_eint_ack,
> +	.set_type	= s5p_irq_eint_set_type,
> +#ifdef CONFIG_PM
> +	.set_wake	= s3c_irqext_wake,
> +#endif
> +
> +};
> +
> +int __init s5p_init_irq_eint(void)
> +{
> +	int irq;
> +
> +	for (irq = IRQ_EINT0; irq <= IRQ_EINT15; irq++)
> +		set_irq_chip(irq, &s5p_irq_vic_eint);
> +
> +	for (irq = IRQ_EINT(16); irq <= IRQ_EINT(31); irq++) {
> +		set_irq_chip(irq, &s5p_irq_eint);
> +		set_irq_handler(irq, handle_level_irq);
> +		set_irq_flags(irq, IRQF_VALID);
> +	}
> +
> +	set_irq_chained_handler(IRQ_EINT16_31, s5p_irq_demux_eint16_31);
> +	return 0;
> +}
> +
> +arch_initcall(s5p_init_irq_eint);

there's an awful lot going on in this patch ,it would have been nicer
to split it into the EINT direct group and then the IRQs for the GPIO.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
