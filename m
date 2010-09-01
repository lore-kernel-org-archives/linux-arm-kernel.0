From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 2 Sep 2010 00:36:24 +0200
Subject: [PATCH 27/74] ST SPEAr : NAND interface driver for spear platforms
In-Reply-To: <7cd7060b403b448d74649cec5c28c795bcbbdbc3.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<07ce8daf18d3a9f13864752074af3490a324d84c.1283161023.git.viresh.kumar@st.com>
	<7cd7060b403b448d74649cec5c28c795bcbbdbc3.1283161023.git.viresh.kumar@st.com>
Message-ID: <AANLkTik9Di4k183t+wuY-1eprsO3xBOESaOY5dnxt6ii@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/30 Viresh KUMAR <viresh.kumar@st.com>:

> From: Vipin Kumar <vipin.kumar@st.com>
>
> SPEAr platforms use Flexible Static Memory Controller(FSMC) provided by ST for
> interfacing with NAND devices.
> This patch adds the support for glue logic for NAND flash on SPEAr boards

OK...

> (...)
> ?create mode 100644 arch/arm/plat-spear/include/plat/fsmc.h
> ?create mode 100644 arch/arm/plat-spear/include/plat/nand.h
> ?create mode 100644 drivers/mtd/nand/spear_nand.c

spear_nand.c?

Why not fsmc-nand.c or similar if this is the name of the block.
We have this in U300, Nomadik NHK8815 and other platforms too,
it doesn't have much to do with SPEAr actually...

Also, what are the include files doing in plat-spear since we have
the same hardware in other platforms? Move them to include/linux/mtd/
so we can use them please.

I *highly* suspect that this driver duplicates some code found in
drivers/mtd/nand/nomadik_nand.c because it's the same silicon.

Alessandro can judge on this, but I have a feeling that driver
should be replaced by this, more mature driver.

> (...)
> diff --git a/arch/arm/plat-spear/include/plat/fsmc.h b/arch/arm/plat-spear/include/plat/fsmc.h
> new file mode 100644
> index 0000000..c0fdcd3
> --- /dev/null
> +++ b/arch/arm/plat-spear/include/plat/fsmc.h
> @@ -0,0 +1,109 @@
> +/*
> + * arch/arm/plat-spear/include/plat/fsmc.h
> + *
> + * SPEAr platform nand interface header file

Replace "SPEAr platform" for "FSMC - Flexible Static Media Controller"

> + *
> + * Copyright (C) 2010 ST Microelectronics
> + * Vipin Kumar <vipin.kumar@st.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#ifndef __PLAT_FSMC_H
> +#define __PLAT_FSMC_H

Change these according to the new suggested placement.

> +
> +#include <linux/delay.h>
> +#include <linux/types.h>
> +#include <asm/param.h>
> +
> +#define FSMC_MAX_NAND_BANKS ? ?4
> +
> +struct nand_bank_regs {
> + ? ? ? u32 pc;
> + ? ? ? u32 sts;
> + ? ? ? u32 comm;
> + ? ? ? u32 attrib;
> + ? ? ? u32 ioata;
> + ? ? ? u32 ecc1;
> + ? ? ? u32 ecc2;
> + ? ? ? u32 ecc3;
> +};
> +
> +struct fsmc_regs {
> + ? ? ? u8 reserved_1[0x40];
> + ? ? ? struct nand_bank_regs bank_regs[FSMC_MAX_NAND_BANKS];
> + ? ? ? u8 reserved_2[0xfe0 - 0xc0];
> + ? ? ? u32 peripid0; ? ? ? ? ? ? ? ? ? /* 0xfe0 */
> + ? ? ? u32 peripid1; ? ? ? ? ? ? ? ? ? /* 0xfe4 */
> + ? ? ? u32 peripid2; ? ? ? ? ? ? ? ? ? /* 0xfe8 */
> + ? ? ? u32 peripid3; ? ? ? ? ? ? ? ? ? /* 0xfec */
> + ? ? ? u32 pcellid0; ? ? ? ? ? ? ? ? ? /* 0xff0 */
> + ? ? ? u32 pcellid1; ? ? ? ? ? ? ? ? ? /* 0xff4 */
> + ? ? ? u32 pcellid2; ? ? ? ? ? ? ? ? ? /* 0xff8 */
> + ? ? ? u32 pcellid3; ? ? ? ? ? ? ? ? ? /* 0xffc */

Do you need to have an u32 for each of these registers?
I think this is the AMBA PrimeCell ID registers which means
that the latter four are just "0xB105F00D" (clever) and
then padded to 32 bits. (Correct me if I'm wrong.)

You can find macros for extracting the important parts of the
field in include/linux/amba/bus.h

> +};
> +
> +#define FSMC_BUSY_WAIT_TIMEOUT (1 * HZ)
> +
> +/* pc register definitions */
> +#define FSMC_RESET ? ? ? ? ? ? (1 << 0)
> +#define FSMC_WAITON ? ? ? ? ? ?(1 << 1)
> +#define FSMC_ENABLE ? ? ? ? ? ?(1 << 2)
> +#define FSMC_DEVTYPE_NAND ? ? ?(1 << 3)
> +#define FSMC_DEVWID_8 ? ? ? ? ?(0 << 4)
> +#define FSMC_DEVWID_16 ? ? ? ? (1 << 4)
> +#define FSMC_ECCEN ? ? ? ? ? ? (1 << 6)
> +#define FSMC_ECCPLEN_512 ? ? ? (0 << 7)
> +#define FSMC_ECCPLEN_256 ? ? ? (1 << 7)
> +#define FSMC_TCLR_1 ? ? ? ? ? ?(1 << 9)
> +#define FSMC_TAR_1 ? ? ? ? ? ? (1 << 13)
> +
> +/* sts register definitions */
> +#define FSMC_CODE_RDY ? ? ? ? ?(1 << 15)
> +
> +/* comm register definitions */
> +#define FSMC_TSET_0 ? ? ? ? ? ?(0 << 0)
> +#define FSMC_TWAIT_6 ? ? ? ? ? (6 << 8)
> +#define FSMC_THOLD_4 ? ? ? ? ? (4 << 16)
> +#define FSMC_THIZ_1 ? ? ? ? ? ?(1 << 24)
> +
> +/* peripid2 register definitions */
> +#define FSMC_REVISION_MSK ? ? ?(0xf)
> +#define FSMC_REVISION_SHFT ? ? (0x4)
> +
> +#define FSMC_VER1 ? ? ? ? ? ? ?1
> +#define FSMC_VER2 ? ? ? ? ? ? ?2
> +#define FSMC_VER3 ? ? ? ? ? ? ?3
> +#define FSMC_VER4 ? ? ? ? ? ? ?4
> +#define FSMC_VER5 ? ? ? ? ? ? ?5
> +#define FSMC_VER6 ? ? ? ? ? ? ?6
> +#define FSMC_VER7 ? ? ? ? ? ? ?7
> +#define FSMC_VER8 ? ? ? ? ? ? ?8
> +
> +static inline u32 get_fsmc_version(struct fsmc_regs *regs)
> +{
> + ? ? ? return (readl(&regs->peripid2) >> FSMC_REVISION_SHFT) &
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? FSMC_REVISION_MSK;

Use macros from <linux/amba/bus.h> to extract version if
possible.

> +}
> +
> +/*
> + * There are 13 bytes of ecc for every 512 byte block in FSMC version 8
> + * and it has to be read consecutively and immediately after the 512
> + * byte data block for hardware to generate the error bit offsets
> + * Managing the ecc bytes in the following way is easier. This way is
> + * similar to oobfree structure maintained already in u-boot nand driver
> + */
> +#define MAX_ECCPLACE_ENTRIES ? 32
> +
> +struct fsmc_nand_eccplace {
> + ? ? ? u8 offset;
> + ? ? ? u8 length;
> +};
> +
> +struct fsmc_eccplace {
> + ? ? ? struct fsmc_nand_eccplace eccplace[MAX_ECCPLACE_ENTRIES];
> +};
> +
> +#endif /* __PLAT_FSMC_H */
> diff --git a/arch/arm/plat-spear/include/plat/nand.h b/arch/arm/plat-spear/include/plat/nand.h
> new file mode 100644
> index 0000000..712b4b0
> --- /dev/null
> +++ b/arch/arm/plat-spear/include/plat/nand.h
> @@ -0,0 +1,76 @@
> +/*
> + * arch/arm/plat-spear/include/plat/nand.h
> + *
> + * NAND macros for SPEAr platform
> + *

Replace "SPEAr platform" for "FSMC - Flexible Static Media Controller"

> + * Copyright (C) 2010 ST Microelectronics
> + * Vipin Kumar <vipin.kumar@st.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#ifndef __PLAT_NAND_H
> +#define __PLAT_NAND_H

Change this to reflect the new suggested placement.

> +
> +#include <linux/mtd/partitions.h>
> +
> +#define SPEAR_NAND_BW8 ? ? ? ? 1
> +#define SPEAR_NAND_BW16 ? ? ? ? ? ? ? ?2

FSMC_NAND*?

> +
> +#if defined(CONFIG_MACH_SPEAR310)
> +#define PLAT_NAND_CLE ? ? ? ? ?(1 << 17)
> +#define PLAT_NAND_ALE ? ? ? ? ?(1 << 16)
> +#else
> +#define PLAT_NAND_CLE ? ? ? ? ?(1 << 16)
> +#define PLAT_NAND_ALE ? ? ? ? ?(1 << 17)
> +#endif

You have to handle this some other way using platform data
I think.

> +
> +struct nand_platform_data {

fsmc_platform_data!

> + ? ? ? /*
> + ? ? ? ?* Board specific information
> + ? ? ? ?* Set from arch/arm/mach-spear<mach>/spear<mach>_evb.c
> + ? ? ? ?*/

Skip this comment...

> +
> + ? ? ? /*
> + ? ? ? ?* Use the default partition table present in the NAND driver if
> + ? ? ? ?* partitions is set to NULL.
> + ? ? ? ?*/
> + ? ? ? struct mtd_partition ? ?*partitions;
> + ? ? ? unsigned int ? ? ? ? ? ?nr_partitions;
> + ? ? ? unsigned int ? ? ? ? ? ?options;
> + ? ? ? unsigned int ? ? ? ? ? ?width;
> +
> + ? ? ? /*
> + ? ? ? ?* Machine specific information
> + ? ? ? ?* Set from arch/arm/mach-spear<mach>/spear<mach>.c
> + ? ? ? ?*/
> +
> + ? ? ? unsigned int ? ? ? ? ? ?bank;
> + ? ? ? /*
> + ? ? ? ?* Set to NULL if bank selection is not supported by machine
> + ? ? ? ?* architecture
> + ? ? ? ?* -> eg. when controller supports only one bank
> + ? ? ? ?*/
> + ? ? ? void ? ? ? ? ? ? ? ? ? ?(*select_bank)(u32 bank, u32 busw);
> +};
> +
> +/* This function is used to set platform data field of pdev->dev */
> +static inline void nand_set_plat_data(struct platform_device *pdev,

What about naming this fsmc_set_plat_data()

> + ? ? ? ? ? ? ? struct mtd_partition *partitions, unsigned int nr_partitions,
> + ? ? ? ? ? ? ? unsigned int options, unsigned int width)
> +{
> + ? ? ? struct nand_platform_data *nand_plat_data;
> + ? ? ? nand_plat_data = dev_get_platdata(&pdev->dev);
> +
> + ? ? ? if (partitions) {
> + ? ? ? ? ? ? ? nand_plat_data->partitions = partitions;
> + ? ? ? ? ? ? ? nand_plat_data->nr_partitions = nr_partitions;
> + ? ? ? }
> +
> + ? ? ? nand_plat_data->options = options;
> + ? ? ? nand_plat_data->width = width;
> +}
> +
> +#endif /* __PLAT_NAND_H */
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 8b4b67c..89d35d1 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -531,4 +531,10 @@ config MTD_NAND_JZ4740
> ? ? ? ?help
> ? ? ? ? ? ? ? ?Enables support for NAND Flash on JZ4740 SoC based boards.
>
> +config MTD_NAND_SPEAR

MTD_NAND_FSMC

> + ? ? ? tristate "Support for NAND on SPEAr platforms"

skip "on SPEAr platforms", there will be more.

> + ? ? ? depends on MTD_NAND && PLAT_SPEAR
> + ? ? ? help
> + ? ? ? ? Enables support for NAND Flash chips wired onto SPEAr boards.

Update help text to fit with U300 and Nomadik etc use.
Something more generic.

> +
> ?endif # MTD_NAND
> diff --git a/drivers/mtd/nand/spear_nand.c b/drivers/mtd/nand/spear_nand.c
> new file mode 100644
> index 0000000..da9661b
> --- /dev/null
> +++ b/drivers/mtd/nand/spear_nand.c

Name the file fsmc-nand.c or so.

> @@ -0,0 +1,860 @@
> +/*
> + * drivers/mtd/nand/spear_nand.c
> + *
> + * SPEAr13XX machines common source file

No... "FSMC Flexible Static Media Controller NAND portions driver"

> + *
> + * Copyright (C) 2010 ST Microelectronics
> + * Vipin Kumar <vipin.kumar@st.com>
> + * Ashish Priyadarshi
> + *
> + * Based on drivers/mtd/nand/nomadik_nand.c

Aha :-)

But why did you fork it instead of merging the drivers??

> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/resource.h>
> +#include <linux/sched.h>
> +#include <linux/types.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/nand.h>
> +#include <linux/mtd/nand_ecc.h>
> +#include <linux/platform_device.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <plat/fsmc.h>
> +#include <plat/nand.h>
> +#include <mtd/mtd-abi.h>
> +
> +static struct nand_ecclayout fsmc_ecc1_layout = {
> + ? ? ? .eccbytes = 24,
> + ? ? ? .eccpos = {2, 3, 4, 18, 19, 20, 34, 35, 36, 50, 51, 52,
> + ? ? ? ? ? ? ? 66, 67, 68, 82, 83, 84, 98, 99, 100, 114, 115, 116},
> + ? ? ? .oobfree = {
> + ? ? ? ? ? ? ? {.offset = 8, .length = 8},
> + ? ? ? ? ? ? ? {.offset = 24, .length = 8},
> + ? ? ? ? ? ? ? {.offset = 40, .length = 8},
> + ? ? ? ? ? ? ? {.offset = 56, .length = 8},
> + ? ? ? ? ? ? ? {.offset = 72, .length = 8},
> + ? ? ? ? ? ? ? {.offset = 88, .length = 8},
> + ? ? ? ? ? ? ? {.offset = 104, .length = 8},
> + ? ? ? ? ? ? ? {.offset = 120, .length = 8}
> + ? ? ? }
> +};
> +
> +static struct nand_ecclayout fsmc_ecc4_lp_layout = {
> + ? ? ? .eccbytes = 104,
> + ? ? ? .eccpos = { ?2, ? 3, ? 4, ? 5, ? 6, ? 7, ? 8,
> + ? ? ? ? ? ? ? 9, ?10, ?11, ?12, ?13, ?14,
> + ? ? ? ? ? ? ? 18, ?19, ?20, ?21, ?22, ?23, ?24,
> + ? ? ? ? ? ? ? 25, ?26, ?27, ?28, ?29, ?30,
> + ? ? ? ? ? ? ? 34, ?35, ?36, ?37, ?38, ?39, ?40,
> + ? ? ? ? ? ? ? 41, ?42, ?43, ?44, ?45, ?46,
> + ? ? ? ? ? ? ? 50, ?51, ?52, ?53, ?54, ?55, ?56,
> + ? ? ? ? ? ? ? 57, ?58, ?59, ?60, ?61, ?62,
> + ? ? ? ? ? ? ? 66, ?67, ?68, ?69, ?70, ?71, ?72,
> + ? ? ? ? ? ? ? 73, ?74, ?75, ?76, ?77, ?78,
> + ? ? ? ? ? ? ? 82, ?83, ?84, ?85, ?86, ?87, ?88,
> + ? ? ? ? ? ? ? 89, ?90, ?91, ?92, ?93, ?94,
> + ? ? ? ? ? ? ? 98, ?99, 100, 101, 102, 103, 104,
> + ? ? ? ? ? ? ? 105, 106, 107, 108, 109, 110,
> + ? ? ? ? ? ? ? 114, 115, 116, 117, 118, 119, 120,
> + ? ? ? ? ? ? ? 121, 122, 123, 124, 125, 126
> + ? ? ? },
> + ? ? ? .oobfree = {
> + ? ? ? ? ? ? ? {.offset = 15, .length = 3},
> + ? ? ? ? ? ? ? {.offset = 31, .length = 3},
> + ? ? ? ? ? ? ? {.offset = 47, .length = 3},
> + ? ? ? ? ? ? ? {.offset = 63, .length = 3},
> + ? ? ? ? ? ? ? {.offset = 79, .length = 3},
> + ? ? ? ? ? ? ? {.offset = 95, .length = 3},
> + ? ? ? ? ? ? ? {.offset = 111, .length = 3},
> + ? ? ? ? ? ? ? {.offset = 127, .length = 1}
> + ? ? ? }
> +};
> +
> +/*
> + * ECC placement definitions in oobfree type format.
> + * There are 13 bytes of ecc for every 512 byte block and it has to be read
> + * consecutively and immediately after the 512 byte data block for hardware to
> + * generate the error bit offsets in 512 byte data.
> + * Managing the ecc bytes in the following way makes it easier for software to
> + * read ecc bytes consecutive to data bytes. This way is similar to
> + * oobfree structure maintained already in generic nand driver
> + */
> +static struct fsmc_eccplace fsmc_ecc4_lp_place = {
> + ? ? ? .eccplace = {
> + ? ? ? ? ? ? ? {.offset = 2, .length = 13},
> + ? ? ? ? ? ? ? {.offset = 18, .length = 13},
> + ? ? ? ? ? ? ? {.offset = 34, .length = 13},
> + ? ? ? ? ? ? ? {.offset = 50, .length = 13},
> + ? ? ? ? ? ? ? {.offset = 66, .length = 13},
> + ? ? ? ? ? ? ? {.offset = 82, .length = 13},
> + ? ? ? ? ? ? ? {.offset = 98, .length = 13},
> + ? ? ? ? ? ? ? {.offset = 114, .length = 13}
> + ? ? ? }
> +};
> +
> +static struct nand_ecclayout fsmc_ecc4_sp_layout = {
> + ? ? ? .eccbytes = 13,
> + ? ? ? .eccpos = { 0, ?1, ?2, ?3, ?6, ?7, 8,
> + ? ? ? ? ? ? ? 9, 10, 11, 12, 13, 14
> + ? ? ? },
> + ? ? ? .oobfree = {
> + ? ? ? ? ? ? ? {.offset = 15, .length = 1},
> + ? ? ? }
> +};
> +
> +static struct fsmc_eccplace fsmc_ecc4_sp_place = {
> + ? ? ? .eccplace = {
> + ? ? ? ? ? ? ? {.offset = 0, .length = 4},
> + ? ? ? ? ? ? ? {.offset = 6, .length = 9}
> + ? ? ? }
> +};

I think ECC placement should be in the platform data.

> +
> +/*
> + * Default partition tables to be used if the partition information not provided
> + * through platform data
> + */
> +#define PARTITION(n, off, sz) ?{.name = n, .offset = off, .size = sz}
> +
> +/*
> + * Default partition layout for small page(= 512 bytes) devices
> + * Size for "Root file system" is updated in driver based on actual device size
> + */
> +static struct mtd_partition partition_info_16KB_blk[] = {
> + ? ? ? PARTITION("X-loader", 0, 4 * 0x4000),
> + ? ? ? PARTITION("U-Boot", 0x10000, 20 * 0x4000),
> + ? ? ? PARTITION("Kernel", 0x60000, 256 * 0x4000),
> + ? ? ? PARTITION("Root File System", 0x460000, 0),
> +};

Ewwww atleast pass this part in from the platform data.

> +
> +/*
> + * Default partition layout for large page(> 512 bytes) devices
> + * Size for "Root file system" is updated in driver based on actual device size
> + */
> +static struct mtd_partition partition_info_128KB_blk[] = {
> + ? ? ? PARTITION("X-loader", 0, 4 * 0x20000),
> + ? ? ? PARTITION("U-Boot", 0x80000, 12 * 0x20000),
> + ? ? ? PARTITION("Kernel", 0x200000, 48 * 0x20000),
> + ? ? ? PARTITION("Root File System", 0x800000, 0),
> +};

Dito.

The rest of the driver looks really nice to my untrained eye, but I'm
including Alessandro and Sebastian on the review.

Yours,
Linus Walleij
