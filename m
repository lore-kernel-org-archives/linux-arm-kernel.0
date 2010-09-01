From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 2 Sep 2010 00:43:44 +0200
Subject: [PATCH 44/74] ST SPEAr : FSMC (Flexible Static Memory Controller)
	NOR interface driver
In-Reply-To: <3083e6913169ae3d3761be1667708c01ea2e344c.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<3083e6913169ae3d3761be1667708c01ea2e344c.1283161023.git.viresh.kumar@st.com>
Message-ID: <AANLkTinEkovA7PLcSLso22Ok+GO-Nra4e27OwyeqC4dz@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/30 Viresh KUMAR <viresh.kumar@st.com>:

> (...)
> ?arch/arm/mach-spear13xx/fsmc-nor.c ? ? ? ? ? ? | ? 81 ++++++++++++++++++++++++
> (...)
>  arch/arm/plat-spear/include/plat/fsmc.h        |   51 +++++++++++++++-

Hmmm... again we have this block also in U300 and NHK8815.

> (...)
> +++ b/arch/arm/mach-spear13xx/fsmc-nor.c
> @@ -0,0 +1,81 @@
> +/*
> + * arch/arm/mach-spear13xx/fsmc-nor.c
> + *
> + * FSMC (Flexible Static Memory Controller) interface for NOR

It even says its generic and should live in
drivers/mtd/maps I think for NOR controllers.

> + *
> + * Copyright (C) 2010 ST Microelectronics
> + * Vipin Kumar<vipin.kumar@st.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <plat/fsmc.h>
> +
> +int __init fsmc_nor_init(struct platform_device *pdev, unsigned long base,
> + ? ? ? ? ? ? ? u32 bank, u32 width)
> +{
> + ? ? ? void __iomem *fsmc_nor_base;
> + ? ? ? struct fsmc_regs *regs;
> + ? ? ? struct clk *clk;
> + ? ? ? int ret;
> + ? ? ? u32 ctrl;
> +
> + ? ? ? if (bank > (FSMC_MAX_NOR_BANKS - 1))
> + ? ? ? ? ? ? ? return -EINVAL;
> +
> + ? ? ? fsmc_nor_base = ioremap(base, FSMC_NOR_REG_SIZE);
> + ? ? ? if (!fsmc_nor_base)
> + ? ? ? ? ? ? ? return -ENOMEM;
> +
> + ? ? ? clk = clk_get(NULL, "fsmc");
> + ? ? ? if (IS_ERR(clk)) {
> + ? ? ? ? ? ? ? iounmap(fsmc_nor_base);
> + ? ? ? ? ? ? ? return PTR_ERR(clk);
> + ? ? ? }
> +
> + ? ? ? ret = clk_enable(clk);
> + ? ? ? if (ret) {
> + ? ? ? ? ? ? ? iounmap(fsmc_nor_base);
> + ? ? ? ? ? ? ? return ret;
> + ? ? ? }
> +
> + ? ? ? regs = (struct fsmc_regs *)fsmc_nor_base;
> +
> + ? ? ? ctrl = WAIT_ENB | WRT_ENABLE | WPROT | NOR_DEV | BANK_ENABLE;
> +
> + ? ? ? switch (width) {
> + ? ? ? case FSMC_FLASH_WIDTH8:
> + ? ? ? ? ? ? ? ctrl |= WIDTH_8;
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case FSMC_FLASH_WIDTH16:
> + ? ? ? ? ? ? ? ctrl |= WIDTH_16;
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? default:
> + ? ? ? ? ? ? ? ctrl |= WIDTH_8;
> + ? ? ? ? ? ? ? break;
> + ? ? ? }
> +
> + ? ? ? writel(ctrl, &regs->nor_bank_regs[bank].ctrl);
> + ? ? ? writel(0x0FFFFFFF, &regs->nor_bank_regs[bank].ctrl_tim);
> + ? ? ? writel(ctrl | RSTPWRDWN, &regs->nor_bank_regs[bank].ctrl);
> +
> + ? ? ? iounmap(fsmc_nor_base);
> +
> + ? ? ? return 0;
> +}
> +
> +void __init fsmc_init_board_info(struct platform_device *pdev,
> + ? ? ? ? ? ? ? struct mtd_partition *partitions, unsigned int nr_partitions,
> + ? ? ? ? ? ? ? unsigned int width)
> +{
> + ? ? ? fsmc_init_plat_data(pdev, partitions, nr_partitions, width);
> +}

All this should be in drivers/mtd/maps/fsmc-nor.c or so am I right?

> diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
> diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c

That kind of stuff you can keep :-)

> diff --git a/arch/arm/plat-spear/include/plat/fsmc.h b/arch/arm/plat-spear/include/plat/fsmc.h

Noooo combine this with the NAND stuff into include/linux/mtd/fsmc.h!

> index c0fdcd3..5909afd 100644
> --- a/arch/arm/plat-spear/include/plat/fsmc.h
> +++ b/arch/arm/plat-spear/include/plat/fsmc.h
> @@ -15,11 +15,36 @@
> ?#define __PLAT_FSMC_H

Change #define to reflect new suggested placement.

>
> ?#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/mtd/physmap.h>
> ?#include <linux/types.h>
> ?#include <asm/param.h>
>
> +#define FSMC_MAX_NOR_BANKS ? ? 4
> ?#define FSMC_MAX_NAND_BANKS ? ?4
>
> +#define FSMC_FLASH_WIDTH8 ? ? ?1
> +#define FSMC_FLASH_WIDTH16 ? ? 2
> +
> +struct nor_bank_regs {
> + ? ? ? u32 ctrl;
> + ? ? ? u32 ctrl_tim;
> +};
> +
> +/* ctrl register definitions */
> +#define BANK_ENABLE ? ? ? ? ? ?(1 << 0)
> +#define MUXED ? ? ? ? ? ? ? ? ?(1 << 1)
> +#define NOR_DEV ? ? ? ? ? ? ? ? ? ? ? ?(2 << 2)
> +#define WIDTH_8 ? ? ? ? ? ? ? ? ? ? ? ?(0 << 4)
> +#define WIDTH_16 ? ? ? ? ? ? ? (1 << 4)
> +#define RSTPWRDWN ? ? ? ? ? ? ?(1 << 6)
> +#define WPROT ? ? ? ? ? ? ? ? ?(1 << 7)
> +#define WRT_ENABLE ? ? ? ? ? ? (1 << 12)
> +#define WAIT_ENB ? ? ? ? ? ? ? (1 << 13)
> +
> +/* ctrl_tim register definitions */
> +
> ?struct nand_bank_regs {
> ? ? ? ?u32 pc;
> ? ? ? ?u32 sts;
> @@ -31,8 +56,11 @@ struct nand_bank_regs {
> ? ? ? ?u32 ecc3;
> ?};
>
> +#define FSMC_NOR_REG_SIZE ? ? ?0x40
> +
> ?struct fsmc_regs {
> - ? ? ? u8 reserved_1[0x40];
> + ? ? ? struct nor_bank_regs nor_bank_regs[FSMC_MAX_NOR_BANKS];
> + ? ? ? u8 reserved_1[0x40 - 0x20];
> ? ? ? ?struct nand_bank_regs bank_regs[FSMC_MAX_NAND_BANKS];
> ? ? ? ?u8 reserved_2[0xfe0 - 0xc0];
> ? ? ? ?u32 peripid0; ? ? ? ? ? ? ? ? ? /* 0xfe0 */
> @@ -106,4 +134,25 @@ struct fsmc_eccplace {
> ? ? ? ?struct fsmc_nand_eccplace eccplace[MAX_ECCPLACE_ENTRIES];
> ?};
>
> +static inline void fsmc_init_plat_data(struct platform_device *pdev,
> + ? ? ? ? ? ? ? struct mtd_partition *partitions, unsigned int nr_partitions,
> + ? ? ? ? ? ? ? unsigned int width)
> +{
> + ? ? ? struct physmap_flash_data *fsmc_plat_data;
> + ? ? ? fsmc_plat_data = dev_get_platdata(&pdev->dev);
> +
> + ? ? ? if (partitions) {
> + ? ? ? ? ? ? ? fsmc_plat_data->parts = partitions;
> + ? ? ? ? ? ? ? fsmc_plat_data->nr_parts = nr_partitions;
> + ? ? ? }
> +
> + ? ? ? fsmc_plat_data->width = width;
> +}
> +
> +extern int __init fsmc_nor_init(struct platform_device *pdev,
> + ? ? ? ? ? ? ? unsigned long base, u32 bank, u32 width);
> +extern void __init fsmc_init_board_info(struct platform_device *pdev,
> + ? ? ? ? ? ? ? struct mtd_partition *partitions, unsigned int nr_partitions,
> + ? ? ? ? ? ? ? unsigned int width);
> +
> ?#endif /* __PLAT_FSMC_H */

Thanks!

Yours,
Linus Walleij
